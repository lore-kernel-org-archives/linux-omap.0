From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
Date: Fri,  5 Feb 2016 19:42:19 +0100
Message-ID: <1454697741-8687-3-git-send-email-contact@paulk.fr>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454697741-8687-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Milo Kim <milo.kim@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

LP872x regulators are made active via the EN pin, which might be hooked to a
GPIO. This adds support for driving the GPIO high when the driver is in use.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../devicetree/bindings/regulator/lp872x.txt       |  1 +
 drivers/regulator/lp872x.c                         | 34 ++++++++++++++++++++++
 include/linux/regulator/lp872x.h                   |  5 ++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/Documentation/devicetree/bindings/regulator/lp872x.txt
index 7818318..ca58a68 100644
--- a/Documentation/devicetree/bindings/regulator/lp872x.txt
+++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
@@ -28,6 +28,7 @@ Optional properties:
   - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872x devices.
   - ti,dvs-vsel: DVS selector. 0 = SEL_V1, 1 = SEL_V2.
   - ti,dvs-state: initial DVS pin state. 0 = DVS_LOW, 1 = DVS_HIGH.
+  - enable-gpios: GPIO specifier for EN pin control of LP872x devices.
 
   Sub nodes for regulator_init_data
     LP8720 has maximum 6 nodes. (child name: ldo1 ~ 5 and buck)
diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 21c49d8..3899211 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -15,6 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/delay.h>
 #include <linux/regulator/lp872x.h>
 #include <linux/regulator/driver.h>
 #include <linux/platform_device.h>
@@ -757,6 +758,33 @@ set_default_dvs_mode:
 				default_dvs_mode[lp->chipid]);
 }
 
+static int lp872x_hw_enable(struct lp872x *lp)
+{
+	int ret, gpio;
+
+	if (!lp->pdata)
+		return -EINVAL;
+
+	gpio = lp->pdata->enable_gpio;
+	if (!gpio_is_valid(gpio))
+		return 0;
+
+	/* Always set enable GPIO high. */
+	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
+	if (ret) {
+		dev_err(lp->dev, "gpio request err: %d\n", ret);
+		return ret;
+	}
+
+	/* Each chip has a different enable delay. */
+	if (lp->chipid == LP8720)
+		usleep_range(LP8720_ENABLE_DELAY, 1.5 * LP8720_ENABLE_DELAY);
+	else
+		usleep_range(LP8725_ENABLE_DELAY, 1.5 * LP8725_ENABLE_DELAY);
+
+	return 0;
+}
+
 static int lp872x_config(struct lp872x *lp)
 {
 	struct lp872x_platform_data *pdata = lp->pdata;
@@ -875,6 +903,8 @@ static struct lp872x_platform_data
 	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
 	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
 
+	pdata->enable_gpio = of_get_named_gpio(np, "enable-gpios", 0);
+
 	if (of_get_child_count(np) == 0)
 		goto out;
 
@@ -948,6 +978,10 @@ static int lp872x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 	lp->chipid = id->driver_data;
 	i2c_set_clientdata(cl, lp);
 
+	ret = lp872x_hw_enable(lp);
+	if (ret)
+		return ret;
+
 	ret = lp872x_config(lp);
 	if (ret)
 		return ret;
diff --git a/include/linux/regulator/lp872x.h b/include/linux/regulator/lp872x.h
index 132e05c..6029279 100644
--- a/include/linux/regulator/lp872x.h
+++ b/include/linux/regulator/lp872x.h
@@ -18,6 +18,9 @@
 
 #define LP872X_MAX_REGULATORS		9
 
+#define LP8720_ENABLE_DELAY		200
+#define LP8725_ENABLE_DELAY		30000
+
 enum lp872x_regulator_id {
 	LP8720_ID_BASE,
 	LP8720_ID_LDO1 = LP8720_ID_BASE,
@@ -79,12 +82,14 @@ struct lp872x_regulator_data {
  * @update_config     : if LP872X_GENERAL_CFG register is updated, set true
  * @regulator_data    : platform regulator id and init data
  * @dvs               : dvs data for buck voltage control
+ * @enable_gpio       : gpio pin number for enable control
  */
 struct lp872x_platform_data {
 	u8 general_config;
 	bool update_config;
 	struct lp872x_regulator_data regulator_data[LP872X_MAX_REGULATORS];
 	struct lp872x_dvs *dvs;
+	int enable_gpio;
 };
 
 #endif
-- 
1.9.1
