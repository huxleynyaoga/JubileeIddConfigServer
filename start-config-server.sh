#!/bin/bash
JAVA_EXEC="/usr/java/jdk-17/bin/java"
export CONFIG_REPO_PATH="file:///u02/Domain/config-server/config-repo/"
export CONFIG_USER="jubilee_admin"
export CONFIG_PWD="secret123"
export ENCRYPTION_KEY="jubilee-key-2024"
export SERVER_PORT=8888

echo "=========================================="
echo "JUBILEE CONFIG SERVER STARTUP"
echo "REPO: $CONFIG_REPO_PATH"
echo "PORT: $SERVER_PORT"
echo "JAVA: $JAVA_EXEC"
echo "=========================================="

$JAVA_EXEC -jar target/config-server-0.0.1-SNAPSHOT.jar \
  --spring.profiles.active=native \
  --spring.security.user.name="$CONFIG_USER" \
  --spring.security.user.password="$CONFIG_PWD" \
  --encrypt.key="$ENCRYPTION_KEY" \
  --spring.cloud.config.server.native.searchLocations="$CONFIG_REPO_PATH" \
  --server.port="$SERVER_PORT" \
  --logging.level.root=INFO \
  --logging.level.com.jubilee=DEBUG