# AMA Team's Vagranted PHP Box

This repository contains [Vagranted][vagranted] resource set for
building PHP boxes for our internal projects. It is implied that target
box runs LEMP stack with PHPMyAdmin and Mailhog on board for easier 
development.

## Features

- All services are exposed via corresponding ports: MySQL on 3306, 
Mailhog (SMTP) on 1025, application itself (Nginx ingress) on port 8080.
- Application runs under www-data user.
- A special directory `/var/log/application` may be used to store logs.
It's content is exposed via `/_logs` url through Nginx.
- Mailhog is accessible via `/_smtp` url.
- PHPMyAdmin is accessible via `/_pma` url.
- Box is being provisioned via Chef (passing context as attributes),
and if context is changed, it is usually enough to re-run 
`vagrant provision` for changes to apply.
- Database for application is created automatically.

## Configuration

MySQL and PHP-FPM configuration may specified under `configuration` key
in corresponding context sections. It's content represents .ini file 
sections and has following format:

```yml
section-name:
  option: value
  other-option: value
next-section-name:
  dragon-option: value
```

To apply configuration, simply call Vagranted to recompile and 
`vagrant provision` after that.

### Installation

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

## FAQ

### Why 32bit / why not using docker?

Sadly, our team works in different environments - part on Windows, part
on Linux. Because of that, it is sometimes required to launch VM as if
it would be launched on the colleagues machine which leads to necessity
of having Vagrant box running inside Windows VM on Linux host (or vice 
versa).

  [vagranted]: https://github.com/ama-team/vagranted.git
