## Domain Digger: Uncovering NS Records

### Overview
*Domain Digger* is a script designed to query and report NS records for a list of domains and their subdomains. The primary objective is to identify potential typographical errors in NS records that could lead to misconfigurations or security vulnerabilities.

### Key Features
- **Subdomain Enumeration:** Uses `sublist3r` to find subdomains for each provided domain.
- **NS Records Query:** Retrieves NS records for all the identified domains and subdomains using the `dig` command.
- **(Coming Soon) WHOIS Lookup Integration:** Future enhancements will include WHOIS lookups to automatically highlight and identify potentially typoed NS records.
