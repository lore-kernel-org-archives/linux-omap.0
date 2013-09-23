From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/10] pwm-backlight: Use new enable_gpio field
Date: Mon, 23 Sep 2013 23:41:05 +0200
Message-ID: <1379972467-11243-9-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379972467-11243-1-git-send-email-treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Make use of the new enable_gpio field and allow it to be set from DT as
well. Now that all legacy users of platform data have been converted to
initialize this field to an invalid value, it is safe to use the field
from the driver.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/video/backlight/pwm-backlight.txt     |  3 ++
 drivers/video/backlight/pwm_bl.c                   | 54 +++++++++++++++++++---
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
index 1e4fc72..052eb03 100644
--- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
@@ -14,6 +14,7 @@ Required properties:
 Optional properties:
   - pwm-names: a list of names for the PWM devices specified in the
                "pwms" property (see PWM binding[0])
+  - enable-gpios: a list of GPIOs to enable and disable the backlight
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 
@@ -25,4 +26,6 @@ Example:
 
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+
+		enable-gpios = <&gpio 58 0>;
 	};
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 8a49b30..506810c 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -10,6 +10,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -27,6 +29,8 @@ struct pwm_bl_data {
 	unsigned int		period;
 	unsigned int		lth_brightness;
 	unsigned int		*levels;
+	int			enable_gpio;
+	unsigned long		enable_gpio_flags;
 	int			(*notify)(struct device *,
 					  int brightness);
 	void			(*notify_after)(struct device *,
@@ -51,12 +55,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness,
 		     pb->lth_brightness;
 
 	pwm_config(pb->pwm, duty_cycle, pb->period);
+
+	if (gpio_is_valid(pb->enable_gpio)) {
+		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
+			gpio_set_value(pb->enable_gpio, 0);
+		else
+			gpio_set_value(pb->enable_gpio, 1);
+	}
+
 	pwm_enable(pb->pwm);
 }
 
 static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
 	pwm_disable(pb->pwm);
+
+	if (gpio_is_valid(pb->enable_gpio)) {
+		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
+			gpio_set_value(pb->enable_gpio, 1);
+		else
+			gpio_set_value(pb->enable_gpio, 0);
+	}
 }
 
 static int pwm_backlight_update_status(struct backlight_device *bl)
@@ -108,6 +127,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 				  struct platform_pwm_backlight_data *data)
 {
 	struct device_node *node = dev->of_node;
+	enum of_gpio_flags flags;
 	struct property *prop;
 	int length;
 	u32 value;
@@ -148,11 +168,10 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		data->max_brightness--;
 	}
 
-	/*
-	 * TODO: Most users of this driver use a number of GPIOs to control
-	 *       backlight power. Support for specifying these needs to be
-	 *       added.
-	 */
+	data->enable_gpio = of_get_named_gpio_flags(node, "enable-gpios", 0,
+						    &flags);
+	if (gpio_is_valid(data->enable_gpio) && (flags & OF_GPIO_ACTIVE_LOW))
+		data->enable_gpio_flags |= PWM_BACKLIGHT_GPIO_ACTIVE_LOW;
 
 	return 0;
 }
@@ -210,12 +229,30 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	} else
 		max = data->max_brightness;
 
+	pb->enable_gpio = data->enable_gpio;
+	pb->enable_gpio_flags = data->enable_gpio_flags;
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
 	pb->check_fb = data->check_fb;
 	pb->exit = data->exit;
 	pb->dev = &pdev->dev;
 
+	if (gpio_is_valid(pb->enable_gpio)) {
+		unsigned long flags;
+
+		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
+			flags = GPIOF_OUT_INIT_HIGH;
+		else
+			flags = GPIOF_OUT_INIT_LOW;
+
+		ret = gpio_request_one(pb->enable_gpio, flags, "enable");
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request GPIO#%d: %d\n",
+				pb->enable_gpio, ret);
+			goto err_alloc;
+		}
+	}
+
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
@@ -224,7 +261,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		if (IS_ERR(pb->pwm)) {
 			dev_err(&pdev->dev, "unable to request legacy PWM\n");
 			ret = PTR_ERR(pb->pwm);
-			goto err_alloc;
+			goto err_gpio;
 		}
 	}
 
@@ -249,7 +286,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (IS_ERR(bl)) {
 		dev_err(&pdev->dev, "failed to register backlight\n");
 		ret = PTR_ERR(bl);
-		goto err_alloc;
+		goto err_gpio;
 	}
 
 	if (data->dft_brightness > data->max_brightness) {
@@ -265,6 +302,9 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, bl);
 	return 0;
 
+err_gpio:
+	if (gpio_is_valid(pb->enable_gpio))
+		gpio_free(pb->enable_gpio);
 err_alloc:
 	if (data->exit)
 		data->exit(&pdev->dev);
-- 
1.8.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
