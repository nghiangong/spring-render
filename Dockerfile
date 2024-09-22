FROM ubuntu:latest AS build
RUN apt update
RUN apt install openjdk-21 -y

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn package

FROM amazoncorretto:21.0.4

WORKDIR /app
EXPOSE 8080
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]



