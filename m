From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v3.4-rc3] MTD: NAND: ams-delta: Fix request_mem_region() failure
Date: Wed, 25 Apr 2012 19:01:14 +0200
Message-ID: <1587089.0XMyH6e1Ic@acer>
References: <1334670557-25640-1-git-send-email-jkrzyszt@tis.icnet.pl> <1335366823.6356.11.camel@koala>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57031 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756158Ab2DYRPq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 13:15:46 -0400
In-Reply-To: <1335366823.6356.11.camel@koala>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Dnia =C5=9Broda, 25 kwietnia 2012 18:13:38 Artem Bityutskiy pisze:
> On Tue, 2012-04-17 at 15:49 +0200, Janusz Krzysztofik wrote:
> > A call to request_mem_region() has been introduced in the omap-gpio
> > driver recently (commit 96751fcbe5438e95514b025e9cee7a6d38038f40,
> > "gpio/omap: Use devm_ API and add request_mem_region"). This change
> > prevented the Amstrad Delta NAND driver, which was doing the same i=
n
> > order to take control over OMAP MPU I/O lines that the NAND device=20
hangs
> > off, from loading successfully.
> >=20
> > There is another driver, omap-keypad, which also manipulates OMAP=20
MPUIO
> > registers, but has never been calling request_mem_region() on=20
startup,
> > so it's not affected by the change in the gpio-omap and works=20
correctly.
> >=20
> > Drop request_mem_region() call and related bits from ams-delta NAND
> > driver.
> >=20
> > Created and tested against linux-3.4-rc3.
> >=20
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>=20
> How about race conditions? Where is the guarantee that these 2 driver=
s
> won't affect each other when doing I/O at the same time to the same H=
W
> resources?

Both drivers use separate subsets of registers that belong to the OMAP1=
=20
MPU I/O device, but are used for controlling different sets of I/O pins=
=2E=20
The NAND driver reads/writes the folowing registers:
- OMAP_MPUIO_INPUT_LATCH,
- OMAP_MPUIO_OUTPUT,
- OMAP_MPUIO_IO_CNTL,
while the keypad driver - the following:
- OMAP_MPUIO_KBR_LATCH,
- OMAP_MPUIO_KBC,
- OMAP_MPUIO_KBD_MASKIT
- OMAP_MPUIO_GPIO_DEBOUNCING.
Both subsets are non-overlapping, and we rely on the drivers being free=
=20
of bugs and doing their job correctly, not stepping on each others'=20
feet, I guess.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
