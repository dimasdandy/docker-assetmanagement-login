FROM openjdk:11.0.7-jre-slim-buster

ENV HOST_POSTGRES=db_login
ENV PORT_POSTGRES=5432
ENV DB_POSTGRES=postgres
ENV USERNAME_POSTGRES=postgres
ENV PASSWORD_POSTGRES=postgres

WORKDIR /app

COPY target/login-0.0.1-SNAPSHOT.jar .

CMD ["java", "-jar", "login-0.0.1-SNAPSHOT.jar"]