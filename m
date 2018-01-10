From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: [PATCH] dt-bindings: Nokia N9 audio support
Date: Wed, 10 Jan 2018 09:53:15 +0100
Message-ID: <20180110085315.GA17841@amd>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
 <20180108222054.GA17452@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180108222054.GA17452@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Filip Matijevi=C4=87 <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add bindings for Nokia N9 audio components.

Signed-off-by: Filip Matijevi=C4=87 <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

diff --git a/Documentation/devicetree/bindings/media/ti-wl1273.txt b/Docume=
ntation/devicetree/bindings/media/ti-wl1273.txt
new file mode 100644
index 0000000..21db389
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti-wl1273.txt
@@ -0,0 +1,36 @@
+Texas Instruments - wl1273 radio/bluetooth module
+
+Required properties:
+
+- compatible - "ti,wl1273-core"
+- reg - I2C slave address
+- interrupts       - The interrupt output from the device.
+- interrupt-parent - The parent interrupt controller.
+- power-gpio       - gpio pin to power the device.
+
+- wl1273radio child - compatible =3D "ti,wl1273-fm-radio";
+
+Optional properties:
+
+- wl1273codec child - compatible =3D "ti,wl1273codec";
+
+Example:
+
+wl1273core: wl1273core@22 {
+		compatible =3D "ti,wl1273-core";
+		reg =3D <0x22>;
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&wl1273_gpio>;
+
+		interrupt-parent =3D <&gpio2>;
+		interrupts =3D <11 2>; /* gpio_43, IRQF_TRIGGER_FALLING */
+
+		wl1273radio: wl1273radio {
+			compatible =3D "ti,wl1273-fm-radio";
+		};
+
+		wl1273codec: wl1273codec {
+			compatible =3D "ti,wl1273-codec";
+		};
+	};
diff --git a/Documentation/devicetree/bindings/sound/nokia,n9.txt b/Documen=
tation/devicetree/bindings/sound/nokia,n9.txt
new file mode 100644
index 0000000..230b1eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nokia,n9.txt
@@ -0,0 +1,32 @@
+* Nokia N9/N950 audio setup
+
+Required properties:
+- compatible: "nokia,n9-audio"
+
+- nokia,twl4030-cpu-dai: phandle for the McBSP node connected to TWL4030
+- nokia,tlv320dac33-cpu-dai: phandle for the McBSP node connected to TLV32=
0DAC33
+- nokia,wl1273-cpu-dai: phandle for the McBSP node connected to WL1273
+
+- nokia,twl4030-codec: phandle for the TWL4030 codec
+- nokia,tlv320dac33-codec: phandle for the TLV320DAC33 codec
+- nokia,wl1273-codec: phandle for the WL1273 codec
+- nokia,headphone-amplifier: phandle for the TPA6130A2 node
+
+- nokia,speaker-amplifier-gpios: GPIO for speaker amplifier
+
+Example:
+
+sound: n9-audio {
+	compatible =3D "nokia,n9-audio";
+
+	nokia,twl4030-cpu-dai =3D <&mcbsp3>;
+	nokia,tlv320dac33-cpu-dai =3D <&mcbsp2>;
+	nokia,wl1273-cpu-dai =3D <&mcbsp4>;
+
+	nokia,twl4030-codec =3D <&twl4030_audio>;
+	nokia,tlv320dac33-codec =3D <&tlv320dac33>;
+	nokia,wl1273-codec =3D <&wl1273codec>;
+	nokia,headphone-amplifier =3D <&tpa6140a2>;
+
+	nokia,speaker-amplifier-gpios =3D <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
+};
diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Docu=
mentation/devicetree/bindings/sound/tlv320dac33.txt
new file mode 100644
index 0000000..8e981f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
@@ -0,0 +1,39 @@
+Texas Instruments - tlv320dac33 Codec module
+
+The tlv320dac33 serial control bus communicates through I2C protocols.
+
+Required properties:
+
+- compatible - "ti,tlv320dac33"
+- reg - I2C slave address
+
+Optional properties:
+
+- power-gpio - gpio pin to power the device
+
+- avdd-supply, dvdd-supply, iovdd-supply: power supplies for the device as=
 covered
+  in Documentation/devicetree/bindings/regulator/regulator.txt
+
+- interrupts       - The interrupt output from the device.
+- interrupt-parent - The parent interrupt controller.
+
+- ti,keep-bclk 	- Keep the BCLK running in FIFO modes
+- ti,burst-bclkdiv - BCLK divider value in burst mode
+
+Example:
+
+tlv320dac33: tlv320dac33@19 {
+	compatible =3D "ti,tlv320dac33";
+	reg =3D <0x19>;
+
+	avdd-supply =3D <&vaux4>;
+	dvdd-supply =3D <&vio>;
+	iovdd-supply =3D <&vio>;
+
+	interrupt-parent =3D <&gpio2>;
+	interrupts =3D <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
+	power-gpio =3D <&gpio2 28 0>; /* gpio_60 */
+
+	ti,keep-bclk;
+	ti,burst-bclkdiv =3D /bits/ 8 <3>;
+};


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpV1HsACgkQMOfwapXb+vIMUgCfQiJowXDCBohzyldvIJ4pLWzp
i/EAnA2SlDggNUupVR91b8ilJzE6o97d
=eBwj
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
