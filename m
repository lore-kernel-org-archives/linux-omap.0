From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] omap3-n900: enable autofocus
Date: Sun, 12 Nov 2017 12:25:29 +0100
Message-ID: <20171112112528.GA21009@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Connect auto-focus coil to the camera sensor, so that it can be used
by camera applications.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index 669c51c..59cc743 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -778,6 +778,8 @@
=20
 		reset-gpio =3D <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
=20
+		lens-focus =3D <&ad5820>;
+
 		port {
 			csi_cam1: endpoint {
 				bus-type =3D <3>; /* CCP2 */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloIL6gACgkQMOfwapXb+vLCwQCfZGOz4jvnTFx2XB8aK4GZBT0v
WEoAn2sZmB8Ll7bj+dCs3h0U1qslvkDs
=+It0
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
