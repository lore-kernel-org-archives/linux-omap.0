From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V5 0/6] OMAPDSS: Cleanup cpu_is checks
Date: Thu, 30 Aug 2012 10:34:21 +0300
Message-ID: <1346312061.2327.27.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <cover.1345468541.git.cmahapatra@ti.com>
	 <20120830002039.GP1303@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Ke/cRf7PDsxt/iaRTyVn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59458 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751366Ab2H3Hed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 03:34:33 -0400
Received: by lbbgj3 with SMTP id gj3so299471lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 00:34:30 -0700 (PDT)
In-Reply-To: <20120830002039.GP1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Ke/cRf7PDsxt/iaRTyVn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-29 at 17:20 -0700, Tony Lindgren wrote:
> * Chandrabhanu Mahapatra <cmahapatra@ti.com> [120820 06:26]:
> > Hi everyone,
> > this patch series aims at cleaning up of DSS of cpu_is checks thereby m=
aking it
> > more generic.
> >=20
> > The 1st patch cleans up cpu_is checks from DISPC code.
> > The 2nd patch removes unused functions from DSS code.
> > The 3rd patch cleans up cpu_is checks from DSS code.
> > The 4th patch removes cpu_is checks from VENC code.
> > The 5th patch disables VENC support on OMAP4.
> > The 6th patch removes cpu_is checks from DPI code and replaces it with =
a
> > dss feature.
>=20
> Good to see this, we need this badly to avoid blocking
> single zImage effort on omaps. Can you also please take

What is the issue with single zImage? How do cpu_is_ check affect it?

> a look at the omap dss headers and make sure that
> drivers/video/omap code does not do any #include <mach/*.h>
> or <plat/*.h>?
>=20
> The driver specific headers should be now moved to live in
> include/linux/platform_data directory instead of the current
> arch/arm/*omap*/include/*.

I had a brief look at drivers/video/omap*. Here's a brief status. I
don't really know much about the old fb driver (drivers/video/omap) so
my comments may not be totally correct. And all fixing I do there is
done in blind, I don't have any omap1 devices.

I've left out the trivial cleanups from the list (i.e. file includes a
header that it doesn't need), there were a bunch of those. I'll make a
patch for these.


$ git grep -E "<plat|<mach" drivers/video/omap*
drivers/video/omap/lcd_ams_delta.c:#include <plat/board-ams-delta.h>
* Needs to be moved
* lcd_ams_delta uses also omap_write/read

drivers/video/omap/lcd_inn1510.c:#include <plat/fpga.h>
* No idea about this. Who wants to convert the fpga support? =3D)

drivers/video/omap/lcd_mipid.c:#include <plat/lcd_mipid.h>
* Needs to be moved

drivers/video/omap/lcd_osk.c:#include <plat/mux.h>
* Uses omap_cfg_reg(PWL). I don't know what this is...
* lcd_osk.c uses omap_write/read

drivers/video/omap/lcdc.c:#include <mach/lcdc.h>
* Needs to be moved

drivers/video/omap/lcdc.c:#include <plat/dma.h>
* Uses arch/arm/mach-omap1/lcd_dma.c. Any idea about this? Will DMA
engine support OMAP1's LCD DMA?

drivers/video/omap/omapfb_main.c:#include <plat/dma.h>
* Uses DMA API to set DMA priority

drivers/video/omap/sossi.c:#include <plat/dma.h>
* Uses arch/arm/mach-omap1/lcd_dma.c

drivers/video/omap2/dss/dss.c:#include <plat/cpu.h>
* Uses cpu_is_* to find out the DSS version. dispc.c also uses cpu_is_*
functions, but doesn't include plat/cpu.h. I know cpu_is_* checks should
be removed, but is there some other file to include for the time being
than plat/cpu.h?

drivers/video/omap2/dss/dss_features.c:#include <plat/cpu.h>
* Uses cpu_is_* to find out the DSS version

drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vrfb.h>
drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vram.h>
drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vram.h>
drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vrfb.h>
drivers/video/omap2/omapfb/omapfb-sysfs.c:#include <plat/vrfb.h>
drivers/video/omap2/vram.c:#include <plat/vram.h>
drivers/video/omap2/vram.c:#include <plat/dma.h>
drivers/video/omap2/vrfb.c:#include <plat/vrfb.h>
drivers/video/omap2/vrfb.c:#include <plat/sdrc.h>

Of these, I'm not sure how to handle.

Grep shows that vram.c is only used by (the newer) omapfb, so it could
be considered a part of that driver. It still needs to be built-in, as
it needs to reserve memory early in the boot process (done with a call
from arch/arm/plat-omap/common.c).

Also board files can use a func call to define the amount of memory to
allocate, but only rx51 seems to do this in the mainline.

Anyway, I believe vram.c is going away when we start to use CMA.


As for vrfb... I'm not really sure where it belongs. It is used by the
newer omapfb and OMAP V4L2 driver. VRFB is a part of the OMAP's memory
controller, so I'm not sure if it's really a normal driver.

 Tomi


--=-Ke/cRf7PDsxt/iaRTyVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQPxd9AAoJEPo9qoy8lh71k5sP/iZQGFGyOcIzTfcnd4kCBGaq
bM/1TuttC6I3sW+saV3Km8RSlNFjLsRZoAJINqqX0A6tQRo27X48OenDRaxZiSAJ
NfQHU9jT6W2yXNxbi0h/7gU9ihUfIyESfcqyym12PN7uhKlRwBqc1cnb0r/Iqj2a
wUYLm31aCDIwmFIT5Zr9N9N/36TEUCQgSM93fjaXYJzyOejjU1GibxCjQauA2YyA
VwPO7bL5LGOJRYNqts7h+GM8myoExEooQyNnnWcKwTgpp0nFKToW9fLBMPGOY9c6
dUrWFN7Lz2XAGJWvFiB/c+EaHXF3eCQ/y+Bga5nCa+FGAySrZCiJhfu2xA5tZKr1
o36ytEIeaqa+G4MXTY8cQJSX6WKN2Kd9m4Oy6i2XnzRWaj3AxUvWYkAOOJK/PFCY
uaKndt0YIkqzt1x0zFkdLQ8DMl8Zz++xkIvuq0jGVu6rHU5GLoLEOf/JzRMp1MKA
Yva8G4EQwKb+Dsc0+KPDegDKvsl+s7BOp44X24E0n5HUke3o+Ta9uTNp7tmyAPo3
y52J9WGLmU8tXkDIiwWC+9mBmZq/Q1uS1cRxHKFCPQtGuK+qxcI1pSaE3TuX96Zx
kwvjIijcFrlf58S0IYW+P9ez8ct+eeIHg4oDiwkHxpfxd8QB2uuJEzOdPAB8uhQQ
qCXORMw6smcF1kPq66b9
=Nqm8
-----END PGP SIGNATURE-----

--=-Ke/cRf7PDsxt/iaRTyVn--

