FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY WebApplication1/ WebApplication1/

WORKDIR /src/WebApplication1/WebApplication1
RUN dotnet restore "WebApplication1.csproj"
RUN dotnet build "WebApplication1.csproj" -c Release -o app/build
RUN dotnet publish "WebApplication1.csproj" -c Release -o app/output

FROM base AS final
COPY --from=build /src/WebApplication1/WebApplication1/app/output .
CMD ASPNETCORE_URLS=http://*:$PORT dotnet WebApplication1.dll
# ENTRYPOINT ["dotnet", "WebApplication1.dll"]