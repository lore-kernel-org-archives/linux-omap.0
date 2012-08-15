From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Wed, 15 Aug 2012 12:31:03 +0300
Message-ID: <1345023063.3494.20.camel@deskari>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-89iK41K9Z9ioZUCTTCpa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:44560 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388Ab2HOJbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 05:31:09 -0400
Received: by lahe6 with SMTP id e6so578482lah.10
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 02:31:06 -0700 (PDT)
In-Reply-To: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org


--=-89iK41K9Z9ioZUCTTCpa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-07-17 at 10:01 -0400, Raphael Assenat wrote:
> Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
>=20

This needed to be converted to work with latest kernel. See patch below.
I've applied the patch to my dev branch, mail me if it's not correct.


commit f4e491f283266b53a926eb3c9017505b04786b9b (HEAD, dev)
Author: Raphael Assenat <raph@8d.com>
Date:   Tue Jul 17 10:01:40 2012 -0400

    OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displ=
ays
   =20
    Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
   =20
    Signed-off-by: Raphael Assenat <raph@8d.com>
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/vid=
eo/omap2/displays/panel-generic-dpi.c
index bc5af25..ae862bb 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -538,6 +538,82 @@ static struct panel_config generic_dpi_panels[] =3D {
 		},
 		.name			=3D "primeview_pd104slf",
 	},
+
+	/* ChiMei G121S1-L01 */
+	{
+		{
+			.x_res		=3D 800,
+			.y_res		=3D 600,
+
+			.pixel_clock	=3D 39700,
+
+			.hfp		=3D 128,
+			.hsw		=3D 1,
+			.hbp		=3D 128,
+
+			.vfp		=3D 28,
+			.vsw		=3D 1,
+			.vbp		=3D 28,
+
+			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
+			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+		},
+		.name			=3D "chimei_g121s1-l01",
+	},
+
+	/* ChiMei G121S1-L02 */
+	{
+		{
+			.x_res		=3D 800,
+			.y_res		=3D 600,
+
+			.pixel_clock	=3D 40000,
+
+			.hfp		=3D 1,
+			.hsw		=3D 256,
+			.hbp		=3D 1,
+
+			.vfp		=3D 1,
+			.vsw		=3D 28,
+			.vbp		=3D 1,
+
+			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
+			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+		},
+		.name			=3D "chimei_g121s1-l02",
+	},
+
+
+	/* ChiMei G121X1-L01 */
+	{
+		{
+			.x_res		=3D 1024,
+			.y_res		=3D 768,
+
+			.pixel_clock	=3D 64900,
+
+			.hfp		=3D 160,
+			.hsw		=3D 1,
+			.hbp		=3D 160,
+
+			.vfp		=3D 38,
+			.vsw		=3D 1,
+			.vbp		=3D 38,
+
+			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
+			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
+			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+		},
+		.name			=3D "chimei_g121x1-l01",
+	},
 };
=20
 struct panel_drv_data {


--=-89iK41K9Z9ioZUCTTCpa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQK2xXAAoJEPo9qoy8lh71GFYP/3Ra2vMJSieHdl47iGJc4uh3
M9TkHFZ4Si5NGedSaYPAq2bJPH6gs15yFeXJKpp5kIdVxlbJhM5JY3oF+mt9TQZq
QWN9oBJXgCA3ew9+IFpQ5jrDGP3Sf5TAjBdPoINeBZwxH+2iPU9HDIXSVPEN2UP2
3xSKmdllpDlfI5ayM9FEztp9HTM2HMVWNJp/6vSzpVAh468Jc9spp/Z4mh3+hMMa
6kuhT6RAoWA+k2GFAieofj/8bZ8gFouq03Z21ZHbPOcDoTo0597rAB/GsUxbFm1J
/EKLhykCI2kg6aY3JXsx0W1a5skjHnLgbJiUzKF0ZbkVmEkh6S1BB9oI2EjCsn2R
6BUXFOQDADUVsu5DDRrAcauTiCTmfAloT5rsoyqKFIzNrWsYNnqRH0Q9pbSjp3HJ
K5qKPRn2mqujL5PmQmhSrPy3sEpRjZF57U45yIqqbuWArLqED+z0moYsI52aZBdH
VltYNhyAe7jVPjCrWhy8/F/1HIWqCDu0x9e6rBus2h8+V8ZkacV/7danIKskjEZ/
R1NnjTbZEqutwlUI4/kUwIqXurnJ2fDVFwWN5w1CLDuo0e64up433uYelFlXf94K
ULsOr1YMKiTiAs0SGXc+Z6Fn7komg6ssoAYF7eo0/p1X6ophbZEa7dhKhBBnYESb
isQP0prgPmguFiE+6cF/
=DKkt
-----END PGP SIGNATURE-----

--=-89iK41K9Z9ioZUCTTCpa--

