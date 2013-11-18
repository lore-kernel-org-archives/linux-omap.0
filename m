From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] gpio: twl4030: Fix passing of pdata in the device
 tree case
Date: Mon, 18 Nov 2013 10:27:24 -0800
Message-ID: <20131118182724.GO10317@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384396537-3486-7-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131113 18:37]:
> We still have some legacy code needing the callback functions
> that won't work properly without platform data. To use platform
> data for twl4030-gpio, we need to not trash the possible data.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.

Here's this one with a fix from Fengguang Wu to use struct assignment
instead of memcpy folded in.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 14 Nov 2013 15:25:08 -0800
Subject: [PATCH] gpio: twl4030: Fix passing of pdata in the device tree case

We still have some legacy code needing the callback functions
that won't work properly without platform data. To use platform
data for twl4030-gpio, we need to not trash the possible data.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
[tony@atomide.com: folded in fix from Fengguang to use struct assignment]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -436,7 +436,8 @@ static int gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
 
 static int gpio_twl4030_remove(struct platform_device *pdev);
 
-static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
+static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev,
+				struct twl4030_gpio_platform_data *pdata)
 {
 	struct twl4030_gpio_platform_data *omap_twl_info;
 
@@ -444,6 +445,9 @@ static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
 	if (!omap_twl_info)
 		return NULL;
 
+	if (pdata)
+		*omap_twl_info = *pdata;
+
 	omap_twl_info->use_leds = of_property_read_bool(dev->of_node,
 			"ti,use-leds");
 
@@ -501,7 +505,7 @@ no_irqs:
 	mutex_init(&priv->mutex);
 
 	if (node)
-		pdata = of_gpio_twl4030(&pdev->dev);
+		pdata = of_gpio_twl4030(&pdev->dev, pdata);
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform data is missing\n");
