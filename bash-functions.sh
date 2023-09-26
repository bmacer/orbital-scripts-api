#/bin/sh

function get_orbital_token () {
    export ORBITAL_SCRIPTS_BEARER_TOKEN=$(curl 2>/dev/null -X POST -u $ORBITAL_SCRIPTS_CLIENT_ID:$ORBITAL_SCRIPTS_API_KEY  https://$ORBITAL_API_URL/v0/oauth2/token | jq -r .token)
}

function get_organization_scripts () {
    get_orbital_token 2>/dev/null
    curl 2>/dev/null -X GET -H "Authorization: Bearer $ORBITAL_SCRIPTS_BEARER_TOKEN" https://$ORBITAL_API_URL/v0/catalogs/scripts | jq
}

function create_script () {
    if [ -z "$1" ]; then
        echo "Usage: create_script <script_file>"
        return 1
    fi

    get_orbital_token 2>/dev/null
    curl 2>/dev/null -X POST -H "Content-Type: application/json" -d @$1 -H "Authorization: Bearer $ORBITAL_SCRIPTS_BEARER_TOKEN" https://$ORBITAL_API_URL/v0/catalogs/scripts | jq
}

function get_script () {
    if [ -z "$1" ]; then
        echo "Usage: get_script <script_file>"
        return 1
    fi

    get_orbital_token 2>/dev/null
    curl 2>/dev/null -X GET -H "Authorization: Bearer $ORBITAL_SCRIPTS_BEARER_TOKEN" https://$ORBITAL_API_URL/v0/catalogs/scripts/$1 | jq
}

function update_script () {
    if [ -z "$2" ]; then
        echo "Usage: update_script <script_id> <update_config_file>"
        return 1
    fi

    get_orbital_token 2>/dev/null
    curl 2>/dev/null -X PUT -H "Content-Type: application/json" -d @$2 -H "Authorization: Bearer $ORBITAL_SCRIPTS_BEARER_TOKEN" https://$ORBITAL_API_URL/v0/catalogs/scripts/$1 | jq
}

function delete_script () {
    if [ -z "$1" ]; then
        echo "Usage: delete_script <script_id>"
        return 1
    fi

    get_orbital_token 2>/dev/null
    curl 2>/dev/null -X DELETE -H "Authorization: Bearer $ORBITAL_SCRIPTS_BEARER_TOKEN" https://$ORBITAL_API_URL/v0/catalogs/scripts/$1 | jq
}

function schedule_script () {
    if [ -z "$1" ]; then
        echo "Usage: update_script <schedule_script_config_file>"
        return 1
    fi

    get_orbital_token 2>/dev/null
    curl 2>/dev/null -X POST -H "Content-Type: application/json" -d @$1 -H "Authorization: Bearer $ORBITAL_SCRIPTS_BEARER_TOKEN" https://$ORBITAL_API_URL/v0/script | jq
}

function run_script () {
    if [ -z "$1" ]; then
        echo "Usage: run_script <run_script_config_file>"
        return 1
    fi

    get_orbital_token 2>/dev/null
    curl 2>/dev/null -X POST -H "Content-Type: application/json" -d @$1 -H "Authorization: Bearer $ORBITAL_SCRIPTS_BEARER_TOKEN" https://$ORBITAL_API_URL/v0/script/run | jq
}
