### Script to be used with LinuxServer.io DockerBase Image of NZBGet
### Will install MP4Automator (https://github.com/mdhiggins/sickbeard_mp4_automator) and Dependencies


sudo add-apt-repository -qy ppa:mc3man/trusty-media

apt-get -q update
apt-get -q update --fix-missing
apt-get -qy upgrade

easy_install pip

##Dependencies###############
apt-get install -qy git
apt-get install -qy ffmpeg

curl https://bootstrap.pypa.io/ez_setup.py -o - | python

pip install requests 
pip install requests[security]
pip install requests-cache
pip install babelfish
pip install 'guessit<2'
pip install 'subliminal<2'
pip install stevedore
pip install python-dateutil
# pip install deluge-client
pip install qtfaststart


##Get MP4Automator
[[ ! -d /mp4automator/.git ]] && (git clone git://github.com/mdhiggins/sickbeard_mp4_automator.git /mp4automator && chown -R abc:abc /mp4automator)

##Use .ini if present or copy sample
[[ ! -f /mp4automator/autoProcess.ini ]] && (cp /mp4automator/autoProcess.ini.sample /mp4automator/autoProcess.ini)

###NZBGet Script
[[ ! -f /scripts/mp4/NZBGetPostProcess.py ]] && (cp /mp4automator/mp4/NZBGetPostProcess.py /scripts/mp4/)



# test if updates have been disabled
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

cd /mp4automator
git pull
chown -R abc:abc /config
