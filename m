From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 15:56:06 +0300
Message-ID: <1337604966.2717.1.camel@deskari>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
	 <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-h/0wILI5wR96rpqBtQ4i"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:37705 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755678Ab2EUM4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 08:56:16 -0400
Received: by lahm15 with SMTP id m15so4606286lah.37
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 05:56:13 -0700 (PDT)
In-Reply-To: <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>


--=-h/0wILI5wR96rpqBtQ4i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here's an updated patch with a fix for the GPIO direction:

=46rom e74be66075d14f7ed55ba3aaa8a166eac6a3e60f Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 21 May 2012 11:28:57 +0300
Subject: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init

Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
remove custom PD GPIO handling for DVI output") moved TFP410 chip's
powerdown-gpio handling from the board files to the tfp410 driver. One
gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
the Beagle board file. This causes the tfp410 driver to fail to request
the gpio on Beagle, causing the driver to fail and thus the DVI output
doesn't work.

Also the powerdown-gpio is initialized as OMAP_PIN_INPUT, whereas it's
an output.

This patch removes the gpio_request_one() from the board file and
changes the pin to OMAP_PIN_OUTPUT.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/=
board-omap3beagle.c
index 8ede8d2..5066080 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -510,9 +510,8 @@ static void __init omap3_beagle_init(void)
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
=20
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
+	/* TFP410 power down GPIO */
+	omap_mux_init_gpio(170, OMAP_PIN_OUTPUT);
=20
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
--=20
1.7.9.5



--=-h/0wILI5wR96rpqBtQ4i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPujtmAAoJEPo9qoy8lh71mUYP/A9NMXEgD3Tj+CTDB0FgUFOW
LbRMdyJyD6Ums2nr+0s/FMg7msscVDn5UCHelQqdepaXUOKqec2nOKh2qgCUeAgJ
OvYaTdU3bmnFsudjcn3kiL+LKasHMAfX+mkac8gYotdiyrr3PIRtp9RkCc9xWuMG
QEbtpyq5mBn6TZJjFgPb8tIa+M6MC8/jfMdsrgnck0PWH/aDUkoUZErm9H+dj/Mf
yleLaly8VIQCBpDmiXbk2pkm87lCKYCMRf6pt5qwMxvzmZfSXDV9CkARjtMxcbpU
Hd/yUcDzz1D3rceAH17BS6DX0TS20msqWD6lBYkeqQvDA5Vd8FdixoyMZjdyIdwQ
o+jaF5viFjwGPXtymbGG0BrQs3saSp6/phDfUFIrbmuXwDh6x2idn10/lqz8MILn
wz0ciDbic1iUSJYd4kCS/YeNo89GIxqgP/D8Y1sdLF4GHMczGCAiemIXLZROUa3N
qGxspqLTSkaNOhl2gpiHA34BstIRfTN1eEfgMYJ2NPQrB4KNO9TMHqmk3oubX/EI
mg2mKWjO06BDBMFIQEBDD0O2blQbKHYsPAo+F+IhTSItsuAqTH46CGSOBfxlVlFG
zUrP/Nbze2RLX3UyA34HpV+HDKFY9NjGT3CuMeiazY2VeZw4SoRIvRW1DzeunvFW
MphihAW4rh34Oqmlw2bS
=Y9nr
-----END PGP SIGNATURE-----

--=-h/0wILI5wR96rpqBtQ4i--

