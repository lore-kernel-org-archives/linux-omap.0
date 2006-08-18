From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: quick test OMAP ALSA driver on H2
Date: Fri, 18 Aug 2006 05:18:07 +0300
Message-ID: <44E5235F.2000103@cc.jyu.fi>
References: <304D2A85A9643F4A991BDDF8D297BBA6041C311A@dlee05.ent.ti.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA6041C311A@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


> The kernel boot log does show H2 TSC2101 is initialized:
> Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
> 13:55:50
> 2006 UTC).
> audio support initialized
> ALSA device list:
>   #0: H2 TSC2101
>
> Do I miss something? (BTW, I have the exact same device nodes as yours).
> I noticed GIT has alsa 1.0.12rc2 while my user library is 1.0.11. Can
> this be the problem? (I don't think it is)
>   
Hi Jian

>From off the list emails I know you got this working by setting up the
alsa util config files.
But just for the record for you and others, I copy pasted the output of
couple of commands
displaying info from the tsc2101 alsa drivers when they are succesfully
loaded and configured.

#root@h6300:/home/lamikr# lsmod
Module Size Used by
hidp 12416 2
irda 116040 0
snd_pcm_oss 56256 0
snd_omap_alsa_tsc2101 19448 1
snd_pcm 86536 2 snd_pcm_oss,snd_omap_alsa_tsc2101
snd_timer 21508 1 snd_pcm
snd_page_alloc 6728 1 snd_pcm
snd_mixer_oss 15104 2 snd_pcm_oss
snd 49048 5
snd_pcm_oss,snd_omap_alsa_tsc2101,snd_pcm,snd_timer,snd_mixer_oss
rfcomm 33880 0
omapts 4720 0
omap_keypad 6936 0
l2cap 19716 10 hidp,rfcomm
hci_uart 15836 0
bluetooth 42524 6 hidp,rfcomm,l2cap,hci_uart
h6300_bt 3456 0

#root@h6300:/home/lamikr# ls -la /proc/asound/
dr-xr-xr-x 5 root root 0 Jan 1 04:05 .
dr-xr-xr-x 73 root root 0 Jan 1 00:00 ..
lrwxrwxrwx 1 root root 5 Jan 1 04:05 TSC2101 -> card0
dr-xr-xr-x 4 root root 0 Jan 1 04:05 card0
-r--r--r-- 1 root root 0 Jan 1 04:05 cards
-r--r--r-- 1 root root 0 Jan 1 04:05 devices
-r--r--r-- 1 root root 0 Jan 1 04:05 modules
dr-xr-xr-x 2 root root 0 Jan 1 04:05 oss
-r--r--r-- 1 root root 0 Jan 1 04:05 pcm
dr-xr-xr-x 2 root root 0 Jan 1 04:05 seq
-r--r--r-- 1 root root 0 Jan 1 04:05 timers
-r--r--r-- 1 root root 0 Jan 1 04:05 version

#root@h6300:/home/lamikr# ls -la /proc/asound/card0/
dr-xr-xr-x 4 root root 0 Jan 1 04:05 .
dr-xr-xr-x 5 root root 0 Jan 1 04:05 ..
-r--r--r-- 1 root root 0 Jan 1 04:05 id
-rw-r--r-- 1 root root 0 Jan 1 04:05 oss_mixer
dr-xr-xr-x 3 root root 0 Jan 1 04:05 pcm0c
dr-xr-xr-x 3 root root 0 Jan 1 04:05 pcm0p

#root@h6300:/home/lamikr# cat /proc/asound/modules
0 snd_omap_alsa_tsc2101
root@h6300:/home/lamikr# cat /proc/asound/devices
0: [ 0] : control
16: [ 0- 0]: digital audio playback
24: [ 0- 0]: digital audio capture
33: : timer

#root@h6300:/home/lamikr# aplay track_01.wav
Playing WAVE 'track_01.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
^XAborted by signal Interrupt...
