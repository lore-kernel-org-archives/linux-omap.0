From: "Andrzej Zaborowski" <balrog@zabor.org>
Subject: [PATCH] ARM: OMAP: Ensure correct GPIO registers access width.
Date: Sun, 26 Nov 2006 21:32:00 +0100
Message-ID: <11645731203663-git-send-email-balrog@zabor.org>
Reply-To: balrogg@gmail.com
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

[Note that this probably gives no gain of any kind.  I don't know
if it should be applied.]

Use 16-bit or 32-bit reads and writes to access GPIO registers in
different banks according to their widths.  Currently all accesses
in gpio.c were 32-bits.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
---
 arch/arm/plat-omap/gpio.c |   96 ++++++++++++++++++++++++++++----------------
 1 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 80bde10..8a013f2 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -146,6 +146,14 @@ #define METHOD_GPIO_1610	2
 #define METHOD_GPIO_730		3
 #define METHOD_GPIO_24XX	4
 
+static const unsigned int gpio_reg_width[] = {
+	[METHOD_MPUIO]		= 16,
+	[METHOD_GPIO_1510]	= 16,
+	[METHOD_GPIO_1610]	= 16,
+	[METHOD_GPIO_730]	= 32,
+	[METHOD_GPIO_24XX]	= 32,
+};
+
 #ifdef CONFIG_ARCH_OMAP16XX
 static struct gpio_bank gpio_bank_1610[5] = {
 	{ OMAP_MPUIO_BASE,     INT_MPUIO,	    IH_MPUIO_BASE,     METHOD_MPUIO},
@@ -314,12 +322,18 @@ #endif
 		WARN_ON(1);
 		return;
 	}
-	l = __raw_readl(reg);
+	if (gpio_reg_width[bank->method] == 32)
+		l = __raw_readl(reg);
+	else
+		l = __raw_readw(reg);
 	if (is_input)
 		l |= 1 << gpio;
 	else
 		l &= ~(1 << gpio);
-	__raw_writel(l, reg);
+	if (gpio_reg_width[bank->method] == 32)
+		__raw_writel(l, reg);
+	else
+		__raw_writew(l, reg);
 }
 
 void omap_set_gpio_direction(int gpio, int is_input)
@@ -343,7 +357,7 @@ static void _set_gpio_dataout(struct gpi
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_OUTPUT;
-		l = __raw_readl(reg);
+		l = __raw_readw(reg);
 		if (enable)
 			l |= 1 << gpio;
 		else
@@ -353,7 +367,7 @@ #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_DATA_OUTPUT;
-		l = __raw_readl(reg);
+		l = __raw_readw(reg);
 		if (enable)
 			l |= 1 << gpio;
 		else
@@ -392,7 +406,10 @@ #endif
 		WARN_ON(1);
 		return;
 	}
-	__raw_writel(l, reg);
+	if (gpio_reg_width[bank->method] == 32)
+		__raw_writel(l, reg);
+	else
+		__raw_writew(l, reg);
 }
 
 void omap_set_gpio_dataout(int gpio, int enable)
@@ -445,8 +462,10 @@ #endif
 	default:
 		return -EINVAL;
 	}
-	return (__raw_readl(reg)
-			& (1 << get_gpio_index(gpio))) != 0;
+	if (gpio_reg_width[bank->method] == 32)
+		return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
+	else
+		return (__raw_readw(reg) & (1 << get_gpio_index(gpio))) != 0;
 }
 
 #define MOD_REG_BIT(reg, bit_mask, set)	\
@@ -496,7 +515,7 @@ static int _set_gpio_triggering(struct g
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_INT_EDGE;
-		l = __raw_readl(reg);
+		l = __raw_readw(reg);
 		if (trigger & __IRQT_RISEDGE)
 			l |= 1 << gpio;
 		else if (trigger & __IRQT_FALEDGE)
@@ -508,7 +527,7 @@ #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_CONTROL;
-		l = __raw_readl(reg);
+		l = __raw_readw(reg);
 		if (trigger & __IRQT_RISEDGE)
 			l |= 1 << gpio;
 		else if (trigger & __IRQT_FALEDGE)
@@ -524,7 +543,7 @@ #ifdef CONFIG_ARCH_OMAP16XX
 		else
 			reg += OMAP1610_GPIO_EDGE_CTRL1;
 		gpio &= 0x07;
-		l = __raw_readl(reg);
+		l = __raw_readw(reg);
 		l &= ~(3 << (gpio << 1));
 		if (trigger & __IRQT_RISEDGE)
 			l |= 2 << (gpio << 1);
@@ -532,9 +551,9 @@ #ifdef CONFIG_ARCH_OMAP16XX
 			l |= 1 << (gpio << 1);
 		if (trigger)
 			/* Enable wake-up during idle for dynamic tick */
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_SET_WAKEUPENA);
+			__raw_writew(1 << gpio, bank->base + OMAP1610_GPIO_SET_WAKEUPENA);
 		else
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
+			__raw_writew(1 << gpio, bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP730
@@ -557,7 +576,10 @@ #endif
 	default:
 		goto bad;
 	}
