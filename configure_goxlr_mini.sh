#! /bin/sh

# Start Jack2 daemon
jack_control eps realtime true

jack_control ds alsa
jack_control dps device hw:GoXLRMini # IMPORTANT: Change `GoXLR` to  `GoXLRMini` if you have the Mini

jack_control dps period 512
jack_control dps rate 48000
jack_control dps nperiods 3

jack_control start


# Load PA Sinks
pactl load-module module-jack-sink channels=2 sink_properties=device.description=GoXLR_System client_name=GoXLR_Sink_System connect=no
pactl load-module module-jack-sink channels=2 sink_properties=device.description=GoXLR_Game client_name=GoXLR_Sink_Game connect=no
pactl load-module module-jack-sink channels=2 sink_properties=device.description=GoXLR_Music client_name=GoXLR_Sink_Music connect=no
pactl load-module module-jack-sink channels=2 sink_properties=device.description=GoXLR_Chat client_name=GoXLR_Sink_Chat connect=no
pactl load-module module-jack-sink channels=2 sink_properties=device.description=GoXLR_Sample client_name=GoXLR_Sink_Sample connect=no

# Load PA Sources
pactl load-module module-jack-source channels=2 source_properties=device.description=GoXLR_Broadcast_Mix client_name=GoXLR_Source_Broadcast_Mix connect=no
pactl load-module module-jack-source channels=2 source_properties=device.description=GoXLR_Chat client_name=GoXLR_Source_Chat connect=no


### Setup default connections

# System Output
jack_connect system:playback_1 GoXLR_Sink_System:front-left
jack_connect system:playback_2 GoXLR_Sink_System:front-right

# Game Output
jack_connect system:playback_3 GoXLR_Sink_Game:front-left
jack_connect system:playback_4 GoXLR_Sink_Game:front-right

# Chat Output
jack_connect system:playback_5 GoXLR_Sink_Chat:front-left
jack_connect system:playback_6 GoXLR_Sink_Chat:front-right

# Music Output
jack_connect system:playback_7 GoXLR_Sink_Music:front-left
jack_connect system:playback_8 GoXLR_Sink_Music:front-right

# Sample Output
jack_connect system:playback_9 GoXLR_Sink_Sample:front-left
jack_connect system:playback_10 GoXLR_Sink_Sample:front-right

# Broadcast Stream Input
jack_connect system:capture_1 GoXLR_Source_Broadcast_Mix:front-left
jack_connect system:capture_2 GoXLR_Source_Broadcast_Mix:front-right

# Chat Input
jack_connect system:capture_3 GoXLR_Source_Chat:front-left
jack_connect system:capture_4 GoXLR_Source_Chat:front-right

## The following isn't strictly necessary but might be useful. ~/.pulse/daemon.conf:
# default-sample-format = float32le
# default-sample-rate = 48000
# realtime-scheduling = yes
# exit-idle-time = -1


