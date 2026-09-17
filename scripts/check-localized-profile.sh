#!/usr/bin/env sh
set -eu
locales='de fr pt it es'
for locale in $locales; do test -f "profile/README.$locale.md"; done
english_links=$(grep -o 'https://github.com/CE-Widgets/[^)]*' profile/README.md | sort)
common_links=$(printf '%s\n' "$english_links" | grep -v -E '/(food-storage-analyzer|flag-minder)$')
for readme in profile/README.md profile/README.de.md profile/README.fr.md profile/README.pt.md profile/README.it.md profile/README.es.md; do
    for locale in $locales; do [ "$readme" = "profile/README.$locale.md" ] || grep -Fq "README.$locale.md" "$readme"; done
    actual_links=$(grep -o 'https://github.com/CE-Widgets/[^)]*' "$readme" | sort)
    if [ "$readme" = 'profile/README.md' ]; then
        test "$actual_links" = "$english_links"
    else
        test "$actual_links" = "$common_links"
        ! grep -Eq 'https://github\.com/CE-Widgets/(food-storage-analyzer|flag-minder)' "$readme"
    fi
done
printf 'Validated organization-profile links and English-only product listings.\n'
