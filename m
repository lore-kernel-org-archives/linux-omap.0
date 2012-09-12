From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 19/22] i2c: omap: switch to threaded IRQ support
Date: Wed, 12 Sep 2012 16:28:13 +0530
Message-ID: <1347447496-16793-20-git-send-email-shubhrajyoti@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

for OMAP2, we can easily switch over to threaded
IRQs on the I2C driver. This will allow us to
spend less time in hardirq context.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
[Trivial formating changes]
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   43 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 498a462..049331c 100644
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
 		return IRQ_NONE;
 
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
