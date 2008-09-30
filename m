From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 08/25] twl4030 uses gpiolib
Date: Tue, 30 Sep 2008 21:42:52 +0300
Message-ID: <1222800189-29737-9-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51259 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbYI3Snm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:43:42 -0400
In-Reply-To: <1222800189-29737-8-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Make the twl4030 core create a platform device to which its
GPIO code will bind, with platform_data used to configure
board-specific behaviors and configuration.

Update the twl4030 GPIO code:

  - Morph its gpio function code into a platform driver.

  - Move away from IRQ (and GPIO) numbers hard-wired in headers.

  - Hook up the twl4030 GPIO code to gpiolib.

  - Start phasing out the older TWL-specific calls ... currently
    those are used only by arch/arm/mach-omap2/hsmmc.c setup code.

  - Use a mutex for locking, not a binary semaphore.

NOTE:  more patches pending:  (a) this doesn't use pdata->pullups
to initialize (currently hsmmc code always sets GPIO-0 pullup even
if the board has an external pullup);  (b) there's a new gpio
request/free hook forthcoming in 2.6.28, which this should use;
(c) likewise there's a new gpio_to_irq() hook; (d) the irq_chip
set_type() mechanism needs to be supported; (e) needs to move over
to drivers/gpio; (f) upcoming threaded IRQ infrastructure should
be used, when that merges.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig        |    2 +-
 drivers/i2c/chips/twl4030-core.c |   44 ++++++
 drivers/i2c/chips/twl4030-gpio.c |  273 +++++++++++++++++++++++++++-----------
 3 files changed, 238 insertions(+), 81 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 121aec9..1a21388 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -159,7 +159,7 @@ config TWL4030_CORE
 
 config TWL4030_GPIO
 	bool "TWL4030 GPIO Driver"
-	depends on TWL4030_CORE
+	depends on TWL4030_CORE && GPIOLIB
 
 config TWL4030_MADC
 	tristate "TWL4030 MADC Driver"
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 02be771..c9460f7 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -63,6 +63,12 @@
 #define twl_has_usb()	false
 #endif
 
+#ifdef CONFIG_TWL4030_GPIO
+#define twl_has_gpio()	true
+#else
+#define twl_has_gpio()	false
+#endif
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -656,6 +662,44 @@ static int add_children(struct twl4030_platform_data *pdata)
 	struct twl4030_client	*twl = NULL;
 	int			status = 0;
 
