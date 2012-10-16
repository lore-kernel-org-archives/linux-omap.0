From: Sebastien Guiriec <s-guiriec-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: omap: adopt pinctrl support
Date: Tue, 16 Oct 2012 17:23:20 +0200
Message-ID: <1350401000-9453-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastien Guiriec <s-guiriec-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some GPIO expanders need some early pin control muxing. Due to
legacy boards sometimes the driver uses subsys_initcall instead of
module_init. This patch takes advantage of defer probe feature
and pin control in order to wait until pin control probing before
GPIO driver probing. It has been tested on OMAP5 board with TCA6424
driver.

log:

[0.482299] omap_i2c i2c.15: could not find pctldev for node /ocp/pinmux@4a00
2840/pinmux_i2c5_pins, deferring probe
[0.482330] platform i2c.15: Driver omap_i2c requests probe deferral
[0.484466] Advanced Linux Sound Architecture Driver Initialized.

[4.746917] omap_i2c i2c.15: bus 4 rev2.4.0 at 100 kHz
[4.755279] gpiochip_find_base: found new base at 477
[4.761169] gpiochip_add: registered GPIOs 477 to 500 on device: tca6424a

Signed-off-by: Sebastien Guiriec <s-guiriec-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..661d8a2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -44,6 +44,7 @@
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
+#include <linux/pinctrl/consumer.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -213,6 +214,8 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+
+	struct pinctrl		*pins;
 };
 
 static const u8 reg_map_ip_v1[] = {
@@ -1107,6 +1110,16 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->dtrev = pdata->rev;
 	}
 
+	dev->pins = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(dev->pins)) {
+		if (PTR_ERR(dev->pins) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_warn(&pdev->dev, "did not get pins for i2c error: %li\n",
+			 PTR_ERR(dev->pins));
+		dev->pins = NULL;
+	}
+
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 
-- 
1.7.10.4
