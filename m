From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 06/18] OMAP: GPIO: cleanup set trigger func
Date: Fri, 22 Apr 2011 16:38:20 +0530
Message-ID: <1303470512-19671-7-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38690 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1DVLEx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:53 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Cleanup GPIO set trigger and toggle edge triggering
functions by removing the cpu_is checks and the CONFIG_ARCH_*
checks .

Some part of the code access the gpio_bank structure which
is specific to the OMAP GPIO driver. Therefore such part of the
code are handled by means of gpio->method.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |   17 ++
 arch/arm/mach-omap1/gpio16xx.c         |   37 +++++
 arch/arm/mach-omap1/gpio7xx.c          |   19 +++
 arch/arm/mach-omap2/gpio.c             |   31 ++++
 arch/arm/plat-omap/gpio.c              |  264 ++++++++++++--------------------
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 6 files changed, 201 insertions(+), 168 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 26c6c25..3c64e69 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/irq.h>
 
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 #define OMAP1510_GPIO_BASE		0xFFFCE000
@@ -128,11 +129,27 @@ static int gpio_valid(int gpio)
 	return -EINVAL;
 }
 
+static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
+{
+	u32 l = gpio_read(base, INT_CTRL);
+
+	if (trigger & IRQ_TYPE_EDGE_RISING)
+		l |= 1 << gpio;
+	else if (trigger & IRQ_TYPE_EDGE_FALLING)
+		l &= ~(1 << gpio);
+	else
+		return -EINVAL;
+
+	gpio_write(l, base, INT_CTRL);
+	return 0;
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
+	.gpio_set_trigger = gpio_set_trigger,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 473c889..6b4afa2 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/irq.h>
 
 #define OMAP1610_GPIO1_BASE		0xfffbe400
 #define OMAP1610_GPIO2_BASE		0xfffbec00
@@ -30,6 +31,12 @@
 #define OMAP1610_NON_MPUIO_GPIO_VALID	((OMAP1610_GPIO_BANK_CNT - 1) *\
 						OMAP1610_GPIO_WIDTH)
 
+#define	OMAP1610_GPIO_USE_EDGE_CTRL2_REG	0x08
+#define	OMAP1610_GPIO_SET_FALLING_EDGE		0x01
+#define	OMAP1610_GPIO_SET_RISING_EDGE		0x02
+#define	OMAP1610_GPIO_BOTH_EDGE_SET		0x03
+#define	OMAP1610_GPIO_EDGE_MASK			0x07
+
 static u16 reg_map[] = {
 	[REV]			= 0x00,
 	[SYS_CFG]		= 0x10,
@@ -236,11 +243,41 @@ static int gpio_valid(int gpio)
 	return -EINVAL;
 }
 
+static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
+{
+	u32 offset;
+	u32 l = 0;
+
+	if (gpio & OMAP1610_GPIO_USE_EDGE_CTRL2_REG)
+		offset = EDGE_CTRL2;
+	else
+		offset = EDGE_CTRL1;
+
+	l = gpio_read(base, offset);
+	gpio &= OMAP1610_GPIO_EDGE_MASK;
+	l &= ~(OMAP1610_GPIO_BOTH_EDGE_SET << (gpio << 1));
+
+	if (trigger & IRQ_TYPE_EDGE_RISING)
+		l |= OMAP1610_GPIO_SET_RISING_EDGE << (gpio << 1);
+	if (trigger & IRQ_TYPE_EDGE_FALLING)
+		l |= OMAP1610_GPIO_SET_FALLING_EDGE << (gpio << 1);
+
+	if (trigger)
+		/* Enable wake-up during idle for dynamic tick */
+		gpio_write(1 << gpio, base, SETWKUENA);
+	else
+		gpio_write(1 << gpio, base, CLEARWKUENA);
+
+	gpio_write(l, base, offset);
+	return 0;
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
+	.gpio_set_trigger = gpio_set_trigger,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index a6c2397..599067d 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/irq.h>
 
 #define OMAP7XX_GPIO1_BASE		0xfffbc000
 #define OMAP7XX_GPIO2_BASE		0xfffbc800
@@ -289,11 +290,29 @@ static int gpio_valid(int gpio)
 	return -EINVAL;
 }
 