+	if (twl_has_gpio() && pdata->gpio) {
+		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM1];
+
+		pdev = platform_device_alloc("twl4030_gpio", -1);
+		if (!pdev)
+			status = -ENOMEM;
+
+		/* more driver model init */
+		if (status == 0) {
+			pdev->dev.parent = &twl->client->dev;
+			/* device_init_wakeup(&pdev->dev, 1); */
+
+			status = platform_device_add_data(pdev, pdata->gpio,
+					sizeof(*pdata->gpio));
+		}
+
+		/* GPIO module IRQ */
+		if (status == 0) {
+			struct resource	r = {
+				.start = pdata->irq_base + 0,
+				.flags = IORESOURCE_IRQ,
+			};
+
+			status = platform_device_add_resources(pdev, &r, 1);
+		}
+
+		if (status == 0)
+			status = platform_device_add(pdev);
+
+		if (status < 0) {
+			platform_device_put(pdev);
+			dev_dbg(&twl->client->dev,
+					"can't create gpio dev, %d\n",
+					status);
+			goto err;
+		}
+	}
+
 	if (twl_has_rtc()) {
 		pdev = platform_device_alloc("twl4030_rtc", -1);
 		if (pdev) {
diff --git a/drivers/i2c/chips/twl4030-gpio.c b/drivers/i2c/chips/twl4030-gpio.c
index b51bed0..0d4dd28 100644
--- a/drivers/i2c/chips/twl4030-gpio.c
+++ b/drivers/i2c/chips/twl4030-gpio.c
@@ -31,22 +31,31 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
-#include <linux/random.h>
-#include <linux/syscalls.h>
+#include <linux/device.h>
 #include <linux/kthread.h>
 #include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
-#include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-gpio.h>
-#include <linux/slab.h>
 
 #include <mach/irqs.h>
 #include <asm/mach/irq.h>
 #include <mach/gpio.h>
 #include <mach/mux.h>
 
-#include <linux/device.h>
+
+/* REVISIT when these symbols vanish elsewhere, remove them here too */
+#undef TWL4030_GPIO_IRQ_BASE
+#undef TWL4030_GPIO_IRQ_END
+#undef TWL4030_MODIRQ_GPIO
+
+static struct gpio_chip twl_gpiochip;
+static int twl4030_gpio_irq_base;
+static int twl4030_gpio_irq_end;
+
 
 /* BitField Definitions */
 
@@ -130,7 +139,7 @@
 #define GPIO_32_MASK			0x0003ffff
 
 /* Data structures */
-static struct semaphore gpio_sem;
+static DEFINE_MUTEX(gpio_lock);
 
 /* store usage of each GPIO. - each bit represents one GPIO */
 static unsigned int gpio_usage_count;
@@ -147,7 +156,7 @@ static struct task_struct *gpio_unmask_thread;
 /*
  * Helper functions to read and write the GPIO ISR and IMR registers as
  * 32-bit integers. Functions return 0 on success, non-zero otherwise.
- * The caller must hold a lock on gpio_sem.
+ * The caller must hold gpio_lock.
  */
 
 static int gpio_read_isr(unsigned int *isr)
@@ -197,25 +206,25 @@ static int gpio_write_imr(unsigned int imr)
  */
 static void twl4030_gpio_mask_and_ack(unsigned int irq)
 {
-	int gpio = irq - TWL4030_GPIO_IRQ_BASE;
+	int gpio = irq - twl4030_gpio_irq_base;
 
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	/* mask */
 	gpio_imr_shadow |= (1 << gpio);
 	gpio_write_imr(gpio_imr_shadow);
 	/* ack */
 	gpio_write_isr(1 << gpio);
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 }
 
 static void twl4030_gpio_unmask(unsigned int irq)
 {
-	int gpio = irq - TWL4030_GPIO_IRQ_BASE;
+	int gpio = irq - twl4030_gpio_irq_base;
 
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	gpio_imr_shadow &= ~(1 << gpio);
 	gpio_write_imr(gpio_imr_shadow);
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 }
 
 /*
@@ -234,7 +243,7 @@ static void twl4030_gpio_mask_irqchip(unsigned int irq) {}
 
 static void twl4030_gpio_unmask_irqchip(unsigned int irq)
 {
-	int gpio = irq - TWL4030_GPIO_IRQ_BASE;
+	int gpio = irq - twl4030_gpio_irq_base;
 
 	gpio_pending_unmask |= (1 << gpio);
 	if (gpio_unmask_thread && gpio_unmask_thread->state != TASK_RUNNING)
@@ -242,7 +251,7 @@ static void twl4030_gpio_unmask_irqchip(unsigned int irq)
 }
 
 static struct irq_chip twl4030_gpio_irq_chip = {
-	.name	= "twl4030-gpio",
+	.name	= "twl4030",
 	.ack	= twl4030_gpio_mask_and_ack_irqchip,
 	.mask	= twl4030_gpio_mask_irqchip,
 	.unmask	= twl4030_gpio_unmask_irqchip,
@@ -297,21 +306,26 @@ int twl4030_request_gpio(int gpio)
 	if (unlikely(gpio >= TWL4030_GPIO_MAX))
 		return -EPERM;
 
-	down(&gpio_sem);
-	if (gpio_usage_count & (0x1 << gpio))
+	ret = gpio_request(twl_gpiochip.base + gpio, NULL);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&gpio_lock);
+	if (gpio_usage_count & (0x1 << gpio)) {
 		ret = -EBUSY;
-	else {
+	} else {
 		/* First time usage? - switch on GPIO module */
 		if (!gpio_usage_count) {
-			ret =
-			gpio_twl4030_write(REG_GPIO_CTRL,
+			ret = gpio_twl4030_write(REG_GPIO_CTRL,
 					MASK_GPIO_CTRL_GPIO_ON);
 			ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
 		}
 		if (!ret)
 			gpio_usage_count |= (0x1 << gpio);
+		else
+			gpio_free(twl_gpiochip.base + gpio);
 	}
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return ret;
 }
 EXPORT_SYMBOL(twl4030_request_gpio);
@@ -326,18 +340,20 @@ int twl4030_free_gpio(int gpio)
 	if (unlikely(gpio >= TWL4030_GPIO_MAX))
 		return -EPERM;
 
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 
-	if ((gpio_usage_count & (0x1 << gpio)) == 0)
+	if ((gpio_usage_count & (0x1 << gpio)) == 0) {
 		ret = -EPERM;
-	else
+	} else {
 		gpio_usage_count &= ~(0x1 << gpio);
+		gpio_free(twl_gpiochip.base + gpio);
+	}
 
 	/* Last time usage? - switch off GPIO module */
-	if (!gpio_usage_count)
+	if (ret == 0 && !gpio_usage_count)
 		ret = gpio_twl4030_write(REG_GPIO_CTRL, 0x0);
 
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return ret;
 }
 EXPORT_SYMBOL(twl4030_free_gpio);
