From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/9] omap: Fix gpio.c for multi-omap for omap4
Date: Fri, 29 Jan 2010 18:01:38 -0800
Message-ID: <20100130020138.10590.86510.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53012 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0A3CBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 21:01:16 -0500
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Set up METHOD_GPIO_44XX instead of trying to use the METHOD_GPIO_24XX.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |  217 ++++++++++++++++++++++++++-------------------
 1 files changed, 126 insertions(+), 91 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index a888304..4395d15 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -202,6 +202,7 @@ struct gpio_bank {
 #define METHOD_GPIO_1610	2
 #define METHOD_GPIO_7XX		3
 #define METHOD_GPIO_24XX	5
+#define METHOD_GPIO_44XX	6
 
 #ifdef CONFIG_ARCH_OMAP16XX
 static struct gpio_bank gpio_bank_1610[5] = {
@@ -312,17 +313,17 @@ static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
 #ifdef CONFIG_ARCH_OMAP4
 static struct gpio_bank gpio_bank_44xx[6] = {
 	{ OMAP44XX_GPIO1_BASE, NULL, INT_44XX_GPIO_BANK1, IH_GPIO_BASE,
-		METHOD_GPIO_24XX },
+		METHOD_GPIO_44XX },
 	{ OMAP44XX_GPIO2_BASE, NULL, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32,
-		METHOD_GPIO_24XX },
+		METHOD_GPIO_44XX },
 	{ OMAP44XX_GPIO3_BASE, NULL, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64,
-		METHOD_GPIO_24XX },
+		METHOD_GPIO_44XX },
 	{ OMAP44XX_GPIO4_BASE, NULL, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96,
-		METHOD_GPIO_24XX },
+		METHOD_GPIO_44XX },
 	{ OMAP44XX_GPIO5_BASE, NULL, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128,
-		METHOD_GPIO_24XX },
+		METHOD_GPIO_44XX },
 	{ OMAP44XX_GPIO6_BASE, NULL, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160,
-		METHOD_GPIO_24XX },
+		METHOD_GPIO_44XX },
 };
 
 #endif
@@ -430,7 +431,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
-	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		reg += OMAP4_GPIO_OE;
 		break;
 #endif
@@ -501,7 +502,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP4
-	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		if (enable)
 			reg += OMAP4_GPIO_SETDATAOUT;
 		else
@@ -550,7 +551,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP4
-	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		reg += OMAP4_GPIO_DATAIN;
 		break;
 #endif
@@ -592,6 +593,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 #endif
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		reg += OMAP24XX_GPIO_DATAOUT;
 		break;
 #endif
@@ -622,11 +624,12 @@ void omap_set_gpio_debounce(int gpio, int enable)
 
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
-#ifdef CONFIG_ARCH_OMAP4
-	reg += OMAP4_GPIO_DEBOUNCENABLE;
-#else
-	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
-#endif
+
+	if (cpu_is_omap44xx())
+		reg += OMAP4_GPIO_DEBOUNCENABLE;
+	else
+		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
+
 	if (!(bank->mod_usage & l)) {
 		printk(KERN_ERR "GPIO %d not requested\n", gpio);
 		return;
@@ -672,11 +675,12 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 	}
 
 	enc_time &= 0xff;
-#ifdef CONFIG_ARCH_OMAP4
-	reg += OMAP4_GPIO_DEBOUNCINGTIME;
-#else
-	reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
-#endif
+
+	if (cpu_is_omap44xx())
+		reg += OMAP4_GPIO_DEBOUNCINGTIME;
+	else
+		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
+
 	__raw_writel(enc_time, reg);
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
@@ -854,6 +858,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 #endif
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
 		break;
 #endif
@@ -938,7 +943,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
-	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		reg += OMAP4_GPIO_IRQSTATUS0;
 		break;
 #endif
@@ -949,12 +954,11 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	__raw_writel(gpio_mask, reg);
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
-#endif
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
+	else if (cpu_is_omap44xx())
+		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
+
 	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		__raw_writel(gpio_mask, reg);
 
@@ -1010,7 +1014,7 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
-	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		reg += OMAP4_GPIO_IRQSTATUSSET0;
 		mask = 0xffffffff;
 		break;
@@ -1082,7 +1086,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP4
-	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		if (enable)
 			reg += OMAP4_GPIO_IRQSTATUSSET0;
 		else
@@ -1128,6 +1132,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 #endif
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
 					"non-wakeup GPIO%d\n",