+static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
+{
+	u32 l = 0;
+
+	l = gpio_read(base, INT_CTRL);
+
+	if (trigger & IRQ_TYPE_EDGE_RISING)
+		l |= 1 << gpio;
+	else if (trigger & IRQ_TYPE_EDGE_FALLING)
+		l &= ~(1 << gpio);
+	else
+		return -EINVAL;
+
+	gpio_write(l, base, INT_CTRL);
+	return 0;
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
+	.gpio_set_trigger = gpio_set_trigger,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 7764ebe..ff3ea7b 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -117,11 +118,41 @@ static int gpio_valid(int gpio)
 	return -EINVAL;
 }
 
+static inline void modify_irq_type(void __iomem *base, u32 offset,
+		u32 bit_mask, u32 set)
+{
+	int l = gpio_read(base, offset);
+
+	if (set)
+		l |= bit_mask;
+	else
+		l &= ~bit_mask;
+
+	gpio_write(l, base, offset);
+}
+
+static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
+{
+	u32 gpio_bit = 1 << gpio;
+
+	modify_irq_type(base, LEVELDETECT0, gpio_bit,
+			trigger & IRQ_TYPE_LEVEL_LOW);
+	modify_irq_type(base, LEVELDETECT1, gpio_bit,
+			trigger & IRQ_TYPE_LEVEL_HIGH);
+	modify_irq_type(base, RISINGDETECT, gpio_bit,
+			trigger & IRQ_TYPE_EDGE_RISING);
+	modify_irq_type(base, FALLINGDETECT, gpio_bit,
+			trigger & IRQ_TYPE_EDGE_FALLING);
+
+	return 0;
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
+	.gpio_set_trigger = gpio_set_trigger,
 };
 
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 701152b..938cc4d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -323,14 +323,6 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 	return (ret & (1 << gpio_fn.get_index(gpio))) != 0;
 }
 
-#define MOD_REG_BIT(reg, bit_mask, set)	\
-do {	\
-	int l = __raw_readl(base + reg); \
-	if (set) l |= bit_mask; \
-	else l &= ~bit_mask; \
-	__raw_writel(l, base + reg); \
-} while(0)
-
 /**
  * _set_gpio_debounce - low level gpio debounce time
  * @bank: the gpio bank we're acting upon
@@ -386,131 +378,57 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	__raw_writel(val, reg);
 }
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
-						int trigger)
-{
-	void __iomem *base = bank->base;
-	u32 gpio_bit = 1 << gpio;
-	u32 val;
-
-	if (cpu_is_omap44xx()) {
-		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_LOW);
-		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_HIGH);
-		MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_RISING);
-		MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_FALLING);
-	} else {
-		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_LOW);
-		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_HIGH);
-		MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_RISING);
-		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_FALLING);
-	}
-	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		if (cpu_is_omap44xx()) {
-			if (trigger != 0)
-				__raw_writel(1 << gpio, bank->base+
-						OMAP4_GPIO_IRQWAKEN0);
-			else {
-				val = __raw_readl(bank->base +
-							OMAP4_GPIO_IRQWAKEN0);
-				__raw_writel(val & (~(1 << gpio)), bank->base +
-							 OMAP4_GPIO_IRQWAKEN0);
-			}
-		} else {
-			/*
-			 * GPIO wakeup request can only be generated on edge
-			 * transitions
-			 */
-			if (trigger & IRQ_TYPE_EDGE_BOTH)
-				__raw_writel(1 << gpio, bank->base
-					+ OMAP24XX_GPIO_SETWKUENA);
-			else
-				__raw_writel(1 << gpio, bank->base
-					+ OMAP24XX_GPIO_CLEARWKUENA);
-		}
-	}
-	/* This part needs to be executed always for OMAP34xx */
-	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
-		/*
-		 * Log the edge gpio and manually trigger the IRQ
-		 * after resume if the input level changes
-		 * to avoid irq lost during PER RET/OFF mode
-		 * Applies for omap2 non-wakeup gpio and all omap3 gpios
-		 */
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
-			bank->enabled_non_wakeup_gpios |= gpio_bit;
-		else
-			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
-	}
-
-	if (cpu_is_omap44xx()) {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT1);
-	} else {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-	}
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP1
 /*
  * This only applies to chips that can't do both rising and falling edge
  * detection at once.  For all other chips, this function is a noop.
  */
 static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 {
-	void __iomem *reg = bank->base;
+	void __iomem *base = bank->base;
 	u32 l = 0;
+	u32 offset;
 
 	switch (bank->method) {
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
-		break;
-#ifdef CONFIG_ARCH_OMAP15XX
+		offset = OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
+		l = gpio_mpuio_read(base, offset);
+
+		if ((l >> gpio) & 1)
+			l &= ~(1 << gpio);
+		else
+			l |= 1 << gpio;
+
+		gpio_mpuio_write(l, base, offset);
+		return;
+
 	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_CONTROL;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_CONTROL;
-		break;
-#endif
+		l = gpio_fn.gpio_read(base, INT_CTRL);
+
+		if ((l >> gpio) & 1)
+			l &= ~(1 << gpio);
+		else
+			l |= 1 << gpio;
+
+		gpio_fn.gpio_write(l, base, INT_CTRL);
+		return;
+
 	default:
 		return;
 	}
-
-	l = __raw_readl(reg);
-	if ((l >> gpio) & 1)
-		l &= ~(1 << gpio);
-	else
-		l |= 1 << gpio;
-
-	__raw_writel(l, reg);
 }
