#!/bin/bash

# X_GHOST IP Tracer by YourName

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
RESET='\033[0m'

# Banner
display_banner() {
    clear
    echo -e "${RED}▓▒░ ${BLUE}IP Tracer ${RED}░▒▓▓▒░ ${GREEN}BY X_GHOST ${RED}░▒▓▓▒░ ${YELLOW}TRACE ANY IP ADDRESS ${RED}░▒▓▓▒░"
    echo -e "${CYAN}_________________________________________________________________${RESET}"
    echo
}

# Check dependencies
check_dependencies() {
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}Error: curl is required but not installed.${RESET}"
        exit 1
    fi
    
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}Error: jq is required for JSON parsing. Please install jq.${RESET}"
        exit 1
    fi
}

# IP information display
display_info() {
    echo -e "${GREEN}${BOLD}Tracking IP: ${YELLOW}$1${RESET}"
    echo -e "${CYAN}===============================================${RESET}"
    
    local info=$(curl -s "http://ipinfo.io/$1/json")
    
    echo -e "${BLUE}IP Address: ${WHITE}$(echo $info | jq -r '.ip')"
    echo -e "${BLUE}Hostname: ${WHITE}$(echo $info | jq -r '.hostname')"
    echo -e "${BLUE}City: ${WHITE}$(echo $info | jq -r '.city')"
    echo -e "${BLUE}Region: ${WHITE}$(echo $info | jq -r '.region')"
    echo -e "${BLUE}Country: ${WHITE}$(echo $info | jq -r '.country')"
    echo -e "${BLUE}Location: ${WHITE}$(echo $info | jq -r '.loc')"
    echo -e "${BLUE}Postal: ${WHITE}$(echo $info | jq -r '.postal')"
    echo -e "${BLUE}Timezone: ${WHITE}$(echo $info | jq -r '.timezone')"
    echo -e "${BLUE}Organization: ${WHITE}$(echo $info | jq -r '.org')"
    
    echo -e "${CYAN}===============================================${RESET}"
    echo -e "${MAGENTA}${BOLD}Map: ${WHITE}https://www.openstreetmap.org/#map=10/$(echo $info | jq -r '.loc')${RESET}"
}

# Main function
main() {
    display_banner
    check_dependencies
    
    if [ $# -eq 0 ]; then
        echo -e "${YELLOW}Enter IP address to trace: ${RESET}"
        read -p "" ip
    else
        ip=$1
    fi

    # Validate IP format
    if [[ ! $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "${RED}Error: Invalid IP address format${RESET}"
        exit 1
    fi

    echo -e "\n${GREEN}${BOLD}Starting trace...${RESET}"
    display_info $ip
    
    echo -e "\n${MAGENTA}${BOLD}Trace completed! ${GREEN}${BOLD}Created by X_GHOST${RESET}"
}

# Execute main function
main "$@"
