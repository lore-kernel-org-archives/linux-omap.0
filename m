From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc8-omap-git] twl4030-gpio irq simplification
Date: Mon, 6 Oct 2008 00:41:32 -0700
Message-ID: <200810060041.32321.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:33473 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751262AbYJFHlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 03:41:35 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Simplify and correct TWL4030 GPIO IRQ handling:

 - support mask() not just unmask()
 - use genirq handle_edge_irq() handler not custom hacks 
 - let that handle (correct) accounting of chained IRQ counts
 - use the more efficient clear-on-read mechanism
 - don't misuse IRQ_LEVEL
 - remove some superfluous locking
 - locking fix:  all irq_chip data needs spinlock protection

Cleanups:
 - give the helper thread a more accurate name
 - don't name the NOP ack() method misleadingly
 - use generic_handle_irq(), not a manually unrolled version thereof
 - comment fixes

Note that the previous IRQ dispatch code was somewhat confused.
It seemed not to know that it was working with edge triggered
interrupts, much less ones which could be transparently acked.

(Also note that COR=1 doesn't enable Clear-On-Read for all modules;
some are documented as using COR=0 for that.  GPIO uses COR=1.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
First step of the plan to share more core irq code ...

 drivers/gpio/twl4030-gpio.c |  265 +++++++++++++++---------------------------
 1 file changed, 96 insertions(+), 169 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -26,11 +26,8 @@
  */
 
 #include <linux/module.h>
-#include <linux/kernel_stat.h>
 #include <linux/init.h>
-#include <linux/time.h>
 #include <linux/interrupt.h>
-#include <linux/device.h>
 #include <linux/kthread.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
@@ -92,17 +89,18 @@ static DEFINE_MUTEX(gpio_lock);
 /* store usage of each GPIO. - each bit represents one GPIO */
 static unsigned int gpio_usage_count;
 
-/* shadow the imr register */
-static unsigned int gpio_imr_shadow;
+/* protect what irq_chip modifies through its helper task */
+static DEFINE_SPINLOCK(gpio_spinlock);
 
-/* bitmask of pending requests to unmask gpio interrupts */
-static unsigned int gpio_pending_unmask;
+/* shadow the imr register; updates are delayed */
+static u32 gpio_imr_shadow;
+static bool gpio_pending_mask;
 
 /* bitmask of requests to set gpio irq trigger type */
 static unsigned int gpio_pending_trigger;
 
-/* pointer to gpio unmask thread struct */
-static struct task_struct *gpio_unmask_thread;
+/* pointer to helper thread */
+static struct task_struct *gpio_helper_thread;
 
 /*
  * Helper functions to read and write the GPIO ISR and IMR registers as
@@ -110,6 +108,9 @@ static struct task_struct *gpio_unmask_t
  * The caller must hold gpio_lock.
  */
 
+/* NOTE:  only the IRQ dispatcher may read ISR; reading it has
+ * side effects, because of the clear-on-read mechanism (COR=1).
+ */
 static int gpio_read_isr(unsigned int *isr)
 {
 	int ret;
@@ -123,19 +124,9 @@ static int gpio_read_isr(unsigned int *i
 	return ret;
 }
 
-static int gpio_write_isr(unsigned int isr)
-{
-	isr &= GPIO_32_MASK;
-	/*
-	 * The buffer passed to the twl4030_i2c_write() routine must have an
-	 * extra byte at the beginning reserved for its internal use.
-	 */
-	isr <<= 8;
-	isr = cpu_to_le32(isr);
-	return twl4030_i2c_write(TWL4030_MODULE_GPIO, (u8 *) &isr,
-				REG_GPIO_ISR1A, 3);
-}
-
+/* IMR is written only during initialization and
+ * by request of the irq_chip code.
+ */
 static int gpio_write_imr(unsigned int imr)
 {
 	imr &= GPIO_32_MASK;
@@ -150,66 +141,54 @@ static int gpio_write_imr(unsigned int i
 }
 
 /*
- * These routines are analagous to the irqchip methods, but they are designed
- * to be called from thread context with cpu interrupts enabled and with no
- * locked spinlocks.  We call these routines from our custom IRQ handler
- * instead of the usual irqchip methods.
- */
-static void twl4030_gpio_mask_and_ack(unsigned int irq)
-{
-	int gpio = irq - twl4030_gpio_irq_base;
-
-	mutex_lock(&gpio_lock);
-	/* mask */
-	gpio_imr_shadow |= (1 << gpio);
-	gpio_write_imr(gpio_imr_shadow);
-	/* ack */
-	gpio_write_isr(1 << gpio);
-	mutex_unlock(&gpio_lock);
-}
-
-static void twl4030_gpio_unmask(unsigned int irq)
-{
-	int gpio = irq - twl4030_gpio_irq_base;
-
-	mutex_lock(&gpio_lock);
-	gpio_imr_shadow &= ~(1 << gpio);
-	gpio_write_imr(gpio_imr_shadow);
-	mutex_unlock(&gpio_lock);
-}
-
-/*
  * These are the irqchip methods for the TWL4030 GPIO interrupts.
  * Our IRQ handle method doesn't call these, but they will be called by
  * other routines such as setup_irq() and enable_irq().  They are called
- * with cpu interrupts disabled and with a lock on the irq_controller_lock
+ * with cpu interrupts disabled and with a lock on the irq_desc.lock
  * spinlock.  This complicates matters, because accessing the TWL4030 GPIO
  * interrupt controller requires I2C bus transactions that can't be initiated
  * in this context.  Our solution is to defer accessing the interrupt
- * controller to a kernel thread.  We only need to support the unmask method.
+ * controller to a kernel thread.
  */
 
-static void twl4030_gpio_irq_mask_and_ack(unsigned int irq)
+static void twl4030_gpio_irq_ack(unsigned int irq)
 {
+	/* NOP -- dispatcher acks when it reads ISR */
 }
 
 static void twl4030_gpio_irq_mask(unsigned int irq)
 {
+	int gpio = irq - twl4030_gpio_irq_base;
+	u32 mask = 1 << gpio;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_spinlock, flags);
+	gpio_pending_mask = true;
+	gpio_imr_shadow |= mask;
+	if (gpio_helper_thread && gpio_helper_thread->state != TASK_RUNNING)
+		wake_up_process(gpio_helper_thread);
+	spin_unlock_irqrestore(&gpio_spinlock, flags);
 }
 
 static void twl4030_gpio_irq_unmask(unsigned int irq)
 {
 	int gpio = irq - twl4030_gpio_irq_base;
+	u32 mask = 1 << gpio;
+	unsigned long flags;
 
-	gpio_pending_unmask |= (1 << gpio);
-	if (gpio_unmask_thread && gpio_unmask_thread->state != TASK_RUNNING)
-		wake_up_process(gpio_unmask_thread);
+	spin_lock_irqsave(&gpio_spinlock, flags);
+	gpio_pending_mask = true;
+	gpio_imr_shadow &= ~mask;
+	if (gpio_helper_thread && gpio_helper_thread->state != TASK_RUNNING)
+		wake_up_process(gpio_helper_thread);
+	spin_unlock_irqrestore(&gpio_spinlock, flags);
 }
 
 static int twl4030_gpio_irq_set_type(unsigned int irq, unsigned trigger)
 {
 	struct irq_desc *desc = irq_desc + irq;
 	int gpio = irq - twl4030_gpio_irq_base;
+	unsigned long flags;
 
 	trigger &= IRQ_TYPE_SENSE_MASK;
 	if (trigger & ~IRQ_TYPE_EDGE_BOTH)
@@ -220,19 +199,18 @@ static int twl4030_gpio_irq_set_type(uns
 	desc->status &= ~IRQ_TYPE_SENSE_MASK;
 	desc->status |= trigger;
 
-	/* REVISIT This makes the "unmask" thread do double duty,
-	 * updating IRQ trigger modes too.  Rename appropriately...
-	 */
+	spin_lock_irqsave(&gpio_spinlock, flags);
 	gpio_pending_trigger |= (1 << gpio);
-	if (gpio_unmask_thread && gpio_unmask_thread->state != TASK_RUNNING)
-		wake_up_process(gpio_unmask_thread);
+	if (gpio_helper_thread && gpio_helper_thread->state != TASK_RUNNING)
+		wake_up_process(gpio_helper_thread);
+	spin_unlock_irqrestore(&gpio_spinlock, flags);
 
 	return 0;
 }
 
 static struct irq_chip twl4030_gpio_irq_chip = {
 	.name		= "twl4030",
-	.ack		= twl4030_gpio_irq_mask_and_ack,
+	.ack		= twl4030_gpio_irq_ack,
 	.mask		= twl4030_gpio_irq_mask,
 	.unmask		= twl4030_gpio_irq_unmask,
 	.set_type	= twl4030_gpio_irq_set_type,
@@ -281,7 +259,7 @@ int twl4030_request_gpio(int gpio)
 		if (!gpio_usage_count) {
 			ret = gpio_twl4030_write(REG_GPIO_CTRL,
 					MASK_GPIO_CTRL_GPIO_ON);
-			ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
+
 		}
 		if (!ret)
 			gpio_usage_count |= BIT(gpio);
@@ -475,37 +453,42 @@ int twl4030_set_gpio_card_detect(int gpi
 /* MODULE FUNCTIONS */
 
 /*
- * gpio_unmask_thread() runs as a kernel thread.  It is awakened by the unmask
- * method for the GPIO interrupts.  It unmasks all of the GPIO interrupts
- * specified in the gpio_pending_unmask bitmask.  We have to do the unmasking
- * in a kernel thread rather than directly in the unmask method because of the
+ * gpio_helper_thread() is a kernel thread that is awakened by irq_chip
+ * methods to update IRQ masks and trigger modes.
+ *
+ * We must do this in a thread rather than in irq_chip methods because of the
  * need to access the TWL4030 via the I2C bus.  Note that we don't need to be
  * concerned about race conditions where the request to unmask a GPIO interrupt
  * has already been cancelled before this thread does the unmasking.  If a GPIO
  * interrupt is improperly unmasked, then the IRQ handler for it will mask it
  * when an interrupt occurs.
  */
-static int twl4030_gpio_unmask_thread(void *data)
+static int twl4030_gpio_helper_thread(void *dev)
 {
 	current->flags |= PF_NOFREEZE;
 
 	while (!kthread_should_stop()) {
 		int irq;
-		unsigned int gpio_unmask;
+		bool do_mask;
+		u32 local_imr;
 		unsigned int gpio_trigger;
 
-		local_irq_disable();
-		gpio_unmask = gpio_pending_unmask;
-		gpio_pending_unmask = 0;
+		spin_lock_irq(&gpio_spinlock);
+
+		do_mask = gpio_pending_mask;
+		gpio_pending_mask = false;
+		local_imr = gpio_imr_shadow;
 
 		gpio_trigger = gpio_pending_trigger;
 		gpio_pending_trigger = 0;
-		local_irq_enable();
 
-		for (irq = twl4030_gpio_irq_base; 0 != gpio_unmask;
-				gpio_unmask >>= 1, irq++) {
-			if (gpio_unmask & 0x1)
-				twl4030_gpio_unmask(irq);
+		spin_unlock_irq(&gpio_spinlock);
+
+		if (do_mask) {
+			int status = gpio_write_imr(local_imr);
+
+			if (status)
+				dev_err(dev, "write IMR err %d\n", status);
 		}
 
 		for (irq = twl4030_gpio_irq_base;
@@ -526,10 +509,10 @@ static int twl4030_gpio_unmask_thread(vo
 					type);
 		}
 
-		local_irq_disable();
-		if (!gpio_pending_unmask && !gpio_pending_trigger)
+		spin_lock_irq(&gpio_spinlock);
+		if (!gpio_pending_mask && !gpio_pending_trigger)
 			set_current_state(TASK_INTERRUPTIBLE);
-		local_irq_enable();
+		spin_unlock_irq(&gpio_spinlock);
 
 		schedule();
 	}
@@ -538,51 +521,6 @@ static int twl4030_gpio_unmask_thread(vo
 }
 
 /*
- * do_twl4030_gpio_irq() is the desc->handle method for each of the twl4030
- * gpio interrupts.  It executes in kernel thread context.
- * On entry, cpu interrupts are enabled.
- */
-static void do_twl4030_gpio_irq(unsigned int irq, irq_desc_t *desc)
-{
-	struct irqaction *action;
-	const unsigned int cpu = smp_processor_id();
-
-	desc->status |= IRQ_LEVEL;
-
-	/*
-	 * Acknowledge, clear _AND_ disable the interrupt.
-	 */
-	twl4030_gpio_mask_and_ack(irq);
-
-	if (!desc->depth) {
-		kstat_cpu(cpu).irqs[irq]++;
-
-		action = desc->action;
-		if (action) {
-			int ret;
-			int status = 0;
-			int retval = 0;
-			do {
-				/* Call the ISR with cpu interrupts enabled. */
-				ret = action->handler(irq, action->dev_id);
-				if (ret == IRQ_HANDLED)
-					status |= action->flags;
-				retval |= ret;
-				action = action->next;
-			} while (action);
-
-			if (retval != IRQ_HANDLED)
-				printk(KERN_ERR "ISR for TWL4030 GPIO"
-					" irq %d can't handle interrupt\n",
-					irq);
-
-			if (!desc->depth)
-				twl4030_gpio_unmask(irq);
-		}
-	}
-}
-
-/*
  * do_twl4030_gpio_module_irq() is the desc->handle method for the twl4030 gpio
  * module interrupt.  It executes in kernel thread context.
  * This is a chained interrupt, so there is no desc->action method for it.
@@ -593,38 +531,21 @@ static void do_twl4030_gpio_irq(unsigned
  */
 static void do_twl4030_gpio_module_irq(unsigned int irq, irq_desc_t *desc)
 {
-	const unsigned int cpu = smp_processor_id();
-
-	desc->status |= IRQ_LEVEL;
-	/*
-	* The desc->handle method would normally call the desc->chip->ack
-	* method here, but we won't bother since our ack method is NULL.
-	*/
-	if (!desc->depth) {
-		int gpio_irq;
-		unsigned int gpio_isr;
-
-		kstat_cpu(cpu).irqs[irq]++;
-		local_irq_enable();
-
-		mutex_lock(&gpio_lock);
-		if (gpio_read_isr(&gpio_isr))
-			gpio_isr = 0;
-		mutex_unlock(&gpio_lock);
+	int gpio_irq;
+	unsigned int gpio_isr;
 
-		for (gpio_irq = twl4030_gpio_irq_base; 0 != gpio_isr;
-			gpio_isr >>= 1, gpio_irq++) {
-			if (gpio_isr & 0x1) {
-				irq_desc_t *d = irq_desc + gpio_irq;
-				d->handle_irq(gpio_irq, d);
-			}
-		}
+	/* PIH irqs like this can't be individually masked or acked ...
+	 * so we don't even call the PIH irq_chip stub methods.
+	 */
+	local_irq_enable();
+	if (gpio_read_isr(&gpio_isr))
+		gpio_isr = 0;
+	local_irq_disable();
 
-		local_irq_disable();
-		/*
-		 * Here is where we should call the unmask method, but again we
-		 * won't bother since it is NULL.
-		 */
+	for (gpio_irq = twl4030_gpio_irq_base; 0 != gpio_isr;
+		gpio_isr >>= 1, gpio_irq++) {
+		if (gpio_isr & 0x1)
+			generic_handle_irq(gpio_irq);
 	}
 }
 
@@ -706,7 +627,7 @@ static int __devinit gpio_twl4030_probe(
 	int irq = 0;
 
 	/* All GPIO interrupts are initially masked */
-	gpio_pending_unmask = 0;
+	gpio_pending_mask = false;
 	gpio_imr_shadow = GPIO_32_MASK;
 	ret = gpio_write_imr(gpio_imr_shadow);
 
@@ -733,15 +654,14 @@ static int __devinit gpio_twl4030_probe(
 
 	if (!ret) {
 		/*
-		 * Create a kernel thread to handle deferred unmasking of gpio
+		 * Create a kernel thread to handle deferred operations on gpio
 		 * interrupts.
 		 */
-		gpio_unmask_thread = kthread_create(twl4030_gpio_unmask_thread,
-			NULL, "twl4030 gpio");
-		if (!gpio_unmask_thread) {
+		gpio_helper_thread = kthread_create(twl4030_gpio_helper_thread,
+				&pdev->dev, "twl4030 gpio");
+		if (!gpio_helper_thread) {
 			dev_err(&pdev->dev,
-				"could not create twl4030 gpio unmask"
-				" thread!\n");
+				"could not create helper thread!\n");
 			ret = -ENOMEM;
 		}
 	}
@@ -751,19 +671,26 @@ static int __devinit gpio_twl4030_probe(
 		for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end;
 				irq++) {
 			set_irq_chip_and_handler(irq, &twl4030_gpio_irq_chip,
-					do_twl4030_gpio_irq);
+					handle_edge_irq);
 			activate_irq(irq);
 		}
 
 		/* gpio module IRQ */
 		irq = platform_get_irq(pdev, 0);
 
+		/* COR=1 means irqs are acked by reading ISR
+		 * PENDDIS=0 means pending events enabled
+		 * EXCLEN=0 means route to both irq lines
+		 */
+		gpio_twl4030_write(REG_GPIO_SIH_CTRL,
+				TWL4030_SIH_CTRL_COR_MASK);
+
 		/*
 		 * Install an irq handler to demultiplex the gpio module
 		 * interrupt.
 		 */
 		set_irq_chained_handler(irq, do_twl4030_gpio_module_irq);
-		wake_up_process(gpio_unmask_thread);
+		wake_up_process(gpio_helper_thread);
 
 		dev_info(&pdev->dev, "IRQ %d chains IRQs %d..%d\n", irq,
 			twl4030_gpio_irq_base, twl4030_gpio_irq_end - 1);
@@ -837,10 +764,10 @@ static int __devexit gpio_twl4030_remove
 	for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end; irq++)
 		set_irq_handler(irq, NULL);
 
-	/* stop the gpio unmask kernel thread */
-	if (gpio_unmask_thread) {
-		kthread_stop(gpio_unmask_thread);
-		gpio_unmask_thread = NULL;
+	/* stop the gpio helper kernel thread */
+	if (gpio_helper_thread) {
+		kthread_stop(gpio_helper_thread);
+		gpio_helper_thread = NULL;
 	}
 
 	return 0;
