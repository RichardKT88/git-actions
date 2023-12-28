FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /App
# Copia todo conteudo da pasta raiz para a pasta destino
COPY . ./
# Restaura as camadas do projeto - os csproj - 
RUN dotnet restore
# Builda e Publica uma release
RUN dotnet publish -c Release -o out 

# Builda uma imagem de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /App/out .
ENTRYPOINT ["dotnet", "consoledocker.dll"]
