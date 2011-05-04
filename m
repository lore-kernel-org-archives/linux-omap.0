From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [RFC] About ARM expansion boards and others things
Date: Wed, 4 May 2011 13:44:14 +0200
Message-ID: <63B8685A-2382-4BEB-A7C9-E56D0235CFD7@dominion.thruhere.net>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com> <4DC12A59.2010608@gmail.com> <BANLkTingDTjKKHqCcWsms7C+QugVxZQc9w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64521 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab1EDLoV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 07:44:21 -0400
In-Reply-To: <BANLkTingDTjKKHqCcWsms7C+QugVxZQc9w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Enric_Balletb=F2_i_Serra?= <eballetbo@gmail.com>
Cc: Vladimir Pantelic <vladoman@gmail.com>, OMAP-KML List <linux-omap@vger.kernel.org>, linux-arm@vger.kernel.org, Jason Kridner <jkridner@beagleboard.org>, Gerald Coley <gerald@beagleboard.org>, "beagleboard@googlegroups.com Board" <beagleboard@googlegroups.com>


Op 4 mei 2011, om 12:46 heeft Enric Balletb=F2 i Serra het volgende ges=
chreven:

> 2011/5/4 Vladimir Pantelic <vladoman@gmail.com>:
>> Enric Balletb=F2 i Serra wrote:
>>>=20
>>> Hi guys,
>>> I'm thinking probably in a crazy idea, I hope someone can help me o=
r
>>> kill definitely this idea from my mind.
>>>=20
>>> I'll explain a little more, the real problem is I don't know how to
>>> add support for an expansion board for IGEP v2 board. I see most of
>>> boards adds the support inside the board-xxxxx.c file, for example =
if
>>> the expansion board has a Touchscreen interface using ADS7846/TSC20=
46
>>> they register ads7846 platform data in board-xxxx.c file. This is o=
k
>>> beacause the ads7846 can be detected and if expansion board is not
>>> present  the detection fails, but maybe other devices in expansion
>>> board can't be detected (for example an I/O expansion). So which is
>>> the best form to do this ?
>>>=20
>>> I'm thinking in create a kernel module for the expansion board that
>>> add all the new features, the expansion board should come with a I2=
C
>>> E2PROM for board ID storage, so the idea is create an i2c driver th=
at
>>> reads the E2PROM and if found the Board ID inits all the expansion
>>> board devices.
>>=20
>> don't know if you are aware of that:
>>=20
>> http://elinux.org/BeagleBoardPinMux#Expansion_boards
>>=20
>=20
> Yes I know it.
>=20
>> also beagle.c board file has support for some expansion boards
>> already, maybe there is some code to be shared.
>>=20
>>=20
>=20
> But I don't see any support for expansion board in board-omap3beagle.=
c
>  http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;f=3Darch/arm/mach-omap2/board-omap3beagle.c;h=3D33007fd4a0835fd=
298129c9fda30b844707cc08b;hb=3DHEAD
>=20
> i see some patches (not published in mainline) that are reading a
> kernel cmdline. I mean,  the bootloader (u-boot) detects if an
> expansion board is present (mostly via i2c) and then add to the kerne=
l
> cmdline a parameter with the name of the expansion board. The kernel
> reads this parameter and initializes the expansion board devices.
>=20
> But not sure if this is a good solution. What solution do you think i=
s
> better ? Using kernel cmdline or create a separate kernel module for
> every expansion board ?

We went the uboot way with beagle because the I2C subsystem in linux su=
cks for things like this. When we were implementing it there was no san=
e way to do:

1) register eeprom with i2c
2) read eeprom
3) register additional i2c devices on the expansion board

And of course in-kernel muxing didn't work back then.

To illustrate the problem a bit more, all camera sensor boards use the =
same I2C id for the sensor, so you can't register them all at once, you=
 need to know which one is attached. So for the beagleboard xM we'd nee=
d the following:

a) being able to read the eeprom from linux and (re)initialize extra i2=
c devices, SPI, mmc, uart, etc
b) being able to read the ID register from the camera sensor and (re)se=
tup the i2c data and v4l2 stuff

Personally, I don't care where the logic resides, it just needs to work=
 and be expandable.

regards,

Koen--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