@@ -345,21 +361,18 @@ EXPORT_SYMBOL(twl4030_free_gpio);
 /*
  * Set direction for TWL4030 GPIO
  */
-int twl4030_set_gpio_direction(int gpio, int is_input)
+static int twl4030_set_gpio_direction(int gpio, int is_input)
 {
 	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
 	u8 d_msk = MASK_GPIODATADIR_GPIOxDIR(GET_GPIO_DATA_OFF(gpio));
 	u8 reg = 0;
-	u8 base = 0;
+	u8 base = REG_GPIODATADIR1 + d_bnk;
 	int ret = 0;
 
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
+	if (unlikely(!(gpio_usage_count & (0x1 << gpio))))
 		return -EPERM;
 
-	base = REG_GPIODATADIR1 + d_bnk;
-
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		if (is_input)
@@ -369,23 +382,21 @@ int twl4030_set_gpio_direction(int gpio, int is_input)
 
 		ret = gpio_twl4030_write(base, reg);
 	}
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_set_gpio_direction);
 
 /*
  * To enable/disable GPIO pin on TWL4030
  */
-int twl4030_set_gpio_dataout(int gpio, int enable)
+static int twl4030_set_gpio_dataout(int gpio, int enable)
 {
 	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
 	u8 d_msk = MASK_GPIODATAOUT_GPIOxOUT(GET_GPIO_DATA_OFF(gpio));
 	u8 base = 0;
 	int ret = 0;
 
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
+	if (unlikely(!(gpio_usage_count & (0x1 << gpio))))
 		return -EPERM;
 
 	if (enable)
@@ -393,12 +404,11 @@ int twl4030_set_gpio_dataout(int gpio, int enable)
 	else
 		base = REG_CLEARGPIODATAOUT1 + d_bnk;
 
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_write(base, d_msk);
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_set_gpio_dataout);
 
 /*
  * To get the status of a GPIO pin on TWL4030
@@ -415,9 +425,9 @@ int twl4030_get_gpio_datain(int gpio)
 		return -EPERM;
 
 	base = REG_GPIODATAIN1 + d_bnk;
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	if (ret > 0)
 		ret = (ret >> d_off) & 0x1;
 
@@ -425,6 +435,7 @@ int twl4030_get_gpio_datain(int gpio)
 }
 EXPORT_SYMBOL(twl4030_get_gpio_datain);
 
+#if 0
 /*
  * Configure PULL type for a GPIO pin on TWL4030
  */
