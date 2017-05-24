# AMA Team's Vagranted PHP Box

This repository contains [Vagranted][vagranted] resource set for
building PHP boxes for our internal projects.

### Usage

- Add [Vagranted][vagranted] as dependency

```bash
composer require --dev ama-team/vagranted
```

- Add box as a resource set:

```yml
# vagranted.yml
dependencies:
  php-box: git+https://github.com/ama-team/vagranted-php-box.git
```

- Compile it

```bash
vendor/bin/vagranted compile
```

You can use you Vagrant box now.

  [vagranted]: https://github.com/ama-team/vagranted.git
