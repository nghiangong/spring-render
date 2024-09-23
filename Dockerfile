# Stage 1: Build stage
FROM ubuntu:latest AS build

# Cập nhật danh sách gói và cài đặt OpenJDK 21 và Maven
RUN apt-get update && apt-get install -y openjdk-21-jdk maven

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép file cấu hình Maven và mã nguồn
COPY pom.xml .
COPY src ./src

# Biên dịch và đóng gói ứng dụng
RUN mvn clean package

# Stage 2: Run stage
FROM amazoncorretto:21.0.4

# Thiết lập thư mục làm việc
WORKDIR /app

# Mở cổng 8080 cho ứng dụng
EXPOSE 8080

# Sao chép file .jar từ giai đoạn build
COPY --from=build /app/target/*.jar app.jar

# Thiết lập lệnh mặc định để chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
