From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] Device tree binding for Avago APDS990X light sensor
Date: Tue, 2 Jan 2018 13:44:51 +0100
Message-ID: <20180102124450.GA18659@amd>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>

This prepares binding for light sensor used in Nokia N9.

Signed-off-by: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/misc/avago-apds990x.txt b/Do=
cumentation/devicetree/bindings/misc/avago-apds990x.txt
new file mode 100644
index 0000000..480c0b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
@@ -0,0 +1,41 @@
+Avago APDS990X driver
+
+https://docs.broadcom.com/docs/AV02-2867EN
+
+Required properties:
+- compatible: "avago,apds990x"
+- reg: address on the I2C bus
+- interrupts: external interrupt line number
+- vdd-supply: power supply for VDD
+- vled-supply: power supply for LEDA
+- avago,ga: Glass attenuation
+- avago,cf1: Clear channel factor 1
+- avago,irf1: IR channel factor 1
+- avago,cf2: Clear channel factor 2
+- avago,irf2: IR channel factor 2
+- avago,df: Device factor
+- avago,pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
+- avago,ppcount: Proximity pulse count
+
+Example (Nokia N9):
+
+	als_ps@39 {
+		compatible =3D "avago,apds990x";
+		reg =3D <0x39>;
+
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <19 (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW)>; /* gpi=
o_83 */
+
+		vdd-supply =3D <&vaux1>;
+		vled-supply =3D <&vbat>;
+
+		avago,ga	=3D <168834>;
+		avago,cf1	=3D <4096>;
+		avago,irf1	=3D <7824>;
+		avago,cf2	=3D <877>;
+		avago,irf2	=3D <1575>;
+		avago,df	=3D <52>;
+
+		avago,pdrive	=3D <0x2>; /* APDS_IRLED_CURR_25mA */
+		avago,ppcount	=3D <5>;
+	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpLfsIACgkQMOfwapXb+vJvVgCfWvKfH1FkzOpUAhxYFy4kKgGC
iBsAniSyWfTStvxU8tErobsBFHKQE0Ey
=Q1k4
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
