From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] dts/droid4: fix dts w.r.t. pwm
Date: Mon, 16 Jul 2018 09:10:48 +0200
Message-ID: <20180716071048.GA23110@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711142526.dto6iost57zx5t5l@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


pwm node should not be under gpio6 node in the device tree.
  =20
This fixes detection of the pwm on Droid 4.
   =20
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index 45305e8..c27fc87 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -159,13 +159,7 @@
=20
 		dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
 	};
-};
-
-&dss {
-	status =3D "okay";
-};
=20
-&gpio6 {
 	pwm8: dmtimer-pwm-8 {
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&vibrator_direction_pin>;
@@ -192,7 +186,10 @@
 		pwm-names =3D "enable", "direction";
 		direction-duty-cycle-ns =3D <10000000>;
 	};
+};
=20
+&dss {
+	status =3D "okay";
 };
=20
 &dsi1 {



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltMRPgACgkQMOfwapXb+vIk0ACgvE4rVgo5JdH9NqnlL8QmMTE0
r2IAn1m56vhiDS1Cu8zRcQ2h66pfX7Ro
=5Ga4
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
