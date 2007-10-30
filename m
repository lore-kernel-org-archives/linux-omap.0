From: David Brownell <david-b@pacbell.net>
Subject: [patch 1/2 2.6.24-rc1-git] OMAP uses gpiolib
Date: Tue, 30 Oct 2007 08:55:07 -0700
Message-ID: <200710300855.07854.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Update OMAP to use the new GPIO implementation framework.  This is just a
quick'n'dirty update; more code could now be removed.  Plus, it might be
best to clean up the entire OMAP GPIO infrastructure ...

This also fixes some spinlock issues reported by the spinlock validator,
which is now (again?) running on ARM.

---
 arch/arm/Kconfig                 |    1 
 arch/arm/plat-omap/gpio.c        |  138 +++++++++++++++++++++++++++++----------
 include/asm-arm/arch-omap/gpio.h |   57 ++++------------
 3 files changed, 123 insertions(+), 73 deletions(-)

--- a/arch/arm/Kconfig	2007-10-29 20:46:23.000000000 -0700
+++ b/arch/arm/Kconfig	2007-10-29 20:50:48.000000000 -0700
@@ -406,6 +406,7 @@ config ARCH_OMAP
 	bool "TI OMAP"
 	select GENERIC_GPIO
 	select GENERIC_TIME
+	select GPIO_LIB
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
--- a/arch/arm/plat-omap/gpio.c	2007-10-29 20:46:23.000000000 -0700
+++ b/arch/arm/plat-omap/gpio.c	2007-10-30 01:17:38.000000000 -0700
@@ -122,7 +122,6 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-	u32 reserved_map;
 #if defined (CONFIG_ARCH_OMAP16XX) || defined (CONFIG_ARCH_OMAP24XX)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
@@ -136,6 +135,7 @@ struct gpio_bank {
 	u32 saved_risingdetect;
 #endif
 	spinlock_t lock;
+	struct gpio_chip chip;
 };
 
 #define METHOD_MPUIO		0
