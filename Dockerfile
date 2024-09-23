# Stage 1: Build stage
FROM maven:3.9.8-amazoncorretto-21 AS build

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
