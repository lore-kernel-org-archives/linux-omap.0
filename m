From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC] About ARM expansion boards and others things
Date: Wed, 04 May 2011 14:50:30 +0300
Message-ID: <1304509830.2099.42.camel@deskari>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:35477 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753777Ab1EDLuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 07:50:35 -0400
In-Reply-To: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?ISO-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Tue, 2011-05-03 at 19:25 +0200, Enric Balletb=C3=B2 i Serra wrote:
> Hi guys,
> I'm thinking probably in a crazy idea, I hope someone can help me or
> kill definitely this idea from my mind.
>=20
> I'll explain a little more, the real problem is I don't know how to
> add support for an expansion board for IGEP v2 board. I see most of
> boards adds the support inside the board-xxxxx.c file, for example if
> the expansion board has a Touchscreen interface using ADS7846/TSC2046
> they register ads7846 platform data in board-xxxx.c file. This is ok
> beacause the ads7846 can be detected and if expansion board is not
> present  the detection fails, but maybe other devices in expansion
> board can't be detected (for example an I/O expansion). So which is
> the best form to do this ?
>=20
> I'm thinking in create a kernel module for the expansion board that
> add all the new features, the expansion board should come with a I2C
> E2PROM for board ID storage, so the idea is create an i2c driver that
> reads the E2PROM and if found the Board ID inits all the expansion
> board devices.
>=20
> I have done a few experiments, I've created a kernel module (driver)
> for a custom expansion board for IGEP v2,  the expansion board has :
>    - I2C E2PROM
>    - ADS7846 touch controller (spi)
>    - Seiko 7.0inch LCD
>    - General purpose I/O
>=20
> The driver is capable to register correctly i2c and spi devices and
> seems is working but I have problems with the Seiko 7.0inch LCD and
> configuring the MUX from driver.
>=20
> Basically I wonder if it's possible add another omap_dss_device from
> kernel module to the omap DSS driver (something like
> omap_dss_register_new_device). Is a good or bad idea ? Why ? Is any
> reason to not export the MUX functionality to be used for other
> drivers ?

Currently omapdss doesn't let you add dss devices dynamically, they all
need to be there when omapdss is loaded.

There shouldn't be any bigger reason why this couldn't be implemented,
but there just has never been need for it and it will make the code mor=
e
complex, so it has just never been done.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
