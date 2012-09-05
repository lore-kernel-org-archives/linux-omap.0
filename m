From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/2] gpio/twl4030: get platform data from device tree
Date: Wed,  5 Sep 2012 09:46:25 +0200
Message-ID: <1346831186-29947-2-git-send-email-florian.vaussard@epfl.ch>
References: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:58412 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751449Ab2IEHql (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 03:46:41 -0400
In-Reply-To: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Adds a number of missing device tree properties for
twl4030/gpio, and update bindings:
- "ti,use-leds"  -> .use_leds
- "ti,debounce"  -> .debounce
- "ti,mmc-cd"    -> .mmc_cd
- "ti,pullups"   -> .pullups
- "ti,pulldowns" -> .pulldowns

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
 drivers/gpio/gpio-twl4030.c                        |   84 +++++++++++++------
 2 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
index 16695d9..66788fd 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
@@ -11,6 +11,11 @@ Required properties:
 - interrupt-controller: Mark the device node as an interrupt controller
   The first cell is the GPIO number.
   The second cell is not used.
+- ti,use-leds : Enables LEDA and LEDB outputs if set
+- ti,debounce : if n-th bit is set, debounces GPIO-n
+- ti,mmc-cd : if n-th bit is set, GPIO-n controls VMMC(n+1)
+- ti,pullups : if n-th bit is set, set a pullup on GPIO-n
+- ti,pulldowns : if n-th bit is set, set a pulldown on GPIO-n
 
 Example:
 
@@ -20,4 +25,5 @@ twl_gpio: gpio {
     gpio-controller;
     #interrupt-cells = <2>;
     interrupt-controller;
+    ti,use-leds;
 };
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 94256fe..477c1d9 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -395,6 +395,31 @@ static int __devinit gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
 
 static int gpio_twl4030_remove(struct platform_device *pdev);
 
+static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
+{
+	struct twl4030_gpio_platform_data *omap_twl_info;
+
+	omap_twl_info = devm_kzalloc(dev, sizeof(*omap_twl_info), GFP_KERNEL);
+	if (!omap_twl_info)
+		return NULL;
+
+	omap_twl_info->gpio_base = -1;
+
+	omap_twl_info->use_leds = of_property_read_bool(dev->of_node,
+			"ti,use-leds");
+
+	of_property_read_u32(dev->of_node, "ti,debounce",
+				&omap_twl_info->debounce);
+	of_property_read_u32(dev->of_node, "ti,mmc-cd",
+				(u32 *)&omap_twl_info->mmc_cd);
+	of_property_read_u32(dev->of_node, "ti,pullups",
+				&omap_twl_info->pullups);
+	of_property_read_u32(dev->of_node, "ti,pulldowns",
+				&omap_twl_info->pulldowns);
+
+	return omap_twl_info;
+}
+
 static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 {
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
@@ -423,39 +448,44 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 	twl4030_gpio_irq_base = irq_base;
 
 no_irqs:
-	twl_gpiochip.base = -1;
 	twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
 	twl_gpiochip.dev = &pdev->dev;
 
-	if (pdata) {
-		twl_gpiochip.base = pdata->gpio_base;
+	if (node)
+		pdata = of_gpio_twl4030(&pdev->dev);
 
-		/*
-		 * NOTE:  boards may waste power if they don't set pullups
-		 * and pulldowns correctly ... default for non-ULPI pins is
-		 * pulldown, and some other pins may have external pullups
-		 * or pulldowns.  Careful!
-		 */
-		ret = gpio_twl4030_pulls(pdata->pullups, pdata->pulldowns);
-		if (ret)
-			dev_dbg(&pdev->dev, "pullups %.05x %.05x --> %d\n",
-					pdata->pullups, pdata->pulldowns,
-					ret);
-
-		ret = gpio_twl4030_debounce(pdata->debounce, pdata->mmc_cd);
-		if (ret)
-			dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
-					pdata->debounce, pdata->mmc_cd,
-					ret);
-
-		/*
-		 * NOTE: we assume VIBRA_CTL.VIBRA_EN, in MODULE_AUDIO_VOICE,
-		 * is (still) clear if use_leds is set.
-		 */
-		if (pdata->use_leds)
-			twl_gpiochip.ngpio += 2;
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "Platform data is missing\n");
+		return -ENXIO;
 	}
 
+	twl_gpiochip.base = pdata->gpio_base;
+
+	/*
+	 * NOTE:  boards may waste power if they don't set pullups
+	 * and pulldowns correctly ... default for non-ULPI pins is
+	 * pulldown, and some other pins may have external pullups
+	 * or pulldowns.  Careful!
+	 */
+	ret = gpio_twl4030_pulls(pdata->pullups, pdata->pulldowns);
+	if (ret)
+		dev_dbg(&pdev->dev, "pullups %.05x %.05x --> %d\n",
+				pdata->pullups, pdata->pulldowns,
+				ret);
+
+	ret = gpio_twl4030_debounce(pdata->debounce, pdata->mmc_cd);
+	if (ret)
+		dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
+				pdata->debounce, pdata->mmc_cd,
+				ret);
+
+	/*
+	 * NOTE: we assume VIBRA_CTL.VIBRA_EN, in MODULE_AUDIO_VOICE,
+	 * is (still) clear if use_leds is set.
+	 */
+	if (pdata->use_leds)
+		twl_gpiochip.ngpio += 2;
+
 	ret = gpiochip_add(&twl_gpiochip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
-- 
1.7.5.4

