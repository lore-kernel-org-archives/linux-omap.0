From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/3] gpio-twl4030: get platform data from device tree
Date: Mon,  3 Sep 2012 15:54:49 +0200
Message-ID: <1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:40817 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756441Ab2ICNzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 09:55:16 -0400
In-Reply-To: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Adds a number of missing properties to the device tree of
twl4030/gpio:
- "ti,use-leds"  -> .use_leds
- "ti,debounce"  -> .debounce
- "ti,mmc-cd"    -> .mmc_cd
- "ti,pullups"   -> .pullups
- "ti,pulldowns" -> .pulldowns

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/gpio/gpio-twl4030.c |   86 +++++++++++++++++++++++++++++-------------
 1 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 94256fe..dabe76b 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -395,6 +395,33 @@ static int __devinit gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
 
 static int gpio_twl4030_remove(struct platform_device *pdev);
 
+static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
+{
+	struct twl4030_gpio_platform_data *omap_twl_info;
+	const char *of_use_leds;
+
+	omap_twl_info = devm_kzalloc(dev, sizeof(*omap_twl_info), GFP_KERNEL);
+	if (!omap_twl_info)
+		return NULL;
+
+	omap_twl_info->gpio_base = -1;
+
+	of_property_read_string(dev->of_node, "ti,use-leds", &of_use_leds);
+	if (!strcmp(of_use_leds, "true"))
+		omap_twl_info->use_leds = true;
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
@@ -423,39 +450,44 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
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

