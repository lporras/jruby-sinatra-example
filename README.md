# Sinatra Hello World with JRuby on Jetty

A proof of concept demonstrating a Sinatra application running on Jetty using JRuby and Warbler.

## Prerequisites

- JRuby 9.3.13.0 (or compatible version)
- Java 21
- Docker and Docker Compose (optional)

## Project Structure

- `app.rb` - Sinatra application with two routes
- `config.ru` - Rack configuration file
- `Gemfile` - Ruby dependencies
- `config/warble.rb` - Warbler configuration for WAR generation
- `Dockerfile` - Multi-stage Docker build
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

### Option 2: Build WAR File (Note: Warbler has compatibility issues with JRuby 9.4.x)

Due to a known bug in Warbler 2.0.5 with JRuby 9.4.x, WAR generation is currently not working.

**Workaround options:**
- Use JRuby 9.3.x where Warbler works correctly
- Use Trinidad (Option 1 above) which runs on Jetty without needing a WAR file
- Use Docker (see below) which handles the WAR build in an isolated environment

## Running with Docker

### Using Docker Compose (Recommended)

```bash
docker-compose up --build
```

Access the application at http://localhost:8080

### Using Docker directly

```bash
# Build the image
docker build -t sinatra-jruby-jetty .

# Run the container
docker run -p 8080:8080 sinatra-jruby-jetty
```

## Available Endpoints

- `GET /` - Returns "Hello World from Sinatra running on JRuby with Jetty!"
- `GET /time` - Returns the current server time

## How It Works

1. **Warbler** packages the Sinatra application into a WAR (Web Application Archive) file
2. The WAR file includes JRuby runtime and all gem dependencies
3. **Jetty** (Java web server) deploys and runs the WAR file natively
4. The Docker build uses a multi-stage approach:
   - Stage 1: Uses JRuby to build the WAR file
   - Stage 2: Uses official Jetty image to deploy the WAR

## Environment Versions

- JRuby: 9.3.13.0
- Java: 11
- Jetty: 11 (in Docker)
- Ruby compatibility: 2.6.8
