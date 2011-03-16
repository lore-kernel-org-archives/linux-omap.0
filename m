From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Wed, 16 Mar 2011 12:42:40 +0200
Message-ID: <4D809420.9080709@nokia.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>	<20110315115315.bcd2451b.jhnikula@gmail.com>	<AANLkTimSHRUJthtZ5co7oTjMZ3pBjGLoT40-HpsZUvUK@mail.gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB593024C3075F8@dbde02.ent.ti.com>	<AANLkTi=rZhmku6j2Cq9E3B8jQbT6R9NHishibLK5atNB@mail.gmail.com>	<AANLkTimNGaNME3QGnwZ1fGSQFktPjm2xVLhrnExRSPuP@mail.gmail.com>	<AANLkTinh1x5S1mR1pxod0CG4oXVO05D=AM1eV2TVAszH@mail.gmail.com>	<4D806965.3030800@nokia.com> <AANLkTim95q6eu6M7r5J49-xjqHMn094++tqALaE1U6Zh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:24100 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab1CPKm6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 06:42:58 -0400
In-Reply-To: <AANLkTim95q6eu6M7r5J49-xjqHMn094++tqALaE1U6Zh@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bob Liu <lliubbo@gmail.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "lars@metafoo.de" <lars@metafoo.de>, "paul@pwsan.com" <paul@pwsan.com>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

Hi,

On 03/16/11 11:27, ext Bob Liu wrote:
> On Wed, Mar 16, 2011 at 3:40 PM, Peter Ujfalusi
> <peter.ujfalusi@nokia.com> wrote:
>> On 03/16/11 07:45, ext Bob Liu wrote:
>>>> amixer cset name=3D"HandsfreeR Switch" 1
>>>> amixer cset name=3D"HandsfreeR Mux" 2
>>>> amixer cset name=3D"HandsfreeL Switch" 1
>>>> amixer cset name=3D"HandsfreeL Mux" 2
>>>> amixer cset name=3D"DAC1 Analog Playback Switch" 1
>>>> amixer cset name=3D"DAC1 Analog Playback Volume" 12
>>>> amixer cset name=3D"DAC1 Digital Coarse Playback Volume" 2
>>>> amixer cset name=3D"DAC1 Digital Fine Playback Volume" 50
>>>> amixer cset name=3D"DAC2 Analog Playback Switch" 1
>>>> amixer cset name=3D"DAC2 Analog Playback Volume" 12
>>>> amixer cset name=3D"DAC2 Digital Coarse Playback Volume" 2
>>>> amixer cset name=3D"DAC2 Digital Fine Playback Volume" 50
>>>>
>>>> aplay -D plughw:0,0 -d 5 /mnt/mmc/beethoven.wav
>>
>> AFAIK the Beagle has the the Headset lines routed to the stereo jack=
, so
>> you might want to try:
>>
>> amixer sset 'HeadsetL Mixer AudioL2' on
>> amixer sset 'HeadsetR Mixer AudioR2' on
>>
>> Do apply the gain settings related to DAC2 path. This is the path fo=
r
>> the stereo (2ch mode).
>>
>=20
> Below is my log, I have reboot the system, still no sound.
> Did I missed something?
> Thanks
>=20
> -------------------------------------------
> # amixer sset 'HeadsetL Mixer AudioL2' on
> Simple mixer control 'HeadsetL Mixer AudioL2',0
>   Capabilities: pswitch pswitch-joined penum
>   Playback channels: Mono
>   Mono: Playback [on]
> # amixer sset 'HeadsetR Mixer AudioR2' on
> Simple mixer control 'HeadsetR Mixer AudioR2',0
>   Capabilities: pswitch pswitch-joined penum
>   Playback channels: Mono
>   Mono: Playback [on]
> #
> # amixer cset name=3D"DAC2 Analog Playback Switch" 1
> name=3D"DAC2 Digital Coarse Playback Volume" 2
> amixer cset name=3D"DAC2 Digital Fine Playback Volume" 50
> numid=3D9,iface=3DMIXER,name=3D'DAC2 Analog Playback Switch'
>   ; type=3DBOOLEAN,access=3Drw------,values=3D2
>   : values=3Don,on
> # amixer cset name=3D"DAC2 Analog Playback Volume" 12
> numid=3D7,iface=3DMIXER,name=3D'DAC2 Analog Playback Volume'
>   ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D18,step=
=3D0
>   : values=3D12,12
>   | dBscale-min=3D-24.00dB,step=3D2.00dB,mute=3D0
> # amixer cset name=3D"DAC2 Digital Coarse Playback Volume" 2
> numid=3D5,iface=3DMIXER,name=3D'DAC2 Digital Coarse Playback Volume'
>   ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D2,step=3D=
0
>   : values=3D2,2
>   | dBscale-min=3D0.00dB,step=3D6.00dB,mute=3D0
> # amixer cset name=3D"DAC2 Digital Fine Playback Volume" 50
> numid=3D3,iface=3DMIXER,name=3D'DAC2 Digital Fine Playback Volume'
>   ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D63,step=
=3D0
>   : values=3D50,50
>   | dBscale-min=3D-63.00dB,step=3D1.00dB,mute=3D1
> #
> # aplay ~/alsa/ap.wav
> Playing WAVE '/home/bob/alsa/ap.wav' : Signed 16 bit Little Endian,
> Rate 22050 Hz, Stereo
>=20
> ----------------------------------------------------

I have downloaded the documentation for the BeagleBoard xM.
The stereo audio out jack is connected to the HSOL/R (Headset L/R) of
the codec.
The commands you execute should be correct, but one thing might be miss=
ing:

amixer sset 'Headset' 2

Does this helps?

The Beagle doc has this to say about the audio output:

8.16.3 Audio Output Jack
A single 3.5mm jack is provided on BeagleBoard to support external
stereo audio output
devices such as headphones and powered speakers. This interface is not
amplified and
may require the use of amplified speakers in certain instances.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
