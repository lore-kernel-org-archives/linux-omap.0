From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/14] ARM: OMAP: Use gpiolib
Date: Mon, 17 Mar 2008 11:42:25 +0200
Message-ID: <1205746958-11242-2-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62130 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbYCQJnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:18 -0400
In-Reply-To: <1205746958-11242-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Update OMAP to use the new GPIO implementation framework.  This is just a
quick'n'dirty update ... more code could now be removed, ideally as part
of cleaning up the entire OMAP GPIO infrastructure ...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                 |    1 +
 arch/arm/plat-omap/gpio.c        |  107 +++++++++++++++++++++++++++++++------
 include/asm-arm/arch-omap/gpio.h |   57 +++++---------------
 3 files changed, 105 insertions(+), 60 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4039a13..992028f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -468,6 +468,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8c78e4e..56889fd 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -136,7 +136,6 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-	u32 reserved_map;
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
@@ -150,6 +149,7 @@ struct gpio_bank {
 	u32 saved_risingdetect;
 #endif
 	spinlock_t lock;
+	struct gpio_chip chip;
 };
 
 #define METHOD_MPUIO		0
@@ -903,19 +903,17 @@ int omap_request_gpio(int gpio)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
+	int status;
 
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
 
+	status = gpio_request(gpio, NULL);
+	if (status < 0)
+		return status;
+
 	bank = get_gpio_bank(gpio);
 	spin_lock_irqsave(&bank->lock, flags);
-	if (unlikely(bank->reserved_map & (1 << get_gpio_index(gpio)))) {
-		printk(KERN_ERR "omap-gpio: GPIO %d is already reserved!\n", gpio);
-		dump_stack();
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return -1;
-	}
-	bank->reserved_map |= (1 << get_gpio_index(gpio));
 
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type().
@@ -945,10 +943,11 @@ void omap_free_gpio(int gpio)
 		return;
 	bank = get_gpio_bank(gpio);
 	spin_lock_irqsave(&bank->lock, flags);
-	if (unlikely(!(bank->reserved_map & (1 << get_gpio_index(gpio))))) {
+	if (unlikely(!gpiochip_is_requested(&bank->chip,
+				get_gpio_index(gpio)))) {
+		spin_unlock_irqrestore(&bank->lock, flags);
 		printk(KERN_ERR "omap-gpio: GPIO %d wasn't reserved!\n", gpio);
 		dump_stack();
-		spin_unlock_irqrestore(&bank->lock, flags);
 		return;
 	}
 #ifdef CONFIG_ARCH_OMAP16XX
@@ -965,9 +964,9 @@ void omap_free_gpio(int gpio)
 		__raw_writel(1 << get_gpio_index(gpio), reg);
 	}
 #endif
-	bank->reserved_map &= ~(1 << get_gpio_index(gpio));
 	_reset_gpio(bank, gpio);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	gpio_free(gpio);
 }
 
 /*
@@ -1266,6 +1265,53 @@ static inline void mpuio_init(void) {}
 
 /*---------------------------------------------------------------------*/
 
+/* REVISIT these are stupid implementations!  replace by ones that
+ * don't switch on METHOD_* and which mostly avoid spinlocks
+ */
+
+static int gpio_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	spin_lock_irqsave(&bank->lock, flags);
+	_set_gpio_direction(bank, offset, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	return 0;
+}
+
+static int gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	return omap_get_gpio_datain(chip->base + offset);
+}
+
+static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	spin_lock_irqsave(&bank->lock, flags);
+	_set_gpio_dataout(bank, offset, value);
+	_set_gpio_direction(bank, offset, 0);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	return 0;
+}
+
+static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	spin_lock_irqsave(&bank->lock, flags);
+	_set_gpio_dataout(bank, offset, value);
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+/*---------------------------------------------------------------------*/
+
 static int initialized;
 #if !defined(CONFIG_ARCH_OMAP3)
 static struct clk * gpio_ick;
@@ -1293,6 +1339,7 @@ static struct lock_class_key gpio_lock_class;
 static int __init _omap_gpio_init(void)
 {
 	int i;
+	int gpio = 0;
 	struct gpio_bank *bank;
 #if defined(CONFIG_ARCH_OMAP3)
 	char clk_name[11];
@@ -1423,7 +1470,6 @@ static int __init _omap_gpio_init(void)
 		int j, gpio_count = 16;
 
 		bank = &gpio_bank[i];
-		bank->reserved_map = 0;
 		bank->base = IO_ADDRESS(bank->base);
 		spin_lock_init(&bank->lock);
 		if (bank_is_mpuio(bank))
@@ -1461,6 +1507,26 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32;
 		}
 #endif
