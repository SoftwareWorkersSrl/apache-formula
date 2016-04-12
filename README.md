# apache-formula

[![Travis branch](https://img.shields.io/travis/Enrise/apache-formula/master.svg?style=flat-square)](https://travis-ci.org/Enrise/apache-formula)

This formula will install the latest stable version of Apache2.


## Compatibility

This formula currently only works on Debian-based systems (Debian, Ubuntu etc).

## Contributing

Pull requests for other OSes and bug fixes are more than welcome.

## Usage

Include "apache" in your project for the "full stack". Optionally you can select which states you require.
For usage with the Zend Server formula you should use "apache.light" instead since that package already has its own Apache installation.

## Todo

- Add configuration support (e.g. for modules)
- Add macro for easy vhost generation
- Add optional vhost management suppport
