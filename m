From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] nokia N9: Add support for magnetometer and touchscreen
Date: Tue, 2 Jan 2018 14:17:22 +0100
Message-ID: <20180102131722.GA20706@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This adds dts support for magnetometer and touchscreen on Nokia N9.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index 39e35f8..57a6679 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -36,6 +57,22 @@
 			};
 		};
 	};
+
+	touch@4b {
+		compatible =3D "atmel,maxtouch";
+		reg =3D <0x4b>;
+		interrupt-parent =3D <&gpio2>;
+		interrupts =3D <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/
+		vdd-supply =3D <&vio>;
+		avdd-supply =3D <&vaux1>;
+	};
+};
+
+&i2c3 {
+	ak8975@0f {
+		compatible =3D "asahi-kasei,ak8975";
+		reg =3D <0x0f>;
+	};
 };
=20
 &isp {


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpLhmIACgkQMOfwapXb+vKz0wCgm9x5pbSz9+v4lvM/sqiN+ePe
zQMAnicadNDGXkvSYA7NIt3aKlbUJPfu
=2lJk
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
