From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc6-omap1] speed up gpio irq handling
Date: Mon, 27 Nov 2006 23:30:01 -0800
Message-ID: <20061128073001.AF6C61E1901@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Speedup and shrink GPIO irq handling code, by using a pointer
that's available in the irq_chip structure instead of calling
the get_gpio_bank() function.  On OMAP1 this saves 44 words,
most of which were in IRQ critical path methods.  Hey, every
few instructions help.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk2/arch/arm/plat-omap/gpio.c
===================================================================
--- osk2.orig/arch/arm/plat-omap/gpio.c	2006-11-27 22:50:30.000000000 -0800
+++ osk2/arch/arm/plat-omap/gpio.c	2006-11-27 23:00:32.000000000 -0800
@@ -585,7 +585,7 @@ static int gpio_irq_type(unsigned irq, u
 			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
-	bank = get_gpio_bank(gpio);
+	bank = get_irq_chip_data(irq);
 	spin_lock(&bank->lock);
 	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
 	if (retval == 0) {
@@ -830,7 +830,7 @@ static int gpio_wake_enable(unsigned int
 
 	if (check_gpio(gpio) < 0)
 		return -ENODEV;
-	bank = get_gpio_bank(gpio);
+	bank = get_irq_chip_data(irq);
 	retval = _set_gpio_wakeup(bank, get_gpio_index(gpio), enable);
 
 	return retval;
@@ -1045,7 +1045,7 @@ static void gpio_irq_handler(unsigned in
 static void gpio_irq_shutdown(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
-	struct gpio_bank *bank = get_gpio_bank(gpio);
+	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_reset_gpio(bank, gpio);
 }
@@ -1053,7 +1053,7 @@ static void gpio_irq_shutdown(unsigned i
 static void gpio_ack_irq(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
-	struct gpio_bank *bank = get_gpio_bank(gpio);
+	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_clear_gpio_irqstatus(bank, gpio);
 }
@@ -1061,7 +1061,7 @@ static void gpio_ack_irq(unsigned int ir
 static void gpio_mask_irq(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
-	struct gpio_bank *bank = get_gpio_bank(gpio);
+	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_set_gpio_irqenable(bank, gpio, 0);
 }
@@ -1070,7 +1070,7 @@ static void gpio_unmask_irq(unsigned int
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
 	unsigned int gpio_idx = get_gpio_index(gpio);
-	struct gpio_bank *bank = get_gpio_bank(gpio);
+	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_set_gpio_irqenable(bank, gpio_idx, 1);
 }
@@ -1099,7 +1099,7 @@ static void mpuio_ack_irq(unsigned int i
 static void mpuio_mask_irq(unsigned int irq)
 {
 	unsigned int gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
-	struct gpio_bank *bank = get_gpio_bank(gpio);
+	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_set_gpio_irqenable(bank, gpio, 0);
 }
@@ -1107,7 +1107,7 @@ static void mpuio_mask_irq(unsigned int 
 static void mpuio_unmask_irq(unsigned int irq)
 {
 	unsigned int gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
-	struct gpio_bank *bank = get_gpio_bank(gpio);
+	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_set_gpio_irqenable(bank, gpio, 1);
 }
@@ -1347,6 +1347,7 @@ static int __init _omap_gpio_init(void)
 #endif
 		for (j = bank->virtual_irq_start;
 		     j < bank->virtual_irq_start + gpio_count; j++) {
+			set_irq_chip_data(j, bank);
 			if (bank_is_mpuio(bank))
 				set_irq_chip(j, &mpuio_irq_chip);
 			else
