From: Manjunath GK <manjugk@ti.com>
Subject: [PATCH] OMAP3 : Fix I2C lockup during timeout/error cases
Date: Wed, 23 Sep 2009 15:44:21 +0530
Message-ID: <1253700861-6548-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39567 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZIWKOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 06:14:21 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8NAEN7A022801
	for <linux-omap@vger.kernel.org>; Wed, 23 Sep 2009 05:14:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>

Current OMAP3 I2C driver code does not follow the correct sequence for soft
reset. Due to this, lock up issues are reported during timeout/error cases.

This patch fixes above issue by disabling I2C controller as per OMAP3430 TRM
for soft reset. As per TRM, I2C controller needs to be disabled as a first
step during soft reset.

Here is correct soft reset sequence:
1. Ensure that the module is disabled
(clear the I2Ci.I2C_CON[15] I2C_EN bit to 0).
2. Set the I2Ci.I2C_SYSC[1] SRST bit to 1.
3. Enable the module by setting I2Ci.I2C_CON[15] I2C_EN bit to 1.
4. Check the I2Ci.I2C_SYSS[0] RDONE bit until it is set to 1 to
indicate the software reset is complete.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 drivers/i2c/busses/i2c-omap.c

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
old mode 100644
new mode 100755
index 827da08..2f869dc
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -265,6 +265,21 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long internal_clk = 0;
 
 	if (dev->rev >= OMAP_I2C_REV_2) {
+		/* Disable I2C controller before soft reset */
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
+			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
+				~(OMAP_I2C_CON_EN));
+		timeout = jiffies + OMAP_I2C_TIMEOUT;
+		while ((omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
+			OMAP_I2C_CON_EN)) {
+			if (time_after(jiffies, timeout)) {
+				dev_warn(dev->dev, "timeout waiting "
+					"for controller reset\n");
+				return -ETIMEDOUT;
+			}
+			schedule();
+		}
+
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
@@ -277,7 +292,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 						"for controller reset\n");
 				return -ETIMEDOUT;
 			}
-			msleep(1);
+			schedule();
 		}
 
 		/* SYSC register is cleared by the reset; rewrite it */
-- 
1.6.0.4

