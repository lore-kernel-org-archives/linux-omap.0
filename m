From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 5/6] replace twl4030-gpio irq_chip
Date: Fri, 10 Oct 2008 14:22:22 -0700
Message-ID: <200810101422.22414.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44663 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760916AbYJJV3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 17:29:53 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Replace twl4030 GPIO IRQ handling with generic SIH support.
No change in functionality; but there's now one less kernel
thread tied up supporting this chip.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/gpio/twl4030-gpio.c |  423 ++++--------------------------------------
 1 file changed, 42 insertions(+), 381 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -51,22 +51,8 @@
  */
 
 
-static inline void activate_irq(int irq)
-{
-#ifdef CONFIG_ARM
-	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
-	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
-	 */
-	set_irq_flags(irq, IRQF_VALID);
-#else
-	/* same effect on other architectures */
-	set_irq_noprobe(irq);
-#endif
-}
-
 static struct gpio_chip twl_gpiochip;
 static int twl4030_gpio_irq_base;
-static int twl4030_gpio_irq_end;
 
 /* genirq interfaces are not available to modules */
 #ifdef MODULE
@@ -89,133 +75,7 @@ static DEFINE_MUTEX(gpio_lock);
 /* store usage of each GPIO. - each bit represents one GPIO */
 static unsigned int gpio_usage_count;
 
-/* protect what irq_chip modifies through its helper task */
-static DEFINE_SPINLOCK(gpio_spinlock);
-
-/* shadow the imr register; updates are delayed */
-static u32 gpio_imr_shadow;
-static bool gpio_pending_mask;
-
-/* bitmask of requests to set gpio irq trigger type */
-static unsigned int gpio_pending_trigger;
-
-/* pointer to helper thread */
-static struct task_struct *gpio_helper_thread;
-
-/*
- * Helper functions to read and write the GPIO ISR and IMR registers as
- * 32-bit integers. Functions return 0 on success, non-zero otherwise.
- * The caller must hold gpio_lock.
- */
-
-/* NOTE:  only the IRQ dispatcher may read ISR; reading it has
- * side effects, because of the clear-on-read mechanism (COR=1).
- */
-static int gpio_read_isr(unsigned int *isr)
-{
-	int ret;
-
-	*isr = 0;
-	ret = twl4030_i2c_read(TWL4030_MODULE_GPIO, (u8 *) isr,
-			REG_GPIO_ISR1A, 3);
-	le32_to_cpup(isr);
-	*isr &= GPIO_32_MASK;
-
-	return ret;
-}
-
-/* IMR is written only during initialization and
- * by request of the irq_chip code.
- */
-static int gpio_write_imr(unsigned int imr)
-{
-	imr &= GPIO_32_MASK;
-	/*
-	 * The buffer passed to the twl4030_i2c_write() routine must have an
-	 * extra byte at the beginning reserved for its internal use.
-	 */
-	imr <<= 8;
-	imr = cpu_to_le32(imr);
-	return twl4030_i2c_write(TWL4030_MODULE_GPIO, (u8 *) &imr,
-				REG_GPIO_IMR1A, 3);
-}
-
-/*
- * These are the irqchip methods for the TWL4030 GPIO interrupts.
- * Our IRQ handle method doesn't call these, but they will be called by
- * other routines such as setup_irq() and enable_irq().  They are called
- * with cpu interrupts disabled and with a lock on the irq_desc.lock
- * spinlock.  This complicates matters, because accessing the TWL4030 GPIO
- * interrupt controller requires I2C bus transactions that can't be initiated
- * in this context.  Our solution is to defer accessing the interrupt
- * controller to a kernel thread.
- */
-
-static void twl4030_gpio_irq_ack(unsigned int irq)
-{
-	/* NOP -- dispatcher acks when it reads ISR */
-}
-
-static void twl4030_gpio_irq_mask(unsigned int irq)
-{
-	int gpio = irq - twl4030_gpio_irq_base;
-	u32 mask = 1 << gpio;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gpio_spinlock, flags);
-	gpio_pending_mask = true;
-	gpio_imr_shadow |= mask;
-	if (gpio_helper_thread && gpio_helper_thread->state != TASK_RUNNING)
-		wake_up_process(gpio_helper_thread);
-	spin_unlock_irqrestore(&gpio_spinlock, flags);
-}
-
-static void twl4030_gpio_irq_unmask(unsigned int irq)
-{
-	int gpio = irq - twl4030_gpio_irq_base;
-	u32 mask = 1 << gpio;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gpio_spinlock, flags);
-	gpio_pending_mask = true;
-	gpio_imr_shadow &= ~mask;
-	if (gpio_helper_thread && gpio_helper_thread->state != TASK_RUNNING)
-		wake_up_process(gpio_helper_thread);
-	spin_unlock_irqrestore(&gpio_spinlock, flags);
-}
-
-static int twl4030_gpio_irq_set_type(unsigned int irq, unsigned trigger)
-{
-	struct irq_desc *desc = irq_desc + irq;
-	int gpio = irq - twl4030_gpio_irq_base;
-	unsigned long flags;
-
-	trigger &= IRQ_TYPE_SENSE_MASK;
-	if (trigger & ~IRQ_TYPE_EDGE_BOTH)
-		return -EINVAL;
-	if ((desc->status & IRQ_TYPE_SENSE_MASK) == trigger)
-		return 0;
-
-	desc->status &= ~IRQ_TYPE_SENSE_MASK;
-	desc->status |= trigger;
-
-	spin_lock_irqsave(&gpio_spinlock, flags);
-	gpio_pending_trigger |= (1 << gpio);
-	if (gpio_helper_thread && gpio_helper_thread->state != TASK_RUNNING)
-		wake_up_process(gpio_helper_thread);
-	spin_unlock_irqrestore(&gpio_spinlock, flags);
-
-	return 0;
-}
-
-static struct irq_chip twl4030_gpio_irq_chip = {
-	.name		= "twl4030",
-	.ack		= twl4030_gpio_irq_ack,
-	.mask		= twl4030_gpio_irq_mask,
-	.unmask		= twl4030_gpio_irq_unmask,
-	.set_type	= twl4030_gpio_irq_set_type,
-};
-
+/*----------------------------------------------------------------------*/
 
 /*
  * To configure TWL4030 GPIO module registers
@@ -355,35 +215,6 @@ int twl4030_get_gpio_datain(int gpio)
 }
 EXPORT_SYMBOL(twl4030_get_gpio_datain);
 
-static int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
-{
-	u8 c_bnk = gpio >> 2;
-	u8 c_off = (gpio & 0x3) * 2;
-	u8 c_msk = 0;
-	u8 reg = 0;
-	u8 base = 0;
-	int ret = 0;
-
-	base = REG_GPIO_EDR1 + c_bnk;
-
-	if (edge & IRQ_TYPE_EDGE_RISING)
-		c_msk |= BIT(c_off + 1);
-	if (edge & IRQ_TYPE_EDGE_FALLING)
-		c_msk |= BIT(c_off);
-
-	mutex_lock(&gpio_lock);
-	ret = gpio_twl4030_read(base);
-	if (ret >= 0) {
-		/* clear the previous rising/falling values */
-		reg = (u8) ret;
-		reg &= ~(0x3 << c_off);
-		reg |= c_msk;
-		ret = gpio_twl4030_write(base, reg);
-	}
-	mutex_unlock(&gpio_lock);
-	return ret;
-}
-
 /*
  * Configure debounce timing value for a GPIO pin on TWL4030
  */
