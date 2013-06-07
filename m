From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 5/5] i2c: omap: remove omap_i2c_isr() hw irq handler
Date: Fri, 7 Jun 2013 21:46:08 +0300
Message-ID: <1370630768-4077-6-git-send-email-grygorii.strashko@ti.com>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

The omap_i2c_isr() does the irq check and schedules threaded handler if any of
enabled IRQs is active, but currently the I2C IRQs are enabled just once,
when I2C IP is enabling (transfer started) and they aren't changed after that.
More over, now the I2C INTC IRQ is disabled when I2C IP is idled.
Thus, I2C IRQs will start coming only when we want that, and there is
no sense to have omap_i2c_isr() anymore:
- omap_i2c_isr_thread() does all needed checks
- synchronization is provided IRQ Core.

So, get rid of omap_i2c_isr(), custom locking and
struct omap_i2c_dev->lock variable.

CC: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---

This is clean-up patch.

 drivers/i2c/busses/i2c-omap.c |   33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b3daf3f..749f390 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -183,7 +183,6 @@ enum {
 #define OMAP_I2C_IP_V2_INTERRUPTS_MASK	0x6FFF
 
 struct omap_i2c_dev {
-	spinlock_t		lock;		/* IRQ synchronization */
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
@@ -876,35 +875,10 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 }
 
 static irqreturn_t
-omap_i2c_isr(int irq, void *dev_id)
-{
-	struct omap_i2c_dev *dev = dev_id;
-	irqreturn_t ret = IRQ_HANDLED;
-	u16 mask;
-	u16 stat;
-
-	spin_lock(&dev->lock);
-	if (pm_runtime_suspended(dev->dev)) {
-		WARN_ONCE(true, "We should never be here!\n");
-		return IRQ_NONE;
-	}
 
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
 omap_i2c_isr_thread(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev = dev_id;
-	unsigned long flags;
 	u16 bits;
 	u16 stat;
 	int err = 0, count = 0;
@@ -914,7 +888,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
@@ -1035,8 +1008,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	omap_i2c_complete_cmd(dev, err);
 
 out:
-	spin_unlock_irqrestore(&dev->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -1146,8 +1117,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 
-	spin_lock_init(&dev->lock);
-
 	platform_set_drvdata(pdev, dev);
 	init_completion(&dev->cmd_complete);
 
@@ -1229,7 +1198,7 @@ omap_i2c_probe(struct platform_device *pdev)
 				IRQF_NO_SUSPEND, pdev->name, dev);
 	else
 		r = devm_request_threaded_irq(&pdev->dev, dev->irq,
-				omap_i2c_isr, omap_i2c_isr_thread,
+				NULL, omap_i2c_isr_thread,
 				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				pdev->name, dev);
 
-- 
1.7.9.5
