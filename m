From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v4 10/18] I2C: OMAP2+: address confused probed version naming
Date: Wed,  1 Jun 2011 17:19:36 -0700
Message-ID: <1306973984-15165-11-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35900 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759196Ab1FBAUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 20:20:04 -0400
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

The driver reflects the confusion that probed I2C revision
from the hardware of 0x40 means it is on an OMAP4430.

However, you will probe the same 0x40 ID on an OMAP3530.  So
this patch changes the name to reflect that.

It also clarifies that the original name OMAP_I2C_REV_2 is
referring to some ancient OMAP1 revision number, not to be
confused with the IP revisions this patch series introduces.

Similarly the term "rev" is used in the ancient OMAP1 ISR,
the term is changed to use omap1 instead.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f7196f3..ecb48c7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -42,12 +42,12 @@
 #include <linux/pm_runtime.h>
 
 /* I2C controller revisions */
-#define OMAP_I2C_REV_2			0x20
+#define OMAP_I2C_OMAP1_REV_2		0x20
 
 /* I2C controller revisions present on specific hardware */
 #define OMAP_I2C_REV_ON_2430		0x36
 #define OMAP_I2C_REV_ON_3430		0x3C
-#define OMAP_I2C_REV_ON_4430		0x40
+#define OMAP_I2C_REV_ON_3530_4430	0x40
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -314,7 +314,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 
-	if (dev->rev < OMAP_I2C_REV_2) {
+	if (dev->rev < OMAP_I2C_OMAP1_REV_2) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
@@ -336,7 +336,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long internal_clk = 0;
 	struct clk *fclk;
 
-	if (dev->rev >= OMAP_I2C_REV_2) {
+	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
 		/* Disable I2C controller before soft reset */
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
 			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
@@ -379,7 +379,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
 			dev->westate = OMAP_I2C_WE_ALL;
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+			if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
+				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+								dev->westate);
 		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
@@ -721,7 +723,7 @@ static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
 #ifdef CONFIG_ARCH_OMAP15XX
 
 static irqreturn_t
-omap_i2c_rev1_isr(int this_irq, void *dev_id)
+omap_i2c_omap1_isr(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev = dev_id;
 	u16 iv, w;
@@ -775,7 +777,7 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 #else
-#define omap_i2c_rev1_isr		NULL
+#define omap_i2c_omap1_isr		NULL
 #endif
 
 /*
@@ -1060,7 +1062,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		 * size. This is to ensure that we can handle the status on int
 		 * call back latencies.
 		 */
-		if (dev->rev >= OMAP_I2C_REV_ON_4430) {
+		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430) {
 			dev->fifo_size = 0;
 			dev->b_hw = 0; /* Disable hardware fixes */
 		} else {
@@ -1076,7 +1078,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-	isr = (dev->rev < OMAP_I2C_REV_2) ? omap_i2c_rev1_isr : omap_i2c_isr;
+	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
+								   omap_i2c_isr;
 	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
 
 	if (r) {
-- 
1.7.4

