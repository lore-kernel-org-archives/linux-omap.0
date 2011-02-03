From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 07/13] cbus: retu: move to threaded IRQ and GENIRQ
Date: Thu,  3 Feb 2011 12:20:22 +0200
Message-ID: <1296728428-26399-8-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53116 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756152Ab1BCKUy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:20:54 -0500
Received: by mail-fx0-f49.google.com with SMTP id 19so1018031fxm.36
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:20:52 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Start moving retu to threaded IRQ and while
at that also give retu an irq_chip so children
can use generic request_threaded_irq() calls.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/Makefile |   10 +-
 drivers/cbus/retu.c   |  270 +++++++++++++++++++++----------------------------
 drivers/cbus/retu.h   |    5 -
 3 files changed, 123 insertions(+), 162 deletions(-)

diff --git a/drivers/cbus/Makefile b/drivers/cbus/Makefile
index 0ad112f..3375b82 100644
--- a/drivers/cbus/Makefile
+++ b/drivers/cbus/Makefile
@@ -6,8 +6,10 @@ obj-$(CONFIG_CBUS)		+= cbus.o
 obj-$(CONFIG_CBUS_TAHVO)	+= tahvo.o
 obj-$(CONFIG_CBUS_RETU)		+= retu.o
 obj-$(CONFIG_CBUS_TAHVO_USB)	+= tahvo-usb.o
-obj-$(CONFIG_CBUS_RETU_POWERBUTTON) += retu-pwrbutton.o
-obj-$(CONFIG_CBUS_RETU_RTC)	+= retu-rtc.o
-obj-$(CONFIG_CBUS_RETU_WDT)	+= retu-wdt.o
 obj-$(CONFIG_CBUS_TAHVO_USER)	+= tahvo-user.o
-obj-$(CONFIG_CBUS_RETU_HEADSET)	+= retu-headset.o
+
+## Disable Retu children until converted to threaded IRQ
+#obj-$(CONFIG_CBUS_RETU_POWERBUTTON) += retu-pwrbutton.o
+#obj-$(CONFIG_CBUS_RETU_RTC)	+= retu-rtc.o
+#obj-$(CONFIG_CBUS_RETU_WDT)	+= retu-wdt.o
+#obj-$(CONFIG_CBUS_RETU_HEADSET)	+= retu-headset.o
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 7e67e1a..fa666fe 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -33,6 +33,7 @@
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
 #include <linux/fs.h>
+#include <linux/mutex.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -43,6 +44,7 @@
 
 #include <plat/mux.h>
 #include <plat/board.h>
+#include <plat/cbus.h>
 
 #include "cbus.h"
 #include "retu.h"
@@ -53,23 +55,24 @@
 struct retu {
 	/* Device lock */
 	spinlock_t		lock;
-	struct tasklet_struct	tasklet;
+	struct mutex		irq_lock;
 	struct device		*dev;
 
+	int			irq_base;
+	int			irq_end;
+
 	int			irq;
 
-	bool			is_vilma;
-};
+	int			ack;
+	bool			ack_pending;
 
-static struct retu *the_retu;
+	int			mask;
+	bool			mask_pending;
 
-struct retu_irq_handler_desc {
-	int (*func)(unsigned long);
-	unsigned long arg;
-	char name[8];
+	bool			is_vilma;
 };
 
-static struct retu_irq_handler_desc retu_irq_handlers[MAX_RETU_IRQ_HANDLERS];
+static struct retu *the_retu;
 
 int retu_get_status(void)
 {
@@ -156,180 +159,137 @@ int retu_read_adc(int channel)
 }
 EXPORT_SYMBOL(retu_read_adc);
 
-static u16 retu_disable_bogus_irqs(u16 mask)
+static irqreturn_t retu_irq_handler(int irq, void *_retu)
 {
-       int i;
-
-       for (i = 0; i < MAX_RETU_IRQ_HANDLERS; i++) {
-               if (mask & (1 << i))
-                       continue;
-               if (retu_irq_handlers[i].func != NULL)
-                       continue;
-               /* an IRQ was enabled but we don't have a handler for it */
-               printk(KERN_INFO PFX "disabling bogus IRQ %d\n", i);
-               mask |= (1 << i);
-       }
-       return mask;
-}
+	struct retu		*retu = _retu;
 
-/*
- * Disable given RETU interrupt
- */
-void retu_disable_irq(int id)
-{
-	struct retu		*retu = the_retu;
-	unsigned long		flags;
-	u16			mask;
+	int			i;
 
-	spin_lock_irqsave(&retu->lock, flags);
-	mask = retu_read_reg(RETU_REG_IMR);
-	mask |= 1 << id;
-	mask = retu_disable_bogus_irqs(mask);
-	retu_write_reg(RETU_REG_IMR, mask);
-	spin_unlock_irqrestore(&retu->lock, flags);
-}
-EXPORT_SYMBOL(retu_disable_irq);
+	u16			idr;
+	u16			imr;
 
