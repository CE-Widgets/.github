#!/usr/bin/env sh
set -eu
locales='de fr pt it es'
for locale in $locales; do test -f "profile/README.$locale.md"; done
for readme in profile/README.md profile/README.de.md profile/README.fr.md profile/README.pt.md profile/README.it.md profile/README.es.md; do
    for locale in $locales; do [ "$readme" = "profile/README.$locale.md" ] || grep -Fq "README.$locale.md" "$readme"; done
    test "$(grep -o 'https://github.com/CE-Widgets/' "$readme" | wc -l)" -eq 9
done
printf 'Validated localized organization-profile links.\n'