@@ -447,7 +458,7 @@ int twl4030_set_gpio_pull(int gpio, int pull_dircn)
 	else if (pull_dircn == TWL4030_GPIO_PULL_UP)
 		c_msk = MASK_GPIOPUPDCTR1_GPIOxPU(c_off);
 
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		/* clear the previous up/down values */
@@ -457,13 +468,15 @@ int twl4030_set_gpio_pull(int gpio, int pull_dircn)
 		reg |= c_msk;
 		ret = gpio_twl4030_write(base, reg);
 	}
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_set_gpio_pull);
+#endif
 
 /*
  * Configure Edge control for a GPIO pin on TWL4030
+ *
+ * FIXME this should just be the irq_chip.set_type() method
  */
 int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 {
@@ -486,7 +499,7 @@ int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 	if (edge & TWL4030_GPIO_EDGE_FALLING)
 		c_msk |= MASK_GPIO_EDR1_GPIOxFALLING(c_off);
 
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		/* clear the previous rising/falling values */
@@ -497,7 +510,7 @@ int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 		reg |= c_msk;
 		ret = gpio_twl4030_write(base, reg);
 	}
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return ret;
 }
 EXPORT_SYMBOL(twl4030_set_gpio_edge_ctrl);
@@ -518,7 +531,7 @@ int twl4030_set_gpio_debounce(int gpio, int enable)
 		return -EPERM;
 
 	base = REG_GPIO_DEBEN1 + d_bnk;
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		if (enable)
@@ -528,11 +541,12 @@ int twl4030_set_gpio_debounce(int gpio, int enable)
 
 		ret = gpio_twl4030_write(base, reg);
 	}
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return ret;
 }
 EXPORT_SYMBOL(twl4030_set_gpio_debounce);
 
+#if 0
 /*
  * Configure Card detect for GPIO pin on TWL4030
  */
@@ -549,7 +563,7 @@ int twl4030_set_gpio_card_detect(int gpio, int enable)
 		return -EPERM;
 	}
 
-	down(&gpio_sem);
+	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(REG_GPIO_CTRL);
 	if (ret >= 0) {
 		if (enable)
@@ -559,10 +573,10 @@ int twl4030_set_gpio_card_detect(int gpio, int enable)
 
 		ret = gpio_twl4030_write(REG_GPIO_CTRL, reg);
 	}
-	up(&gpio_sem);
+	mutex_unlock(&gpio_lock);
 	return (ret);
 }
-EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
+#endif
 
 /* MODULE FUNCTIONS */
 
@@ -590,7 +604,7 @@ static int twl4030_gpio_unmask_thread(void *data)
 		gpio_pending_unmask = 0;
 		local_irq_enable();
 
