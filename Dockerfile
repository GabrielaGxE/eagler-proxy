FROM eclipse-temurin:21-jre-alpine
WORKDIR /server
RUN apk add --no-cache curl jq

# Descargar Velocity, EaglerXServer y ViaVersion
RUN curl -fL -o velocity.jar https://papermc.io
RUN mkdir -p plugins
RUN curl -fL -o plugins/EaglerXServer.jar https://github.com
RUN curl -fL -o plugins/ViaVersion.jar https://papermc.io

# Crear forwarding.secret y velocity.toml directamente adentro
RUN echo "miclave12345" > /server/forwarding.secret
RUN printf 'config-version = "2.7"\nbind = "0.0.0.0:25577"\nmotd = "<#09add3>Proxy Eaglercraft 26.2"\nshow-max-players = 20\nonline-mode = false\nforce-key-authentication = false\nplayer-info-forwarding-mode = "none"\nforwarding-secret-file = "forwarding.secret"\n\n[servers]\nlobby = "eaglercraft-minecraft.aternos.me:47126"\ntry = ["lobby"]\n\n[forced-hosts]\n' > /server/velocity.toml

EXPOSE 8080
CMD ["java", "-Xms256M", "-Xmx450M", "-jar", "velocity.jar"]
