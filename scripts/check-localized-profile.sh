#!/usr/bin/env sh
set -eu
locales='de fr pt it es'
for locale in $locales; do test -f "profile/README.$locale.md"; done
english_links=$(grep -o 'https://github.com/CE-Widgets/[^)]*' profile/README.md | sort)
for readme in profile/README.md profile/README.de.md profile/README.fr.md profile/README.pt.md profile/README.it.md profile/README.es.md; do
    for locale in $locales; do [ "$readme" = "profile/README.$locale.md" ] || grep -Fq "README.$locale.md" "$readme"; done
    actual_links=$(grep -o 'https://github.com/CE-Widgets/[^)]*' "$readme" | sort)
    test "$actual_links" = "$english_links"
done
printf 'Validated organization-profile links and synchronized product listings.\n'
