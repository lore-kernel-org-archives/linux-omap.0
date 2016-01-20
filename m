From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Wed, 20 Jan 2016 13:29:51 +0100
Message-ID: <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-omap@vger.kernel.org

On the AM335x SoC rev. <=3D 1.0 the "Input Function of the EXTINTn
Terminal is Inverted", for which the only remedy is to "Use an active
high interrupt source or use an external inverter to change the
polarity of any active low interrupt source."

This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
electronics TX48 module. Make the IRQ optional in the driver and use a
polling routine instead if no IRQ is specified in DT.
Otherwise the driver will continuously generate interrupts and make
the system unusable.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/regulator/ltc3589.c | 49 +++++++++++++++++++++++++++++++++++++=
++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 972c386..fff90cd 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -65,6 +65,8 @@
 #define LTC3589_VCCR_SW3_GO		BIT(4)
 #define LTC3589_VCCR_LDO2_GO		BIT(6)
=20
+#define POLL_PERIOD			1000
+
 enum ltc3589_variant {
 	LTC3589,
 	LTC3589_1,
@@ -97,6 +99,7 @@ struct ltc3589 {
 	enum ltc3589_variant variant;
 	struct ltc3589_regulator regulator_descs[LTC3589_NUM_REGULATORS];
 	struct regulator_dev *regulators[LTC3589_NUM_REGULATORS];
+	struct delayed_work poll_timer;
 };
=20
 static const int ltc3589_ldo4[] =3D {
@@ -407,11 +410,10 @@ static const struct regmap_config ltc3589_regmap_=
config =3D {
 	.cache_type =3D REGCACHE_RBTREE,
 };
=20
-
-static irqreturn_t ltc3589_isr(int irq, void *dev_id)
+static inline void ltc3589_handle_irq(struct ltc3589 *ltc3589)
 {
-	struct ltc3589 *ltc3589 =3D dev_id;
-	unsigned int i, irqstat, event;
+	u32 irqstat, event;
+	int i;
=20
 	regmap_read(ltc3589->regmap, LTC3589_IRQSTAT, &irqstat);
=20
@@ -431,6 +433,24 @@ static irqreturn_t ltc3589_isr(int irq, void *dev_=
id)
=20
 	/* Clear warning condition */
 	regmap_write(ltc3589->regmap, LTC3589_CLIRQ, 0);
+}
+
+static void ltc3589_poll_func(struct work_struct *work)
+{
+	struct ltc3589 *ltc3589 =3D container_of(work, struct ltc3589,
+					poll_timer.work);
+	unsigned long timeout =3D msecs_to_jiffies(POLL_PERIOD);
+
+	ltc3589_handle_irq(ltc3589);
+
+	schedule_delayed_work(&ltc3589->poll_timer, timeout);
+}
+
+static irqreturn_t ltc3589_isr(int irq, void *dev_id)
+{
+	struct ltc3589 *ltc3589 =3D dev_id;
+
+	ltc3589_handle_irq(ltc3589);
=20
 	return IRQ_HANDLED;
 }
@@ -519,6 +539,16 @@ static int ltc3589_probe(struct i2c_client *client=
,
 			return ret;
 		}
 	}
+	if (client->irq <=3D 0) {
+		dev_warn(dev,
+			"No interrupt configured; poll for thermal shutdown and undervoltag=
e events\n");
+
+		INIT_DELAYED_WORK(&ltc3589->poll_timer, ltc3589_poll_func);
+		schedule_delayed_work(&ltc3589->poll_timer,
+				msecs_to_jiffies(POLL_PERIOD));
+
+		return 0;
+	}
=20
 	ret =3D devm_request_threaded_irq(dev, client->irq, NULL, ltc3589_isr=
,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -531,6 +561,16 @@ static int ltc3589_probe(struct i2c_client *client=
,
 	return 0;
 }
=20
+static int ltc3589_remove(struct i2c_client *client)
+{
+	struct ltc3589 *ltc3589 =3D i2c_get_clientdata(client);
+
+	if (client->irq <=3D 0)
+		cancel_delayed_work(&ltc3589->poll_timer);
+
+	return 0;
+}
+
 static struct i2c_device_id ltc3589_i2c_id[] =3D {
 	{ "ltc3589",   LTC3589   },
 	{ "ltc3589-1", LTC3589_1 },
@@ -544,6 +584,7 @@ static struct i2c_driver ltc3589_driver =3D {
 		.name =3D DRIVER_NAME,
 	},
 	.probe =3D ltc3589_probe,
+	.remove =3D ltc3589_remove,
 	.id_table =3D ltc3589_i2c_id,
 };
 module_i2c_driver(ltc3589_driver);
--=20
2.1.4
