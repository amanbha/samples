#!/bin/bash

CurrentDir=`dirname $0`
ContainerDemoAppPkgDir=$CurrentDir/ContainerDemoAppPkg
ContainerAggregatorServicePkgDir=$ContainerDemoAppPkgDir/ContainerAggregatorPkg
WebFrontServicePkgDir=$ContainerDemoAppPkgDir/WebFrontPkg

# Create Applciation package structure.
mkdir -p $ContainerAggregatorServicePkgDir/Code
mkdir -p $ContainerAggregatorServicePkgDir/Config
mkdir -p $WebFrontServicePkgDir/Code
mkdir -p $WebFrontServicePkgDir/Config
cp $CurrentDir/ContainerDemoApp/ApplicationPackageRoot/ApplicationManifest.xml $ContainerDemoAppPkgDir/ApplicationManifest.xml -f
cp $CurrentDir/ContainerAggregator/PackageRoot/ServiceManifest_Linux.xml $ContainerAggregatorServicePkgDir/ServiceManifest.xml -f
cp $CurrentDir/ContainerAggregator/PackageRoot/Config/Settings.xml $ContainerAggregatorServicePkgDir/Config/Settings.xml -f
cp $CurrentDir/WebFront/PackageRoot/ServiceManifest_Linux.xml $WebFrontServicePkgDir/ServiceManifest.xml -f
cp $CurrentDir/WebFront/PackageRoot/Config/Settings.xml $WebFrontServicePkgDir/Config/Settings.xml -f

# Copy the entrypoint for code packages.
cp $CurrentDir/ContainerAggregator/ContainerAggregator.sh $ContainerAggregatorServicePkgDir/Code/ContainerAggregator.sh -f
cp $CurrentDir/WebFront/WebFront.sh $WebFrontServicePkgDir/Code/WebFront.sh -f


cd ContainerAggregator.Interfaces
dotnet restore -r ubuntu.16.04-x64 -s $HOME/sdk -s https://api.nuget.org/v3/index.json
dotnet build 
cd -

cd Microsoft.ServiceFabric.Samples.Utility
dotnet restore -r ubuntu.16.04-x64 -s $HOME/sdk -s https://api.nuget.org/v3/index.json
dotnet build 
cd -

cd ContainerAggregator
dotnet restore -r ubuntu.16.04-x64 -s $HOME/sdk -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../ContainerDemoAppPkg/ContainerAggregatorPkg/Code/

cd -

cd WebFront
dotnet restore -r ubuntu.16.04-x64 -s $HOME/sdk -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../ContainerDemoAppPkg/WebFrontPkg/Code/
cd -