+
+		/* REVISIT eventually switch from OMAP-specific gpio structs
+		 * over to the generic ones
+		 */
+		bank->chip.direction_input = gpio_input;
+		bank->chip.get = gpio_get;
+		bank->chip.direction_output = gpio_output;
+		bank->chip.set = gpio_set;
+		if (bank_is_mpuio(bank)) {
+			bank->chip.label = "mpuio";
+			bank->chip.base = OMAP_MPUIO(0);
+		} else {
+			bank->chip.label = "gpio";
+			bank->chip.base = gpio;
+			gpio += gpio_count;
+		}
+		bank->chip.ngpio = gpio_count;
+
+		gpiochip_add(&bank->chip);
+
 		for (j = bank->virtual_irq_start;
 		     j < bank->virtual_irq_start + gpio_count; j++) {
 			lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
@@ -1757,8 +1823,10 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 
 		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
 			unsigned	irq, value, is_in, irqstat;
+			const char	*label;
 
-			if (!(bank->reserved_map & mask))
+			label = gpiochip_is_requested(&bank->chip, j);
+			if (!label)
 				continue;
 
 			irq = bank->virtual_irq_start + j;
@@ -1766,13 +1834,16 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 			is_in = gpio_is_input(bank, mask);
 
 			if (bank_is_mpuio(bank))
-				seq_printf(s, "MPUIO %2d: ", j);
+				seq_printf(s, "MPUIO %2d ", j);
 			else
-				seq_printf(s, "GPIO %3d: ", gpio);
-			seq_printf(s, "%s %s",
+				seq_printf(s, "GPIO %3d ", gpio);
+			seq_printf(s, "(%10s): %s %s",
+					label,
 					is_in ? "in " : "out",
 					value ? "hi"  : "lo");
 
+/* FIXME for at least omap2, show pullup/pulldown state */
+
 			irqstat = irq_desc[irq].status;
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
@@ -1795,10 +1866,10 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 					trigger = "high";
 					break;
 				case IRQ_TYPE_NONE:
-					trigger = "(unspecified)";
+					trigger = "(?)";
 					break;
 				}
-				seq_printf(s, ", irq-%d %s%s",
+				seq_printf(s, ", irq-%d %-8s%s",
 						irq, trigger,
 						(bank->suspend_wakeup & mask)
 							? " wakeup" : "");
diff --git a/include/asm-arm/arch-omap/gpio.h b/include/asm-arm/arch-omap/gpio.h
index 164da09..86621a0 100644
--- a/include/asm-arm/arch-omap/gpio.h
+++ b/include/asm-arm/arch-omap/gpio.h
@@ -82,62 +82,35 @@ extern void omap_set_gpio_debounce_time(int gpio, int enable);
 
 /*-------------------------------------------------------------------------*/
 
-/* wrappers for "new style" GPIO calls. the old OMAP-specfic ones should
- * eventually be removed (along with this errno.h inclusion), and maybe
- * gpios should put MPUIOs last too.
+/* Wrappers for "new style" GPIO calls, using the new infrastructure
+ * which lets us plug in FPGA, I2C, and other implementations.
+ * *
+ * The original OMAP-specfic calls should eventually be removed.
  */
 
-#include <asm/errno.h>
-
-static inline int gpio_request(unsigned gpio, const char *label)
-{
-	return omap_request_gpio(gpio);
-}
-
-static inline void gpio_free(unsigned gpio)
-{
-	omap_free_gpio(gpio);
-}
-
-static inline int __gpio_set_direction(unsigned gpio, int is_input)
-{
-	if (cpu_class_is_omap2()) {
-		if (gpio > OMAP_MAX_GPIO_LINES)
-			return -EINVAL;
-	} else {
-		if (gpio > (OMAP_MAX_GPIO_LINES + 16 /* MPUIO */))
-			return -EINVAL;
-	}
-	omap_set_gpio_direction(gpio, is_input);
-	return 0;
-}
-
-static inline int gpio_direction_input(unsigned gpio)
-{
-	return __gpio_set_direction(gpio, 1);
-}
-
-static inline int gpio_direction_output(unsigned gpio, int value)
-{
-	omap_set_gpio_dataout(gpio, value);
-	return __gpio_set_direction(gpio, 0);
-}
+#include <linux/errno.h>
+#include <asm-generic/gpio.h>
 
 static inline int gpio_get_value(unsigned gpio)
 {
-	return omap_get_gpio_datain(gpio);
+	return __gpio_get_value(gpio);
 }
 
 static inline void gpio_set_value(unsigned gpio, int value)
 {
-	omap_set_gpio_dataout(gpio, value);
+	__gpio_set_value(gpio, value);
 }
 
-#include <asm-generic/gpio.h>		/* cansleep wrappers */
+static inline int gpio_cansleep(unsigned gpio)
+{
+	return __gpio_cansleep(gpio);
+}
 
 static inline int gpio_to_irq(unsigned gpio)
 {
-	return OMAP_GPIO_IRQ(gpio);
+	if (gpio < (OMAP_MAX_GPIO_LINES + 16))
+		return OMAP_GPIO_IRQ(gpio);
+	return -EINVAL;
 }
 
 static inline int irq_to_gpio(unsigned irq)
-- 
1.5.3.6