-#endif
 
 static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 {
-	void __iomem *reg = bank->base;
+	int ret = 0;
+	void __iomem *base = bank->base;
 	u32 l = 0;
+	u32 offset;
 
 	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
-		l = __raw_readl(reg);
+		offset = OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
+		l = gpio_mpuio_read(base, offset);
 		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
 		if (trigger & IRQ_TYPE_EDGE_RISING)
@@ -518,70 +436,80 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 		else if (trigger & IRQ_TYPE_EDGE_FALLING)
 			l &= ~(1 << gpio);
 		else
-			goto bad;
+			return -EINVAL;
+
+		gpio_mpuio_write(l, base, offset);
 		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
+
 	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_CONTROL;
-		l = __raw_readl(reg);
+	case METHOD_GPIO_7XX:
 		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 1 << gpio;
-		else if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l &= ~(1 << gpio);
-		else
-			goto bad;
+
+		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
 		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
+
 	case METHOD_GPIO_1610:
-		if (gpio & 0x08)
-			reg += OMAP1610_GPIO_EDGE_CTRL2;
-		else
-			reg += OMAP1610_GPIO_EDGE_CTRL1;
-		gpio &= 0x07;
-		l = __raw_readl(reg);
-		l &= ~(3 << (gpio << 1));
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 2 << (gpio << 1);
-		if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l |= 1 << (gpio << 1);
-		if (trigger)
-			/* Enable wake-up during idle for dynamic tick */
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_SET_WAKEUPENA);
-		else
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
+		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
 		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_CONTROL;
-		l = __raw_readl(reg);
-		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
-			bank->toggle_mask |= 1 << gpio;
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 1 << gpio;
-		else if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l &= ~(1 << gpio);
-		else
-			goto bad;
+
+	case METHOD_GPIO_44XX:
+		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
+
+		if (likely(!(bank->non_wakeup_gpios & (1 << gpio)))) {
+			if (trigger != 0)
+				gpio_fn.gpio_write(1 << gpio, base, IRQWAKEN0);
+			else {
+				u32 val;
+
+				val = gpio_fn.gpio_read(base, IRQWAKEN0);
+				gpio_fn.gpio_write(val & (~(1 << gpio)), base,
+						IRQWAKEN0);
+			}
+
+			bank->level_mask = gpio_fn.gpio_read(base,
+							LEVELDETECT0);
+			bank->level_mask |= gpio_fn.gpio_read(base,
+							LEVELDETECT1);
+		}
 		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
