From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 09/18] I2C: OMAP: Correct I2C revision for OMAP3
Date: Wed, 11 Apr 2012 16:42:47 +0530
Message-ID: <1334142776-10583-10-git-send-email-shubhrajyoti@ti.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334142776-10583-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>

The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
revision is the same for 3430 and 3530. However, the OMAP3630 device has the
same I2C revision as OMAP4. Correct the revision definition to reflect this.

This patch is based on work done by Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Changes from his patch
- Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530

Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
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
1.7.4.1
