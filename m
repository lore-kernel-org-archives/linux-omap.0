From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/5] leds: leds-gpio: adopt pinctrl support
Date: Fri, 31 Aug 2012 14:59:20 +0530
Message-ID: <1346405361-29711-5-git-send-email-anilkumar@ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346405361-29711-1-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
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
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adopt pinctrl support to leds-gpio driver, based on the device
pointer (leds-gpio) pinctrl driver configure SoC pins to GPIO
mode.

Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
---
 drivers/leds/leds-gpio.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index c032b21..d98dfb9 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 
 struct gpio_led_data {
 	struct led_classdev cdev;
@@ -236,14 +237,23 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
 {
 	struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_leds_priv *priv;
-	int i, ret = 0;
+	struct pinctrl *pinctrl;
+	int i = 0;
+	int ret = 0;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		return PTR_ERR(pinctrl);
+	}
 
 	if (pdata && pdata->num_leds) {
 		priv = devm_kzalloc(&pdev->dev,
 				sizeof_gpio_leds_priv(pdata->num_leds),
 					GFP_KERNEL);
-		if (!priv)
-			return -ENOMEM;
+		if (!priv) {
+			ret = -ENOMEM;
+			goto err_pctrl_put;
+		}
 
 		priv->num_leds = pdata->num_leds;
 		for (i = 0; i < priv->num_leds; i++) {
@@ -254,18 +264,25 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
 				/* On failure: unwind the led creations */
 				for (i = i - 1; i >= 0; i--)
 					delete_gpio_led(&priv->leds[i]);
-				return ret;
+				goto err_pctrl_put;
 			}
 		}
 	} else {
 		priv = gpio_leds_create_of(pdev);
-		if (!priv)
-			return -ENODEV;
+		if (!priv) {
+			ret = -ENODEV;
+			goto err_del_gpio_led;
+		}
 	}
 
 	platform_set_drvdata(pdev, priv);
 
-	return 0;
+err_pctrl_put:
+	pinctrl_put(pinctrl);
+err_del_gpio_led:
+	while (--i >= 0)
+		delete_gpio_led(&priv->leds[i]);
+	return ret;
 }
 
 static int __devexit gpio_led_remove(struct platform_device *pdev)
-- 
1.7.9.5
