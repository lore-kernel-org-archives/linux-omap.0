From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv5 07/10] OMAP3: PM: Adding T2 enabling of smartreflex support
Date: Fri, 10 Dec 2010 23:32:58 +0530
Message-ID: <1292004181-4804-8-git-send-email-thara@ti.com>
References: <1292004181-4804-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48014 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621Ab0LJSDQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 13:03:16 -0500
In-Reply-To: <1292004181-4804-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com, Thara Gopinath <thara@ti.com>

This patch adds support in the twl4030 driver to enable smartreflex.
The smartreflex bit on twl4030 needs to be enabled by default irrespective
of whether smartreflex module is enabled on the OMAP side or not.
This is because without this bit enabled the voltage scaling through
vp forceupdate does not function properly.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 drivers/mfd/twl-core.c  |   13 +++++++++++++
 include/linux/i2c/twl.h |   11 +++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 35275ba..b895ceb 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1046,6 +1046,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Disable TWL4030/TWL5030 I2C Pull-up on I2C1 and I2C4(SR) interface.
 	 * Program I2C_SCL_CTRL_PU(bit 0)=0, I2C_SDA_CTRL_PU (bit 2)=0,
 	 * SR_I2C_SCL_CTRL_PU(bit 4)=0 and SR_I2C_SDA_CTRL_PU(bit 6)=0.
+	 * Also enable the smartreflex I2S bit.
 	 */
 
 	if (twl_class_is_4030()) {
@@ -1053,6 +1054,18 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		temp &= ~(SR_I2C_SDA_CTRL_PU | SR_I2C_SCL_CTRL_PU | \
 		I2C_SDA_CTRL_PU | I2C_SCL_CTRL_PU);
 		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
+
+		/* The smartreflex bit on twl4030 needs to be enabled by
+		 * default irrespective of whether smartreflex module is
+		 * enabled on the OMAP side or not. This is because without
+		 * this bit enabled the voltage scaling through
+		 * vp forceupdate does not function properly.
+		 */
+		twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
+			TWL4030_PM_RECEIVER_DCDC_GLOBAL_CFG);
+		temp |= SMARTREFLEX_ENABLE;
+		twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
+			TWL4030_PM_RECEIVER_DCDC_GLOBAL_CFG);
 	}
 
 	status = add_children(pdata, id->driver_data);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index c760991..d392f06 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -434,6 +434,17 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 
 /*----------------------------------------------------------------------*/
 
+/*
+ * PM Receiver module register offsets (use TWL4030_MODULE_PM_RECEIVER)
+ */
+
+#define TWL4030_PM_RECEIVER_DCDC_GLOBAL_CFG	0x06
+
+/* Smartreflex I2S bus enable/ vmode enable bit */
+#define SMARTREFLEX_ENABLE			BIT(3)
+
+/*----------------------------------------------------------------------*/
+
 /* Power bus message definitions */
 
 /* The TWL4030/5030 splits its power-management resources (the various
-- 
1.7.0.4