@@ -1222,7 +1227,8 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP2PLUS
-	if (bank->method == METHOD_GPIO_24XX) {
+	if ((bank->method == METHOD_GPIO_24XX) ||
+			(bank->method == METHOD_GPIO_44XX)) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 		__raw_writel(1 << offset, reg);
@@ -1284,7 +1290,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
-	if (bank->method == METHOD_GPIO_24XX)
+	if (bank->method == METHOD_GPIO_44XX)
 		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
 #endif
 	while(1) {
@@ -1564,6 +1570,7 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 		reg += OMAP7XX_GPIO_DIR_CONTROL;
 		break;
 	case METHOD_GPIO_24XX:
+	case METHOD_GPIO_44XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
 	}
@@ -1803,28 +1810,34 @@ static int __init _omap_gpio_init(void)
 		}
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
-		if (bank->method == METHOD_GPIO_24XX) {
+		if ((bank->method == METHOD_GPIO_24XX) ||
+				(bank->method == METHOD_GPIO_44XX)) {
 			static const u32 non_wakeup_gpios[] = {
 				0xe203ffc0, 0x08700040
 			};
-		if (cpu_is_omap44xx()) {
-			__raw_writel(0xffffffff, bank->base +
+
+			if (cpu_is_omap44xx()) {
+				__raw_writel(0xffffffff, bank->base +
 						OMAP4_GPIO_IRQSTATUSCLR0);
-			__raw_writew(0x0015, bank->base +
+				__raw_writew(0x0015, bank->base +
 						OMAP4_GPIO_SYSCONFIG);
-			__raw_writel(0x00000000, bank->base +
+				__raw_writel(0x00000000, bank->base +
 						 OMAP4_GPIO_DEBOUNCENABLE);
-			/* Initialize interface clock ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
-		} else {
-			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
-			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
-			__raw_writew(0x0015, bank->base + OMAP24XX_GPIO_SYSCONFIG);
-			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_DEBOUNCE_EN);
-
-			/* Initialize interface clock ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
-		}
+				/* Initialize interface clock ungated, module enabled */
+				__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
+			} else {
+				__raw_writel(0x00000000, bank->base +
+						OMAP24XX_GPIO_IRQENABLE1);
+				__raw_writel(0xffffffff, bank->base +
+						OMAP24XX_GPIO_IRQSTATUS1);
+				__raw_writew(0x0015, bank->base +
+						OMAP24XX_GPIO_SYSCONFIG);
+				__raw_writel(0x00000000, bank->base +
+						OMAP24XX_GPIO_DEBOUNCE_EN);
+
+				/* Initialize interface clock ungated, module enabled */
+				__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
+			}
 			if (i < ARRAY_SIZE(non_wakeup_gpios))
 				bank->non_wakeup_gpios = non_wakeup_gpios[i];
 			gpio_count = 32;
@@ -1926,7 +1939,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 			break;
 #endif
 #ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_24XX:
+		case METHOD_GPIO_44XX:
 			wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
 			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
 			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
@@ -1973,7 +1986,7 @@ static int omap_gpio_resume(struct sys_device *dev)
 			break;
 #endif
 #ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_24XX:
+		case METHOD_GPIO_44XX:
 			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
 			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
 			break;
@@ -2020,29 +2033,42 @@ void omap2_gpio_prepare_for_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		bank->saved_datain = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
-		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		bank->saved_datain = __raw_readl(bank->base +
-							OMAP4_GPIO_DATAIN);
-		l1 = __raw_readl(bank->base + OMAP4_GPIO_FALLINGDETECT);
-		l2 = __raw_readl(bank->base + OMAP4_GPIO_RISINGDETECT);
-#endif
+
+		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			bank->saved_datain = __raw_readl(bank->base +
+					OMAP24XX_GPIO_DATAIN);
+			l1 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_FALLINGDETECT);
+			l2 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_RISINGDETECT);
+		}
+
+		if (cpu_is_omap44xx()) {
+			bank->saved_datain = __raw_readl(bank->base +
+						OMAP4_GPIO_DATAIN);
+			l1 = __raw_readl(bank->base +
+						OMAP4_GPIO_FALLINGDETECT);
+			l2 = __raw_readl(bank->base +
+						OMAP4_GPIO_RISINGDETECT);
+		}
+
 		bank->saved_fallingdetect = l1;
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
-		__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
-#endif
+
+		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			__raw_writel(l1, bank->base +
+					OMAP24XX_GPIO_FALLINGDETECT);
+			__raw_writel(l2, bank->base +
+					OMAP24XX_GPIO_RISINGDETECT);
+		}
+
+		if (cpu_is_omap44xx()) {
+			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
+			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
+		}
+
 		c++;
 	}
 	if (!c) {
@@ -2064,20 +2090,23 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		__raw_writel(bank->saved_fallingdetect,
+
+		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(bank->saved_risingdetect,
+			__raw_writel(bank->saved_risingdetect,
 				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		__raw_writel(bank->saved_fallingdetect,
+			l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
+		}
+
+		if (cpu_is_omap44xx()) {
+			__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP4_GPIO_FALLINGDETECT);
-		__raw_writel(bank->saved_risingdetect,
+			__raw_writel(bank->saved_risingdetect,
 				 bank->base + OMAP4_GPIO_RISINGDETECT);
-		l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
-#endif
+			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
+		}
+
 		/* Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
 		 * horribly racy, but it's the best we can do to work around
@@ -2103,30 +2132,36 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (gen) {
 			u32 old0, old1;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+
+			if (cpu_is_omap24xx() || cpu_is_omap44xx()) {
+				old0 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+				old1 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
 			__raw_writel(old1 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-			old0 = __raw_readl(bank->base +
+			__raw_writel(old0, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_writel(old1, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
+			}
+
+			if (cpu_is_omap44xx()) {
+				old0 = __raw_readl(bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
-			old1 = __raw_readl(bank->base +
+				old1 = __raw_readl(bank->base +
 						OMAP4_GPIO_LEVELDETECT1);
-			__raw_writel(old0 | l, bank->base +
+				__raw_writel(old0 | l, bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
-			__raw_writel(old1 | l, bank->base +
+				__raw_writel(old1 | l, bank->base +
 						OMAP4_GPIO_LEVELDETECT1);
-			__raw_writel(old0, bank->base +
+				__raw_writel(old0, bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
-			__raw_writel(old1, bank->base +
+				__raw_writel(old1, bank->base +
 						OMAP4_GPIO_LEVELDETECT1);
-#endif
+			}
 		}
 	}
 

