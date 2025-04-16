# Inception

![Inception](https://img.shields.io/badge/Docker-Infrastructure-blue)
![WordPress](https://img.shields.io/badge/WordPress-Latest-green)
![Nginx](https://img.shields.io/badge/Nginx-TLSv1.3-orange)
![MariaDB](https://img.shields.io/badge/MariaDB-Latest-yellow)

A Docker-based infrastructure project that sets up a complete WordPress environment with separate services running in their own containers.

## 📋 Overview

This project implements a small-scale containerized infrastructure composed of three main services:

1. **NGINX**: Web server with TLSv1.3 support acting as the entry point on port 443 (HTTPS)
2. **WordPress**: PHP-FPM installation for the WordPress CMS
3. **MariaDB**: Database server for WordPress content

All services run in separate containers, communicate over a Docker network, and store persistent data in Docker volumes.

## 🏗️ Architecture

```
                                   ┌───────────┐
                                   │           │
                                   │  Client   │
                                   │           │
                                   └─────┬─────┘
                                         │
                                         │ HTTPS (443)
                                         ▼
┌────────────────────────────────────────────────────────────────────┐
│                         Docker Network                             │
│                                                                    │
│   ┌─────────────┐          ┌─────────────┐          ┌─────────────┐│
│   │             │          │             │          │             ││
│   │  NGINX      │◄────────►│  WordPress  │◄────────►│  MariaDB    ││
│   │  Container  │   9000   │  Container  │   3306   │  Container  ││
│   │             │          │             │          │             ││
│   └──────┬──────┘          └──────┬──────┘          └──────┬──────┘│
│          │                        │                        │       │
└──────────┼────────────────────────┼────────────────────────┼───────┘
           │                        │                        │
           ▼                        ▼                        ▼
    ┌─────────────┐          ┌─────────────┐          ┌─────────────┐
    │  WordPress  │          │  WordPress  │          │   MariaDB   │
    │   Volume    │          │   Volume    │          │    Volume   │
    └─────────────┘          └─────────────┘          └─────────────┘
```

The infrastructure follows these design principles:

- Each service runs in its dedicated container
- All containers are built using Debian Bullseye
- No pre-built images from DockerHub are used (except for base OS)
- All containers restart automatically in case of a crash
- Data is persistent through Docker volumes
- Environment variables store all sensitive information
- NGINX is the only entry point via HTTPS (port 443)

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose installed
- Make utility
- Sudo privileges

### Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/inception.git
cd inception
```

2. Edit the `.env` file in the `srcs` directory with your custom settings (optional, defaults are provided)

3. Run the setup:
```bash
make
```

4. Add the domain to your `/etc/hosts` file:
```bash
sudo echo "127.0.0.1 yoelansa.42.fr" >> /etc/hosts
```

5. Access WordPress at `https://yoelansa.42.fr`

## 🔧 Makefile Commands

The project includes a Makefile with the following commands:

- `make` or `make up`: Build and start all containers
- `make down`: Stop and remove containers
- `make stop`: Stop containers without removing them
- `make start`: Start previously stopped containers
- `make build`: Build container images without starting them
- `make clean`: Stop and remove all Docker containers
- `make re`: Clean and restart everything
- `make prune`: Deep clean (removes containers, images, volumes, and networks)

## 🔍 Project Structure

```
.
├── Makefile                    # Main build file
└── srcs/                       # Source files
    ├── docker-compose.yml      # Services configuration
    ├── .env                    # Environment variables
    └── requirements/           # Service definitions
        ├── mariadb/            # MariaDB container files
        │   ├── Dockerfile
        │   └── tools/          # Scripts and configs
        │       └── script.sh   # Initialization script
        ├── nginx/              # NGINX container files
        │   ├── Dockerfile
        │   ├── conf/           # NGINX configuration
        │   │   └── nginx.conf
        │   └── tools/          # Scripts and configs
        │       └── script.sh   # SSL setup script
        └── wordpress/          # WordPress container files
            ├── Dockerfile
            ├── wp-config.php   # WordPress configuration
            ├── www.conf        # PHP-FPM configuration
            └── script.sh       # WordPress setup script
```

## 📊 Services

### NGINX

- Acts as the only entry point to the infrastructure
- TLSv1.3 encryption with self-signed certificates
- Routes requests to the WordPress container
- Handles static file serving

### WordPress

- Latest WordPress installation with PHP-FPM
- Configured with WP-CLI for automated setup
- Custom admin and regular user accounts
- Communicates with MariaDB for data storage

### MariaDB

- Database server for WordPress
- Custom user and database configuration
- Secure initialization with environment variables
- Data persistence through Docker volumes

## 📦 Volumes

The project uses two persistent volumes:

1. `mariadb`: Stores the database files at `/home/yoelansa/data/mariadb`
2. `wordpress`: Stores the WordPress files at `/home/yoelansa/data/wordpress`

## 🔒 Security Features

- TLSv1.3 encryption for all web traffic
- No hardcoded passwords (all in `.env` file)
- Limited container access (principle of least privilege)
- Custom WordPress security keys
- MariaDB secure initialization

## 🛠️ Customization

You can customize this setup by editing the `.env` file with your own:

- Domain name
- Database credentials
- WordPress admin credentials
- WordPress user credentials

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/yourusername/inception/issues).

## 📝 License

This project is [MIT](https://opensource.org/licenses/MIT) licensed.

## 🙏 Acknowledgements

- [42 School](https://42.fr/) for the project subject
- Docker documentation
- WordPress community
- NGINX documentation
- MariaDB documentation
