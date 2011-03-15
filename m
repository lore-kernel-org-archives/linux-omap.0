From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 10/18] I2C: OMAP2+: address confused probed version naming
Date: Tue, 15 Mar 2011 19:57:04 +0000
Message-ID: <20110315195704.30000.56240.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37340 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756982Ab1COT5I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:57:08 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1206062wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:57:07 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

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
---

 drivers/i2c/busses/i2c-omap.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 14f5b50..ecb48c7 100644
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
@@ -379,7 +379,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
 			dev->westate = OMAP_I2C_WE_ALL;
-			if (dev->rev < OMAP_I2C_REV_ON_4430)
+			if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
 				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
 								dev->westate);
 		}
@@ -723,7 +723,7 @@ static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
 #ifdef CONFIG_ARCH_OMAP15XX
 
 static irqreturn_t
-omap_i2c_rev1_isr(int this_irq, void *dev_id)
+omap_i2c_omap1_isr(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev = dev_id;
 	u16 iv, w;
@@ -777,7 +777,7 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 #else
-#define omap_i2c_rev1_isr		NULL
+#define omap_i2c_omap1_isr		NULL
 #endif
 
 /*
@@ -1062,7 +1062,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		 * size. This is to ensure that we can handle the status on int
 		 * call back latencies.
 		 */
-		if (dev->rev >= OMAP_I2C_REV_ON_4430) {
+		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430) {
 			dev->fifo_size = 0;
 			dev->b_hw = 0; /* Disable hardware fixes */
 		} else {
@@ -1078,7 +1078,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-	isr = (dev->rev < OMAP_I2C_REV_2) ? omap_i2c_rev1_isr : omap_i2c_isr;
+	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
+								   omap_i2c_isr;
 	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
 
 	if (r) {

