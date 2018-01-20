# Pronto runner for PHPStan

[![Build Status](https://travis-ci.org/Powerhamster/pronto-phpstan.svg?branch=master)](https://travis-ci.org/Powerhamster/pronto-phpstan)

Pronto runner for [PHPStan](https://github.com/phpstan/phpstan).
[What is Pronto?](https://github.com/prontolabs/pronto)

Configuration
-------------

Configuration is available via following environment variables

| Name                        | Description                                                               | Default |
|-----------------------------|---------------------------------------------------------------------------|---------|
| `PRONTO_PHPSTAN_EXECUTABLE` | Path to a PHPStan executable                                              | phpstan |
| `PRONTO_PHPSTAN_CONFIG`     | Additonal config file which should be ussd (-c)                           | none    |
| `PRONTO_PHPSTAN_AUTOLOADER` | Autoloader file wich phpstan should use (-a)                              | none    |
| `PRONTO_PHPSTAN_LEVEL`      | Level on which phpstan will run (-l)                                      | 7       |

Credits
-------
inspired by [pronto-phpcs](https://github.com/EllisV/pronto-phpcs)

Copyright
---------

Copyright (c) 2018 Thomas Rothe. See [LICENSE](LICENSE) for further details.
