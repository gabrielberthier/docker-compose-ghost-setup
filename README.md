# Docker Compose Quickstart for Ghost Blogging Platform

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/robincher/docker-compose-ghost-quickstart/blob/master/LICENSE)

Quick start docker compose that include Ghost blog, Nginx proxy with TLS/SSL and MySQL database. The intention is to get a general feel of depolying Ghost in production mode, where each component (Web, App & DB) are deployed seperately. This supports scaling and isolate failure (if any).

If you want to test Ghost in dev mode, you can run `docker compose -f ./dev/docker-compose.dev.yml` or use the Ghost CLI. 

```
npm install -g ghost-cli@latest # Install Ghost
```

```
ghost install local # Running on Dev
```

## Table of Contents

- [Opearting Env](#opearting-env)
- [Technolgoy Stack](#technology-stack)
- [Preparation](#technology-stack)
- [How to use it](#how-to-use-it)
- [Database Backup](#how-to-back-up-your-database)
- [Install Customised Theme](#install-theme)
- [Security and Networking](#security-and-networking)
- [License](#license)
- [References](#references)

## Why using this in production environment?

☝️ Easy setup

👨‍💻 Ready to production and local development

⚡ Performance Optimized

🔒 SSL auto-renewed

## Operating ENV

- **Operating System** Ubuntu is the default OS. Use 20.04 or newer.

- **docker** Docker version 20.10.23, build 7155243.

- **docker-compose** Docker Compose version v2.15.1.

## Technology Stack

- Node.js
  - Ghost blog software version 5.x (defaults to latest version).
- NGINX
  - proxying port 80 calls to the Node web server on port 2368.
- MySQL database
  - version 8.0.
  - using ~~UTFMB4~~ encoding (UTF8, actually). MySQL's UTF8 implementation is limited. UTFMB4 includes Emoji, try using it.

## Preparation

- A server sitting somewhere, like Amazon EC2 , Google Compute Cloud or a virutal machine (VPS) connected to your own network. 
- Register a domain name (either public or within your own network).
- Access to your domain's DNS.
- Make sure your DNS domain points to your host machine.

## How to Use It

1. Clone this project into the server's filesystem.
2. And .env file with the following variables:
  ```bash
    GHOST_APP_DOMAIN=yourdomain.com
    ROOT_PSD=rootpswrd
    MYSQL_DATABASE=ghostdb
    MYSQL_DATABASE_USER=ghost
    MYSQL_PASSWORD=mysqlpswd
    ENVIRONMENT=production
    EMAIL_ADDRESS=mail@yourdomain.com
  ```
3. Edit settings in config.<<env>>.json and docker-compose.yml as necessary and only if you wish, as it is not required.
   - config.production.json and update the fields as required
   - Database Initial set-up settings - under ghost and mysql services in docker-compose file, indicate the env variables
4. Run `cd docker-compose-ghost-quickstart && sudo chmod +rwx setup.sh`.
5. Execute the setup script. `./setup.sh`.

## How start using locally?

In your local environment you need to have installed:

- Docker
- Docker Compose

After clone this repository, you can access the `dev` folder to be able to run the local dev environment using this command below.

```bash
git clone https://github.com/clean-docker/ghost-cms.git ghost
cd ghost/dev
docker-compose up -d
```

Done! Access your https://localhost/ghost to access the admin panel and create your account.

## How to back up your database

1. Run "docker-compose ps" to get a list of running containers.
2. Locate the name of the mysql container.
3. Run this command to get the container's internal IP: docker inspect --format='{{.NetworkSettings.IPAddress}}' THAT_CONTAINER-NAME
4. In your favorite database GUI tool (like Navicat or DataGrip), create a new connection via SSH tunnel to the host machine
5. Use the internal IP address and database user and password to connect to database once SSH tunnel is established to host.
6. You'll have access to the data so you can view data and run backups.

## Install Theme

Stop docker-compose with:
`docker-compose stop`

Copy the new theme to **./ghost/content/theme** so that your theme folder sits next to the casper folder in the themes directory

Now run:
`docker-compose up -d`

Log in to the Ghost admin, go to Settings > General, and at the bottom is the Theme dropdown. Select your theme and click Save.

**How does that work?**

The ./ghost/content directory (on docker host machine) gets mounted inside your ghost container folder /var/lib/ghost when the container starts running. See docker-compose.yml for more details

## Security and Networking

- Only NGINX's ports (443) are exposed at host level.
- Support only TLS version 1.2 for incoming traffic
- HTTP/2 Enabled for Nginx Reverse Proxy

## License

[MIT LICENSE ](https://github.com/gabrielberthier/docker-compose-ghost-setup/blob/main/LICENSE)

## References

- [Docker Compose for Ghost by John Washam](https://github.com/jwasham/docker-ghost-template)
- [Ghost@Dockerhub](https://hub.docker.com/_/ghost/)
- [Installing Ghost locally for Dev](https://docs.ghost.org/docs/install-local)
- [How to host Ghost on Docker](https://andrewbridges.org/how-to-host-ghost-on-docker/)
- [Nginx and Let’s Encrypt with Docker in Less Than 5 Minutes](https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71)
- [Ghost CMS + Docker Compose](https://github.com/clean-docker/ghost-cms)

## Script Commands

| Commands  | Description  |
|---|---|
| `./scripts/dc start`  | Start your containers  |
| `./scripts/dc stop`  | Stop all containers  |
| `./scripts/dc update`  | Get Ghost updates and restart containers |

