FROM eclipse-temurin:21-jre-alpine
WORKDIR /server
RUN apk add --no-cache curl jq

# Consultar la API de PaperMC y descargar la última versión oficial de Velocity automáticamente
RUN VERSION=$(curl -s -A "Mozilla/5.0" https://papermc.io | jq -r '.versions[-1]') && \
    BUILD=$(curl -s -A "Mozilla/5.0" https://papermc.io/versions/$VERSION | jq -r '.builds[-1]') && \
    curl -fL -A "Mozilla/5.0" -o velocity.jar "https://papermc.io/versions/$VERSION/builds/$BUILD/downloads/velocity-$VERSION-$BUILD.jar"

# Descargar EaglerXServer y ViaVersion
RUN mkdir -p plugins
RUN curl -fL -A "Mozilla/5.0" -o plugins/EaglerXServer.jar https://github.com
RUN curl -fL -A "Mozilla/5.0" -o plugins/ViaVersion.jar https://papermc.io

# Crear configuración
RUN echo "miclave12345" > /server/forwarding.secret
RUN printf 'config-version = "2.7"\nbind = "0.0.0.0:25577"\nmotd = "<#09add3>Proxy Eaglercraft 26.2"\nshow-max-players = 20\nonline-mode = false\nforce-key-authentication = false\nplayer-info-forwarding-mode = "none"\nforwarding-secret-file = "forwarding.secret"\n\n[servers]\nlobby = "eaglercraft-minecraf.aternos.me:47126"\ntry = ["lobby"]\n\n[forced-hosts]\n' > /server/velocity.toml

EXPOSE 8080
CMD ["java", "-Xms256M", "-Xmx450M", "-jar", "velocity.jar"]
