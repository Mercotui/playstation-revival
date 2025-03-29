# Flashing Memory Cards

I decided to use an Arduino as an adapter to flash my memory cards.

## Setup MemCARDuino

To get a working MemCARDuino:

Download and extract the [Arduino CLI](https://github.com/arduino/arduino-cli/releases), place it in this directory.

Connect an ESP8266 board to your PC via USB.

Then run the following commands:

```bash
./arduino-cli core update-index
./arduino-cli core install esp8266:esp8266 --config-file ./.cli-config.yml
git clone git@github.com:ShendoXT/memcarduino.git
# arduino-cli expects the .ino file to match the parent directory, rename the repo:
mv memcarduino/ MemCARDuino
./arduino-cli compile --fqbn esp8266:esp8266:d1_mini MemCARDuino
./arduino-cli upload -p /dev/ttyUSB0 --fqbn esp8266:esp8266:d1_mini MemCARDuino
```
 
P.s. you might want to upload with `sudo`, if you are not in the `dailout` group.

The accompanying python script communicates with the Arduino,
to manage the dependencies I added a poetry project:

```bash
sudo dnf install pipx
pipx install poetry
poetry install
```

## Using MemCARDuino

We can use MemCARDuino as:

```bash
# Run check
poetry run python MemCARDuino/memcarduino.py --port /dev/ttyUSB0

# Read from card
poetry run python MemCARDuino/memcarduino.py --port /dev/ttyUSB0 --read card.bin

# Write an image to card
poetry run python MemCARDuino/memcarduino.py --port /dev/ttyUSB0 --write freepsxboot-unirom-fastload-20220919-bios-4.1-1997-12-16-E-318178bf-slot2.mcd
```
