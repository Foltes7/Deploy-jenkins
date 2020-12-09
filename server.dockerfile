FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY WebApplication1/ WebApplication1/

WORKDIR /src/WebApplication1/WebApplication1
RUN dotnet restore
RUN dotnet publish "WebApplication1.csproj" -c Release -o app/output

FROM base AS final
COPY --from=build /src/WebApplication1/WebApplication1/app/output /app/
WORKDIR /app
# CMD ASPNETCORE_URLS=http://*:$PORT dotnet WebApplication1.dll
# ENTRYPOINT ["dotnet", "WebApplication1.dll"]

EXPOSE 5000
CMD exec ./WebApplication1 --urls http://+:5000