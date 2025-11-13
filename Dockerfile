FROM eclipse-temurin:21-jdk-jammy

# Install dependencies for asdf and JRuby
RUN apt-get update && apt-get install -y \
    curl \
    git \
    make \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install asdf
ENV ASDF_DIR=/root/.asdf
RUN git clone https://github.com/asdf-vm/asdf.git ${ASDF_DIR} --branch v0.14.0 && \
    echo '. ${ASDF_DIR}/asdf.sh' >> /root/.bashrc

# Install JRuby via asdf
ENV JRUBY_VERSION=jruby-9.3.13.0
RUN . ${ASDF_DIR}/asdf.sh && \
    asdf plugin add ruby && \
    asdf install ruby ${JRUBY_VERSION} && \
    asdf global ruby ${JRUBY_VERSION}

ENV PATH="${ASDF_DIR}/shims:${ASDF_DIR}/bin:${PATH}"

WORKDIR /app

# Copy application files
COPY Gemfile* ./
RUN jruby -S gem install bundler && \
    jruby -S bundle install

COPY . .

# Create startup script with JVM arguments
RUN echo '#!/bin/bash\n\
export _JAVA_OPTIONS="--add-opens=java.base/java.io=org.jruby.dist --add-opens=java.base/java.nio=org.jruby.dist --add-opens=java.base/sun.nio.ch=org.jruby.dist --add-opens=java.base/java.lang=org.jruby.dist --add-opens=java.base/java.lang.reflect=org.jruby.dist --add-opens=java.base/java.text=org.jruby.dist --add-opens=java.base/java.util=org.jruby.dist --add-opens=java.base/java.security=org.jruby.dist --add-opens=java.base/java.util.regex=org.jruby.dist --add-opens=java.base/java.net=org.jruby.dist --add-opens=java.management/sun.management=org.jruby.dist --add-opens=java.logging/java.util.logging=org.jruby.dist"\n\
exec jruby -S trinidad --config trinidad.yml\n\
' > /app/start.sh && chmod +x /app/start.sh

EXPOSE 3000

CMD ["/app/start.sh"]
