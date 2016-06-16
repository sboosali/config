#!/usr/bin/bash

# osx ps final all processes activity monitor

ps aux

killall distnoted
killall usernoted

# mds_stores
# mds stands for “metadata server”
sudo mdutil -a -i 

# dictation
# com.apple.SpeechRecognitionCore.speechrecognitiond

# not found
killall VTDecoderXPCService
killall iTunes
killall "/Applications/iTunes.app/Contents/MacOS/iTunesHelper.app/Contents/MacOS/iTunesHelper"
