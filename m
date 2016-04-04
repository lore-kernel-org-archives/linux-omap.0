From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] i2c/omap: drop the lock hard irq context
Date: Mon, 4 Apr 2016 16:55:23 +0300
Message-ID: <1459778123-16267-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The lock is taken while reading two registers. On RT the first lock is
taken in hard irq where it might sleep and in the threaded irq.
The threaded irq runs in oneshot mode so the hard irq does not run until
the thread the completes so there is no reason to grab the lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[grygorii.strashko@ti.com: drop locking from isr completely and remove
lock field from struct omap_i2c_dev]
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
RFC:
 http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/188370.html
 drivers/i2c/busses/i2c-omap.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 13c4529..ab1279b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -185,7 +185,6 @@ enum {
 #define OMAP_I2C_IP_V2_INTERRUPTS_MASK	0x6FFF
 
 struct omap_i2c_dev {
-	spinlock_t		lock;		/* IRQ synchronization */
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
@@ -995,15 +994,12 @@ omap_i2c_isr(int irq, void *dev_id)
 	u16 mask;
 	u16 stat;
 
-	spin_lock(&omap->lock);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
 	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
+	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
 
-	spin_unlock(&omap->lock);
-
 	return ret;
 }
 
@@ -1011,12 +1007,10 @@ static irqreturn_t
 omap_i2c_isr_thread(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *omap = dev_id;
-	unsigned long flags;
 	u16 bits;
 	u16 stat;
 	int err = 0, count = 0;
 
-	spin_lock_irqsave(&omap->lock, flags);
 	do {
 		bits = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
 		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
@@ -1142,8 +1136,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	omap_i2c_complete_cmd(omap, err);
 
 out:
-	spin_unlock_irqrestore(&omap->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -1330,8 +1322,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	omap->dev = &pdev->dev;
 	omap->irq = irq;
 
-	spin_lock_init(&omap->lock);
-
 	platform_set_drvdata(pdev, omap);
 	init_completion(&omap->cmd_complete);
 
-- 
2.8.0
