# Sinatra Hello World with JRuby

A proof of concept demonstrating a Sinatra application running on different servers (Trinidad/Jetty and Tomcat) using JRuby.

## Prerequisites

- JRuby 9.3.13.0
- Java 21 (OpenJDK 21)
- Docker and Docker Compose (for containerized deployment)

## Project Structure

- `app.rb` - Sinatra application with two routes
- `config.ru` - Rack configuration file
- `Gemfile` - Ruby dependencies
- `Dockerfile` - Docker build configuration for Trinidad/Jetty
- `Dockerfile.tomcat` - Docker build configuration for Tomcat
- `docker-compose.yml` - Docker Compose configuration for both servers

## Running Locally (Without Docker)

### Option 1: Using Trinidad (Jetty-based server)

1. Install dependencies:
```bash
jruby -S gem install bundler
jruby -S bundle install
```

2. Run with Trinidad:
```bash
jruby -J--add-opens=java.base/sun.nio.ch=ALL-UNNAMED -J--add-opens=java.base/java.io=ALL-UNNAMED -J--add-opens=java.logging/java.util.logging=ALL-UNNAMED -S trinidad
```

Access the application at http://localhost:3000

### Option 2: Using Tomcat

1. Install dependencies and build WAR file:
```bash
jruby -S gem install bundler
jruby -S bundle install
jruby -S bundle exec warble
```

2. Deploy the generated WAR file to your Tomcat installation's webapps directory

## Running with Docker

### Running Both Servers Simultaneously

Start both Trinidad (Jetty) and Tomcat servers:
```bash
docker compose up --build
```

Access the applications:
- **Trinidad/Jetty**: http://localhost:3000
- **Tomcat**: http://localhost:8080

Stop both servers:
```bash
docker compose down
```

### Running Individual Servers

#### Trinidad/Jetty only:
```bash
docker-compose up --build sinatra-trinidad
```

#### Tomcat only:
```bash
docker-compose up --build sinatra-tomcat
```

### Using Docker Directly

#### Trinidad/Jetty:
```bash
# Build the image
docker build -t sinatra-jruby-trinidad .

# Run the container
docker run -p 3000:3000 sinatra-jruby-trinidad
```

#### Tomcat:
```bash
# Build the image
docker build -f Dockerfile.tomcat -t sinatra-jruby-tomcat .

# Run the container
docker run -p 8080:8080 sinatra-jruby-tomcat
```

## Available Endpoints

- `GET /` - Returns "Hello World from Sinatra running on JRuby with Trinidad!"
- `GET /time` - Returns the current server time

## How It Works

### Trinidad/Jetty Setup
1. **Trinidad** is a Jetty-based web server built specifically for JRuby
2. Trinidad runs Rack applications (like Sinatra) directly without needing WAR packaging
3. Runs on port 3000

### Tomcat Setup
1. Uses **Warbler** to package the Sinatra application as a WAR file
2. Deploys the WAR to Tomcat's webapps directory
3. Runs on port 8080

## Environment Versions

- JRuby: 9.3.13.0
- Java: OpenJDK 21
- Tomcat: 9.0.98 (in Docker)
- Ruby compatibility: 2.6.8
