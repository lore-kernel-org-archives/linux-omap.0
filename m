From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: omap: revert "i2c: omap: switch to threaded IRQ
 support"
Date: Mon, 15 Oct 2012 01:51:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Commit 3b2f8f82dad7d1f79cdc8fc05bd1c94baf109bde ("i2c: omap: switch to
threaded IRQ support") causes communication with I2C devices to fail
after system suspend/resume on all OMAP3 devices:

...
[   40.228576] PM: noirq resume of devices complete after 3.723 msecs
[   40.233184] PM: early resume of devices complete after 3.173 msecs
[   40.242736] [sched_delayed] sched: RT throttling activated
[   41.235046] omap_i2c omap_i2c.1: controller timed out
[   41.235351] twl: i2c_read failed to transfer all messages
[   41.235382] omap_hsmmc omap_hsmmc.0: could not set regulator OCR (-110)
[   41.396453] mmc0: error -110 during resume (card was removed?)
[   42.391754] omap_i2c omap_i2c.1: controller timed out
[   42.391876] twl: i2c_write failed to transfer all messages
[   42.391906] twl_rtc: Could not write TWLregister F - error -110
[   43.391326] omap_i2c omap_i2c.1: controller timed out
[   43.391479] twl: i2c_read failed to transfer all messages
[   43.391510] twl_rtc: Could not read TWLregister D - error -110
[   43.391540] twl_rtc twl_rtc: twl_rtc_read_time: reading CTRL_REG, error -110
[   43.392364] PM: resume of devices complete after 3158.935 msecs

When the root filesystem is on MMC, as in the above example, the
card's voltage regulator is not re-enabled and the filesystem becomes
inaccessible after resume.

Fix by reverting the conversion to a threaded IRQ handler.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   44 +++++++----------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..e001c2a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -180,7 +180,6 @@ enum {
 #define I2C_OMAP_ERRATA_I462		(1 << 1)
 
 struct omap_i2c_dev {
-	spinlock_t		lock;		/* IRQ synchronization */
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
@@ -865,35 +864,13 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 }
 
 static irqreturn_t
-omap_i2c_isr(int irq, void *dev_id)
+omap_i2c_isr(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev = dev_id;
-	irqreturn_t ret = IRQ_HANDLED;
-	u16 mask;
-	u16 stat;
-
-	spin_lock(&dev->lock);
-	mask = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-
-	if (stat & mask)
-		ret = IRQ_WAKE_THREAD;
-
-	spin_unlock(&dev->lock);
-
-	return ret;
-}
-
-static irqreturn_t
-omap_i2c_isr_thread(int this_irq, void *dev_id)
-{
-	struct omap_i2c_dev *dev = dev_id;
-	unsigned long flags;
 	u16 bits;
 	u16 stat;
 	int err = 0, count = 0;
 
-	spin_lock_irqsave(&dev->lock, flags);
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
@@ -907,7 +884,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 		if (!stat) {
 			/* my work here is done */
-			goto out;
+			return IRQ_HANDLED;
 		}
 
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
@@ -1016,8 +993,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	omap_i2c_complete_cmd(dev, err);
 
 out:
-	spin_unlock_irqrestore(&dev->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -1062,6 +1037,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
+	irq_handler_t isr;
 	int irq;
 	int r;
 
@@ -1110,8 +1086,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 
-	spin_lock_init(&dev->lock);
-
 	platform_set_drvdata(pdev, dev);
 	init_completion(&dev->cmd_complete);
 
@@ -1166,14 +1140,10 @@ omap_i2c_probe(struct platform_device *pdev)
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-	if (dev->rev < OMAP_I2C_OMAP1_REV_2)
-		r = devm_request_irq(&pdev->dev, dev->irq, omap_i2c_omap1_isr,
-				IRQF_NO_SUSPEND, pdev->name, dev);
-	else
-		r = devm_request_threaded_irq(&pdev->dev, dev->irq,
-				omap_i2c_isr, omap_i2c_isr_thread,
-				IRQF_NO_SUSPEND | IRQF_ONESHOT,
-				pdev->name, dev);
+	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
+								   omap_i2c_isr;
+	r = devm_request_irq(&pdev->dev, dev->irq, isr, IRQF_NO_SUSPEND,
+			     pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
-- 
1.7.10.4
