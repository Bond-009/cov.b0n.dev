#!/bin/sh

set -e

cd "$1"

find . -type d -name 'TestResults' -exec rm -r {} +
dotnet test --configuration Release --collect:'XPlat Code Coverage' --settings tests/coverletArgs.runsettings --verbosity minimal
reportgenerator "-title:Jellyfin" "-reporttypes:Html;Badges;JsonSummary" "-reports:tests/**/coverage.cobertura.xml" "-assemblyfilters:-*.Tests" "-targetdir:$2" "-historydir:$3" "-verbosity:Warning"
