From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] fix vibrations on Droid 4
Date: Wed, 1 Aug 2018 22:28:21 +0200
Message-ID: <20180801202821.GB4033@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716075926.GU99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Vibration GPIOs don't have anything to do with wakeup. Move it to
normal section; this fixes vibrations on Droid 4.
   =20
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index c27fc87..7b82179 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -646,15 +646,6 @@
 		OMAP4_IOPAD(0x10c, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_fsx */
 		>;
 	};
-};
-
-&omap4_pmx_wkup {
-	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
-		/* gpio_wk0 */
-		pinctrl-single,pins =3D <
-		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
-		>;
-	};
=20
 	vibrator_direction_pin: pinmux_vibrator_direction_pin {
 		pinctrl-single,pins =3D <
@@ -669,6 +660,15 @@
 	};
 };
=20
+&omap4_pmx_wkup {
+	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
+		/* gpio_wk0 */
+		pinctrl-single,pins =3D <
+		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
+		>;
+	};
+};
+
 /*
  * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin f=
or
  * uart1 wakeirq.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltiF+UACgkQMOfwapXb+vLU9gCguQsW/CgcTyDmuOhR5plML8qf
dA0An3eBzR8gVfUN4Ll2rgdoK6aopym5
=m5zH
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
