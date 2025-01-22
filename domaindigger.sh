#!/bin/bash

# ===========================================================
#               Domain Digger: Uncovering NS Records
# ===========================================================
# Version: 1.0
# Description: This script performs subdomain enumeration and
#              queries the NS records of the domains and their subdomains.
# ===========================================================

# Check if a list of domains is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_with_domains>"
    exit 1
fi

domain_file="$1"

if [ ! -f "$domain_file" ]; then
    echo "File '$domain_file' not found!"
    exit 1
fi

# Check for sublist3r availability
if ! command -v sublist3r &> /dev/null; then
    echo -e "[\033[0;31mERROR\033[0m] sublist3r is not installed."
    exit 1
fi

# Create temporary files for subdomains and results
temp_subdomains=$(mktemp)
temp_results=$(mktemp)

# Process each domain
while IFS= read -r domain; do
    echo -e "[\033[0;34mINFO\033[0m] Processing all subdomains for domain: $domain. Please be patient..."
    sublist3r -d "$domain" -o "$temp_subdomains" &> /dev/null

    echo "$domain" >> "$temp_subdomains"

    while IFS= read -r subdomain; do
        if [ -n "$subdomain" ]; then
            dig "$subdomain" NS +short | grep -v '^$' | while IFS= read -r ns; do
                echo "$subdomain has NS: $ns" >> "$temp_results"
            done
        fi
    done < "$temp_subdomains"
done < "$domain_file"

# Display final results in the order queried
echo -e "\n[\033[0;32mRESULT\033[0m] NS records for all domains and subdomains:"
cat "$temp_results"

# Clean up temporary files
rm -f "$temp_subdomains" "$temp_results"
