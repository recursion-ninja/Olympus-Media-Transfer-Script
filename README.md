# Auto Download from Olympus Tough TG-6

This is a set of scripts that automatically download all pictures from the
Olympus TG-6 camera over the WiFi connection.

## Usage

### Configure the script

Edit `Olympus-Media-Transfer.sh`, the configuration section to adjust these variables:

| Variable    | Description                            |
|:------------|:---------------------------------------|
| `DIRECTORY` | The local filepath where the files go. |
| `IP`        | The IP address the camera.             |
| `BASE_URL`  | The URL of the camera's media folder.  |

**Example:**
```
# Configuration
DIRECTORY="/data/share/Camera-TG6"
IP=192.168.0.10
BASE_URL="http://$IP/DCIM/100OLYMP"
```

### Enable the camera

1. Turn on the camera
2. Press the Playback Menu button [⏵]
3. Select "Connection to Smartphone"
4. Select "Private Connecttion" 
5. You will see a QR-CODE alogn with the SSID name and password
6. Connect your local machine to the displayed WiFi network
7. You will see "Connecting your smartphone"

### Invoke the transfer script

```
./Olympus-Media-Transfer.sh
```

## Related

- [toot](https://toot.wales/@niccokunzmann/109138649568136197)
