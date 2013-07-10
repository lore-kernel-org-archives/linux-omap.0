From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 02/12] drivers/i2c/busses: don't use devm_pinctrl_get_select_default() in probe
Date: Wed, 10 Jul 2013 16:57:37 +0100
Message-ID: <1373471889-18107-2-git-send-email-wsa@the-dreams.de>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373471889-18107-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for setting the default pins. Compile tested only.

Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (personally at LCE13)
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 142b694d..d09512e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -43,7 +43,6 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
-#include <linux/pinctrl/consumer.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -216,8 +215,6 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
-
-	struct pinctrl		*pins;
 };
 
 static const u8 reg_map_ip_v1[] = {
@@ -1120,16 +1117,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
 	}
 
-	dev->pins = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(dev->pins)) {
-		if (PTR_ERR(dev->pins) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_warn(&pdev->dev, "did not get pins for i2c error: %li\n",
-			 PTR_ERR(dev->pins));
-		dev->pins = NULL;
-	}
-
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 
-- 
1.7.10.4
