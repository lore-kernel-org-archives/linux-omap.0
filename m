From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] n900 device tree: cleanup
Date: Tue, 11 Oct 2016 10:12:43 +0200
Message-ID: <20161011081243.GA24580@amd>
References: <20161011075416.GA22453@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0662942261098520731=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161011075416.GA22453@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0662942261098520731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix GPIO comment to be consistent with rest of file and add comment what
tpa6130 is.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index bfffd6c..ca9fe8c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -47,7 +47,7 @@
 		compatible =3D "gpio-leds";
 		heartbeat {
 			label =3D "debug::sleep";
-			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
+			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* 162 */
 			linux,default-trigger =3D "default-on";
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&debug_leds>;
@@ -637,6 +637,7 @@
 		reg =3D <0x55>;
 	};
=20
+	/* Stereo headphone amplifier */
 	tpa6130a2: tpa6130a2@60 {
 		compatible =3D "ti,tpa6130a2";
 		reg =3D <0x60>;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf8nvsACgkQMOfwapXb+vLDpwCeJC+t2CaUA44sCSGgzTZ29NXz
92oAoLaFgtD9UuZKzIvqsRCvVln0x7aB
=bWvM
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


--===============0662942261098520731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0662942261098520731==--
