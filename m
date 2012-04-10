From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv6 18/19] I2C: OMAP: Rename the 1p153 to the erratum id i462
Date: Tue, 10 Apr 2012 16:26:36 +0530
Message-ID: <1334055397-899-19-git-send-email-shubhrajyoti@ti.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45866 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab2DJK53 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 06:57:29 -0400
In-Reply-To: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, Jon Hunter <jon-hunter@ti.com>

The section number in the recent errata document has changed.
Rename the erratum 1p153 to the unique id i462 instead, so that
it is easier to reference. Also change the function name and comments
to reflect the same.

Cc: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a3160d1..7b24b44 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -170,7 +170,7 @@ enum {
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
-#define I2C_OMAP3_1P153			(1 << 1)
+#define I2C_OMAP_ERRATA_I462		(1 << 1)
 
 struct omap_i2c_dev {
 	struct device		*dev;
@@ -751,11 +751,11 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
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
 
@@ -918,8 +918,8 @@ complete:
 					break;
 				}
 
-				if ((dev->errata & I2C_OMAP3_1P153) &&
-				    errata_omap3_1p153(dev, &stat, &err))
+				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
+				    errata_omap3_i462(dev, &stat, &err))
 					goto complete;
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
@@ -1057,7 +1057,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
 	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
-		dev->errata |= I2C_OMAP3_1P153;
+		dev->errata |= I2C_OMAP_ERRATA_I462;
 
 	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
 		u16 s;
-- 
1.7.4.1

