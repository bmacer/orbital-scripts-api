## Purpose

This repository is an unofficial, use-at-your-own-risk demonstration of the Orbital Scripts API.

## Pre-requisites

### Environment Variables

#### ORBITAL_API_URL

See https://orbital.amp.cisco.com/help/api/#orbital-service-addresses.
Depending on your cloud (NAM, EU, APJC), it will be one of the following:

```
export ORBITAL_API_URL=orbital.amp.cisco.com
export ORBITAL_API_URL=orbital.eu.amp.cisco.com
export ORBITAL_API_URL=orbital.apjc.amp.cisco.com
```

#### ORBITAL_SCRIPTS_CLIENT_ID and ORBITAL_SCRIPTS_API_KEY

Following instructions here for Client ID and API key:
https://orbital.amp.cisco.com/help/api/authentication/
https://orbital.eu.amp.cisco.com/help/api/authentication/
https://orbital.apjc.amp.cisco.com/help/api/authentication/

## Setup

Source the `bash-functions.sh` file to gain access to its functions.

```
source ./bash-functions.sh
```

## Usage

### get_orbital_token

This is a helper function, used for authentication, but if you want to run it alone, it will exchange your client ID and API key for a bearer token, which will be stored in environment variable `ORBITAL_SCRIPTS_BEARER_TOKEN`.

```
get_orbital_token
echo $ORBITAL_SCRIPTS_BEARER_TOKEN
eyJhbGciOiJSU<...snip...>K_knBDuorrVw
```

### create_script

There are two parts to creating a script--the script itself (Python), and the configuration object (JSON). For our example we will use `example-script.py` as the script and `example-script-config.json` as the configuration.

The script gets inserted into the configuration as a base-64 encoded string. So let's encode our script:

```
cat example-script.py | base64
IyBleGFtcGxlLnB5CmltcG9ydCBvcwpwcmludCgnSGVsbG8ge3sgLmZpcnN0X25hbWUgfX0ge3sgLmxhc3RfbmFtZSB9fScpCnByaW50KGYiVGhlIGZpbGVzIGluIHtvcy5nZXRjd2QoKX0gYXJlOiB7b3MubGlzdGRpcigpfSIp
```

We will put this in our `example-script-config.json` under `script` > `content`. Notice this example also demonstrates how to create a script that accepts arguments (`first_name` and `last_name`)

Now we can create the script:

```
create_script example-script-config.json
```

```json
{
  "data": {
    "ID": "org:123445",
    "title": "Example Orbital Script Using the API23",
    "created": "0001-01-01T00:00:00Z",
    "creator": "836d5219-ed59-46d8-9ffa-2bf692273409",
    "organization": "ee7c29d8-4b78-4a30-ba27-06bc34a7d7fb",
    "config": {
      "version": "1.20",
      "platform": ["darwin", "windows"],
      "description": "Example Orbital Script Using API, will print first and last name of arguments, and print the files in the current directory.",
      "script": {
        "content": "IyBleGFtcGxlLnB5CmltcG9ydCBvcwpwcmludCgnSGVsbG8ge3sgLmZpcnN0X25hbWUgfX0ge3sgLmxhc3RfbmFtZSB9fScpCnByaW50KGYiVGhlIGZpbGVzIGluIHtvcy5nZXRjd2QoKX0gYXJlOiB7b3MubGlzdGRpcigpfSIp",
        "label": "string",
        "name": "Print first and last name script3",
        "args": [
          {
            "name": "first_name",
            "value": "DEFAULT_FIRST",
            "description": "first name",
            "optional": true
          },
          {
            "name": "last_name",
            "value": "DEFAULT_LAST",
            "description": "last name",
            "optional": true
          }
        ],
        "timeout": 30
      }
    }
  },
  "errors": null
}
```

### get_script

To get a single script by ID, pass the id as an argument:

```
get_script org:101
```

