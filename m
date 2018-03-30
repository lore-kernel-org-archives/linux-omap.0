From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 02/10] mfd: ti-lmu: switch to gpiod
Date: Fri, 30 Mar 2018 19:24:06 +0200
Message-ID: <20180330172414.26575-3-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Use new descriptor based API instead of the legacy one.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/ti-lmu.c       | 28 ++++++++++++----------------
 include/linux/mfd/ti-lmu.h |  3 ++-
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 990437e5ed0a..e14cb9f41b44 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -12,7 +12,7 @@
 
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
 
 struct ti_lmu_data {
@@ -32,17 +31,8 @@ struct ti_lmu_data {
 
 static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_lmu_id id)
 {
-	int ret;
-
-	if (gpio_is_valid(lmu->en_gpio)) {
-		ret = devm_gpio_request_one(lmu->dev, lmu->en_gpio,
-					    GPIOF_OUT_INIT_HIGH, "lmu_hwen");
-		if (ret) {
-			dev_err(lmu->dev, "Can not request enable GPIO: %d\n",
-				ret);
-			return ret;
-		}
-	}
+	if (lmu->en_gpio)
+		gpiod_set_value(lmu->en_gpio, 1);
 
 	/* Delay about 1ms after HW enable pin control */
 	usleep_range(1000, 1500);
@@ -59,8 +49,8 @@ static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_lmu_id id)
 
 static void ti_lmu_disable_hw(struct ti_lmu *lmu)
 {
-	if (gpio_is_valid(lmu->en_gpio))
-		gpio_set_value(lmu->en_gpio, 0);
+	if (lmu->en_gpio)
+		gpiod_set_value(lmu->en_gpio, 0);
 }
 
 static const struct mfd_cell lm3532_devices[] = {
@@ -204,7 +194,13 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 		return PTR_ERR(lmu->regmap);
 
 	/* HW enable pin control and additional power up sequence if required */
-	lmu->en_gpio = of_get_named_gpio(dev->of_node, "enable-gpios", 0);
+	lmu->en_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(lmu->en_gpio)) {
+		ret = PTR_ERR(lmu->en_gpio);
+		dev_err(dev, "Can not request enable GPIO: %d\n", ret);
+		return ret;
+	}
+
 	ret = ti_lmu_enable_hw(lmu, id->driver_data);
 	if (ret)
 		return ret;
diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
index 09d5f30384e5..1ef51ed36be5 100644
--- a/include/linux/mfd/ti-lmu.h
+++ b/include/linux/mfd/ti-lmu.h
@@ -16,6 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/notifier.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
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
-- 
2.16.2
