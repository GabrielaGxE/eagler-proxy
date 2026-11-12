FROM eclipse-temurin:21-jre-alpine
WORKDIR /server
RUN apk add --no-cache curl jq

# Descargar Velocity
RUN curl -fL -o velocity.jar https://papermc.io

RUN mkdir -p plugins

# Descargar EaglerXServer oficial (v1.1.1) y ViaVersion (5.12.2)
RUN curl -fL -o plugins/EaglerXServer.jar https://github.com
RUN curl -fL -o plugins/ViaVersion.jar https://papermc.io

COPY velocity.toml /server/velocity.toml
COPY forwarding.secret /server/forwarding.secret

EXPOSE 8080
CMD ["java", "-Xms256M", "-Xmx450M", "-jar", "velocity.jar"]
