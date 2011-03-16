From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Wed, 16 Mar 2011 09:40:21 +0200
Message-ID: <4D806965.3030800@nokia.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>	<20110315115315.bcd2451b.jhnikula@gmail.com>	<AANLkTimSHRUJthtZ5co7oTjMZ3pBjGLoT40-HpsZUvUK@mail.gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB593024C3075F8@dbde02.ent.ti.com>	<AANLkTi=rZhmku6j2Cq9E3B8jQbT6R9NHishibLK5atNB@mail.gmail.com>	<AANLkTimNGaNME3QGnwZ1fGSQFktPjm2xVLhrnExRSPuP@mail.gmail.com> <AANLkTinh1x5S1mR1pxod0CG4oXVO05D=AM1eV2TVAszH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:24607 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab1CPHkb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 03:40:31 -0400
In-Reply-To: <AANLkTinh1x5S1mR1pxod0CG4oXVO05D=AM1eV2TVAszH@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bob Liu <lliubbo@gmail.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "lars@metafoo.de" <lars@metafoo.de>, "paul@pwsan.com" <paul@pwsan.com>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

On 03/16/11 07:45, ext Bob Liu wrote:
>> amixer cset name=3D"HandsfreeR Switch" 1
>> amixer cset name=3D"HandsfreeR Mux" 2
>> amixer cset name=3D"HandsfreeL Switch" 1
>> amixer cset name=3D"HandsfreeL Mux" 2
>> amixer cset name=3D"DAC1 Analog Playback Switch" 1
>> amixer cset name=3D"DAC1 Analog Playback Volume" 12
>> amixer cset name=3D"DAC1 Digital Coarse Playback Volume" 2
>> amixer cset name=3D"DAC1 Digital Fine Playback Volume" 50
>> amixer cset name=3D"DAC2 Analog Playback Switch" 1
>> amixer cset name=3D"DAC2 Analog Playback Volume" 12
>> amixer cset name=3D"DAC2 Digital Coarse Playback Volume" 2
>> amixer cset name=3D"DAC2 Digital Fine Playback Volume" 50
>>
>> aplay -D plughw:0,0 -d 5 /mnt/mmc/beethoven.wav

AFAIK the Beagle has the the Headset lines routed to the stereo jack, s=
o
you might want to try:

amixer sset 'HeadsetL Mixer AudioL2' on
amixer sset 'HeadsetR Mixer AudioR2' on

Do apply the gain settings related to DAC2 path. This is the path for
the stereo (2ch mode).

Let me know, if it works.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
