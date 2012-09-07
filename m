From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] gpio/twl4030: get platform data from device tree
Date: Fri, 7 Sep 2012 19:33:38 +0200
Message-ID: <504A2FF2.7070607@ti.com>
References: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch>
 <1346831186-29947-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346831186-29947-2-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Florian,

I've just noticed that this patch is reporting some CHECK issues.

d1f5052 - gpio/twl4030: get platform data from device tree
CHECK: Alignment should match open parenthesis
#66: FILE: drivers/gpio/gpio-twl4030.c:412:
+	of_property_read_u32(dev->of_node, "ti,debounce",
+				&omap_twl_info->debounce);

CHECK: Alignment should match open parenthesis
#68: FILE: drivers/gpio/gpio-twl4030.c:414:
+	of_property_read_u32(dev->of_node, "ti,mmc-cd",
+				(u32 *)&omap_twl_info->mmc_cd);

CHECK: Alignment should match open parenthesis
#70: FILE: drivers/gpio/gpio-twl4030.c:416:
+	of_property_read_u32(dev->of_node, "ti,pullups",
+				&omap_twl_info->pullups);

CHECK: Alignment should match open parenthesis
#72: FILE: drivers/gpio/gpio-twl4030.c:418:
+	of_property_read_u32(dev->of_node, "ti,pulldowns",
+				&omap_twl_info->pulldowns);

CHECK: Alignment should match open parenthesis
+				pdata->pullups, pdata->pulldowns,

CHECK: Alignment should match open parenthesis
#139: FILE: drivers/gpio/gpio-twl4030.c:479:
+		dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
+				pdata->debounce, pdata->mmc_cd,

total: 0 errors, 0 warnings, 6 checks, 118 lines checked


I fixed them since it was trivial, but next time you should ensure that the patch pass checkpatch before posting.

Just let me know if you have any issue with the following update.

Regards,
Benoit

---
>From f74ce8fb849e9f9c54a494cff5fc30d53ca4e963 Mon Sep 17 00:00:00 2001
From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Date: Wed, 5 Sep 2012 09:46:25 +0200
Subject: [PATCH] gpio/twl4030: get platform data from device tree

Adds a number of missing device tree properties for
twl4030/gpio, and update bindings:
- "ti,use-leds"  -> .use_leds
- "ti,debounce"  -> .debounce
- "ti,mmc-cd"    -> .mmc_cd
- "ti,pullups"   -> .pullups
- "ti,pulldowns" -> .pulldowns

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
[b-cousson-l0cyMroinI0@public.gmane.org: Fix some checkpatch CHECK issues]
Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
 drivers/gpio/gpio-twl4030.c                        |   82 +++++++++++++-------
 2 files changed, 61 insertions(+), 27 deletions(-)

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
index 94256fe..f923252 100644
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
+			     &omap_twl_info->debounce);
+	of_property_read_u32(dev->of_node, "ti,mmc-cd",
+			     (u32 *)&omap_twl_info->mmc_cd);
+	of_property_read_u32(dev->of_node, "ti,pullups",
+			     &omap_twl_info->pullups);
+	of_property_read_u32(dev->of_node, "ti,pulldowns",
+			     &omap_twl_info->pulldowns);
+
+	return omap_twl_info;
+}
+
 static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 {
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
@@ -423,39 +448,42 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
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
+			pdata->pullups, pdata->pulldowns, ret);
+
+	ret = gpio_twl4030_debounce(pdata->debounce, pdata->mmc_cd);
+	if (ret)
+		dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
+			pdata->debounce, pdata->mmc_cd, ret);
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
1.7.0.4
