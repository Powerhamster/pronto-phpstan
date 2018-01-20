require 'pronto'
require 'shellwords'
require 'nokogiri'

module Pronto
  class PhpStan < Runner
    def initialize(patches, commit = nil)
      super

      @executable = ENV['PRONTO_PHPSTAN_EXECUTABLE'] || 'phpstan'
      @config = ENV['PRONTO_PHPSTAN_CONFIG'] || nil
      @autoloader = ENV['PRONTO_PHPSTAN_AUTOLOADER'] || nil
      @level = ENV['PRONTO_PHPSTAN_LEVEL'] || 7
    end

    def run
      return [] unless @patches

      @patches.select { |patch| valid_patch?(patch) }
              .map { |patch| inspect(patch) }
              .flatten.compact
    end

    def valid_patch?(patch)
      patch.additions > 0 && php_file?(patch.new_file_full_path)
    end

    def inspect(patch)
      path = patch.new_file_full_path.to_s
      run_phpstan(path).map do |error_element|
        line_no = Integer(error_element.attribute('line').value)
        message = error_element.attribute('message').value
        severity = error_element.attribute('severity').value
        patch.added_lines.select { |line| line.new_lineno == line_no }
             .map { |line| new_message(message, severity, line) }
      end
    end

    def run_phpstan(path)
      escaped_executable = Shellwords.escape(@executable)
      escaped_level = Shellwords.escape(@level)
      escaped_path = Shellwords.escape(path)

      command = "#{escaped_executable} analyse --errorFormat=checkstyle -l #{escaped_level}"

      unless @autoloader.nil?
        escaped_autoloader = Shellwords.escape(@autoloader)
        command = "#{command} -a #{escaped_autoloader}"
      end

      unless @config.nil?
        escaped_config = Shellwords.escape(@config)
        command = "#{command} -c #{escaped_config}"
      end

      command = "#{command} #{escaped_path}"
      doc = Nokogiri::XML(`#{command}`)
      doc.xpath('//file/error')
    end

    def new_message(message, severity, line)
      path = line.patch.delta.new_file[:path]
      level = severity == 'error' ? :error : :warning

      Message.new(path, line, level, message, nil, self.class)
    end

    def php_file?(path)
      File.extname(path) == '.php'
    end
  end
end
