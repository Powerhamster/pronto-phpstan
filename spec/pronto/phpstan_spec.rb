require 'spec_helper'

module Pronto
  describe PhpStan do
    let(:phpstan) { PhpStan.new(patches) }
    let(:patches) { nil }

    describe '#run' do
      subject(:run) { phpstan.run }

      context 'patches are nil' do
        it { should == [] }
      end

      context 'no patches' do
        let(:patches) { [] }
        it { should == [] }
      end

      context 'patches with a one warning' do
        include_context 'test repo'

        let(:patches) { repo.diff('master') }

        it 'returns correct number of violations' do
          expect(run.count).to eql(1)
        end

        it 'returns expected error message' do
          expect(run.first.msg).to eql('Call to an undefined method Powerhamster\Test::bar().')
        end
      end
    end
  end
end
