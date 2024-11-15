# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Sao chép file .csproj và thực hiện restore dependencies
COPY backend/backend.csproj ./backend/
WORKDIR /app/backend
RUN dotnet restore
COPY . .
CMD ["dotnet", "run", "--urls", "http://0.0.0.0:5214"]
