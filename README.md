# docker-nanodep

Docker image containing nanodep

## Config

Config using these environment variables for depsyncer:

| ENV VARIABLE                      | Default Value    | Description                                                                        |
|-----------------------------------|------------------|------------------------------------------------------------------------------------|
| API_KEY                           |                  | API key for API endpoints (required)                                               |
| DEBUG                             |                  | Log debug messages                                                                 |
| DBUSER                            |                  | Database username (required)                                                       |
| DBPASS                            |                  | Database password (required)                                                       |
| DBNAME                            |                  | Database name (required)                                                           |
| DBHOST                            | 127.0.0.1        | Database host                                                                      |
| LISTEN                            | 9001             | Listen port                                                                        |

Config using these environment variables for depserver:

| ENV VARIABLE                      | Default Value    | Description                                                                        |
|-----------------------------------|------------------|------------------------------------------------------------------------------------|
| DEPNAMES                          |                  | List of depnames to sync (required)                                                |
| DEBUG                             |                  | Log debug messages                                                                 |
| DEBUG_ASSIGNER                    |                  | Additional debug logging of the device assigner                                    |
| DEBUG_SYNCER                      |                  | Additional debug logging of the device syncer                                      |
| DURATION                          |                  | Duration in seconds between DEP syncs (0 for single sync)                          |
| LIMIT                             | 0                | Limit fetch and sync calls to this many devices (0 for server default)             |
| DBUSER                            |                  | Database username (required)                                                       |
| DBPASS                            |                  | Database password (required)                                                       |
| DBNAME                            |                  | Database name (required)                                                           |
| DBHOST                            | 127.0.0.1        | Database host                                                                      |
| WEBHOOK                           |                  | URL to send requests to                                                            |

Use at you own peril