# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Sao chép file .csproj và thực hiện restore dependencies
COPY backend/backend.csproj ./backend/
WORKDIR /app/backend
RUN dotnet restore

# Xóa thư mục tạm để tránh xung đột
RUN rm -rf /app/backend/obj /app/backend/bin

# Sao chép toàn bộ mã nguồn và build ứng dụng
COPY . .
RUN dotnet publish -c Release -o out

# Stage 2: Run
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/backend/out .
ENTRYPOINT ["dotnet", "backend.dll"]
