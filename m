From: Pavel Machek <pavel@ucw.cz>
Subject: N900 modem support in 3.18-rc1
Date: Tue, 4 Nov 2014 21:51:17 +0100
Message-ID: <20141104205117.GA17606@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

Hi!

I'd like to test a modem (and eventually to get it to work :-) ) on
n900. So far I found:

http://lwn.net/Articles/592485/

It says:

# supported. Testing the patchset with ofono works like this:
# 
#  # provide cmt device for ofono
#  ln -sf /sys/bus/hsi/n900-modem /dev/cmt

root@n900:/dev# ln -sf /sys/bus/hsi/n900-modem /dev/cmt
root@n900:/dev# ls -al /dev/cmt
lrwxrwxrwx 1 root root 23 Jan  1 08:51 /dev/cmt ->
/sys/bus/hsi/n900-modem
root@n900:/dev# cat /dev/cmt
cat: /dev/cmt: No such file or directory
root@n900:/dev# cd /dev/cmt
-bash: cd: /dev/cmt: No such file or directory
root@n900:/dev# 
root@n900:/dev# ls -al /sys/bus/hsi/
devices/           drivers_autoprobe  uevent             
drivers/           drivers_probe      
root@n900:/dev# ls -al /sys/bus/hsi/devices/
cmt_speech/   hsi_char/     n900-modem/   ssi-protocol/ 
root@n900:/dev# ls -al /sys/bus/hsi/devices/n900-modem
lrwxrwxrwx 1 root root 0 Jan  1 08:46 /sys/bus/hsi/devices/n900-modem
->
../../../devices/68000000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
root@n900:/dev# 

That seemed to match, so I symlinked it.

#  # start ofono
#  ofono --nodetach --debug

It it a typo and it wants ofonod?

root@n900:~# ofonod --nodetach --debug &
[1] 3552
root@n900:~# ofonod[3552]: oFono version 1.6

#  # enable the modem
#  mdbus2 -s org.ofono /n900_0 org.ofono.Modem.SetProperty Powered true

root@n900:~# mdbus2 -s org.ofono /n900_0 org.ofono.Modem.SetProperty
Powered true
[ERR]: There is no method with name org.ofono.Modem.SetProperty on
path /n900_0!

#  # enable modem's RF parts
#  mdbus2 -s org.ofono /n900_0 org.ofono.Modem.SetProperty Online true

root@n900:~# mdbus2 -s org.ofono /n900_0 org.ofono.Modem.SetProperty
Online true
[ERR]: There is no method with name org.ofono.Modem.SetProperty on
path /n900_0!

#  # scan for available networks (takes some time)
#  mdbus2 -s org.ofono /n900_0 org.ofono.NetworkRegistration.Scan

root@n900:~# mdbus2 -s org.ofono /n900_0
org.ofono.NetworkRegistration.Scan
[ERR]: There is no method with name org.ofono.NetworkRegistration.Scan
on path /n900_0!

Any ideas? Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
