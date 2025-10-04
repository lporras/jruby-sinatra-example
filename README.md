# Sinatra Hello World with JRuby on Trinidad

A proof of concept demonstrating a Sinatra application running on Trinidad (Jetty-based server) using JRuby.

## Prerequisites

- JRuby 9.3.13.0 (or compatible version)
- Java 11
- Docker and Docker Compose (optional)

## Project Structure

- `app.rb` - Sinatra application with two routes
- `config.ru` - Rack configuration file
- `Gemfile` - Ruby dependencies
- `Dockerfile` - Docker build configuration
- `docker-compose.yml` - Docker Compose configuration

## Running Locally with JRuby

### Option 1: Using Trinidad (Jetty-based server)

1. Install dependencies:
```bash
jruby -S gem install bundler
jruby -S bundle install
```

2. Run with Trinidad (uses Jetty internally):
```bash
jruby -S trinidad
```

Access the application at http://localhost:3000


## Running with Docker

### Using Docker Compose (Recommended)

```bash
docker-compose up --build
```

Access the application at http://localhost:3000

### Using Docker directly

```bash
# Build the image
docker build -t sinatra-jruby-trinidad .

# Run the container
docker run -p 3000:3000 sinatra-jruby-trinidad
```

## Available Endpoints

- `GET /` - Returns "Hello World from Sinatra running on JRuby with Trinidad!"
- `GET /time` - Returns the current server time

## How It Works

1. **Trinidad** is a Jetty-based web server built specifically for JRuby
2. Trinidad runs Rack applications (like Sinatra) directly without needing WAR packaging
3. The Docker build:
   - Installs JRuby and dependencies
   - Copies the application code
   - Runs Trinidad server on port 3000

## Environment Versions

- JRuby: 9.3.13.0
- Java: 11
- Jetty: 11 (in Docker)
- Ruby compatibility: 2.6.8