@@ -450,105 +281,6 @@ int twl4030_set_gpio_card_detect(int gpi
 }
 #endif
 
-/* MODULE FUNCTIONS */
-
-/*
- * gpio_helper_thread() is a kernel thread that is awakened by irq_chip
- * methods to update IRQ masks and trigger modes.
- *
- * We must do this in a thread rather than in irq_chip methods because of the
- * need to access the TWL4030 via the I2C bus.  Note that we don't need to be
- * concerned about race conditions where the request to unmask a GPIO interrupt
- * has already been cancelled before this thread does the unmasking.  If a GPIO
- * interrupt is improperly unmasked, then the IRQ handler for it will mask it
- * when an interrupt occurs.
- */
-static int twl4030_gpio_helper_thread(void *dev)
-{
-	current->flags |= PF_NOFREEZE;
-
-	while (!kthread_should_stop()) {
-		int irq;
-		bool do_mask;
-		u32 local_imr;
-		unsigned int gpio_trigger;
-
-		spin_lock_irq(&gpio_spinlock);
-
-		do_mask = gpio_pending_mask;
-		gpio_pending_mask = false;
-		local_imr = gpio_imr_shadow;
-
-		gpio_trigger = gpio_pending_trigger;
-		gpio_pending_trigger = 0;
-
-		spin_unlock_irq(&gpio_spinlock);
-
-		if (do_mask) {
-			int status = gpio_write_imr(local_imr);
-
-			if (status)
-				dev_err(dev, "write IMR err %d\n", status);
-		}
-
-		for (irq = twl4030_gpio_irq_base;
-				gpio_trigger;
-				gpio_trigger >>= 1, irq++) {
-			struct irq_desc *desc;
-			unsigned type;
-
-			if (!(gpio_trigger & 0x1))
-				continue;
-
-			desc = irq_desc + irq;
-			spin_lock_irq(&desc->lock);
-			type = desc->status & IRQ_TYPE_SENSE_MASK;
-			spin_unlock_irq(&desc->lock);
-
-			twl4030_set_gpio_edge_ctrl(irq - twl4030_gpio_irq_base,
-					type);
-		}
-
-		spin_lock_irq(&gpio_spinlock);
-		if (!gpio_pending_mask && !gpio_pending_trigger)
-			set_current_state(TASK_INTERRUPTIBLE);
-		spin_unlock_irq(&gpio_spinlock);
-
-		schedule();
-	}
-	set_current_state(TASK_RUNNING);
-	return 0;
-}
-
-/*
- * do_twl4030_gpio_module_irq() is the desc->handle method for the twl4030 gpio
- * module interrupt.  It executes in kernel thread context.
- * This is a chained interrupt, so there is no desc->action method for it.
- * We query the gpio module interrupt controller in the twl4030 to determine
- * which gpio lines are generating interrupt requests, and then call the
- * desc->handle method for each gpio that needs service.
- * On entry, cpu interrupts are disabled.
- */
-static void do_twl4030_gpio_module_irq(unsigned int irq, irq_desc_t *desc)
-{
-	int gpio_irq;
-	unsigned int gpio_isr;
-
-	/* PIH irqs like this can't be individually masked or acked ...
-	 * so we don't even call the PIH irq_chip stub methods.
-	 */
-	local_irq_enable();
-	if (gpio_read_isr(&gpio_isr))
-		gpio_isr = 0;
-	local_irq_disable();
-
-	for (gpio_irq = twl4030_gpio_irq_base; 0 != gpio_isr;
-		gpio_isr >>= 1, gpio_irq++) {
-		if (gpio_isr & 0x1)
-			generic_handle_irq(gpio_irq);
-	}
-}
-
 /*----------------------------------------------------------------------*/
 
 static int twl_direction_in(struct gpio_chip *chip, unsigned offset)
