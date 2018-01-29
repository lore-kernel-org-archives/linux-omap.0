From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 00:05:39 +0100
Message-ID: <20180129230539.GA18280@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com, pavel@ucw.cz, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This adds device tree support to tlv320dac33.c.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Docu=
mentation/devicetree/bindings/sound/tlv320dac33.txt
new file mode 100644
index 0000000..6cbd311
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
+- power-gpios - gpio pin to power the device, active high
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
+	power-gpio =3D <&gpio2 28 0>; /* gpio_60 */
+
+	ti,keep-bclk;
+	ti,burst-bclkdiv =3D <3>;
+};
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 5b94a15..2a0fe06 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -30,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -105,7 +108,7 @@ struct tlv320dac33_priv {
 	unsigned int nsample;		/* burst read amount from host */
 	int mode1_latency;		/* latency caused by the i2c writes in
 					 * us */
-	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
+	u32 burst_bclkdiv;		/* BCLK divider value in burst mode */
 	unsigned int burst_rate;	/* Interface speed in Burst modes */
=20
 	int keep_bclk;			/* Keep the BCLK continuously running
@@ -1484,16 +1487,11 @@ static struct snd_soc_dai_driver dac33_dai =3D {
 static int dac33_i2c_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
-	struct tlv320dac33_platform_data *pdata;
+	struct tlv320dac33_platform_data *pdata =3D client->dev.platform_data;
 	struct tlv320dac33_priv *dac33;
+	struct device_node *np =3D client->dev.of_node;
 	int ret, i;
=20
-	if (client->dev.platform_data =3D=3D NULL) {
-		dev_err(&client->dev, "Platform data not set\n");
-		return -ENODEV;
-	}
-	pdata =3D client->dev.platform_data;
-
 	dac33 =3D devm_kzalloc(&client->dev, sizeof(struct tlv320dac33_priv),
 			     GFP_KERNEL);
 	if (dac33 =3D=3D NULL)
@@ -1505,10 +1503,26 @@ static int dac33_i2c_probe(struct i2c_client *clien=
t,
=20
 	i2c_set_clientdata(client, dac33);
=20
-	dac33->power_gpio =3D pdata->power_gpio;
-	dac33->burst_bclkdiv =3D pdata->burst_bclkdiv;
-	dac33->keep_bclk =3D pdata->keep_bclk;
-	dac33->mode1_latency =3D pdata->mode1_latency;
+	if (pdata) {
+		dac33->power_gpio =3D pdata->power_gpio;
+		dac33->burst_bclkdiv =3D pdata->burst_bclkdiv;
+		dac33->keep_bclk =3D pdata->keep_bclk;
+		dac33->mode1_latency =3D pdata->mode1_latency;
+	} else if (np) {
+		ret =3D of_get_named_gpio(np, "power-gpios", 0);
+		if (ret >=3D 0)
+			dac33->power_gpio =3D ret;
+		else
+			dac33->power_gpio =3D -1;
+
+		if (of_property_read_bool(np, "ti,keep-bclk"))
+			dac33->keep_bclk =3D true;
+
+		of_property_read_u32(np, "ti,burst-bclkdiv", &dac33->burst_bclkdiv);
+	} else {
+		dev_err(&client->dev, "Platform data not set\n");
+		return -ENODEV;
+	}
 	if (!dac33->mode1_latency)
 		dac33->mode1_latency =3D 10000; /* 10ms */
 	dac33->irq =3D client->irq;
@@ -1574,9 +1588,16 @@ static const struct i2c_device_id tlv320dac33_i2c_id=
[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, tlv320dac33_i2c_id);
=20
+static const struct of_device_id tlv320dac33_of_match[] =3D {
+	{ .compatible =3D "ti,tlv320dac33", },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, tlv320dac33_of_match);
+
 static struct i2c_driver tlv320dac33_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "tlv320dac33-codec",
+		.of_match_table =3D of_match_ptr(tlv320dac33_of_match),
 	},
 	.probe		=3D dac33_i2c_probe,
 	.remove		=3D dac33_i2c_remove,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpvqMMACgkQMOfwapXb+vKqtQCdFnCA4LlqtKuol9jqGJWx5juh
lfoAn0jQ6cD3Ke0CRvJGD5gLMTSZGKY/
=NnnZ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