+
 	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
-		set_24xx_gpio_triggering(bank, gpio, trigger);
-		return 0;
-#endif
+		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
+
+		if (likely(!(bank->non_wakeup_gpios & (1 << gpio)))) {
+			/*
+			 * GPIO wakeup request can only be generated on edge
+			 * transitions
+			 */
+			if (trigger & IRQ_TYPE_EDGE_BOTH)
+				gpio_fn.gpio_write(1 << gpio, base, SETWKUENA);
+			else
+				gpio_fn.gpio_write(1 << gpio, base,
+							CLEARWKUENA);
+			/*
+			 * Log the edge gpio and manually trigger the IRQ
+			 * after resume if the input level changes
+			 * to avoid irq lost during PER RET/OFF mode
+			 * Applies for omap2 non-wakeup gpio and all omap3 gpios
+			 */
+			if (trigger & IRQ_TYPE_EDGE_BOTH)
+				bank->enabled_non_wakeup_gpios |= (1 << gpio);
+			else
+				bank->enabled_non_wakeup_gpios &= ~(1 << gpio);
+
+			bank->level_mask = gpio_fn.gpio_read(base,
+							LEVELDETECT0);
+			bank->level_mask |= gpio_fn.gpio_read(base,
+							LEVELDETECT1);
+		}
+		break;
 	default:
-		goto bad;
+		ret = -EINVAL;
+		break;
 	}
-	__raw_writel(l, reg);
-	return 0;
-bad:
-	return -EINVAL;
+
+	return ret;
 }
 
 static int gpio_irq_type(struct irq_data *d, unsigned type)
@@ -591,7 +519,9 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	int retval;
 	unsigned long flags;
 
-	if (!cpu_class_is_omap2() && d->irq > IH_MPUIO_BASE)
+	bank = irq_data_get_irq_chip_data(d);
+
+	if ((bank->method == METHOD_MPUIO) && d->irq > IH_MPUIO_BASE)
 		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
 	else
 		gpio = d->irq - IH_GPIO_BASE;
@@ -603,11 +533,10 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 
 	/* OMAP1 allows only only edge triggering */
-	if (!cpu_class_is_omap2()
+	if ((bank->method < METHOD_GPIO_24XX)
 			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
-	bank = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, gpio_fn.get_index(gpio), type);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -1065,7 +994,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			if (!(isr & 1))
 				continue;
 
-#ifdef CONFIG_ARCH_OMAP1
 			/*
 			 * Some chips can't respond to both rising and falling
 			 * at the same time.  If this irq was requested with
@@ -1075,7 +1003,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 */
 			if (bank->toggle_mask & (1 << gpio_index))
 				_toggle_gpio_edge_triggering(bank, gpio_index);
-#endif
 
 			generic_handle_irq(gpio_irq);
 		}
@@ -1540,6 +1467,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		gpio_fn.gpio_valid = pdata->gpio_fn->gpio_valid;
 		gpio_fn.gpio_read = pdata->gpio_fn->gpio_read;
 		gpio_fn.gpio_write = pdata->gpio_fn->gpio_write;
+		gpio_fn.gpio_set_trigger = pdata->gpio_fn->gpio_set_trigger;
 	}
 
 	id = pdev->id;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 745515a..b7c10bd 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -113,6 +113,7 @@ struct omap_gpio_func {
 	int (*gpio_valid)(int gpio);
 	u32 (*gpio_read)(void __iomem *base, int reg);
 	void (*gpio_write)(u32 val, void __iomem *base, int reg);
+	int (*gpio_set_trigger)(void __iomem *base, int gpio, int trigger);
 };
 
 struct omap_gpio_platform_data {
-- 
1.7.1

