From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 02/13] cbus: retu: give it a context structure
Date: Thu,  3 Feb 2011 12:20:17 +0200
Message-ID: <1296728428-26399-3-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58707 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756132Ab1BCKUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:20:40 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so1027014fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:20:38 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

This is pretty much a cleanup patch just
adding a context structure for Retu, to avoid
all the globals it had.

Note that this breaks retu-user.c due to moving
the lock around, but that retu-user.c has to
go anyway as it's completely non-standard way
of accessing Retu children.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |  123 ++++++++++++++++++++++++++++++++++-----------------
 drivers/cbus/retu.h |    2 -
 2 files changed, 82 insertions(+), 43 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index f44d770..39d4fa4 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
+#include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -49,11 +50,18 @@
 #define RETU_ID			0x01
 #define PFX			"retu: "
 
-static int retu_initialized;
-static int retu_is_vilma;
+struct retu {
+	/* Device lock */
+	spinlock_t		lock;
+	struct tasklet_struct	tasklet;
+	struct device		*dev;
 
-static struct tasklet_struct retu_tasklet;
-spinlock_t retu_lock = SPIN_LOCK_UNLOCKED;
+	int			irq;
+
+	bool			is_vilma;
+};
+
+static struct retu *the_retu;
 
 struct retu_irq_handler_desc {
 	int (*func)(unsigned long);
@@ -65,7 +73,7 @@ static struct retu_irq_handler_desc retu_irq_handlers[MAX_RETU_IRQ_HANDLERS];
 
 int retu_get_status(void)
 {
-	return retu_initialized;
+	return the_retu ? 1 : 0;
 }
 EXPORT_SYMBOL(retu_get_status);
 
@@ -77,7 +85,7 @@ EXPORT_SYMBOL(retu_get_status);
  */
 int retu_read_reg(unsigned reg)
 {
-	BUG_ON(!retu_initialized);
+	BUG_ON(!the_retu);
 	return cbus_read_reg(RETU_ID, reg);
 }
 EXPORT_SYMBOL(retu_read_reg);
@@ -91,22 +99,23 @@ EXPORT_SYMBOL(retu_read_reg);
  */
 void retu_write_reg(unsigned reg, u16 val)
 {
-	BUG_ON(!retu_initialized);
+	BUG_ON(!the_retu);
 	cbus_write_reg(RETU_ID, reg, val);
 }
 EXPORT_SYMBOL(retu_write_reg);
 
 void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 {
-	unsigned long flags;
-	u16 w;
+	struct retu		*retu = the_retu;
+	unsigned long		flags;
+	u16			w;
 
-	spin_lock_irqsave(&retu_lock, flags);
+	spin_lock_irqsave(&retu->lock, flags);
 	w = retu_read_reg(reg);
 	w &= ~clear;
 	w |= set;
 	retu_write_reg(reg, w);
-	spin_unlock_irqrestore(&retu_lock, flags);
+	spin_unlock_irqrestore(&retu->lock, flags);
 }
 EXPORT_SYMBOL_GPL(retu_set_clear_reg_bits);
 
@@ -114,15 +123,19 @@ EXPORT_SYMBOL_GPL(retu_set_clear_reg_bits);
 
 int retu_read_adc(int channel)
 {
-	unsigned long flags;
-	int res;
+	struct retu		*retu = the_retu;
+	unsigned long		flags;
+	int			res;
+
+	if (!retu)
+		return -ENODEV;
 
 	if (channel < 0 || channel > ADC_MAX_CHAN_NUMBER)
 		return -EINVAL;
 
-	spin_lock_irqsave(&retu_lock, flags);
+	spin_lock_irqsave(&retu->lock, flags);
 
-	if ((channel == 8) && retu_is_vilma) {
+	if ((channel == 8) && retu->is_vilma) {
 		int scr = retu_read_reg(RETU_REG_ADCSCR);
 		int ch = (retu_read_reg(RETU_REG_ADCR) >> 10) & 0xf;
 		if (((scr & 0xff) != 0) && (ch != 8))
@@ -133,11 +146,11 @@ int retu_read_adc(int channel)
 	retu_write_reg(RETU_REG_ADCR, channel << 10);
 	res = retu_read_reg(RETU_REG_ADCR) & 0x3ff;
 
-	if (retu_is_vilma)
+	if (retu->is_vilma)
 		retu_write_reg(RETU_REG_ADCR, (1 << 13));
 
 	/* Unlock retu */
-	spin_unlock_irqrestore(&retu_lock, flags);
+	spin_unlock_irqrestore(&retu->lock, flags);
 
 	return res;
 }
@@ -164,15 +177,16 @@ static u16 retu_disable_bogus_irqs(u16 mask)
  */
 void retu_disable_irq(int id)
 {
-	unsigned long flags;
-	u16 mask;
+	struct retu		*retu = the_retu;
+	unsigned long		flags;
+	u16			mask;
 
-	spin_lock_irqsave(&retu_lock, flags);
+	spin_lock_irqsave(&retu->lock, flags);
 	mask = retu_read_reg(RETU_REG_IMR);
 	mask |= 1 << id;
 	mask = retu_disable_bogus_irqs(mask);
 	retu_write_reg(RETU_REG_IMR, mask);
-	spin_unlock_irqrestore(&retu_lock, flags);
+	spin_unlock_irqrestore(&retu->lock, flags);
 }
 EXPORT_SYMBOL(retu_disable_irq);
 
@@ -181,19 +195,21 @@ EXPORT_SYMBOL(retu_disable_irq);
  */
 void retu_enable_irq(int id)
 {
-	unsigned long flags;
-	u16 mask;
+	struct retu		*retu = the_retu;
+	unsigned long		flags;
+	u16			mask;
 
 	if (id == 3) {
 		printk("Enabling Retu IRQ %d\n", id);
 		dump_stack();
 	}
-	spin_lock_irqsave(&retu_lock, flags);
+
+	spin_lock_irqsave(&retu->lock, flags);
 	mask = retu_read_reg(RETU_REG_IMR);
 	mask &= ~(1 << id);
 	mask = retu_disable_bogus_irqs(mask);
 	retu_write_reg(RETU_REG_IMR, mask);
-	spin_unlock_irqrestore(&retu_lock, flags);
+	spin_unlock_irqrestore(&retu->lock, flags);
 }
 EXPORT_SYMBOL(retu_enable_irq);
 
@@ -209,9 +225,12 @@ EXPORT_SYMBOL(retu_ack_irq);
 /*
  * RETU interrupt handler. Only schedules the tasklet.
  */
-static irqreturn_t retu_irq_handler(int irq, void *dev_id)
+static irqreturn_t retu_irq_handler(int irq, void *_retu)
 {
-	tasklet_schedule(&retu_tasklet);
+	struct retu		*retu = _retu;
+
+	tasklet_schedule(&retu->tasklet);
+
 	return IRQ_HANDLED;
 }
 
@@ -259,9 +278,10 @@ static void retu_tasklet_handler(unsigned long data)
  */
 int retu_request_irq(int id, void *irq_handler, unsigned long arg, char *name)
 {
-	struct retu_irq_handler_desc *hnd;
+	struct retu			*retu = the_retu;
+	struct retu_irq_handler_desc	*hnd;
 
-	if (!retu_initialized)
+	if (!retu)
 		return -ENODEV;
 
 	if (irq_handler == NULL || id >= MAX_RETU_IRQ_HANDLERS ||
@@ -392,30 +412,46 @@ static int retu_allocate_children(struct device *parent)
  */
 static int __init retu_probe(struct platform_device *pdev)
 {
-	int rev, ret;
-	int irq;
+	struct retu	*retu;
+	int		rev;
+	int		ret;
+	int		irq;
+
+	retu = kzalloc(sizeof(*retu), GFP_KERNEL);
+	if (!retu) {
+		dev_err(&pdev->dev, "not enough memory\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, retu);
+	the_retu = retu;
 
 	/* Prepare tasklet */
-	tasklet_init(&retu_tasklet, retu_tasklet_handler, 0);
+	tasklet_init(&retu->tasklet, retu_tasklet_handler, 0);
+	spin_lock_init(&retu->lock);
 
 	irq = platform_get_irq(pdev, 0);
 
-	retu_initialized = 1;
+	retu->irq = irq;
 
 	rev = retu_read_reg(RETU_REG_ASICR) & 0xff;
 	if (rev & (1 << 7))
-		retu_is_vilma = 1;
+		retu->is_vilma = true;
 
-	dev_info(&pdev->dev, "%s v%d.%d found\n", retu_is_vilma ? "Vilma" : "Retu",
-	       (rev >> 4) & 0x07, rev & 0x0f);
+	dev_info(&pdev->dev, "%s v%d.%d found\n",
+			retu->is_vilma ? "Vilma" : "Retu",
+			(rev >> 4) & 0x07, rev & 0x0f);
 
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
 
 	ret = request_irq(irq, retu_irq_handler, 0,
-			  "retu", 0);
+			  "retu", retu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
+		tasklet_kill(&retu->tasklet);
+		kfree(retu);
+		the_retu = NULL;
 		return ret;
 	}
 
@@ -429,7 +465,9 @@ static int __init retu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unable to allocate Retu children\n");
 		retu_write_reg(RETU_REG_IMR, 0xffff);
 		free_irq(irq, 0);
-		tasklet_kill(&retu_tasklet);
+		tasklet_kill(&retu->tasklet);
+		kfree(retu);
+		the_retu = NULL;
 		return ret;
 	}
 
@@ -438,14 +476,17 @@ static int __init retu_probe(struct platform_device *pdev)
 
 static int __exit retu_remove(struct platform_device *pdev)
 {
-	int irq;
+	struct retu		*retu = platform_get_drvdata(pdev);
+	int			irq;
 
 	irq = platform_get_irq(pdev, 0);
 
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
-	free_irq(irq, 0);
-	tasklet_kill(&retu_tasklet);
+	free_irq(irq, retu);
+	tasklet_kill(&retu->tasklet);
+	kfree(retu);
+	the_retu = NULL;
 
 	return 0;
 }
diff --git a/drivers/cbus/retu.h b/drivers/cbus/retu.h
index f459768..ada7f2e 100644
--- a/drivers/cbus/retu.h
+++ b/drivers/cbus/retu.h
@@ -68,6 +68,4 @@ void retu_enable_irq(int id);
 void retu_disable_irq(int id);
 void retu_ack_irq(int id);
 
-extern spinlock_t retu_lock;
-
 #endif /* __DRIVERS_CBUS_RETU_H */
-- 
1.7.4.rc2

