From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: tps65910: wire up sleep control configuration
Date: Wed, 14 Jun 2017 14:25:13 +0200
Message-ID: <efc798c2a1140c545cc210a29ed2791495956510.1497442770.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

This enables configuring the PMIC's sleep mode via device-tree.

A pointer indirection to sleep mode data is removed, as it simplifies
the implementation slightly.

References: 201cf052810d20814a77ca0e0045a2c1a3508a1f
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 Documentation/devicetree/bindings/mfd/tps65910.txt |  4 ++++
 drivers/mfd/tps65910.c                             | 22 +++++++++++++++-------
 include/linux/mfd/tps65910.h                       |  2 +-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps65910.txt b/Documentation/devicetree/bindings/mfd/tps65910.txt
index 38833e63a59f9..8af1202b381dc 100644
--- a/Documentation/devicetree/bindings/mfd/tps65910.txt
+++ b/Documentation/devicetree/bindings/mfd/tps65910.txt
@@ -61,6 +61,10 @@ Optional properties:
   There should be 9 entries here, one for each gpio.
 - ti,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
+- ti,sleep-enable: Enable SLEEP state.
+- ti,sleep-keep-therm: Keep thermal monitoring on in sleep state.
+- ti,sleep-keep-ck32k: Keep the 32KHz clock output on in sleep state.
+- ti,sleep-keep-hsclk: Keep high speed internal clock on in sleep state.
 
 Regulator Optional properties:
 - ti,regulator-ext-sleep-control: enable external sleep
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 11cab1582f2f2..8263605f6d2fa 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -328,11 +328,7 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 		goto err_sleep_init;
 	}
 
-	/* Return if there is no sleep keepon data. */
-	if (!pmic_pdata->slp_keepon)
-		return 0;
-
-	if (pmic_pdata->slp_keepon->therm_keepon) {
+	if (pmic_pdata->slp_keepon.therm_keepon) {
 		ret = tps65910_reg_set_bits(tps65910,
 				TPS65910_SLEEP_KEEP_RES_ON,
 				SLEEP_KEEP_RES_ON_THERM_KEEPON_MASK);
@@ -342,7 +338,7 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 		}
 	}
 
-	if (pmic_pdata->slp_keepon->clkout32k_keepon) {
+	if (pmic_pdata->slp_keepon.clkout32k_keepon) {
 		ret = tps65910_reg_set_bits(tps65910,
 				TPS65910_SLEEP_KEEP_RES_ON,
 				SLEEP_KEEP_RES_ON_CLKOUT32K_KEEPON_MASK);
@@ -352,7 +348,7 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 		}
 	}
 
-	if (pmic_pdata->slp_keepon->i2chs_keepon) {
+	if (pmic_pdata->slp_keepon.i2chs_keepon) {
 		ret = tps65910_reg_set_bits(tps65910,
 				TPS65910_SLEEP_KEEP_RES_ON,
 				SLEEP_KEEP_RES_ON_I2CHS_KEEPON_MASK);
@@ -415,6 +411,18 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 	prop = of_property_read_bool(np, "ti,en-ck32k-xtal");
 	board_info->en_ck32k_xtal = prop;
 
+	prop = of_property_read_bool(np, "ti,sleep-enable");
+	board_info->en_dev_slp = prop;
+
+	prop = of_property_read_bool(np, "ti,sleep-keep-therm");
+	board_info->slp_keepon.therm_keepon = prop;
+
+	prop = of_property_read_bool(np, "ti,sleep-keep-ck32k");
+	board_info->slp_keepon.clkout32k_keepon = prop;
+
+	prop = of_property_read_bool(np, "ti,sleep-keep-hsclk");
+	board_info->slp_keepon.i2chs_keepon = prop;
+
 	board_info->irq = client->irq;
 	board_info->irq_base = -1;
 	board_info->pm_off = of_property_read_bool(np,
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index ffb21e79204d6..deffdcd0236f9 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -879,7 +879,7 @@ struct tps65910_board {
 	bool en_ck32k_xtal;
 	bool en_dev_slp;
 	bool pm_off;
-	struct tps65910_sleep_keepon_data *slp_keepon;
+	struct tps65910_sleep_keepon_data slp_keepon;
 	bool en_gpio_sleep[TPS6591X_MAX_NUM_GPIO];
 	unsigned long regulator_ext_sleep_control[TPS65910_NUM_REGS];
 	struct regulator_init_data *tps65910_pmic_init_data[TPS65910_NUM_REGS];
-- 
2.11.0
