From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Device tree binding for Avago APDS990X light sensor
Date: Wed, 27 Dec 2017 10:18:28 +0100
Message-ID: <20171227091828.GA3307@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>

This prepares binding for light sensor used in Nokia N9.=20

Signed-off-by: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>
Signed-off-by: Pavel machek <pavel@ucw.cz>

---

Patches to convert APDS990X driver to device tree and to switch to iio
are available.

diff --git a/Documentation/devicetree/bindings/misc/avago-apds990x.txt b/Do=
cumentation/devicetree/bindings/misc/avago-apds990x.txt
new file mode 100644
index 0000000..e038146
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
@@ -0,0 +1,39 @@
+Avago APDS990X driver
+
+Required properties:
+- compatible: "avago,apds990x"
+- reg: address on the I2C bus
+- interrupts: external interrupt line number
+- Vdd-supply: power supply for VDD
+- Vled-supply: power supply for LEDA
+- ga: Glass attenuation
+- cf1: Clear channel factor 1
+- irf1: IR channel factor 1
+- cf2: Clear channel factor 2
+- irf2: IR channel factor 2
+- df: Device factor
+- pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
+- ppcount: Proximity pulse count
+
+Example (Nokia N9):
+
+	als_ps@39 {
+		compatible =3D "avago,apds990x";
+		reg =3D <0x39>;
+
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <19 10>; /* gpio_83, IRQF_TRIGGER_FALLING | IRQF_TRIGGER_=
LOW */
+
+		Vdd-supply =3D <&vaux1>;
+		Vled-supply =3D <&vbat>;
+
+		ga	=3D <168834>;
+		cf1	=3D <4096>;
+		irf1	=3D <7824>;
+		cf2	=3D <877>;
+		irf2	=3D <1575>;
+		df	=3D <52>;
+
+		pdrive	=3D <0x2>; /* APDS_IRLED_CURR_25mA */
+		ppcount	=3D <5>;
+	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpDZWQACgkQMOfwapXb+vKUWACcD9TCR6gkdVH4SuJSNHcQC1WS
ycsAoJdaxyg5E62HV8mMcNm/6FuM6ITb
=a8eO
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
