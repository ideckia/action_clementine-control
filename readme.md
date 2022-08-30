# Action for ideckia: clementine-control

## Definition

Control the [Clementine player](https://www.clementine-player.org/) playback

## Properties

| Name | Type | Description | Shared | Default | Possible values |
| ----- |----- | ----- | ----- | ----- | ----- |
| action | String | Action | false | 'playpause' | [previous,play,next,playpause,shuffle,stop] |
| clementine_auth_code | Int | AuthCode | true | -1 | null |
| clementine_host | String | Host | true | "127.0.0.1" | null |
| clementine_port | Int | Port | true | 5500 | null |

## On single click

Executes the defined action (play, pause, next song...)

## On long press

Does nothing

## Example in layout file

```json
{
    "state": {
        "text": "clementine-control action example",
        "actions": [
            {
                "name": "clementine-control",
                "props": {
                    "action": "playpause",
                    "clementine_auth_code": -1,
                    "clementine_host": "127.0.0.1",
                    "clementine_port": 5500
                }
            }
        ]
    }
}
```

## Configuring Clementine to allow remote connections

Remember that Clementine must be configured to accept connections through its network remote control protocol.

You can configure this through Clementine  `Tools > Preferences > Network remote control` configuration menu. Enable `Use network remote control` and configure the other options for your use case.