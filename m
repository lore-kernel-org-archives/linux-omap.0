From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 09/18] I2C: OMAP: Correct I2C revision for OMAP3
Date: Tue, 3 Apr 2012 17:08:18 +0530
Message-ID: <1333453107-7697-10-git-send-email-shubhrajyoti@ti.com>
References: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52614 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab2DCLje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 07:39:34 -0400
In-Reply-To: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Jon Hunter <jon-hunter@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
revision is the same for 3430 and 3530. However, the OMAP3630 device has the
same I2C revision as OMAP4. Correct the revision definition to reflect this.

This patch is based on work done by Jon Hunter <jon-hunter@ti.com>
Changes from his patch
- Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a461097..959e97c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -50,8 +50,8 @@
 
 /* I2C controller revisions present on specific hardware */
 #define OMAP_I2C_REV_ON_2430		0x36
-#define OMAP_I2C_REV_ON_3430		0x3C
-#define OMAP_I2C_REV_ON_3530_4430	0x40
+#define OMAP_I2C_REV_ON_3430_3530	0x3C
+#define OMAP_I2C_REV_ON_3630_4430	0x40
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -298,7 +298,7 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
 			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
 					   SYSC_AUTOIDLE_MASK);
 
-		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
+		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
 			dev->syscstate = SYSC_AUTOIDLE_MASK;
 			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
 			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
@@ -1051,7 +1051,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
-	if (dev->rev <= OMAP_I2C_REV_ON_3430)
+	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
 		dev->errata |= I2C_OMAP3_1P153;
 
 	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
@@ -1069,7 +1069,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
+		if (dev->rev >= OMAP_I2C_REV_ON_3630_4430)
 			dev->b_hw = 0; /* Disable hardware fixes */
 		else
 			dev->b_hw = 1; /* Enable hardware fixes */
-- 
1.7.1

