From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: Re: Upcoming merge window and omap NAND patches
Date: Wed, 05 May 2010 07:49:03 +0300
Message-ID: <1273034943.3702.19.camel@localhost>
References: <20100504220803.GN29604@atomide.com>
Reply-To: Artem.Bityutskiy@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26146 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab0EEEzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 00:55:31 -0400
In-Reply-To: <20100504220803.GN29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimal.newwork@gmail.com>, Steve Sakoman <sakoman@gmail.com>, Mike Rapoport <mike@compulab.co.il>

On Wed, 2010-05-05 at 00:08 +0200, ext Tony Lindgren wrote:
> Hi all,
>=20
> There are several omap NAND patches pending, but some basic things
> should be fixed first.
>=20
> 1. The NAND driver needs to stop tinkering with the GPMC registers
>=20
> The omap General Purpose Memory Controller (GPMC) registers are omap
> specific, and not driver specific. Tinkering with these registers
> can cause issues with the other devices on the GPMC.
>=20
> To find out what needs to disappear fomr the NAND driver, just do:
>=20
> $ grep baseaddr drivers/mtd/nand/omap2.c
>=20
> Any GPMC register tinkering needs to happen in arch/arm/mach-omap2/gp=
mc.c.
> If there are not currently GPMC functions to do something in gpmc.c, =
then
> let's add the necessary support there.
>=20
> 2. Passing hardcoded GPMC_CS0_BASE needs to go from the board files
>=20
> Passing hardcoded GPMC virtual addressess is sure way to mess up
> things. This should all become unnecessary once the NAND drivers
> stops messing with the GPMC registers directly.
>=20
> So, as a result, I'm not planning on pushing any omap NAND related
> patches until these basic issues are fixed. I'll mark these patches
> as "Changes requested" in patchwork.kernel.org even if these patches
> don't have anything else wrong with them.
>=20
> Let's fix the basic things for good, and put the other patches on
> hold for a while. Sorry if this causes problems!

Hi,

fair enough. I guess Vimal should address this, as he seems to be the T=
I
mr. NAND, right? :-)

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
