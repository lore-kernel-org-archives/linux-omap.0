From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 5/5] OMAP: I2C: Restore only if context is lost
Date: Thu, 21 Jul 2011 12:23:05 +0530
Message-ID: <1311231185-5503-6-git-send-email-shubhrajyoti@ti.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab1GUGxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 02:53:30 -0400
In-Reply-To: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently restore is done always.
Adding conditional restore.The restore is done only if the context is lost.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 07e5a64..06fa457 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <plat/omap_device.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -201,6 +202,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	u32			dev_lost_count;
 };
 
 const static u8 reg_map_ip_v1[] = {
@@ -261,6 +263,18 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
+
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
@@ -274,14 +288,11 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
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
+
 	dev->idle = 0;
 
 	/*
@@ -318,7 +329,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
 	dev->idle = 1;
-
+	dev->dev_lost_count = omap_device_get_context_loss_count(pdev);
 	pm_runtime_put_sync(&pdev->dev);
 }
 
@@ -574,6 +585,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			r = dev->device_reset(dev->dev);
 			if (r < 0)
 				dev_err(dev->dev, "reset failed\n");
+			omap_i2c_restore(dev);
 		}
 		omap_i2c_init(dev);
 		return -ETIMEDOUT;
@@ -589,6 +601,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			r = dev->device_reset(dev->dev);
 			if (r < 0)
 				dev_err(dev->dev, "reset failed\n");
+			omap_i2c_restore(dev);
 		}
 		omap_i2c_init(dev);
 		return -EIO;
-- 
1.7.1

