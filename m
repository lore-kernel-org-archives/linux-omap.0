From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Nokia N9: add support for up/down keys in the dts
Date: Tue, 2 Jan 2018 13:59:48 +0100
Message-ID: <20180102125948.GA20051@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This adds support for volume up/down keys in the dts.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index 39e35f8..57a6679 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -11,9 +11,10 @@
 /dts-v1/;
=20
 #include "omap3-n950-n9.dtsi"
+#include <dt-bindings/input/input.h>
=20
 / {
 	model =3D "Nokia N9";
 	compatible =3D "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
 };
=20
@@ -72,3 +133,9 @@
 	st,max-limit-y =3D <46>;
 	st,max-limit-z =3D <46>;
 };
+
+&twl_keypad {
+	linux,keymap =3D < MATRIX_KEY(6, 8, KEY_VOLUMEUP)
+			 MATRIX_KEY(7, 8, KEY_VOLUMEDOWN)
+			 >;
+};


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpLgkQACgkQMOfwapXb+vI4QQCgh+ZWUYFWe/812P1CrdqDHPnS
9vEAoIrY7DxCnIhYVh1onFt5gUcIO72z
=ajcM
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
