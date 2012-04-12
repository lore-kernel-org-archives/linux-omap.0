From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 18/18] I2C: OMAP: Rename the 1p153 to the erratum id i462
Date: Thu, 12 Apr 2012 18:36:35 +0530
Message-ID: <1334235995-6727-19-git-send-email-shubhrajyoti@ti.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334235995-6727-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The section number in the recent errata document has changed.
Rename the erratum 1p153 to the unique id i462 instead, so that
it is easier to reference. Also change the function name and comments
to reflect the same.

Cc: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9239e9c..c592497 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -170,7 +170,7 @@ enum {
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
-#define I2C_OMAP3_1P153			(1 << 1)
+#define I2C_OMAP_ERRATA_I462		(1 << 1)
 
 struct omap_i2c_dev {
 	struct device		*dev;
@@ -753,11 +753,11 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
 #endif
 
 /*
- * OMAP3430 Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing
+ * OMAP3430 Errata i462: When an XRDY/XDR is hit, wait for XUDF before writing
  * data to DATA_REG. Otherwise some data bytes can be lost while transferring
  * them from the memory to the I2C interface.
  */
-static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
+static int errata_omap3_i462(struct omap_i2c_dev *dev, u16 *stat, int *err)
 {
 	unsigned long timeout = 10000;
 
@@ -920,8 +920,8 @@ complete:
 					break;
 				}
 
-				if ((dev->errata & I2C_OMAP3_1P153) &&
-				    errata_omap3_1p153(dev, &stat, &err))
+				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
+				    errata_omap3_i462(dev, &stat, &err))
 					goto complete;
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
@@ -1056,7 +1056,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
 	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
-		dev->errata |= I2C_OMAP3_1P153;
+		dev->errata |= I2C_OMAP_ERRATA_I462;
 
 	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
 		u16 s;
-- 
1.7.4.1
