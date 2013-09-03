From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Pandaboard Kernel 3.8.13.6 no HDMI
Date: Tue, 03 Sep 2013 01:44:11 +0100
Message-ID: <522530DB.9080706@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from know-smtprelay-omc-5.server.virginmedia.net ([80.0.253.69]:33013
	"EHLO know-smtprelay-omc-5.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab3ICAt4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Sep 2013 20:49:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The Pandaboard list seems dormant so I am seeking help here.

The previous kernel with HDMI video output was 3.2.7x5.

I built and installed this new kernel with this xorg.conf, it does not 
work.
Section "Device"
         Identifier      "fb0"
         Driver "omapfb"
         Option "fb" "/dev/fb0"
EndSection

Section "Monitor"
         Identifier "HP"
         ModeLine "1920x1080" 148.501  1920 2008 2052 2200  1080 1084 1089
1125 -HSync -VSync
EndSection

Section "Screen"
         Identifier      "screen0"
         Device  "fb0"
         Monitor "HP"
         DefaultDepth    16
         SubSection "Display"
                 Depth   16
                 Modes   "1920x1080" "800x480"
         EndSubSection
EndSection

Mode "800x480"
     # D: 29.001 MHz, H: 31.251 kHz, V: 59.525 Hz
     DotClock 29.002
     HTimings 800 840 888 928
     VTimings 480 503 506 525
     Flags    "-HSync" "-VSync"
EndMode

Using the udlfb driver and an xorg.conf for the Lilliput USB 7" screen 
there is no problem, LXDE is up and running and CRTL-ALT-F1 etc. all 
OK,  but I need the USB screen for the Beaglebone.

root@panda:/etc/X11# lsmod
Module                  Size  Used by
omapdss               253516  0
udlfb                  17703  2
bluetooth             221172  6
snd_usb_audio         115881  0
snd_usbmidi_lib        18680  1 snd_usb_audio
snd_rawmidi            21747  1 snd_usbmidi_lib
snd_hwdep               6190  1 snd_usb_audio
snd_pcm_oss            42617  0
snd_mixer_oss          14244  1 snd_pcm_oss
snd_pcm                84961  2 snd_pcm_oss,snd_usb_audio
snd_page_alloc          5296  1 snd_pcm
snd_timer              20277  1 snd_pcm
snd                    61483  8 
snd_pcm_oss,snd_usb_audio,snd_hwdep,snd_timer,snd_pcm,snd_rawmidi,snd_usbmidi_lib,snd_mixer_oss
soundcore               7260  1 snd
ehci_hcd               54613  0
ohci_hcd               31836  0
root@panda:/etc/X11# ls /lib/modules/3.8.13.6x-dirty/kernel/drivers/video/
backlight  omap2  udlfb.ko
root@panda:/etc/X11# ll 
/lib/modules/3.8.13.6x-dirty/kernel/drivers/video/omap2/omapfb
total 64
drwxr-xr-x 2 root root  4096 Sep  2 10:18 ./
drwxr-xr-x 5 root root  4096 Sep  2 10:18 ../
-rw-r--r-- 1 root root 56916 Sep  2 02:52 omapfb.ko
root@panda:/etc/X11# modprobe omapfb
ERROR: could not insert 'omapfb': No such device
root@panda:/etc/X11# insmod 
/lib/modules/3.8.13.6x-dirty/kernel/drivers/video/omap2/omapfb/omapfb.ko
Error: could not insert module 
/lib/modules/3.8.13.6x-dirty/kernel/drivers/video/omap2/omapfb/omapfb.ko: No 
such device
root@panda:/1/ubuntu-raring# grep CONFIG_FB .config
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_ARMCLCD=y
CONFIG_FB_UVESA=y
CONFIG_FB_TMIO=y
CONFIG_FB_TMIO_ACCELL=y
CONFIG_FB_UDL=m
CONFIG_FB_VIRTUAL=y
CONFIG_OMAP2_VRFB=y
CONFIG_OMAP2_DSS_RFBI=y
CONFIG_FB_OMAP2=m
CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
CONFIG_FB_OMAP2_NUM_FBS=3

root@panda:/etc/X11# grep HDMI /1/ubuntu-raring/.config
CONFIG_OMAP4_DSS_HDMI=y

ONFIG_ARCH_OMAP4=y
CONFIG_MACH_OMAP4_PANDA=y

Displayed on the serial console
=======================
root@panda:~# [34587.439270] omapdss error: timeout reading edid
[34587.445220] omapfb omapfb: failed to allocate framebuffer
[34587.450958] omapfb omapfb: failed to allocate fbmem
[34587.456604] omapfb omapfb: failed to setup omapfb
[34587.461853] failed to register omapfb driver
Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