-		for (irq = TWL4030_GPIO_IRQ_BASE; 0 != gpio_unmask;
+		for (irq = twl4030_gpio_irq_base; 0 != gpio_unmask;
 				gpio_unmask >>= 1, irq++) {
 			if (gpio_unmask & 0x1)
 				twl4030_gpio_unmask(irq);
@@ -677,12 +691,12 @@ static void do_twl4030_gpio_module_irq(unsigned int irq, irq_desc_t *desc)
 		kstat_cpu(cpu).irqs[irq]++;
 		local_irq_enable();
 
-		down(&gpio_sem);
+		mutex_lock(&gpio_lock);
 		if (gpio_read_isr(&gpio_isr))
 			gpio_isr = 0;
-		up(&gpio_sem);
+		mutex_unlock(&gpio_lock);
 
-		for (gpio_irq = TWL4030_GPIO_IRQ_BASE; 0 != gpio_isr;
+		for (gpio_irq = twl4030_gpio_irq_base; 0 != gpio_isr;
 			gpio_isr >>= 1, gpio_irq++) {
 			if (gpio_isr & 0x1) {
 				irq_desc_t *d = irq_desc + gpio_irq;
@@ -698,19 +712,60 @@ static void do_twl4030_gpio_module_irq(unsigned int irq, irq_desc_t *desc)
 	}
 }
 
-/* TWL4030 Initialization module */
-static int __init gpio_twl4030_init(void)
+/*----------------------------------------------------------------------*/
+
+static int twl_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	return twl4030_set_gpio_direction(offset, 1);
+}
+
+static int twl_get(struct gpio_chip *chip, unsigned offset)
+{
+	int status = twl4030_get_gpio_datain(offset);
+
+	return (status < 0) ? 0 : status;
+}
+
+static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
+{
+	twl4030_set_gpio_dataout(offset, value);
+	return twl4030_set_gpio_direction(offset, 0);
+}
+
+static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
 {
+	twl4030_set_gpio_dataout(offset, value);
+}
+
+static struct gpio_chip twl_gpiochip = {
+	.label			= "twl4030",
+	.owner			= THIS_MODULE,
+	.direction_input	= twl_direction_in,
+	.get			= twl_get,
+	.direction_output	= twl_direction_out,
+	.set			= twl_set,
+	.can_sleep		= 1,
+};
+
+/*----------------------------------------------------------------------*/
+
+static int gpio_twl4030_remove(struct platform_device *pdev);
+
+static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
+{
+	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
 	int irq = 0;
 
-	/* init the global locking sem */
-	sema_init(&gpio_sem, 1);
-
 	/* All GPIO interrupts are initially masked */
 	gpio_pending_unmask = 0;
 	gpio_imr_shadow = GPIO_32_MASK;
 	ret = gpio_write_imr(gpio_imr_shadow);
+
+	twl4030_gpio_irq_base = pdata->irq_base;
+	twl4030_gpio_irq_end = pdata->irq_end;
+
+	/* REVISIT skip most of this if the irq range is empty... */
 	if (!ret) {
 		/*
 		 * Create a kernel thread to handle deferred unmasking of gpio
@@ -719,50 +774,88 @@ static int __init gpio_twl4030_init(void)
 		gpio_unmask_thread = kthread_create(twl4030_gpio_unmask_thread,
 			NULL, "twl4030 gpio");
 		if (!gpio_unmask_thread) {
-			printk(KERN_ERR
-				"%s: could not create twl4030 gpio unmask"
-				" thread!\n", __func__);
+			dev_err(&pdev->dev,
+				"could not create twl4030 gpio unmask"
+				" thread!\n");
 			ret = -ENOMEM;
 		}
 	}
 
 	if (!ret) {
 		/* install an irq handler for each of the gpio interrupts */
-		for (irq = TWL4030_GPIO_IRQ_BASE; irq < TWL4030_GPIO_IRQ_END;
-			irq++) {
+		for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end;
+				irq++) {
 			set_irq_chip(irq, &twl4030_gpio_irq_chip);
 			set_irq_handler(irq, do_twl4030_gpio_irq);
 			set_irq_flags(irq, IRQF_VALID);
 		}
 
+		/* gpio module IRQ */
+		irq = platform_get_irq(pdev, 0);
+
 		/*
 		 * Install an irq handler to demultiplex the gpio module
 		 * interrupt.
 		 */
-		set_irq_chip(TWL4030_MODIRQ_GPIO,
-			&twl4030_gpio_module_irq_chip);
-		set_irq_chained_handler(TWL4030_MODIRQ_GPIO,
-			do_twl4030_gpio_module_irq);
+		set_irq_chip(irq, &twl4030_gpio_module_irq_chip);
+		set_irq_chained_handler(irq, do_twl4030_gpio_module_irq);
 		wake_up_process(gpio_unmask_thread);
+
+		dev_info(&pdev->dev, "IRQ %d chains IRQs %d..%d\n", irq,
+			twl4030_gpio_irq_base, twl4030_gpio_irq_end - 1);
+	}
+
+	if (!ret) {
+		twl_gpiochip.base = pdata->gpio_base;
+		twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
+		twl_gpiochip.dev = &pdev->dev;
+
+		ret = gpiochip_add(&twl_gpiochip);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+					"could not register gpiochip, %d\n",
+					ret);
+			twl_gpiochip.ngpio = 0;
+			gpio_twl4030_remove(pdev);
+		} else if (pdata->setup) {
+			int status;
+
+			status = pdata->setup(&pdev->dev,
+					pdata->gpio_base, TWL4030_GPIO_MAX);
+			if (status)
+				dev_dbg(&pdev->dev, "setup --> %d\n", status);
+		}
 	}
 
-	printk(KERN_INFO "TWL4030 GPIO Demux: IRQ Range %d to %d,"
-		" Initialization %s\n", TWL4030_GPIO_IRQ_BASE,
-		TWL4030_GPIO_IRQ_END, (ret) ? "Failed" : "Success");
 	return ret;
 }
 
