From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] tlv320dac33: Add device tree bindings
Date: Wed, 31 Jan 2018 20:01:12 +0100
Message-ID: <20180131190112.GA31608@amd>
References: <20180129230539.GA18280@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129230539.GA18280@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This adds device tree bindings for tlv320dac33.c.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Docu=
mentation/devicetree/bindings/sound/tlv320dac33.txt
new file mode 100644
index 0000000..7fdda95
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
@@ -0,0 +1,32 @@
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
+- reset-gpios - gpio pin to power the device, active low
+
+- interrupts       - The interrupt output from the device.
+- interrupt-parent - The parent interrupt controller.
+
+- ti,keep-bclk 	- Keep the BCLK running in FIFO modes
+- ti,burst-bclkdiv - BCLK divider value in burst mode
+
+Example:
+
+tlv320dac33: audio-codec@19 {
+	compatible =3D "ti,tlv320dac33";
+	reg =3D <0x19>;
+
+	interrupt-parent =3D <&gpio2>;
+	interrupts =3D <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
+	reset-gpios =3D <&gpio2 28 0>; /* gpio_60 */
+
+	ti,keep-bclk;
+	ti,burst-bclkdiv =3D <3>;
+};


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpyEngACgkQMOfwapXb+vIoBgCglNyLOuWrgVOVKZJHl2KRTmFf
5CQAnjW1sBvNqWmNwQh7HdTOwM6TgcJD
=bMd9
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
