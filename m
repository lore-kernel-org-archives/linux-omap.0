From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/3] mfd: ti-lmu: use of_device_get_match_data() helper
Date: Tue, 11 Sep 2018 23:06:50 +0200
Message-ID: <20180911210650.GC32497@amd>
References: <20180911210133.GA32497@amd>
 <20180911210344.GB32497@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911210344.GB32497@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, lee.jones@linaro.org, dmurphy@ti.com
List-Id: linux-omap@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace of_match_device() with of_device_get_match_data(), which
slightly decreases lines of code and allows to move the DT table
next to the I2C table.
   =20
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index de76298..ce16c89 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -142,34 +142,21 @@ TI_LMU_DATA(lm3633, LM3633_MAX_REG);
 TI_LMU_DATA(lm3695, LM3695_MAX_REG);
 TI_LMU_DATA(lm3697, LM3697_MAX_REG);
=20
-static const struct of_device_id ti_lmu_of_match[] =3D {
-	{ .compatible =3D "ti,lm3532", .data =3D &lm3532_data },
-	{ .compatible =3D "ti,lm3631", .data =3D &lm3631_data },
-	{ .compatible =3D "ti,lm3632", .data =3D &lm3632_data },
-	{ .compatible =3D "ti,lm3633", .data =3D &lm3633_data },
-	{ .compatible =3D "ti,lm3695", .data =3D &lm3695_data },
-	{ .compatible =3D "ti,lm3697", .data =3D &lm3697_data },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
-
 static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id =
*id)
 {
 	struct device *dev =3D &cl->dev;
-	const struct of_device_id *match;
 	const struct ti_lmu_data *data;
 	struct regmap_config regmap_cfg;
 	struct ti_lmu *lmu;
 	int ret;
=20
-	match =3D of_match_device(ti_lmu_of_match, dev);
-	if (!match)
-		return -ENODEV;
 	/*
 	 * Get device specific data from of_match table.
 	 * This data is defined by using TI_LMU_DATA() macro.
 	 */
-	data =3D (struct ti_lmu_data *)match->data;
+	data =3D of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
=20
 	lmu =3D devm_kzalloc(dev, sizeof(*lmu), GFP_KERNEL);
 	if (!lmu)
@@ -217,6 +204,17 @@ static int ti_lmu_probe(struct i2c_client *cl, const s=
truct i2c_device_id *id)
 				    data->num_cells, NULL, 0, NULL);
 }
=20
+static const struct of_device_id ti_lmu_of_match[] =3D {
+	{ .compatible =3D "ti,lm3532", .data =3D &lm3532_data },
+	{ .compatible =3D "ti,lm3631", .data =3D &lm3631_data },
+	{ .compatible =3D "ti,lm3632", .data =3D &lm3632_data },
+	{ .compatible =3D "ti,lm3633", .data =3D &lm3633_data },
+	{ .compatible =3D "ti,lm3695", .data =3D &lm3695_data },
+	{ .compatible =3D "ti,lm3697", .data =3D &lm3697_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
+
 static const struct i2c_device_id ti_lmu_ids[] =3D {
 	{ "lm3532", LM3532 },
 	{ "lm3631", LM3631 },


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluYLmoACgkQMOfwapXb+vI2BgCgkNowxJ3S7jkc1KAREOXVgrZa
5ScAn35mTV+a1LlY/ZMLel3TwZizMXUk
=sP4n
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
