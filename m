From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH for sre] Fix "backlight" on N9
Date: Thu, 16 Nov 2017 00:18:11 +0100
Message-ID: <20171115231811.GA25191@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This should get "backlight" to work on N9/N950.

First hunk may not apply to you.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/=
drm/omapdrm/displays/panel-dsi-cm.c
index 24b459e..57827a1 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -374,8 +374,6 @@ static int dsicm_bl_update_status(struct backlight_devi=
ce *dev)
 	else
 		level =3D 0;
=20
-	level =3D 0xff;
-
 	dev_dbg(&ddata->pdev->dev, "update brightness to %d\n", level);
=20
 	mutex_lock(&ddata->lock);
@@ -1382,6 +1380,7 @@ static int dsicm_probe(struct platform_device *pdev)
 	if (ddata->use_dsi_backlight) {
 		struct backlight_properties props =3D { 0 };
 		props.max_brightness =3D 255;
+		props.brightness =3D 128;
 		props.type =3D BACKLIGHT_RAW;
=20
 		bldev =3D devm_backlight_device_register(dev, dev_name(dev),

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloMyzMACgkQMOfwapXb+vI39wCfc7SU6jLyo8AoHaHlvKcdB9Kx
2K8AoMHp3Fp+IB1+03aZOHTIaIcacS3z
=a19n
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
