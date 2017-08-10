From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] nokia n900: update dts with camera support
Date: Thu, 10 Aug 2017 22:49:23 +0200
Message-ID: <20170810204923.GA18442@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, sakari.ailus@iki.fi
List-Id: linux-omap@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Add camera support to N900 dts. Also add a note about MMC & debugging.

Signed-off-by: Pavel Machek <pavel@ucw.cz>


diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index 49f3708..b1be53d 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -144,6 +144,15 @@
 		io-channel-names =3D "temp", "bsi", "vbat";
 	};
=20
+	rear_camera: camera@0 {
+		compatible =3D "linux,camera";
+
+		module {
+			model =3D "TCM8341MD";
+			sensor =3D <&cam1>;
+		};
+	};
+
 	pwm9: dmtimer-pwm {
 		compatible =3D "ti,omap-dmtimer-pwm";
 		#pwm-cells =3D <3>;
@@ -164,6 +173,31 @@
 	};
 };
=20
+&isp {
+	vdds_csib-supply =3D <&vaux2>;
+
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&camera_pins>;
+
+	ports {
+		port@1 {
+			reg =3D <1>;
+
+			csi_isp: endpoint {
+				remote-endpoint =3D <&csi_cam1>;
+				bus-type =3D <3>; /* CCP2 */
+				clock-lanes =3D <1>;
+				data-lanes =3D <0>;
+				lane-polarity =3D <0 0>;
+				clock-inv =3D <0>;
+				/* Select strobe =3D <1> for back camera, <0> for front camera */
+				strobe =3D <1>;
+				crc =3D <0>;
+			};
+		};
+	};
+};
+
 &omap3_pmx_core {
 	pinctrl-names =3D "default";
=20
@@ -328,6 +362,22 @@
 			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)		/* gpio 157 =3D> cmt=
_bsi */
 		>;
 	};
+
+	camera_pins: pinmux_camera {
+		pinctrl-single,pins =3D <
+			OMAP3_CORE1_IOPAD(0x210c, PIN_OUTPUT | MUX_MODE7)       /* cam_hs */
+			OMAP3_CORE1_IOPAD(0x210e, PIN_OUTPUT | MUX_MODE7)       /* cam_vs */
+			OMAP3_CORE1_IOPAD(0x2110, PIN_OUTPUT | MUX_MODE0)       /* cam_xclka */
+			OMAP3_CORE1_IOPAD(0x211e, PIN_OUTPUT | MUX_MODE7)       /* cam_d4 */
+			OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT | MUX_MODE0)        /* cam_d6 */
+			OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT | MUX_MODE0)        /* cam_d7 */
+			OMAP3_CORE1_IOPAD(0x2126, PIN_INPUT | MUX_MODE0)        /* cam_d8 */
+			OMAP3_CORE1_IOPAD(0x2128, PIN_INPUT | MUX_MODE0)        /* cam_d9 */
+			OMAP3_CORE1_IOPAD(0x212a, PIN_OUTPUT | MUX_MODE7)       /* cam_d10 */
+			OMAP3_CORE1_IOPAD(0x212e, PIN_OUTPUT | MUX_MODE7)       /* cam_xclkb */
+			OMAP3_CORE1_IOPAD(0x2132, PIN_OUTPUT | MUX_MODE0)       /* cam_strobe */
+		>;
+	};
 };
=20
 &i2c1 {
@@ -726,6 +776,40 @@
 		st,max-limit-y =3D <32>;
 		st,max-limit-z =3D <32>;
 	};
+
+	cam1: camera@3e {
+		compatible =3D "toshiba,et8ek8";
+		reg =3D <0x3e>;
+
+		vana-supply =3D <&vaux4>;
+
+		clocks =3D <&isp 0>;
+		clock-names =3D "extclk";
+		clock-frequency =3D <9600000>;
+
+		reset-gpio =3D <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
+
+		port {
+			csi_cam1: endpoint {
+				bus-type =3D <3>; /* CCP2 */
+				strobe =3D <1>;
+				clock-inv =3D <0>;
+				crc =3D <1>;
+
+				remote-endpoint =3D <&csi_isp>;
+			};
+		};
+	};
+
+	/* D/A converter for auto-focus */
+	ad5820: dac@0c {
+		compatible =3D "adi,ad5820";
+		reg =3D <0x0c>;
+
+		VANA-supply =3D <&vaux4>;
+
+		#io-channel-cells =3D <0>;
+	};
 };
=20
 &mmc1 {
@@ -733,6 +817,9 @@
 	pinctrl-0 =3D <&mmc1_pins>;
 	vmmc-supply =3D <&vmmc1>;
 	bus-width =3D <4>;
+	/* For debugging, it is often good idea to remove this GPIO.
+	   It means you can remove back cover (to reboot by removing
+	   battery) and still use the MMC card. */
 	cd-gpios =3D <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
 };
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmMxtMACgkQMOfwapXb+vIlpQCghJI1OqTtio4iYes4w/ZEIDoo
tFoAoIHwRJrUc3Tk0wuiS0ZNs4mw65c5
=2kG+
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