```json
{
  "data": {
    "ID": "org:101",
    "title": "Example Orbital Script Using the API23",
    "created": "2023-09-26T11:50:04.373457Z",
    "creator": "836d5219-ed59-46d8-9ffa-2bf692273409",
    "organization": "ee7c29d8-4b78-4a30-ba27-06bc34a7d7fb",
    "config": {
      "version": "1.20",
      "platform": ["darwin", "windows"],
      "description": "Example Orbital Script Using API, will print first and last name of arguments, and print the files in the current directory.",
      "script": {
        "content": "IyBleGFtcGxlLnB5CmltcG9ydCBvcwpwcmludCgnSGVsbG8ge3sgLmZpcnN0X25hbWUgfX0ge3sgLmxhc3RfbmFtZSB9fScpCnByaW50KGYiVGhlIGZpbGVzIGluIHtvcy5nZXRjd2QoKX0gYXJlOiB7b3MubGlzdGRpcigpfSIp",
        "label": "string",
        "name": "Print first and last name script3",
        "args": [
          {
            "name": "first_name",
            "value": "DEFAULT_FIRST",
            "description": "first name",
            "optional": true
          },
          {
            "name": "last_name",
            "value": "DEFAULT_LAST",
            "description": "last name",
            "optional": true
          }
        ],
        "timeout": 30
      }
    },
    "updated": "2023-09-26T11:59:02.348241Z"
  },
  "errors": null
}
```

If the script ID is not found:

```
get_script org:102
```

```json
{
  "errors": ["catalog script not available"]
}
```

### delete_script

To delete a script, pass the id as an argument. The script will return upon successful deletion.

```
delete_script org:101
```

```json
{
  "data": {
    "ID": "org:101",
    "title": "Example Orbital Script Using the API23",
    "created": "2023-09-26T11:50:04.373457Z",
    "creator": "836d5219-ed59-46d8-9ffa-2bf692273409",
    "organization": "ee7c29d8-4b78-4a30-ba27-06bc34a7d7fb",
    "config": {
      "version": "1.20",
      "platform": ["darwin", "windows"],
      "description": "[Changed] Example Orbital Script Using API, will print first and last name of arguments, and print the files in the current directory.",
      "script": {
        "content": "IyBleGFtcGxlLnB5CmltcG9ydCBvcwpwcmludCgnSGVsbG8ge3sgLmZpcnN0X25hbWUgfX0ge3sgLmxhc3RfbmFtZSB9fScpCnByaW50KGYiVGhlIGZpbGVzIGluIHtvcy5nZXRjd2QoKX0gYXJlOiB7b3MubGlzdGRpcigpfSIp",
        "label": "string",
        "name": "Print first and last name script3",
        "args": [
          {
            "name": "first_name",
            "value": "DEFAULT_FIRST",
            "description": "first name",
            "optional": true
          },
          {
            "name": "last_name",
            "value": "DEFAULT_LAST",
            "description": "last name",
            "optional": true
          }
        ],
        "timeout": 30
      }
    },
    "updated": "2023-09-26T11:59:02.348241Z"
  },
  "errors": null
}
```

If the script doesn't exist or has already been deleted:

```
delete_script org:101
{
  "errors": [
    "{<nil> [catalog script not found]}"
  ]
}
```

### update_script

To update a script, pass the script ID and file path of the updated configuration.

```
update_script org:104 example-script-update.json
```

```json
{
  "data": {
    "ID": "org:104",
    "title": "Example Orbital Script Using the API23",
    "created": "2023-09-26T12:09:36.709854Z",
    "creator": "836d5219-ed59-46d8-9ffa-2bf692273409",
    "organization": "ee7c29d8-4b78-4a30-ba27-06bc34a7d7fb",
    "config": {
      "version": "1.20",
      "platform": ["darwin", "windows"],
      "description": "[Changed] Example Orbital Script Using API, will print first and last name of arguments, and print the files in the current directory.",
      "script": {
        "content": "IyBleGFtcGxlLnB5CmltcG9ydCBvcwpwcmludCgnSGVsbG8ge3sgLmZpcnN0X25hbWUgfX0ge3sgLmxhc3RfbmFtZSB9fScpCnByaW50KGYiVGhlIGZpbGVzIGluIHtvcy5nZXRjd2QoKX0gYXJlOiB7b3MubGlzdGRpcigpfSIp",
        "label": "string",
        "name": "Print first and last name script3",
        "args": [
          {
            "name": "first_name",
            "value": "DEFAULT_FIRST",
            "description": "first name",
            "optional": true
          },
          {
            "name": "last_name",
            "value": "DEFAULT_LAST",
            "description": "last name",
            "optional": true
          }
        ],
        "timeout": 30
      }
    },
    "updated": "2023-09-26T05:12:50.194264586-07:00"
  },
  "errors": null
}
```
