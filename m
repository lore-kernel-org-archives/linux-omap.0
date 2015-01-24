From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sat, 24 Jan 2015 13:00:00 +0100
Message-ID: <201501241300.00723@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com> <20150113204219.GJ2419@atomide.com> <20150115142536.GC512@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1881668.s5S6y2blRv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:54335 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbAXMAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 07:00:04 -0500
Received: by mail-we0-f172.google.com with SMTP id q59so1822423wes.3
        for <linux-omap@vger.kernel.org>; Sat, 24 Jan 2015 04:00:02 -0800 (PST)
In-Reply-To: <20150115142536.GC512@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

--nextPart1881668.s5S6y2blRv
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 15 January 2015 15:25:36 Sebastian Reichel wrote:
> On Tue, Jan 13, 2015 at 12:42:20PM -0800, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> > > On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > > > It seems we can now drop omap3517 legacy booting support
> > > > to get a bit closer to making all of omap3 boot in
> > > > device tree only mode.
> > > >=20
> > > > All these boards have at least minimal support for
> > > > booting with device tree, and pretty much anything
> > > > supported with the legacy board files can be configured
> > > > also for device tree based booting if not done already.
> > >=20
> > > Ah, very nice.
> > >=20
> > > Just out of curiosity, what are the remaining showstoppers
> > > for the 3430 and 3530 based boards?
> >=20
> > Not much really. We're now printing a warning to get a
> > people to upgrade their systems. So with some boards we
> > need to wait a while.
> >=20
> > Then here are the remaining items that I'm aware of:
> >=20
> > - A regression at least on some n900 with appended DTB not
> > booting
> >=20
> >   properly any longer reported by Pali
> >=20
> > - A regression where the legacy ATAGs don't seem to get
> > properly
> >=20
> >   translated by the uncompress code for atag_rev at least
> >   reported by Pali
> >=20
> > - A few missing .dts files for devkit8000, omap3logic,
> > omap3stalker,
> >=20
> >   omap3pandora and omap3touchbook
> >=20
> > Pali and Sebastian probably know best of any other remaining
> > issues to drop n900 legacy booting.
>=20
> Apart from the bugs there is only one feature-wise regression
> when the system is booted via DT, which is the accelerometer.
> I will (re)send patches for that in the next days.
>=20
> -- Sebastian

Another regression for DT setup (which does not occur for board code):

omap_hsmmc driver does not export slot_name sysfs entry because
it not supported by DT yet. Entry slot_name is used by userspace
application to determinate if mmc block device is internal eMMC
memory or external uSD card. So support for this property also in
DT is needed.

Here is simple patch which fix this problem:

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index 8571027..31ca609 100644
=2D-- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -665,6 +665,7 @@
 };
=20
 &mmc1 {
+	slot-name =3D "external";
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&mmc1_pins>;
 	vmmc-supply =3D <&vmmc1>;
@@ -674,6 +675,7 @@
=20
 /* most boards use vaux3, only some old versions use vmmc2 instead */
 &mmc2 {
+	slot-name =3D "internal";
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&mmc2_pins>;
 	vmmc-supply =3D <&vaux3>;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7c71dcd..cd189eb 100644
=2D-- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2021,6 +2021,8 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_=
pdata(struct device *dev)
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		pdata->pm_caps |=3D MMC_PM_WAKE_SDIO_IRQ;
=20
+	of_property_read_string(np, "slot-name", &pdata->name);
+
 	return pdata;
 }
 #else


With this patch identification works fine:

/ # cat /sys/block/mmcblk0/device/../slot_name=20
external
/ # cat /sys/block/mmcblk1/device/../slot_name=20
internal

Without patch omap_hsmmc driver does not create slot_name.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1881668.s5S6y2blRv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTDiUAACgkQi/DJPQPkQ1IkLACgiLuxGz5zy+BfHSd1PtQjQBBp
L+cAoKBHj5uR+VxIr8Ku6Rqqs/OHSFG+
=8w7M
-----END PGP SIGNATURE-----

--nextPart1881668.s5S6y2blRv--
