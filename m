From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv6 20/24] i2c: omap: switch to threaded IRQ support
Date: Tue, 14 Aug 2012 19:49:02 +0530
Message-ID: <1344953946-13005-21-git-send-email-shubhrajyoti@ti.com>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60164 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820Ab2HNOUF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 10:20:05 -0400
In-Reply-To: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

for OMAP2, we can easily switch over to threaded
IRQs on the I2C driver. This will allow us to
spend less time in hardirq context.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[Trivial formating changes]
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   43 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f5eafb7..39e5d36 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -176,6 +176,7 @@ enum {
 #define I2C_OMAP_ERRATA_I462		(1 << 1)
 
 struct omap_i2c_dev {
+	spinlock_t		lock;		/* IRQ synchronization */
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
@@ -854,9 +855,30 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 }
 
 static irqreturn_t
-omap_i2c_isr(int this_irq, void *dev_id)
+omap_i2c_isr(int irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev = dev_id;
+	irqreturn_t ret = IRQ_HANDLED;
+	u16 mask;
+	u16 stat;
+
+	spin_lock(&dev->lock);
+	mask = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
+	stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+
+	if (stat & mask)
+		ret = IRQ_WAKE_THREAD;
+
+	spin_unlock(&dev->lock);
+
+	return ret;
+}
+
+static irqreturn_t
+omap_i2c_isr_thread(int this_irq, void *dev_id)
+{
+	struct omap_i2c_dev *dev = dev_id;
+	unsigned long flags;
 	u16 bits;
 	u16 stat;
 	int err = 0, count = 0;
@@ -864,6 +886,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	if (pm_runtime_suspended(dev->dev))
 		return IRQ_HANDLED;
 
+	spin_lock_irqsave(&dev->lock, flags);
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
@@ -877,6 +900,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 
 		if (!stat) {
 			/* my work here is done */
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return IRQ_HANDLED;
 		}
 
@@ -985,6 +1009,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 
 out:
 	omap_i2c_complete_cmd(dev, err);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -1028,7 +1054,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
-	irq_handler_t isr;
 	int irq;
 	int r;
 
@@ -1078,6 +1103,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 
+	spin_lock_init(&dev->lock);
+
 	platform_set_drvdata(pdev, dev);
 	init_completion(&dev->cmd_complete);
 
@@ -1130,10 +1157,14 @@ omap_i2c_probe(struct platform_device *pdev)
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
-								   omap_i2c_isr;
-	r = devm_request_irq(&pdev->dev, dev->irq, isr, IRQF_NO_SUSPEND,
-			     pdev->name, dev);
+	if (dev->rev < OMAP_I2C_OMAP1_REV_2)
+		r = devm_request_irq(&pdev->dev, dev->irq, omap_i2c_omap1_isr,
+				IRQF_NO_SUSPEND, pdev->name, dev);
+	else
+		r = devm_request_threaded_irq(&pdev->dev, dev->irq,
+				omap_i2c_isr, omap_i2c_isr_thread,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
+				pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
-- 
1.7.5.4

