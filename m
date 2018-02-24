From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3] tlv320dac33: Add device tree bindings
Date: Sat, 24 Feb 2018 21:57:04 +0100
Message-ID: <20180224205704.GB5132@amd>
References: <20180129230539.GA18280@amd> <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
 <20180205082445.GA18274@amd> <20180206121122.GG5681@sirena.org.uk>
 <20180206134906.GA7842@amd> <20180206152722.GH5681@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4355167336441258345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180206152722.GH5681@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tony@atomide.com, abcloriens@gmail.com, tiwai@suse.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, patrikbachan@gmail.com, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, serge@hallyn.com, devicetree@vger.kernel.org, pali.rohar@gmail.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, martijn@brixit.nl, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, clayton@craftyguy.net, sakari.ailus@linux.intel.com, sre@kernel.org, bhumirks@gmail.com
List-Id: linux-omap@vger.kernel.org


--===============4355167336441258345==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-02-06 15:27:22, Mark Brown wrote:
> On Tue, Feb 06, 2018 at 02:49:06PM +0100, Pavel Machek wrote:
> > On Tue 2018-02-06 12:11:22, Mark Brown wrote:
>=20
> > > Please submit patches using subject lines reflecting the style for the
> > > subsystem.  This makes it easier for people to identify relevant
> > > patches.  Look at what existing commits in the area you're changing a=
re
> > > doing and make sure your subject lines visually resemble what they're
> > > doing.
>=20
> > AFAICT this goes to Documentation, not sound.
>=20
> Even if that were the case you're not following the commonly accepted
> practice there either.
>=20
> > If you have any comments on V1 of this patch, that would be nice, I'd
> > like to get that merged once we are finished with the bindings.
>=20
> It is the middle of the merge window, please be a bit more patient.

For the record, patch currently looks like this. If you have some
comments on the code, I'd like to hear them.

Best regards,
								Pavel

diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Docu=
mentation/devicetree/bindings/sound/tlv320dac33.txt
new file mode 100644
index 0000000..aee0a87
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
+- ti,burst-bclkdiv - BCLK divider value in burst mode. Valid range is 1..2=
55.
+
+Optional properties:
+
+- reset-gpios      - gpio pin to power the device, active high.
+
+- interrupts       - The interrupt output from the device.
+- interrupt-parent - The parent interrupt controller.
+
+- ti,keep-bclk     - Keep the BCLK running in FIFO modes.
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
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 8c71d2f..7302789 100644
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
 	u8 *reg_cache;
 	unsigned int burst_rate;	/* Interface speed in Burst modes */
=20
@@ -1483,16 +1486,11 @@ static struct snd_soc_dai_driver dac33_dai =3D {
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
@@ -1511,10 +1509,26 @@ static int dac33_i2c_probe(struct i2c_client *clien=
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
@@ -1580,9 +1594,16 @@ static const struct i2c_device_id tlv320dac33_i2c_id=
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

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqR0aAACgkQMOfwapXb+vLK3ACgi4vLN/bmL/cNyjta4ujT0bIA
/vsAoJU6WsuB/WffTuZ6vkv4qNB2hu97
=l61X
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--===============4355167336441258345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4355167336441258345==--
