From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv11 5/6] i2c: omap: Correct I2C revision for OMAP3
Date: Thu, 28 Jun 2012 20:41:31 +0530
Message-ID: <1340896292-12112-6-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44427 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab2F1PM0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:12:26 -0400
In-Reply-To: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
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

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- Add Felipe's Reviewed by tag

 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4bbf288..5058dfc 100644
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
@@ -303,7 +303,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
 					   SYSC_AUTOIDLE_MASK);
 
-		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
+		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
 			dev->syscstate = SYSC_AUTOIDLE_MASK;
 			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
 			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
@@ -1018,7 +1018,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
-	if (dev->rev <= OMAP_I2C_REV_ON_3430)
+	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
 		dev->errata |= I2C_OMAP_ERRATA_I462;
 
 	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
@@ -1036,7 +1036,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
+		if (dev->rev >= OMAP_I2C_REV_ON_3630_4430)
 			dev->b_hw = 0; /* Disable hardware fixes */
 		else
 			dev->b_hw = 1; /* Enable hardware fixes */
-- 
1.7.5.4

