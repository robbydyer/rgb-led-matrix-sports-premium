# Raspberry Pi Sports RGB LED Matrix Premium

Software to control a raspberry pi LED matrix.

![example1](assets/mlb_live1.jpg)

This is the Premium version of RGB LED Matrix software for sports, weather, stocks and more. For the free version with limited features, see https://github.com/robbydyer/sports

You muse have an active subscription to use this version. See the [Patreon Page](https://patreon.com/RGBLEDMatrixTickerSoftware) for more info

Premium features include:

- Scroll Mode
- Weather Board
- Stock Board
- Live MLB game view - shows baserunners, pitch count, outs, inning
- Gambling odds

## Current Board Types

- Sports. Shows upcoming, live, and completed games for the day (or the week for football), as well as news headlines:
  - NHL
  - MLB
  - NFL
  - NBA
  - MLS
  - NCAA Football
  - NCAA Men's Basketball
  - English Premiere League
  - PGA Tour Leaderboards
  - UEFA Champions League
  - FIFA World Cup
  - Bundesliga
  - DFB German Pokal
- Weather
- Stocks
- Racing. Currently just shows upcoming event schedule
  - F1
  - Indy Car
- Google Calendar
- Player Stats boards- currently supports MLB and NHL.
- Image Board: Takes a list of directories containg images and displays them. Works with GIF's too!
- Clock
- Sys: Displays basic system info. Currently Mem and CPU usage

#### Table of Contents

- [Getting Help](#getting-help)<br>
- [Installation](#installation)<br>
- [Configuration](#configuration)<br>
- [Running the Board](#running-the-board)<br>
- [Web UI Controller](#web-ui)<br>
- [API Endpoint](#api-endpoints)<br>
- [Contributing/Development](#contributing)<br>
- [Examples](#examples)<br>

## Getting Help

There's a public Discord channel, "RGB Sportsmatrix Help" <https://discord.gg/8vPp4xfdtV>

## Installation

### Supported Pi

This project currently supports all Raspberry Pi's with an armv7l or aarch64 architecture. This includes Pi 3b, 4, Zero 2. Pi's with the armv6 (like the original Pi Zero) architecture are not supported.

You can check your Pi's architecture by running the following command:

```shell
uname -m
```

### Install script

There's a helper install script that pulls the latest release's .deb package and installs it and starts the service. Obviously, piping a
remote script to `sudo bash` is risky, so please take a look at `script/install.sh` to verify nothing nefarious is going on. You can always manually download the .deb package in the [Releases Section](https://github.com/robbydyer/sports/releases/latest). Just make sure to pick the correct one for your architecture.

Run the following command in a Terminal on your Pi

```shell
curl https://raw.githubusercontent.com/robbydyer/rgb-led-matrix-sports-premium/master/script/install.sh | sudo bash
```

### Device Registration

Using the premium version requires a one-time device registration. The script will ask you to open a web URL which will then prompt you to authenticate with Patreon.

```shell
devicesetup
```

### Spotify Setup
To use the Spotify now-playing board, you need to run a one-time setup to connect your device to your Spotify account. You will need to also add your Spotify email address under the `spotifyConfig` section in the configuration file `/etc/sportsmatrix.conf`.

Run the following command and open the provided link an a web browser:
```shell
spotifysetup
```

## Configuration

You can run the app without passing any configuration, it will just use some sane defaults. Currently it only defaults to showing the NHL board. Each board that is enabled will be rotated through. The default location for the config file is `/etc/sportsmatrix.conf`

See the [Full Example Configuration](sportsmatrix.conf.example)<br>

For a list of all possible team abbreviations (including conference/divisions when available), see [this list](all_team_abbreviations.txt)<br>

## Running the Board

If you installed the app with the installer script or a .deb package directly, then the service will run automatically. You can start/stop/restart the service with systemctl commands:

```shell
# stops the service
sudo systemctl stop sportsmatrix

# Restarts the service, like after changes to the config file
sudo systemctl restart sportsmatrix
```

You can also run the app manually in the foreground. The .deb package installs the binary to `/usr/local/bin/sportsmatrix`
NOTE: You *MUST* run the app via sudo. The underlying C library requires it. It does switch to a less-privileged user after the matrix is initialized.

```shell
# Show all CLI options
sportsmatrix --help

# Run with defaults
sudo sportsmatrix.bin run

# With config file
sudo sportsmatrix.bin run -c myconfig.conf

# NHL demo mode
sudo sportsmatrix.bin nhltest
```

## Web UI

There is a (very) basic web UI frontend for managing the board. It is bundled with the binary and served as a single-page app. The UI gives buttons for all the backend [API Endpoints](#api-endpoints). You can also view a rendered version of the board in the "Board" section (make sure your configuration enables this). Front-end dev is not my strongsuit, so it's not particularly pretty.

The Web UI is accessible at `http://[HOSTNAME OR IP]:[PORT]`, where port is whatever you configure the `httpListenPort` in your config file to be. For example, if your Pi's hostname is `mypi` and your configured listen port is `8080`, `http://mypi:8080`

![example1](assets/images/ui4.png) ![example2](assets/images/ui3.png) ![example3](assets/images/ui2.png) ![example4](assets/images/ui1.png)

Example of the Web Board:<br>
![webboard](assets/images/tv_nhl.jpg)

## API endpoints

The Web UI has a built-in doc page describing the API. It also includes an interactive way to test API calls. There's a
button in the nav "API Docs", or you can go to `http://[YOURIP]/docs`

### Special "Jump only" Image directories

If you would like to configure certain image directories to contain "jump only" images (only seen when an API call is made to show them), you can
do so by configuring them like:

```
imageConfig:
  directoryList:
  - directory: /my/image/dir
    jumpOnly: true
```

Then, to display a particular image in that directory, make the API call and pass the desired image name.

```
curl -X POST --header "Content-Type: application/json" -d '{"name":"goal.gif"}' "http://myhost:myport/imageboard.v1.ImageBoard/Jump"
```

## Examples

![NHL example 2](assets/mlb_final1.jpg)

![MLB example](assets/stock1.jpg)

STOCK TICKER
![Stock Ticker](assets/weather1.jpg)