@@ -576,8 +308,9 @@ static void twl_set(struct gpio_chip *ch
 
 static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	/* NOTE: assumes IRQs are set up ... */
-	return twl4030_gpio_irq_base + offset;
+	return twl4030_gpio_irq_base
+		? (twl4030_gpio_irq_base + offset)
+		: -EINVAL;
 }
 
 static struct gpio_chip twl_gpiochip = {
@@ -624,111 +357,52 @@ static int __devinit gpio_twl4030_probe(
 {
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
-	int irq = 0;
 
-	/* All GPIO interrupts are initially masked */
-	gpio_pending_mask = false;
-	gpio_imr_shadow = GPIO_32_MASK;
-	ret = gpio_write_imr(gpio_imr_shadow);
-
-	twl4030_gpio_irq_base = pdata->irq_base;
-	twl4030_gpio_irq_end = pdata->irq_end;
-
-	if ((twl4030_gpio_irq_end - twl4030_gpio_irq_base) > 0) {
+	/* maybe setup IRQs */
+	if (pdata->irq_base) {
 		if (is_module()) {
 			dev_err(&pdev->dev,
 				"can't dispatch IRQs from modules\n");
 			goto no_irqs;
 		}
-		if (twl4030_gpio_irq_end > NR_IRQS) {
-			dev_err(&pdev->dev,
-				"last IRQ is too large: %d\n",
-				twl4030_gpio_irq_end);
-			return -EINVAL;
-		}
-	} else {
-		dev_notice(&pdev->dev,
-			"no IRQs being dispatched\n");
-		goto no_irqs;
-	}
-
-	if (!ret) {
-		/*
-		 * Create a kernel thread to handle deferred operations on gpio
-		 * interrupts.
-		 */
-		gpio_helper_thread = kthread_create(twl4030_gpio_helper_thread,
-				&pdev->dev, "twl4030 gpio");
-		if (!gpio_helper_thread) {
-			dev_err(&pdev->dev,
-				"could not create helper thread!\n");
-			ret = -ENOMEM;
-		}
-	}
-
-	if (!ret) {
-		/* install an irq handler for each of the gpio interrupts */
-		for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end;
-				irq++) {
-			set_irq_chip_and_handler(irq, &twl4030_gpio_irq_chip,
-					handle_edge_irq);
-			activate_irq(irq);
-		}
-
-		/* gpio module IRQ */
-		irq = platform_get_irq(pdev, 0);
-
-		/* COR=1 means irqs are acked by reading ISR
-		 * PENDDIS=0 means pending events enabled
-		 * EXCLEN=0 means route to both irq lines
-		 */
-		gpio_twl4030_write(REG_GPIO_SIH_CTRL,
-				TWL4030_SIH_CTRL_COR_MASK);
-
-		/*
-		 * Install an irq handler to demultiplex the gpio module
-		 * interrupt.
-		 */
-		set_irq_chained_handler(irq, do_twl4030_gpio_module_irq);
-		wake_up_process(gpio_helper_thread);
-
-		dev_info(&pdev->dev, "IRQ %d chains IRQs %d..%d\n", irq,
-			twl4030_gpio_irq_base, twl4030_gpio_irq_end - 1);
+		ret = twl4030_sih_setup(TWL4030_MODULE_GPIO);
+		if (ret < 0)
+			return ret;
+		WARN_ON(ret != pdata->irq_base);
+		twl4030_gpio_irq_base = ret;
 	}
 
 no_irqs:
-	if (!ret) {
-		/*
-		 * NOTE:  boards may waste power if they don't set pullups
-		 * and pulldowns correctly ... default for non-ULPI pins is
-		 * pulldown, and some other pins may have external pullups
-		 * or pulldowns.  Careful!
-		 */
-		ret = gpio_twl4030_pulls(pdata->pullups, pdata->pulldowns);
-		if (ret)
-			dev_dbg(&pdev->dev, "pullups %.05x %.05x --> %d\n",
-					pdata->pullups, pdata->pulldowns,
-					ret);
+	/*
+	 * NOTE:  boards may waste power if they don't set pullups
+	 * and pulldowns correctly ... default for non-ULPI pins is
+	 * pulldown, and some other pins may have external pullups
+	 * or pulldowns.  Careful!
+	 */
+	ret = gpio_twl4030_pulls(pdata->pullups, pdata->pulldowns);
+	if (ret)
+		dev_dbg(&pdev->dev, "pullups %.05x %.05x --> %d\n",
+				pdata->pullups, pdata->pulldowns,
+				ret);
 
-		twl_gpiochip.base = pdata->gpio_base;
-		twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
-		twl_gpiochip.dev = &pdev->dev;
+	twl_gpiochip.base = pdata->gpio_base;
+	twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
+	twl_gpiochip.dev = &pdev->dev;
 
-		ret = gpiochip_add(&twl_gpiochip);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-					"could not register gpiochip, %d\n",
-					ret);
-			twl_gpiochip.ngpio = 0;
-			gpio_twl4030_remove(pdev);
-		} else if (pdata->setup) {
-			int status;
+	ret = gpiochip_add(&twl_gpiochip);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+				"could not register gpiochip, %d\n",
+				ret);
+		twl_gpiochip.ngpio = 0;
+		gpio_twl4030_remove(pdev);
+	} else if (pdata->setup) {
+		int status;
 
-			status = pdata->setup(&pdev->dev,
-					pdata->gpio_base, TWL4030_GPIO_MAX);
-			if (status)
-				dev_dbg(&pdev->dev, "setup --> %d\n", status);
-		}
+		status = pdata->setup(&pdev->dev,
+				pdata->gpio_base, TWL4030_GPIO_MAX);
+		if (status)
+			dev_dbg(&pdev->dev, "setup --> %d\n", status);
 	}
 
 	return ret;
@@ -738,7 +412,6 @@ static int __devexit gpio_twl4030_remove
 {
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
 	int status;
-	int irq;
 
 	if (pdata->teardown) {
 		status = pdata->teardown(&pdev->dev,
@@ -753,24 +426,12 @@ static int __devexit gpio_twl4030_remove
 	if (status < 0)
 		return status;
 
-	if (is_module() || (twl4030_gpio_irq_end - twl4030_gpio_irq_base) <= 0)
+	if (is_module())
 		return 0;
 
-	/* uninstall the gpio demultiplexing interrupt handler */
-	irq = platform_get_irq(pdev, 0);
-	set_irq_handler(irq, NULL);
-
-	/* uninstall the irq handler for each of the gpio interrupts */
-	for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end; irq++)
-		set_irq_handler(irq, NULL);
-
-	/* stop the gpio helper kernel thread */
-	if (gpio_helper_thread) {
-		kthread_stop(gpio_helper_thread);
-		gpio_helper_thread = NULL;
-	}
-
-	return 0;
+	/* REVISIT no support yet for deregistering all the IRQs */
+	WARN_ON(1);
+	return -EIO;
 }
 
 /* Note:  this hardware lives inside an I2C-based multi-function device. */
