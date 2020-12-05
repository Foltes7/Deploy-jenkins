FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY WebApplication1/WebApplication1/ WebApplication1/

WORKDIR /src/WebApplication1
RUN dotnet restore "WebApplication1.csproj"
RUN dotnet build "WebApplication1.csproj" -c Release -o app/build
RUN dotnet publish "WebApplication1.csproj" -c Release -o app/output

FROM base AS final
COPY --from=build /src/WebApplication1/app/output .
CMD ASPNETCORE_URLS=http://*:$PORT dotnet WebApplication1.dll
# ENTRYPOINT ["dotnet", "WebApplication1.dll"]