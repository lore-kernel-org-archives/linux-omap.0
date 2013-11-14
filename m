From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/8] gpio: twl4030: Fix passing of pdata in the device tree case
Date: Wed, 13 Nov 2013 18:35:35 -0800
Message-ID: <1384396537-3486-7-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1384396537-3486-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We still have some legacy code needing the callback functions
that won't work properly without platform data. To use platform
data for twl4030-gpio, we need to not trash the possible data.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

If this looks OK, I'd like to merge this as a fix via arm-soc tree
along with the other patches in this series as my later patches
depend on patches in this series.

---
 drivers/gpio/gpio-twl4030.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 5738d5a..e6ecbe3 100644
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
+		memcpy(omap_twl_info, pdata, sizeof(*omap_twl_info));
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
-- 
1.8.1.1