@@ -323,13 +323,14 @@ static void _set_gpio_direction(struct g
 void omap_set_gpio_direction(int gpio, int is_input)
 {
 	struct gpio_bank *bank;
+	unsigned long flags;
 
 	if (check_gpio(gpio) < 0)
 		return;
 	bank = get_gpio_bank(gpio);
-	spin_lock(&bank->lock);
+	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_direction(bank, get_gpio_index(gpio), is_input);
-	spin_unlock(&bank->lock);
+	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
@@ -396,13 +397,14 @@ static void _set_gpio_dataout(struct gpi
 void omap_set_gpio_dataout(int gpio, int enable)
 {
 	struct gpio_bank *bank;
+	unsigned long flags;
 
 	if (check_gpio(gpio) < 0)
 		return;
 	bank = get_gpio_bank(gpio);
-	spin_lock(&bank->lock);
+	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_dataout(bank, get_gpio_index(gpio), enable);
-	spin_unlock(&bank->lock);
+	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 int omap_get_gpio_datain(int gpio)
@@ -566,6 +568,7 @@ static int gpio_irq_type(unsigned irq, u
 	struct gpio_bank *bank;
 	unsigned gpio;
 	int retval;
+	unsigned long flags;
 
 	if (!cpu_is_omap24xx() && irq > IH_MPUIO_BASE)
 		gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
@@ -584,13 +587,13 @@ static int gpio_irq_type(unsigned irq, u
 		return -EINVAL;
 
 	bank = get_irq_chip_data(irq);
-	spin_lock(&bank->lock);
+	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
 	if (retval == 0) {
 		irq_desc[irq].status &= ~IRQ_TYPE_SENSE_MASK;
 		irq_desc[irq].status |= type;
 	}
-	spin_unlock(&bank->lock);
+	spin_unlock_irqrestore(&bank->lock, flags);
 	return retval;
 }
 
@@ -770,11 +773,13 @@ static inline void _set_gpio_irqenable(s
  */
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
+	unsigned long flags;
+
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_MPUIO:
 	case METHOD_GPIO_1610:
-		spin_lock(&bank->lock);
+		spin_lock_irqsave(&bank->lock, flags);
 		if (enable) {
 			bank->suspend_wakeup |= (1 << gpio);
 			enable_irq_wake(bank->irq);
@@ -782,7 +787,7 @@ static int _set_gpio_wakeup(struct gpio_
 			disable_irq_wake(bank->irq);
 			bank->suspend_wakeup &= ~(1 << gpio);
 		}
-		spin_unlock(&bank->lock);
+		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
 #ifdef CONFIG_ARCH_OMAP24XX
@@ -793,7 +798,7 @@ static int _set_gpio_wakeup(struct gpio_
 					(bank - gpio_bank) * 32 + gpio);
 			return -EINVAL;
 		}
-		spin_lock(&bank->lock);
+		spin_lock_irqsave(&bank->lock, flags);
 		if (enable) {
 			bank->suspend_wakeup |= (1 << gpio);
 			enable_irq_wake(bank->irq);
@@ -801,7 +806,7 @@ static int _set_gpio_wakeup(struct gpio_
 			disable_irq_wake(bank->irq);
 			bank->suspend_wakeup &= ~(1 << gpio);
 		}
-		spin_unlock(&bank->lock);
+		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
 	default:
@@ -837,19 +842,18 @@ static int gpio_wake_enable(unsigned int
 int omap_request_gpio(int gpio)
 {
 	struct gpio_bank *bank;
+	int status;
+	unsigned long flags;
 
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
 
+	status = gpio_request(gpio, NULL);
+	if (status < 0)
+		return status;
+
 	bank = get_gpio_bank(gpio);
-	spin_lock(&bank->lock);
-	if (unlikely(bank->reserved_map & (1 << get_gpio_index(gpio)))) {
-		printk(KERN_ERR "omap-gpio: GPIO %d is already reserved!\n", gpio);
-		dump_stack();
-		spin_unlock(&bank->lock);
-		return -1;
-	}
-	bank->reserved_map |= (1 << get_gpio_index(gpio));
+	spin_lock_irqsave(&bank->lock, flags);
 
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type().
@@ -865,7 +869,7 @@ int omap_request_gpio(int gpio)
 		__raw_writel(__raw_readl(reg) | (1 << get_gpio_index(gpio)), reg);
 	}
 #endif
-	spin_unlock(&bank->lock);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -873,15 +877,17 @@ int omap_request_gpio(int gpio)
 void omap_free_gpio(int gpio)
 {
 	struct gpio_bank *bank;
+	unsigned long flags;
 
 	if (check_gpio(gpio) < 0)
 		return;
 	bank = get_gpio_bank(gpio);
-	spin_lock(&bank->lock);
-	if (unlikely(!(bank->reserved_map & (1 << get_gpio_index(gpio))))) {
+	spin_lock_irqsave(&bank->lock, flags);
+	if (unlikely(!gpiochip_is_requested(&bank->chip,
+				get_gpio_index(gpio)))) {
+		spin_unlock_irqrestore(&bank->lock, flags);
 		printk(KERN_ERR "omap-gpio: GPIO %d wasn't reserved!\n", gpio);
 		dump_stack();
-		spin_unlock(&bank->lock);
 		return;
 	}
 #ifdef CONFIG_ARCH_OMAP16XX
@@ -898,9 +904,9 @@ void omap_free_gpio(int gpio)
 		__raw_writel(1 << get_gpio_index(gpio), reg);
 	}
 #endif
-	bank->reserved_map &= ~(1 << get_gpio_index(gpio));
 	_reset_gpio(bank, gpio);
-	spin_unlock(&bank->lock);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	gpio_free(gpio);
 }
 
 /*
@@ -1198,6 +1204,53 @@ static inline void mpuio_init(void) {}
 
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
 static struct clk * gpio_ick;
 static struct clk * gpio_fck;
@@ -1211,6 +1264,7 @@ static int __init _omap_gpio_init(void)
 {
 	int i;
 	struct gpio_bank *bank;
+	int gpio = 0;
 
 	initialized = 1;
 
@@ -1302,7 +1356,6 @@ static int __init _omap_gpio_init(void)
 		int j, gpio_count = 16;
 
 		bank = &gpio_bank[i];
-		bank->reserved_map = 0;
 		bank->base = IO_ADDRESS(bank->base);
 		spin_lock_init(&bank->lock);
 		if (bank_is_mpuio(bank))
@@ -1345,6 +1398,26 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32;
 		}
 #endif
+
+		/* REVISIT just switch from OMAP-specific gpio structs
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
 			set_irq_chip_data(j, bank);
@@ -1630,7 +1703,7 @@ static int dbg_gpio_show(struct seq_file
 		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
 			unsigned	irq, value, is_in, irqstat;
 
-			if (!(bank->reserved_map & mask))
+			if (!gpiochip_is_requested(&bank->chip, j))
 				continue;
 
 			irq = bank->virtual_irq_start + j;
@@ -1638,10 +1711,11 @@ static int dbg_gpio_show(struct seq_file
 			is_in = gpio_is_input(bank, mask);
 
 			if (bank_is_mpuio(bank))
-				seq_printf(s, "MPUIO %2d: ", j);
+				seq_printf(s, "MPUIO %2d ", j);
 			else
-				seq_printf(s, "GPIO %3d: ", gpio);
-			seq_printf(s, "%s %s",
+				seq_printf(s, "GPIO %3d ", gpio);
+			seq_printf(s, "(%10s): %s %s",
+					bank->chip.requested[j],
 					is_in ? "in " : "out",
 					value ? "hi"  : "lo");
 
@@ -1667,10 +1741,10 @@ static int dbg_gpio_show(struct seq_file
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
--- a/include/asm-arm/arch-omap/gpio.h	2007-10-29 20:46:23.000000000 -0700
+++ b/include/asm-arm/arch-omap/gpio.h	2007-10-30 00:39:20.000000000 -0700
@@ -78,62 +78,37 @@ extern int omap_get_gpio_datain(int gpio
 
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
+/* REVISIT this should be 32 for omap730, except for MPUIO ... */
+#define ARCH_GPIOS_PER_CHIP	16
 
-static inline int gpio_direction_output(unsigned gpio, int value)
-{
-	omap_set_gpio_dataout(gpio, value);
-	return __gpio_set_direction(gpio, 0);
-}
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
