From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Wed, 16 Mar 2011 17:27:02 +0800
Message-ID: <AANLkTim95q6eu6M7r5J49-xjqHMn094++tqALaE1U6Zh@mail.gmail.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>
	<20110315115315.bcd2451b.jhnikula@gmail.com>
	<AANLkTimSHRUJthtZ5co7oTjMZ3pBjGLoT40-HpsZUvUK@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3075F8@dbde02.ent.ti.com>
	<AANLkTi=rZhmku6j2Cq9E3B8jQbT6R9NHishibLK5atNB@mail.gmail.com>
	<AANLkTimNGaNME3QGnwZ1fGSQFktPjm2xVLhrnExRSPuP@mail.gmail.com>
	<AANLkTinh1x5S1mR1pxod0CG4oXVO05D=AM1eV2TVAszH@mail.gmail.com>
	<4D806965.3030800@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41190 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab1CPJ1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 05:27:03 -0400
Received: by qyk7 with SMTP id 7so3215895qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 02:27:02 -0700 (PDT)
In-Reply-To: <4D806965.3030800@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "lars@metafoo.de" <lars@metafoo.de>, "paul@pwsan.com" <paul@pwsan.com>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

On Wed, Mar 16, 2011 at 3:40 PM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> On 03/16/11 07:45, ext Bob Liu wrote:
>>> amixer cset name="HandsfreeR Switch" 1
>>> amixer cset name="HandsfreeR Mux" 2
>>> amixer cset name="HandsfreeL Switch" 1
>>> amixer cset name="HandsfreeL Mux" 2
>>> amixer cset name="DAC1 Analog Playback Switch" 1
>>> amixer cset name="DAC1 Analog Playback Volume" 12
>>> amixer cset name="DAC1 Digital Coarse Playback Volume" 2
>>> amixer cset name="DAC1 Digital Fine Playback Volume" 50
>>> amixer cset name="DAC2 Analog Playback Switch" 1
>>> amixer cset name="DAC2 Analog Playback Volume" 12
>>> amixer cset name="DAC2 Digital Coarse Playback Volume" 2
>>> amixer cset name="DAC2 Digital Fine Playback Volume" 50
>>>
>>> aplay -D plughw:0,0 -d 5 /mnt/mmc/beethoven.wav
>
> AFAIK the Beagle has the the Headset lines routed to the stereo jack, so
> you might want to try:
>
> amixer sset 'HeadsetL Mixer AudioL2' on
> amixer sset 'HeadsetR Mixer AudioR2' on
>
> Do apply the gain settings related to DAC2 path. This is the path for
> the stereo (2ch mode).
>

Below is my log, I have reboot the system, still no sound.
Did I missed something?
Thanks

-------------------------------------------
# amixer sset 'HeadsetL Mixer AudioL2' on
Simple mixer control 'HeadsetL Mixer AudioL2',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
# amixer sset 'HeadsetR Mixer AudioR2' on
Simple mixer control 'HeadsetR Mixer AudioR2',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
#
# amixer cset name="DAC2 Analog Playback Switch" 1
name="DAC2 Digital Coarse Playback Volume" 2
amixer cset name="DAC2 Digital Fine Playback Volume" 50
numid=9,iface=MIXER,name='DAC2 Analog Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
# amixer cset name="DAC2 Analog Playback Volume" 12
numid=7,iface=MIXER,name='DAC2 Analog Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=18,step=0
  : values=12,12
  | dBscale-min=-24.00dB,step=2.00dB,mute=0
# amixer cset name="DAC2 Digital Coarse Playback Volume" 2
numid=5,iface=MIXER,name='DAC2 Digital Coarse Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=2,step=0
  : values=2,2
  | dBscale-min=0.00dB,step=6.00dB,mute=0
# amixer cset name="DAC2 Digital Fine Playback Volume" 50
numid=3,iface=MIXER,name='DAC2 Digital Fine Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=63,step=0
  : values=50,50
  | dBscale-min=-63.00dB,step=1.00dB,mute=1
#
# aplay ~/alsa/ap.wav
Playing WAVE '/home/bob/alsa/ap.wav' : Signed 16 bit Little Endian,
Rate 22050 Hz, Stereo

----------------------------------------------------
-- 
Regards,
--Bob