-/* TWL GPIO exit module */
-static void __exit gpio_twl4030_exit(void)
+static int __devexit gpio_twl4030_remove(struct platform_device *pdev)
 {
+	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
+	int status;
 	int irq;
 
+	if (pdata->teardown) {
+		status = pdata->teardown(&pdev->dev,
+				pdata->gpio_base, TWL4030_GPIO_MAX);
+		if (status) {
+			dev_dbg(&pdev->dev, "teardown --> %d\n", status);
+			return status;
+		}
+	}
+
+	status = gpiochip_remove(&twl_gpiochip);
+	if (status < 0)
+		return status;
+
 	/* uninstall the gpio demultiplexing interrupt handler */
-	set_irq_handler(TWL4030_MODIRQ_GPIO, NULL);
-	set_irq_flags(TWL4030_MODIRQ_GPIO, 0);
+	irq = platform_get_irq(pdev, 0);
+	set_irq_handler(irq, NULL);
+	set_irq_flags(irq, 0);
 
 	/* uninstall the irq handler for each of the gpio interrupts */
-	for (irq = TWL4030_GPIO_IRQ_BASE; irq < TWL4030_GPIO_IRQ_END; irq++) {
+	for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end; irq++) {
 		set_irq_handler(irq, NULL);
 		set_irq_flags(irq, 0);
 	}
@@ -772,12 +865,32 @@ static void __exit gpio_twl4030_exit(void)
 		kthread_stop(gpio_unmask_thread);
 		gpio_unmask_thread = NULL;
 	}
+
+	return 0;
 }
 
+/* Note:  this hardware lives inside an I2C-based multi-function device. */
+MODULE_ALIAS("platform:twl4030_gpio");
+
+static struct platform_driver gpio_twl4030_driver = {
+	.driver.name	= "twl4030_gpio",
+	.driver.owner	= THIS_MODULE,
+	.probe		= gpio_twl4030_probe,
+	.remove		= __devexit_p(gpio_twl4030_remove),
+};
+
+static int __init gpio_twl4030_init(void)
+{
+	return platform_driver_register(&gpio_twl4030_driver);
+}
 module_init(gpio_twl4030_init);
+
+static void __exit gpio_twl4030_exit(void)
+{
+	platform_driver_unregister(&gpio_twl4030_driver);
+}
 module_exit(gpio_twl4030_exit);
 
-MODULE_ALIAS("i2c:twl4030-gpio");
 MODULE_AUTHOR("Texas Instruments, Inc.");
 MODULE_DESCRIPTION("GPIO interface for TWL4030");
 MODULE_LICENSE("GPL");
-- 
1.6.0.1.196.g01914

