From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHV3 4/4] OMAP: I2C: I2C register restore only if context is lost
Date: Thu, 21 Jul 2011 19:23:01 +0530
Message-ID: <1311256381-25548-5-git-send-email-shubhrajyoti@ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1311256381-25548-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 Currently i2c register restore is done always.
 Adding conditional restore.
 The i2c register restore is done only if the context is lost.

Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org> 
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 75bb62d..dffdbfd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <plat/omap_device.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -200,6 +201,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	u32			dev_lost_count;
 };
 
 const static u8 reg_map_ip_v1[] = {
@@ -260,6 +262,17 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
+static void omap_i2c_restore(struct omap_i2c_dev *dev)
+{
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+}
+
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
 	struct platform_device *pdev;
@@ -273,13 +286,9 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+		u32 loss_cnt = omap_device_get_context_loss_count(pdev);
+		if (dev->dev_lost_count != loss_cnt)
+			omap_i2c_restore(dev);
 	}
 	dev->idle = 0;
 
@@ -318,6 +327,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	}
 	dev->idle = 1;
 
+	dev->dev_lost_count = omap_device_get_context_loss_count(pdev);
 	pm_runtime_put_sync(&pdev->dev);
 }
 
-- 
1.7.1
