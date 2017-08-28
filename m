From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] nokia n900: drop unneeded/undocumented parts of the dts
Date: Mon, 28 Aug 2017 15:18:16 +0200
Message-ID: <20170828131816.GB30115@amd>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>, sakari.ailus@linux.intel.com
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Sakari mentioned that some parts of the dts are not needed and do
not have proper documentation, yet.

As the camera works without them, remove them for now.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -144,15 +144,6 @@
 		io-channel-names =3D "temp", "bsi", "vbat";
 	};
=20
-	rear_camera: camera@0 {
-		compatible =3D "linux,camera";
-
-		module {
-			model =3D "TCM8341MD";
-			sensor =3D <&cam1>;
-		};
-	};
-
 	pwm9: dmtimer-pwm {
 		compatible =3D "ti,omap-dmtimer-pwm";
 		#pwm-cells =3D <3>;
@@ -189,10 +180,8 @@
 				clock-lanes =3D <1>;
 				data-lanes =3D <0>;
 				lane-polarity =3D <0 0>;
-				clock-inv =3D <0>;
 				/* Select strobe =3D <1> for back camera, <0> for front camera */
 				strobe =3D <1>;
-				crc =3D <0>;
 			};
 		};
 	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmkGBgACgkQMOfwapXb+vKN3ACfTUWv2i16xtHuJko/j0RVWGWf
MegAoMND0rg4MXbep5hHOvB87TBW6iN0
=oRne
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
