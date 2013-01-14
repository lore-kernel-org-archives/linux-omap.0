From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: McBSP functions not exported
Date: Mon, 14 Jan 2013 09:48:08 +0100
Message-ID: <50F3C648.60101@ti.com>
References: <20130111114846.00005679@unknown> <50F010CF.8020808@ti.com> <ebad79c2234bac82958b7a1deea3ae55@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54472 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916Ab3ANIsQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jan 2013 03:48:16 -0500
In-Reply-To: <ebad79c2234bac82958b7a1deea3ae55@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Barker <paul@paulbarker.me.uk>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi,

On 01/11/2013 05:27 PM, Paul Barker wrote:
>> What functions you were using from the McBSP driver(s)?
>=20
> I'm just using the request, free, start, stop and config functions, t=
hen
> using DMA to copy data.

OK.

>> I have taken a brief look at ADS1672 datasheet. At first glance I wo=
uld think
>> that if you connect the ADC to SPI port of OMAP3 you should be able =
to read
>> the data out as well. On BeagleBoard-xM you should have access to
>> McSPI3 (CS0,
>> CS1) and McSPI4 (CS0).
>=20
> I've just been having a look at the McSPI interface and SPI code in t=
he kernel.
> I can see how to wire this up, use the processor as SPI master and th=
e ADC as
> SPI slave, get the clock running, etc. I need the transfers to be syn=
chronised
> to the data ready signal from the ADC, or I need them to occur at a g=
uaranteed
> frequency. I can't see how to do either of these with the SPI interfa=
ce provided
> by <linux/spi/spi.h>, so looks like I'd have to interface directly wi=
th the
> McSPI hardware. I'll have a bash around, try to get some advice from =
the
> beagleboard@googlegroups.com list and see what I can come up with as =
I think
> that's a bit off topic for this list.

Naturally you would use the data ready line as interrupt source for you=
r
driver. When you receive the interrupt you would issue a read via SPI t=
o get
the result from the chip.

>>> If you have any advice on this or a pointer to a better place to as=
k
>>> this question please let me know.
>>
>> Can you try to see if you can use McSPI for your application?
>>
>> As background: we did not had any other uses of McBSP when I have de=
cided to
>> merge the code and move it out from arch/arm/plat-omap/ This was nee=
ded to be
>> done in any ways. The decision back then was that since we don't hav=
e users
>> for McBSP other than audio, it is going to be moved under sound/soc/=
omap/
>=20
> This makes sense. The only other benefit I can see from exporting the=
 McBSP
> functions again is that audio drivers for custom boards based on OMAP=
 processors
> could then be written as external modules. That's not really what I'm=
 doing here
> though.

I don't see how it could help custom boards. For audio all boards can j=
ust
happily use the McBSP stack + omap-pcm. It could help with boards where=
 the
McBSP is not used for audio. But I think those users could use McSPI in=
stead
of McBSP for their needs.

As a sidenote: The support for SPI like protocols in McBSP only existed=
 on
OMAP1 where we had a stop clocks possibility. In all latest versions of=
 OMAP
removed this possibility and McBSP officially only supports I2S, PCM, T=
DM
protocols. This was another reason to move the McBSP under sound.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
