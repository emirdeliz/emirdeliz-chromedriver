# emirdeliz-chromedriver

This action sets up a [ChromeDriver](https://chromedriver.chromium.org/) for use in actions

## OS/Platform support

- ubuntu-latest, ubuntu-20.04 or ubuntu-18.04
- macos-latest, macos-10.15
- windows-latest, windows-2019

# Usage

See [action.yml](action.yml)

# inputs

```yml
version:
  description: 'The chromedriver version'
  default: 'latest'
arch:
  description: 'The chromedriver arch (linux64, mac64, mac_arm64 or wind32)'
  default: 'linux64'
download-path:
  description: 'The path to download chromedriver'
  default: ''
```
