# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Sao chép file .csproj từ thư mục `src` vào thư mục làm việc
COPY src/*.csproj ./src/
WORKDIR /app/src

# Restore các dependencies
RUN dotnet restore

# Sao chép toàn bộ mã nguồn và build
COPY . .
RUN dotnet publish -c Release -o out

# Stage 2: Run
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/src/out .
ENTRYPOINT ["dotnet", "YourAppName.dll"]
