FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Sao chép file .csproj và restore các dependencies
COPY *.csproj ./
RUN dotnet restore

# Sao chép toàn bộ dự án và build
COPY . .
RUN dotnet publish -c Release -o out

# Chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Lab02.dll"]
