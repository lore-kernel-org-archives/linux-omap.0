From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP4: panda: add statics to remove warnings
Date: Wed, 25 Apr 2012 15:29:11 +0300
Message-ID: <1335356951.2799.5.camel@deskari>
References: <1335166780-5899-1-git-send-email-tomi.valkeinen@ti.com>
	 <20120424171630.GQ3739@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ls9UEhLNuucyp0ycINzo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:51362 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752538Ab2DYM3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 08:29:16 -0400
Received: by lbjn8 with SMTP id n8so25435lbj.6
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 05:29:13 -0700 (PDT)
In-Reply-To: <20120424171630.GQ3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--=-ls9UEhLNuucyp0ycINzo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-04-24 at 10:16 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120423 00:43]:
> > Add statics to board-omap4-panda.c's internal functions and data
> > structures to remove warnings.
>=20
> Care to update with the warnings produced?

Ah, sure. Updated patch below:

=46rom e96ddeb7d783d48a15a32f8ef5a7bae3089f66b9 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 28 Mar 2012 11:38:58 +0300
Subject: [PATCH] OMAP4: panda: add statics to remove warnings

Add statics to board-omap4-panda.c's internal functions and data
structures to remove sparse warnings:

arch/arm/mach-omap2/board-omap4panda.c:234:29: warning: symbol
'omap_panda_wlan_data' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap4panda.c:441:24: warning: symbol
'omap4_panda_dvi_device' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap4panda.c:451:12: warning: symbol
'omap4_panda_dvi_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap4panda.c:512:13: warning: symbol
'omap4_panda_display_init' was not declared. Should it be static?

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/b=
oard-omap4panda.c
index 1b782ba..8216e5f 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -231,7 +231,7 @@ static struct platform_device omap_vwlan_device =3D {
 	},
 };
=20
-struct wl12xx_platform_data omap_panda_wlan_data  __initdata =3D {
+static struct wl12xx_platform_data omap_panda_wlan_data  __initdata =3D {
 	/* PANDA ref clock is 38.4 MHz */
 	.board_ref_clock =3D 2,
 };
@@ -438,7 +438,7 @@ static struct panel_dvi_platform_data omap4_dvi_panel =
=3D {
 	.i2c_bus_num =3D 3,
 };
=20
-struct omap_dss_device omap4_panda_dvi_device =3D {
+static struct omap_dss_device omap4_panda_dvi_device =3D {
 	.type			=3D OMAP_DISPLAY_TYPE_DPI,
 	.name			=3D "dvi",
 	.driver_name		=3D "dvi",
@@ -448,7 +448,7 @@ struct omap_dss_device omap4_panda_dvi_device =3D {
 	.channel		=3D OMAP_DSS_CHANNEL_LCD2,
 };
=20
-int __init omap4_panda_dvi_init(void)
+static int __init omap4_panda_dvi_init(void)
 {
 	int r;
=20
@@ -509,7 +509,7 @@ static struct omap_dss_board_info omap4_panda_dss_data =
=3D {
 	.default_device	=3D &omap4_panda_dvi_device,
 };
=20
-void __init omap4_panda_display_init(void)
+static void __init omap4_panda_display_init(void)
 {
 	int r;
=20
--=20
1.7.4.1



--=-ls9UEhLNuucyp0ycINzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPl+4XAAoJEPo9qoy8lh71W5IP/1KtIcWoEpZ6ulehpBNan3T5
Hxdw1r1wwAq9sBgWyNBOsBgW44/2G6iBYjGf/Qb9nWNOia7dK5Cg5ixegmOgjRdW
Qm2tkG1LWGXixar4+SIhbX1CKYcQI++5RetGgqwZYl1t86ZIpXYnudLMhWE4FpR7
XTGMmmm/tGJkSsTzxyc8odqpaPSIm9kJE6b6PDw5nS6Uo2t+stkH7TTLR0tpGnOm
L8Gp+zBCrqKrnmCw/nk1lBoze0W3QinY1OS5yI0Z6IE+J4pdkkNfcnAPzfhQEyGY
cSsiIZIkBgypGQ7TBtx7dywu9xh7DJCaLK3uBg8wjYohJRaYJQdhYgdMP/L5/ctk
/Sqz07zo1/Xy9qjdFmHms9H3fkno37KfL8AboGLPJikphqhzTCOTGk2nsAqDp3Uo
AVFzuWkoYTvC+0zyxvnoCSp7tyAq9LXXH75i6VPm98k2kwAWJPEYBXrw59qQXjTU
ZtvSYLl7he5cfy9KnHzJNvp/XX8DyD35bh3h0NhY4CxOAaV3vYUNAV23TiNAxcSQ
cb+BY2J1C5Bv69q08UQtZVyUF0aP2Ju+HcZaMCuup8rIjRHVU42bW82wLjqEOAXj
RZ7er9xACSP3d5MQ84AQrYMEbzeKa+FFbN4UOOoEfgi92yTaQVYfkvuYqjfjeNzJ
ZVeBy9pTffDswf0pRSdv
=dpTt
-----END PGP SIGNATURE-----

--=-ls9UEhLNuucyp0ycINzo--

