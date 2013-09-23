From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/10] pwm-backlight: Use an optional power supply
Date: Mon, 23 Sep 2013 23:41:06 +0200
Message-ID: <1379972467-11243-10-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379972467-11243-1-git-send-email-treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Many backlights require a power supply to work properly. This commit
uses a power-supply regulator, if available, to power up and power down
the panel.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/video/backlight/pwm-backlight.txt      |  2 ++
 drivers/video/backlight/pwm_bl.c                    | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
index 052eb03..3898f26 100644
--- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
@@ -15,6 +15,7 @@ Optional properties:
   - pwm-names: a list of names for the PWM devices specified in the
                "pwms" property (see PWM binding[0])
   - enable-gpios: a list of GPIOs to enable and disable the backlight
+  - power-supply: regulator for supply voltage
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 
@@ -28,4 +29,5 @@ Example:
 		default-brightness-level = <6>;
 
 		enable-gpios = <&gpio 58 0>;
+		power-supply = <&vdd_bl_reg>;
 	};
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 506810c..a2b3876 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 struct pwm_bl_data {
@@ -29,6 +30,7 @@ struct pwm_bl_data {
 	unsigned int		period;
 	unsigned int		lth_brightness;
 	unsigned int		*levels;
+	struct regulator	*power_supply;
 	int			enable_gpio;
 	unsigned long		enable_gpio_flags;
 	int			(*notify)(struct device *,
@@ -56,6 +58,12 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness,
 
 	pwm_config(pb->pwm, duty_cycle, pb->period);
 
+	if (pb->power_supply) {
+		err = regulator_enable(pb->power_supply);
+		if (err < 0)
+			dev_err(pb->dev, "failed to enable power supply\n");
+	}
+
 	if (gpio_is_valid(pb->enable_gpio)) {
 		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
 			gpio_set_value(pb->enable_gpio, 0);
@@ -76,6 +84,9 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 		else
 			gpio_set_value(pb->enable_gpio, 0);
 	}
+
+	if (pb->power_supply)
+		regulator_disable(pb->power_supply);
 }
 
 static int pwm_backlight_update_status(struct backlight_device *bl)
@@ -253,6 +264,16 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		}
 	}
 
+	pb->power_supply = devm_regulator_get_optional(&pdev->dev, "power");
+	if (IS_ERR(pb->power_supply)) {
+		if (PTR_ERR(pb->power_supply) != -ENODEV) {
+			ret = PTR_ERR(pb->power_supply);
+			goto err_gpio;
+		}
+
+		pb->power_supply = NULL;
+	}
+
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
-- 
1.8.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
