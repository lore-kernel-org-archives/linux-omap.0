From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Wed, 16 Mar 2011 13:29:18 +0200
Message-ID: <4D809F0E.1000304@nokia.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>	<20110315115315.bcd2451b.jhnikula@gmail.com>	<AANLkTimSHRUJthtZ5co7oTjMZ3pBjGLoT40-HpsZUvUK@mail.gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB593024C3075F8@dbde02.ent.ti.com>	<AANLkTi=rZhmku6j2Cq9E3B8jQbT6R9NHishibLK5atNB@mail.gmail.com>	<AANLkTimNGaNME3QGnwZ1fGSQFktPjm2xVLhrnExRSPuP@mail.gmail.com>	<AANLkTinh1x5S1mR1pxod0CG4oXVO05D=AM1eV2TVAszH@mail.gmail.com>	<4D806965.3030800@nokia.com>	<AANLkTim95q6eu6M7r5J49-xjqHMn094++tqALaE1U6Zh@mail.gmail.com>	<4D809420.9080709@nokia.com> <AANLkTi=3e6SHigDzT3yXh9u6zgDOe=8KpL-UGp3s_EVb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:43740 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab1CPL3g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 07:29:36 -0400
In-Reply-To: <AANLkTi=3e6SHigDzT3yXh9u6zgDOe=8KpL-UGp3s_EVb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bob Liu <lliubbo@gmail.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "lars@metafoo.de" <lars@metafoo.de>, "paul@pwsan.com" <paul@pwsan.com>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

Hi,

On 03/16/11 12:52, ext Bob Liu wrote:
> Yeah, it works!!  Thank you very much.

You welcome!

> So in order to make aplay work I need to set all of these?
> --------------------
> amixer sset 'HeadsetL Mixer AudioL2' on
> amixer sset 'HeadsetR Mixer AudioR2' on
> amixer sset 'Headset' 2
> amixer cset name=3D"DAC2 Analog Playback Switch" 1
> amixer cset name=3D"DAC2 Analog Playback Volume" 12
> amixer cset name=3D"DAC2 Digital Coarse Playback Volume" 2
> amixer cset name=3D"DAC2 Digital Fine Playback Volume" 50
> --------------------
>=20
> And what should I set making arecord also work?

Beagle has the AUXL/R connected to audio in jack.
So you need a line-in type of input, not a mic.

In theory:
amixer sset 'Analog' 1 # 6dB amplification
amixer sset 'Analog Left AUXL' cap
amixer sset 'Analog Right AUXR' cap
amixer sset 'TX1' 'Analog'
amixer sset 'TX1 Digital' 5 # 5db amplification

arecord -Dhw:0 -fdat -twav recording.wav

You can play with the gains, if they are not correct.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
