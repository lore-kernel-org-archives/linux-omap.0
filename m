From: Tuomas Kulve <tuomas.kulve@movial.fi>
Subject: Re: Patch to enable omapfb scaling
Date: Mon, 03 Nov 2008 17:03:01 +0200
Message-ID: <490F12A5.1000900@movial.fi>
References: <490AE1A0.70609@movial.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC0F5374030B7C3901FEC56D1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.movial.fi ([62.236.91.34]:41096 "EHLO smtp.movial.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755667AbYKCPDE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Nov 2008 10:03:04 -0500
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 7F7ECC80D7
	for <linux-omap@vger.kernel.org>; Mon,  3 Nov 2008 17:03:01 +0200 (EET)
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id N00+MNMMLXro for <linux-omap@vger.kernel.org>;
	Mon,  3 Nov 2008 17:03:01 +0200 (EET)
Received: from [172.17.49.56] (sd056.hel.movial.fi [172.17.49.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 4FE04C80D3
	for <linux-omap@vger.kernel.org>; Mon,  3 Nov 2008 17:03:01 +0200 (EET)
In-Reply-To: <490AE1A0.70609@movial.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0F5374030B7C3901FEC56D1
Content-Type: multipart/mixed;
 boundary="------------060107010803030305060206"

This is a multi-part message in MIME format.
--------------060107010803030305060206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tuomas Kulve wrote:
> Hi
>=20
> The attached patch enables omapfb scaling. Tested on omap3 based
> beagleboard with 2.6.27-omap1 kernel from linux-omap kernel tree.

The 0002 patch implements downscaling in omapfb. It seems to work on
ES3.0 beagleboard and ES2.1 EVM but not on my rev B5 beagleboard.

The patch still needs cleanup but it should work with e.g. X.Org's XV
extension:

http://gitweb.pingu.fi/?p=3Dxf86-video-omapfb.git;a=3Dsummary


--=20
Tuomas Kulve, Movial Creative Technologies Inc.
Porkkalankatu 13J, FI-00180 Helsinki
Fax +358 9 8567 6401, Tel +358 9 8567 6400
www.movial.com

--------------060107010803030305060206
Content-Type: text/x-patch;
 name="0002-Implemented-video-downsampling-in-omapfb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="0002-Implemented-video-downsampling-in-omapfb.patch"

=46rom 069ce763b1a7e936b7b2bdc288d94dd98e477d7e Mon Sep 17 00:00:00 2001
From: Tuomas Kulve <tuomas.kulve@movial.com>
Date: Mon, 3 Nov 2008 11:22:56 +0200
Subject: [PATCH] Implemented video downsampling in omapfb.

---
 drivers/video/omap/dispc.c |   58 ++++++++++++++++++++++++++++++++++++++=
++----
 1 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 68bc887..83f37bf 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -545,6 +545,17 @@ static void write_firhv_reg(int plane, int reg, u32 =
value)
 	dispc_write_reg(base + reg * 8,	value);
 }
=20
+static void write_firv_reg(int plane, int reg, u32 value)
+{
+	u32 base;
+
+	if (plane =3D=3D 1)
+		base =3D 0x1E0;
+	else
+		base =3D 0x1E0 + 0x20;
+	dispc_write_reg(base + reg * 4,	value);
+}
+
 static void set_upsampling_coef_table(int plane)
 {
 	const u32 coef[][2] =3D {
@@ -565,6 +576,27 @@ static void set_upsampling_coef_table(int plane)
 	}
 }
=20
+static void set_downsampling_coef_table(int plane)
+{
+	const u32 coef[][3] =3D {
+		{ 0x24382400, 0x24382400, 0x00000000 },
+		{ 0x28371FFE, 0x28391F04, 0x000004FE },
+		{ 0x2C361BFB, 0x2D381B08, 0x000008FB },
+		{ 0x303516F9, 0x3237170C, 0x00000CF9 },
+		{ 0x11343311, 0x123737F7, 0x0000F711 },
+		{ 0x1635300C, 0x173732F9, 0x0000F90C },
+		{ 0x1B362C08, 0x1B382DFB, 0x0000FB08 },
+		{ 0x1F372804, 0x1F3928FE, 0x0000FE04 },
+	};
+	int i;
+
+	for (i =3D 0; i < 8; i++) {
+		write_firh_reg(plane, i, coef[i][0]);
+		write_firhv_reg(plane, i, coef[i][1]);
+		write_firv_reg(plane, i, coef[i][2]);
+	}
+}
+
 static int omap_dispc_set_scale(int plane,
 				int orig_width, int orig_height,
 				int out_width, int out_height)
@@ -592,16 +624,32 @@ static int omap_dispc_set_scale(int plane,
 		if (orig_height > out_height ||
 		    orig_width * 8 < out_width ||
 		    orig_height * 8 < out_height) {
+			dev_dbg(dispc.fbdev->dev,
+				"Max upsampling is 8x, "
+				"tried: %dx%d -> %dx%d\n",
+				orig_width, orig_height,
+				out_width, out_height);
 			enable_lcd_clocks(0);
 			return -EINVAL;
 		}
 		set_upsampling_coef_table(plane);
 	} else if (orig_width > out_width) {
-		/* Downsampling not yet supported
-		*/
-
-		enable_lcd_clocks(0);
-		return -EINVAL;
+		/*
+		 * Downsampling.
+		 * Currently you can only scale both dimensions in one way.
+		 */
+		if (orig_height < out_height ||
+		    orig_width > out_width * 4 ||
+		    orig_height > out_height * 4) {
+			dev_dbg(dispc.fbdev->dev,
+				"Max downsampling is 4x, "
+				"tried: %dx%d -> %dx%d\n",
+				orig_width, orig_height,
+				out_width, out_height);
+			enable_lcd_clocks(0);
+			return -EINVAL;
+		}
+		set_downsampling_coef_table(plane);
 	}
 	if (!orig_width || orig_width =3D=3D out_width)
 		fir_hinc =3D 0;
--=20
1.5.6.5


--------------060107010803030305060206
Content-Type: text/x-patch;
 name*0="0003-Calculate-fir_-inc-using-resolution-minus-one-in-oma.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0003-Calculate-fir_-inc-using-resolution-minus-one-in-oma.pa";
 filename*1="tch"

=46rom fd41a240a99de4c1408097bb39fa89cec4b7868d Mon Sep 17 00:00:00 2001
From: Tuomas Kulve <tuomas.kulve@movial.com>
Date: Fri, 31 Oct 2008 20:05:26 +0200
Subject: [PATCH] Calculate fir_*inc using resolution minus one in omapfb =
scaling.

---
 drivers/video/omap/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 83f37bf..7ac4a86 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -654,11 +654,11 @@ static int omap_dispc_set_scale(int plane,
 	if (!orig_width || orig_width =3D=3D out_width)
 		fir_hinc =3D 0;
 	else
-		fir_hinc =3D 1024 * orig_width / out_width;
+		fir_hinc =3D 1024 * (orig_width - 1) / (out_width - 1);
 	if (!orig_height || orig_height =3D=3D out_height)
 		fir_vinc =3D 0;
 	else
-		fir_vinc =3D 1024 * orig_height / out_height;
+		fir_vinc =3D 1024 * (orig_height - 1) / (out_height - 1);
 	dispc.fir_hinc[plane] =3D fir_hinc;
 	dispc.fir_vinc[plane] =3D fir_vinc;
=20
--=20
1.5.6.5


--------------060107010803030305060206--

--------------enigC0F5374030B7C3901FEC56D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJDxKllNBpRwkGRGMRAnz0AKC2kPdj2WALFQg41zhJFqy+Bus+hgCg9xFc
amcIBMWGUYJkpwmuQBLrzdw=
=N3Sp
-----END PGP SIGNATURE-----

--------------enigC0F5374030B7C3901FEC56D1--