-/*
- * Enable given RETU interrupt
- */
-void retu_enable_irq(int id)
-{
-	struct retu		*retu = the_retu;
-	unsigned long		flags;
-	u16			mask;
+	idr = retu_read_reg(RETU_REG_IDR);
+	imr = retu_read_reg(RETU_REG_IMR);
+	idr &= ~imr;
 
-	if (id == 3) {
-		printk("Enabling Retu IRQ %d\n", id);
-		dump_stack();
+	if (!idr) {
+		dev_vdbg(retu->dev, "No IRQ, spurious?\n");
+		return IRQ_NONE;
 	}
 
-	spin_lock_irqsave(&retu->lock, flags);
-	mask = retu_read_reg(RETU_REG_IMR);
-	mask &= ~(1 << id);
-	mask = retu_disable_bogus_irqs(mask);
-	retu_write_reg(RETU_REG_IMR, mask);
-	spin_unlock_irqrestore(&retu->lock, flags);
+	for (i = 0; idr != 0; i++, idr >>= 1) {
+		if (!(idr & 1))
+			continue;
+
+		handle_nested_irq(i);
+	}
+
+	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL(retu_enable_irq);
 
-/*
- * Acknowledge given RETU interrupt
- */
-void retu_ack_irq(int id)
+/* -------------------------------------------------------------------------- */
+
+static void retu_irq_mask(struct irq_data *data)
 {
-	retu_write_reg(RETU_REG_IDR, 1 << id);
+	struct retu		*retu = irq_data_get_irq_chip_data(data);
+	int			irq = data->irq;
+
+	retu->mask |= (1 << (irq - retu->irq_base));
+	retu->mask_pending = true;
 }
-EXPORT_SYMBOL(retu_ack_irq);
 
-/*
- * RETU interrupt handler. Only schedules the tasklet.
- */
-static irqreturn_t retu_irq_handler(int irq, void *_retu)
+static void retu_irq_unmask(struct irq_data *data)
 {
-	struct retu		*retu = _retu;
+	struct retu		*retu = irq_data_get_irq_chip_data(data);
+	int			irq = data->irq;
 
-	tasklet_schedule(&retu->tasklet);
+	retu->mask &= ~(1 << (irq - retu->irq_base));
+	retu->mask_pending = true;
 
-	return IRQ_HANDLED;
 }
 
-/*
- * Tasklet handler
- */
-static void retu_tasklet_handler(unsigned long data)
+static void retu_irq_ack(struct irq_data *data)
 {
-	struct retu_irq_handler_desc *hnd;
-	u16 id;
-	u16 im;
-	int i;
-
-	for (;;) {
-		id = retu_read_reg(RETU_REG_IDR);
-		im = ~retu_read_reg(RETU_REG_IMR);
-		id &= im;
-
-		if (!id)
-			break;
-
-		for (i = 0; id != 0; i++, id >>= 1) {
-			if (!(id & 1))
-				continue;
-			hnd = &retu_irq_handlers[i];
-			if (hnd->func == NULL) {
-                               /* Spurious retu interrupt - disable and ack it */
-				printk(KERN_INFO "Spurious Retu interrupt "
-						 "(id %d)\n", i);
-				retu_disable_irq(i);
-				retu_ack_irq(i);
-				continue;
-			}
-			hnd->func(hnd->arg);
-			/*
-			 * Don't acknowledge the interrupt here
-			 * It must be done explicitly
-			 */
-		}
-	}
+	struct retu		*retu = irq_data_get_irq_chip_data(data);
+	int			irq = data->irq;
+
+	retu->ack |= (1 << (irq - retu->irq_base));
+	retu->ack_pending = true;
 }
 
-/*
- * Register the handler for a given RETU interrupt source.
- */
-int retu_request_irq(int id, void *irq_handler, unsigned long arg, char *name)
+static void retu_bus_lock(struct irq_data *data)
 {
-	struct retu			*retu = the_retu;
-	struct retu_irq_handler_desc	*hnd;
+	struct retu		*retu = irq_data_get_irq_chip_data(data);
 
-	if (!retu)
-		return -ENODEV;
+	mutex_lock(&retu->irq_lock);
+}
 
-	if (irq_handler == NULL || id >= MAX_RETU_IRQ_HANDLERS ||
-	    name == NULL) {
-		printk(KERN_ERR PFX "Invalid arguments to %s\n",
-		       __FUNCTION__);
-		return -EINVAL;
+static void retu_bus_sync_unlock(struct irq_data *data)
+{
+	struct retu		*retu = irq_data_get_irq_chip_data(data);
+
+	if (retu->mask_pending) {
+		retu_write_reg(RETU_REG_IMR, retu->mask);
+		retu->mask_pending = false;
 	}
-	hnd = &retu_irq_handlers[id];
-	if (hnd->func != NULL) {
-		printk(KERN_ERR PFX "IRQ %d already reserved\n", id);
-		return -EBUSY;
+
+	if (retu->ack_pending) {
+		retu_write_reg(RETU_REG_IDR, retu->ack);
+		retu->ack_pending = false;
 	}
-	printk(KERN_INFO PFX "Registering interrupt %d for device %s\n",
-	       id, name);
-	hnd->func = irq_handler;
-	hnd->arg = arg;
-	strlcpy(hnd->name, name, sizeof(hnd->name));
 
-	retu_ack_irq(id);
-	retu_enable_irq(id);
+	mutex_unlock(&retu->irq_lock);
+}
 
-	return 0;
+static struct irq_chip retu_irq_chip = {
+	.name			= "retu",
+	.irq_bus_lock		= retu_bus_lock,
+	.irq_bus_sync_unlock	= retu_bus_sync_unlock,
+	.irq_mask		= retu_irq_mask,
+	.irq_unmask		= retu_irq_unmask,
+	.irq_ack		= retu_irq_ack,
+};
+
+static inline void retu_irq_setup(int irq)
+{
+#ifdef CONFIG_ARM
+	set_irq_flags(irq, IRQF_VALID);
+#else
+	set_irq_noprobe(irq);
+#endif
 }
-EXPORT_SYMBOL(retu_request_irq);
 
-/*
- * Unregister the handler for a given RETU interrupt source.
- */
-void retu_free_irq(int id)
+static void retu_irq_init(struct retu *retu)
 {
-	struct retu_irq_handler_desc *hnd;
+	int			base = retu->irq_base;
+	int			end = retu->irq_end;
+	int			irq;
 
-	if (id >= MAX_RETU_IRQ_HANDLERS) {
-		printk(KERN_ERR PFX "Invalid argument to %s\n",
-		       __FUNCTION__);
-		return;
-	}
-	hnd = &retu_irq_handlers[id];
-	if (hnd->func == NULL) {
-		printk(KERN_ERR PFX "IRQ %d already freed\n", id);
-		return;
+	for (irq = base; irq < end; irq++) {
+		set_irq_chip_data(irq, retu);
+		set_irq_chip_and_handler(irq, &retu_irq_chip,
+				handle_simple_irq);
+		set_irq_nested_thread(irq, 1);
+		retu_irq_setup(irq);
 	}
+}
+
+static void retu_irq_exit(struct retu *retu)
+{
+	int			base = retu->irq_base;
+	int			end = retu->irq_end;
+	int			irq;
 
-	retu_disable_irq(id);
-	hnd->func = NULL;
+	for (irq = base; irq < end; irq++) {
+#ifdef CONFIG_ARM
+		set_irq_flags(irq, 0);
+#endif
+		set_irq_chip_and_handler(irq, NULL, NULL);
+		set_irq_chip_data(irq, NULL);
+	}
 }
-EXPORT_SYMBOL(retu_free_irq);
+
+/* -------------------------------------------------------------------------- */
 
 /**
  * retu_power_off - Shut down power to system
@@ -413,6 +373,7 @@ static int retu_allocate_children(struct device *parent)
 static int __init retu_probe(struct platform_device *pdev)
 {
 	struct retu	*retu;
+	struct cbus_retu_platform_data *pdata = pdev->dev.platform_data;
 
 	int		ret = -ENOMEM;
 	int		rev;
@@ -428,12 +389,16 @@ static int __init retu_probe(struct platform_device *pdev)
 	the_retu = retu;
 
 	/* Prepare tasklet */
-	tasklet_init(&retu->tasklet, retu_tasklet_handler, 0);
 	spin_lock_init(&retu->lock);
+	mutex_init(&retu->irq_lock);
 
 	irq = platform_get_irq(pdev, 0);
 
 	retu->irq = irq;
+	retu->irq_base = pdata->irq_base;
+	retu->irq_end = pdata->irq_end;
+
+	retu_irq_init(retu);
 
 	rev = retu_read_reg(RETU_REG_ASICR) & 0xff;
 	if (rev & (1 << 7))
@@ -446,7 +411,7 @@ static int __init retu_probe(struct platform_device *pdev)
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
 
-	ret = request_irq(irq, retu_irq_handler, 0,
+	ret = request_threaded_irq(irq, NULL, retu_irq_handler, 0,
 			  "retu", retu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
@@ -471,7 +436,6 @@ err2:
 	free_irq(irq, retu);
 
 err1:
-	tasklet_kill(&retu->tasklet);
 	kfree(retu);
 	the_retu = NULL;
 
@@ -489,7 +453,7 @@ static int __exit retu_remove(struct platform_device *pdev)
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
 	free_irq(irq, retu);
-	tasklet_kill(&retu->tasklet);
+	retu_irq_exit(retu);
 	kfree(retu);
 	the_retu = NULL;
 
diff --git a/drivers/cbus/retu.h b/drivers/cbus/retu.h
index ada7f2e..1b05f3e 100644
--- a/drivers/cbus/retu.h
+++ b/drivers/cbus/retu.h
@@ -62,10 +62,5 @@ int retu_read_reg(unsigned reg);
 void retu_write_reg(unsigned reg, u16 val);
 void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
 int retu_read_adc(int channel);
-int retu_request_irq(int id, void *irq_handler, unsigned long arg, char *name);
-void retu_free_irq(int id);
-void retu_enable_irq(int id);
-void retu_disable_irq(int id);
-void retu_ack_irq(int id);
 
 #endif /* __DRIVERS_CBUS_RETU_H */
-- 
1.7.4.rc2