-	__raw_writel(l, reg);
+	if (gpio_reg_width[bank->method] == 32)
+		__raw_writel(l, reg);
+	else
+		__raw_writew(l, reg);
 	return 0;
 bad:
 	return -EINVAL;
@@ -631,7 +653,10 @@ #endif
 		WARN_ON(1);
 		return;
 	}
-	__raw_writel(gpio_mask, reg);
+	if (gpio_reg_width[bank->method] == 32)
+		__raw_writel(gpio_mask, reg);
+	else
+		__raw_writew(gpio_mask, reg);
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
 	if (cpu_is_omap2420())
@@ -648,40 +673,34 @@ static u32 _get_gpio_irqbank_mask(struct
 	void __iomem *reg = bank->base;
 	int inv = 0;
 	u32 l;
-	u32 mask;
 
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_MASKIT;
-		mask = 0xffff;
 		inv = 1;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_MASK;
-		mask = 0xffff;
 		inv = 1;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_IRQENABLE1;
-		mask = 0xffff;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP730
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_MASK;
-		mask = 0xffffffff;
 		inv = 1;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
-		mask = 0xffffffff;
 		break;
 #endif
 	default:
@@ -689,10 +708,11 @@ #endif
 		return 0;
 	}
 
-	l = __raw_readl(reg);
+	l = (gpio_reg_width[bank->method] == 32) ?
+		__raw_readl(reg) : __raw_readw(reg);
 	if (inv)
 		l = ~l;
-	l &= mask;
+	l &= (gpio_reg_width[bank->method] == 32) ? 0xffffffff : 0xffff;
 	return l;
 }
 
@@ -705,7 +725,7 @@ static void _enable_gpio_irqbank(struct
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_MASKIT;
-		l = __raw_readl(reg);
+		l = __raw_readw(reg);
 		if (enable)
 			l &= ~(gpio_mask);
 		else
@@ -715,7 +735,7 @@ #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_MASK;
-		l = __raw_readl(reg);
+		l = __raw_readw(reg);
 		if (enable)
 			l &= ~(gpio_mask);
 		else
@@ -754,7 +774,10 @@ #endif
 		WARN_ON(1);
 		return;
 	}
-	__raw_writel(l, reg);
+	if (gpio_reg_width[bank->method] == 32)
+		__raw_writel(l, reg);
+	else
+		__raw_writew(l, reg);
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
@@ -858,7 +881,7 @@ #ifdef CONFIG_ARCH_OMAP15XX
 
 		/* Claim the pin for MPU */
 		reg = bank->base + OMAP1510_GPIO_PIN_CONTROL;
-		__raw_writel(__raw_readl(reg) | (1 << get_gpio_index(gpio)), reg);
+		__raw_writew(__raw_readw(reg) | (1 << get_gpio_index(gpio)), reg);
 	}
 #endif
 	spin_unlock(&bank->lock);
@@ -884,7 +907,7 @@ #ifdef CONFIG_ARCH_OMAP16XX
 	if (bank->method == METHOD_GPIO_1610) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-		__raw_writel(1 << get_gpio_index(gpio), reg);
+		__raw_writew(1 << get_gpio_index(gpio), reg);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP24XX
@@ -945,10 +968,10 @@ #endif
 		u32 enabled;
 
 		enabled = _get_gpio_irqbank_mask(bank);
-		isr_saved = isr = __raw_readl(isr_reg) & enabled;
-
-		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
-			isr &= 0x0000ffff;
+		if (gpio_reg_width[bank->method] == 32)
+			isr_saved = isr = __raw_readl(isr_reg) & enabled;
+		else
+			isr_saved = isr = __raw_readw(isr_reg) & enabled;
 
 		if (cpu_is_omap24xx()) {
 			level_mask =
@@ -1535,7 +1558,10 @@ static int gpio_is_input(struct gpio_ban
 		reg += OMAP24XX_GPIO_OE;
 		break;
 	}
-	return __raw_readl(reg) & mask;
+	if (gpio_reg_width[bank->method] == 32)
+		return __raw_readl(reg) & mask;
+	else
+		return __raw_readw(reg) & mask;
 }
 
 
@@ -1545,13 +1571,13 @@ static int dbg_gpio_show(struct seq_file
 
 	for (i = 0, gpio = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank	*bank = gpio_bank + i;
-		unsigned		bankwidth = 16;
+		unsigned		bankwidth;
 		u32			mask = 1;
 
 		if (bank_is_mpuio(bank))
 			gpio = OMAP_MPUIO(0);
-		else if (cpu_is_omap24xx() || cpu_is_omap730())
-			bankwidth = 32;
+
+		bankwidth = gpio_reg_width[bank->method];
 
 		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
 			unsigned	irq, value, is_in, irqstat;
-- 
1.4.3.2
