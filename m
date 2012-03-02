From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 09/12] gpio/twl: Add DT support to gpio-twl4030 driver
Date: Fri, 2 Mar 2012 17:50:21 +0100
Message-ID: <1330707024-23730-10-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030333Ab2CBQvY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 11:51:24 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add the DT support for the I2C GPIO expander inside the twl4030.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 .../devicetree/bindings/gpio/gpio-twl4030.txt      |   23 ++++++
 drivers/gpio/gpio-twl4030.c                        |   79 ++++++++++++-------
 2 files changed, 73 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-twl4030.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
new file mode 100644
index 0000000..16695d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
@@ -0,0 +1,23 @@
+twl4030 GPIO controller bindings
+
+Required properties:
+- compatible:
+  - "ti,twl4030-gpio" for twl4030 GPIO controller
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller.
+- #interrupt-cells : Should be 2.
+- interrupt-controller: Mark the device node as an interrupt controller
+  The first cell is the GPIO number.
+  The second cell is not used.
+
+Example:
+
+twl_gpio: gpio {
+    compatible = "ti,twl4030-gpio";
+    #gpio-cells = <2>;
+    gpio-controller;
+    #interrupt-cells = <2>;
+    interrupt-controller;
+};
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 49e5c6e..94256fe 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -32,6 +32,8 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/irqdomain.h>
 
 #include <linux/i2c/twl.h>
 
@@ -256,7 +258,8 @@ static int twl_request(struct gpio_chip *chip, unsigned offset)
 		 * and vMMC2 power supplies based on card presence.
 		 */
 		pdata = chip->dev->platform_data;
-		value |= pdata->mmc_cd & 0x03;
+		if (pdata)
+			value |= pdata->mmc_cd & 0x03;
 
 		status = gpio_twl4030_write(REG_GPIO_CTRL, value);
 	}
@@ -395,6 +398,7 @@ static int gpio_twl4030_remove(struct platform_device *pdev);
 static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 {
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *node = pdev->dev.of_node;
 	int ret, irq_base;
 
 	/* maybe setup IRQs */
@@ -409,6 +413,9 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 		return irq_base;
 	}
 
+	irq_domain_add_legacy(node, TWL4030_GPIO_MAX, irq_base, 0,
+			      &irq_domain_simple_ops, NULL);
+
 	ret = twl4030_sih_setup(&pdev->dev, TWL4030_MODULE_GPIO, irq_base);
 	if (ret < 0)
 		return ret;
@@ -416,40 +423,45 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 	twl4030_gpio_irq_base = irq_base;
 
 no_irqs:
-	/*
-	 * NOTE:  boards may waste power if they don't set pullups
-	 * and pulldowns correctly ... default for non-ULPI pins is
-	 * pulldown, and some other pins may have external pullups
-	 * or pulldowns.  Careful!
-	 */
-	ret = gpio_twl4030_pulls(pdata->pullups, pdata->pulldowns);
-	if (ret)
-		dev_dbg(&pdev->dev, "pullups %.05x %.05x --> %d\n",
-				pdata->pullups, pdata->pulldowns,
-				ret);
-
-	ret = gpio_twl4030_debounce(pdata->debounce, pdata->mmc_cd);
-	if (ret)
-		dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
-				pdata->debounce, pdata->mmc_cd,
-				ret);
-
-	twl_gpiochip.base = pdata->gpio_base;
+	twl_gpiochip.base = -1;
 	twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
 	twl_gpiochip.dev = &pdev->dev;
 
-	/* NOTE: we assume VIBRA_CTL.VIBRA_EN, in MODULE_AUDIO_VOICE,
-	 * is (still) clear if use_leds is set.
-	 */
-	if (pdata->use_leds)
-		twl_gpiochip.ngpio += 2;
+	if (pdata) {
+		twl_gpiochip.base = pdata->gpio_base;
+
+		/*
+		 * NOTE:  boards may waste power if they don't set pullups
+		 * and pulldowns correctly ... default for non-ULPI pins is
+		 * pulldown, and some other pins may have external pullups
+		 * or pulldowns.  Careful!
+		 */
+		ret = gpio_twl4030_pulls(pdata->pullups, pdata->pulldowns);
+		if (ret)
+			dev_dbg(&pdev->dev, "pullups %.05x %.05x --> %d\n",
+					pdata->pullups, pdata->pulldowns,
+					ret);
+
+		ret = gpio_twl4030_debounce(pdata->debounce, pdata->mmc_cd);
+		if (ret)
+			dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
+					pdata->debounce, pdata->mmc_cd,
+					ret);
+
+		/*
+		 * NOTE: we assume VIBRA_CTL.VIBRA_EN, in MODULE_AUDIO_VOICE,
+		 * is (still) clear if use_leds is set.
+		 */
+		if (pdata->use_leds)
+			twl_gpiochip.ngpio += 2;
+	}
 
 	ret = gpiochip_add(&twl_gpiochip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
 		twl_gpiochip.ngpio = 0;
 		gpio_twl4030_remove(pdev);
-	} else if (pdata->setup) {
+	} else if (pdata && pdata->setup) {
 		int status;
 
 		status = pdata->setup(&pdev->dev,
@@ -467,7 +479,7 @@ static int gpio_twl4030_remove(struct platform_device *pdev)
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
 	int status;
 
-	if (pdata->teardown) {
+	if (pdata && pdata->teardown) {
 		status = pdata->teardown(&pdev->dev,
 				pdata->gpio_base, TWL4030_GPIO_MAX);
 		if (status) {
@@ -488,12 +500,21 @@ static int gpio_twl4030_remove(struct platform_device *pdev)
 	return -EIO;
 }
 
+static const struct of_device_id twl_gpio_match[] = {
+	{ .compatible = "ti,twl4030-gpio", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, twl_gpio_match);
+
 /* Note:  this hardware lives inside an I2C-based multi-function device. */
 MODULE_ALIAS("platform:twl4030_gpio");
 
 static struct platform_driver gpio_twl4030_driver = {
-	.driver.name	= "twl4030_gpio",
-	.driver.owner	= THIS_MODULE,
+	.driver = {
+		.name	= "twl4030_gpio",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(twl_gpio_match),
+	},
 	.probe		= gpio_twl4030_probe,
 	.remove		= gpio_twl4030_remove,
 };
-- 
1.7.0.4

