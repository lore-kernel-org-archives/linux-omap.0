From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/6] gpio/omap: Fix IRQ handling for SPARSE_IRQ
Date: Fri, 24 Feb 2012 23:21:29 +0100
Message-ID: <1330122091-28113-5-git-send-email-b-cousson@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38337 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274Ab2BXWWX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 17:22:23 -0500
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The driver is still relying on internal OMAP IRQ defines that
are not relevant anymore if OMAP is built with SPARSE_IRQ.

Replace the defines with the proper IRQ base number.
Clean some comment style issue.
Remove some hidden and ugly cpu_class_is_omap1() inside the
gpio header.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/include/plat/gpio.h |   22 ++------------------
 drivers/gpio/gpio-omap.c               |   33 ++++++++++++++++---------------
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index cb75b65..b8a96c6 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -218,30 +218,14 @@ extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
 /*-------------------------------------------------------------------------*/
 
-/* Wrappers for "new style" GPIO calls, using the new infrastructure
+/*
+ * Wrappers for "new style" GPIO calls, using the new infrastructure
  * which lets us plug in FPGA, I2C, and other implementations.
- * *
+ *
  * The original OMAP-specific calls should eventually be removed.
  */
 
 #include <linux/errno.h>
 #include <asm-generic/gpio.h>
 
-static inline int irq_to_gpio(unsigned irq)
-{
-	int tmp;
-
-	/* omap1 SOC mpuio */
-	if (cpu_class_is_omap1() && (irq < (IH_MPUIO_BASE + 16)))
-		return (irq - IH_MPUIO_BASE) + OMAP_MAX_GPIO_LINES;
-
-	/* SOC gpio */
-	tmp = irq - IH_GPIO_BASE;
-	if (tmp < OMAP_MAX_GPIO_LINES)
-		return tmp;
-
-	/* we don't supply reverse mappings for non-SOC gpios */
-	return -EIO;
-}
-
 #endif
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index bc2bd69..afef0f7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -93,6 +93,11 @@ struct gpio_bank {
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 #define GPIO_MOD_CTRL_BIT	BIT(0)
 
+static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
+{
+	return gpio_irq - bank->irq_base + bank->chip.base;
+}
+
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 {
 	void __iomem *reg = bank->base;
@@ -369,7 +374,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 
 static int gpio_irq_type(struct irq_data *d, unsigned type)
 {
-	struct gpio_bank *bank;
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	unsigned gpio;
 	int retval;
 	unsigned long flags;
@@ -377,13 +382,11 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	if (!cpu_class_is_omap2() && d->irq > IH_MPUIO_BASE)
 		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
 	else
-		gpio = d->irq - IH_GPIO_BASE;
+		gpio = irq_to_gpio(bank, d->irq);
 
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
-	bank = irq_data_get_irq_chip_data(d);
-
 	if (!bank->regs->leveldetect0 &&
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
@@ -524,14 +527,10 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
 static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
-	unsigned int gpio = d->irq - IH_GPIO_BASE;
-	struct gpio_bank *bank;
-	int retval;
-
-	bank = irq_data_get_irq_chip_data(d);
-	retval = _set_gpio_wakeup(bank, gpio, enable);
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 
-	return retval;
+	return _set_gpio_wakeup(bank, gpio, enable);
 }
 
 static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -675,11 +674,13 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		gpio_irq = bank->irq_base;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
-			gpio_index = GPIO_INDEX(bank, irq_to_gpio(gpio_irq));
+			int gpio = irq_to_gpio(bank, gpio_irq);
 
 			if (!(isr & 1))
 				continue;
 
+			gpio_index = GPIO_INDEX(bank, gpio);
+
 			/*
 			 * Some chips can't respond to both rising and falling
 			 * at the same time.  If this irq was requested with
@@ -705,8 +706,8 @@ exit:
 
 static void gpio_irq_shutdown(struct irq_data *d)
 {
-	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -716,16 +717,16 @@ static void gpio_irq_shutdown(struct irq_data *d)
 
 static void gpio_ack_irq(struct irq_data *d)
 {
-	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 
 	_clear_gpio_irqstatus(bank, gpio);
 }
 
 static void gpio_mask_irq(struct irq_data *d)
 {
-	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -736,8 +737,8 @@ static void gpio_mask_irq(struct irq_data *d)
 
 static void gpio_unmask_irq(struct irq_data *d)
 {
-	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
-- 
1.7.0.4

