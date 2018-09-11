From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/3] mfd: ti-lmu: switch to gpiod
Date: Tue, 11 Sep 2018 23:01:33 +0200
Message-ID: <20180911210133.GA32497@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, lee.jones@linaro.org, dmurphy@ti.com
List-Id: linux-omap@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use new descriptor based API instead of the legacy one.
   =20
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 990437e..e14cb9f 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -12,7 +12,7 @@
=20
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
=20
 struct ti_lmu_data {
@@ -32,17 +31,8 @@ struct ti_lmu_data {
=20
 static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_lmu_id id)
 {
-	int ret;
-
-	if (gpio_is_valid(lmu->en_gpio)) {
-		ret =3D devm_gpio_request_one(lmu->dev, lmu->en_gpio,
-					    GPIOF_OUT_INIT_HIGH, "lmu_hwen");
-		if (ret) {
-			dev_err(lmu->dev, "Can not request enable GPIO: %d\n",
-				ret);
-			return ret;
-		}
-	}
+	if (lmu->en_gpio)
+		gpiod_set_value(lmu->en_gpio, 1);
=20
 	/* Delay about 1ms after HW enable pin control */
 	usleep_range(1000, 1500);
@@ -59,8 +49,8 @@ static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_l=
mu_id id)
=20
 static void ti_lmu_disable_hw(struct ti_lmu *lmu)
 {
-	if (gpio_is_valid(lmu->en_gpio))
-		gpio_set_value(lmu->en_gpio, 0);
+	if (lmu->en_gpio)
+		gpiod_set_value(lmu->en_gpio, 0);
 }
=20
 static const struct mfd_cell lm3532_devices[] =3D {
@@ -204,7 +194,13 @@ static int ti_lmu_probe(struct i2c_client *cl, const s=
truct i2c_device_id *id)
 		return PTR_ERR(lmu->regmap);
=20
 	/* HW enable pin control and additional power up sequence if required */
-	lmu->en_gpio =3D of_get_named_gpio(dev->of_node, "enable-gpios", 0);
+	lmu->en_gpio =3D devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(lmu->en_gpio)) {
+		ret =3D PTR_ERR(lmu->en_gpio);
+		dev_err(dev, "Can not request enable GPIO: %d\n", ret);
+		return ret;
+	}
+
 	ret =3D ti_lmu_enable_hw(lmu, id->driver_data);
 	if (ret)
 		return ret;
diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
index 09d5f30..1ef51ed 100644
--- a/include/linux/mfd/ti-lmu.h
+++ b/include/linux/mfd/ti-lmu.h
@@ -16,6 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/notifier.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
=20
 /* Notifier event */
 #define LMU_EVENT_MONITOR_DONE		0x01
@@ -81,7 +82,7 @@ enum lm363x_regulator_id {
 struct ti_lmu {
 	struct device *dev;
 	struct regmap *regmap;
-	int en_gpio;
+	struct gpio_desc *en_gpio;
 	struct blocking_notifier_head notifier;
 };
 #endif


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluYLS0ACgkQMOfwapXb+vIovgCeMkAxgrYAKaZV9q1gU/ltyL7c
vQUAoKLIV8M7xKcSi3BcxDGzvfzxOx0O
=oZvi
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
