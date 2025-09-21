FROM ubuntu:22.04

# Install OpenJDK 17
RUN apt-get update && apt-get install -y openjdk-17-jdk \
    libxext6 libxrender1 libxtst6 libxi6 libxrandr2 libxfixes3 \
    libxcursor1 libxinerama1 libglib2.0-0 libxxf86vm1 libxcomposite1 \
    libxdamage1 libx11-xcb1 mesa-utils libgl1 libgl1-mesa-dri \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY /build/sc-editor-linux64.jar /app/sc-editor-linux64.jar
ENV DISPLAY=:0

# Run the app with JVM exports
ENTRYPOINT ["java", \
  "--add-exports", "java.base/java.lang=ALL-UNNAMED", \
  "--add-exports", "java.desktop/sun.awt=ALL-UNNAMED", \
  "--add-exports", "java.desktop/sun.java2d=ALL-UNNAMED", \
  "-jar", "/app/sc-editor-linux64.jar" ]
