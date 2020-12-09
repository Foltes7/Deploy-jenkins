FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM node:alpine as angular-compiler

WORKDIR /admin

COPY Admin .

RUN npm install &&\
    npm run build-prod


FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY WebApplication1/ WebApplication1/

WORKDIR /src/WebApplication1/WebApplication1
RUN dotnet restore
RUN dotnet publish "WebApplication1.csproj" -c Release -o app/output

FROM base AS final
COPY --from=build /src/WebApplication1/WebApplication1/app/output /app/
COPY --from=angular-compiler /admin/dist/Admin/* /app/wwwroot/admin/
WORKDIR /app
# CMD ASPNETCORE_URLS=http://*:$PORT dotnet WebApplication1.dll
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
