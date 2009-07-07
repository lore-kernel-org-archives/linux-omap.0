From: rafiuddin.syed@ti.com
Subject: [PATCH 4/4] ARM: OMAP4: GPIO Support on OMAP4
Date: Tue,  7 Jul 2009 14:17:10 +0530
Message-ID: <1246956430-24863-4-git-send-email-rafiuddin.syed@ti.com>
References: <1246956430-24863-1-git-send-email-rafiuddin.syed@ti.com>
 <1246956430-24863-2-git-send-email-rafiuddin.syed@ti.com>
 <1246956430-24863-3-git-send-email-rafiuddin.syed@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44908 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbZGGIrd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jul 2009 04:47:33 -0400
In-Reply-To: <1246956430-24863-3-git-send-email-rafiuddin.syed@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

This patch adds GPIO support on OMAP4430 platform and adds
OMAP4 register defnitions.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/plat-omap/gpio.c |  228 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 183 insertions(+), 45 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7fd89ba..3dc2fd3 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -138,6 +138,32 @@
 #define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
 #define OMAP24XX_GPIO_SETDATAOUT	0x0094
 
+#define OMAP4_GPIO_REVISION		0x0000
+#define OMAP4_GPIO_SYSCONFIG		0x0010
+#define OMAP4_GPIO_EOI			0x0020
+#define OMAP4_GPIO_IRQSTATUSRAW0	0x0024
+#define OMAP4_GPIO_IRQSTATUSRAW1	0x0028
+#define OMAP4_GPIO_IRQSTATUS0		0x002c
+#define OMAP4_GPIO_IRQSTATUS1		0x0030
+#define OMAP4_GPIO_IRQSTATUSSET0	0x0034
+#define OMAP4_GPIO_IRQSTATUSSET1	0x0038
+#define OMAP4_GPIO_IRQSTATUSCLR0	0x003c
+#define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
+#define OMAP4_GPIO_IRQWAKEN0		0x0044
+#define OMAP4_GPIO_IRQWAKEN1		0x0048
+#define OMAP4_GPIO_SYSSTATUS		0x0104
+#define OMAP4_GPIO_CTRL			0x0130
+#define OMAP4_GPIO_OE			0x0134
+#define OMAP4_GPIO_DATAIN		0x0138
+#define OMAP4_GPIO_DATAOUT		0x013c
+#define OMAP4_GPIO_LEVELDETECT0		0x0140
+#define OMAP4_GPIO_LEVELDETECT1		0x0144
+#define OMAP4_GPIO_RISINGDETECT		0x0148
+#define OMAP4_GPIO_FALLINGDETECT	0x014c
+#define OMAP4_GPIO_DEBOUNCENABLE	0x0150
+#define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
+#define OMAP4_GPIO_CLEARDATAOUT		0x0190
+#define OMAP4_GPIO_SETDATAOUT		0x0194
 /*
  * omap34xx specific GPIO registers
  */
@@ -386,12 +412,16 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 		reg += OMAP850_GPIO_DIR_CONTROL;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
 #endif
+#if defined(CONFIG_ARCH_OMAP4)
+	case METHOD_GPIO_24XX:
+		reg += OMAP4_GPIO_OE;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 		return;
@@ -459,8 +489,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETDATAOUT;
@@ -469,6 +498,15 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 		l = 1 << gpio;
 		break;
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+	case METHOD_GPIO_24XX:
+		if (enable)
+			reg += OMAP4_GPIO_SETDATAOUT;
+		else
+			reg += OMAP4_GPIO_CLEARDATAOUT;
+		l = 1 << gpio;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 		return;
@@ -511,12 +549,16 @@ static int __omap_get_gpio_datain(int gpio)
 		reg += OMAP850_GPIO_DATA_INPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAIN;
 		break;
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+	case METHOD_GPIO_24XX:
+		reg += OMAP4_GPIO_DATAIN;
+		break;
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -593,23 +635,46 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 {
 	void __iomem *base = bank->base;
 	u32 gpio_bit = 1 << gpio;
+	u32 val;
 
-	MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
-		trigger & IRQ_TYPE_LEVEL_LOW);
-	MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
-		trigger & IRQ_TYPE_LEVEL_HIGH);
-	MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
-		trigger & IRQ_TYPE_EDGE_RISING);
-	MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
-		trigger & IRQ_TYPE_EDGE_FALLING);
-
+	if (cpu_is_omap44xx()) {
+		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_bit,
+			trigger & IRQ_TYPE_LEVEL_LOW);
+		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_bit,
+			trigger & IRQ_TYPE_LEVEL_HIGH);
+		MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_bit,
+			trigger & IRQ_TYPE_EDGE_RISING);
+		MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio_bit,
+			trigger & IRQ_TYPE_EDGE_FALLING);
+	} else {
+		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
+			trigger & IRQ_TYPE_LEVEL_LOW);
+		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
+			trigger & IRQ_TYPE_LEVEL_HIGH);
+		MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
+			trigger & IRQ_TYPE_EDGE_RISING);
+		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
+			trigger & IRQ_TYPE_EDGE_FALLING);
+	}
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		if (trigger != 0)
-			__raw_writel(1 << gpio, bank->base
+		if (cpu_is_omap44xx()) {
+			if (trigger != 0)
+				__raw_writel(1 << gpio, bank->base+
+						OMAP4_GPIO_IRQWAKEN0);
+			else {
+				val = __raw_readl(bank->base +
+							OMAP4_GPIO_IRQWAKEN0);
+				__raw_writel(val & (~(1 << gpio)), bank->base +
+							 OMAP4_GPIO_IRQWAKEN0);
+			}
+		} else {
+			if (trigger != 0)
+				__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_SETWKUENA);
-		else
-			__raw_writel(1 << gpio, bank->base
+			else
+				__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_CLEARWKUENA);
+		}
 	} else {
 		if (trigger != 0)
 			bank->enabled_non_wakeup_gpios |= gpio_bit;
@@ -617,9 +682,15 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
 
-	bank->level_mask =
-		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
-		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+	if (cpu_is_omap44xx()) {
+		bank->level_mask =
+			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0) |
+			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT1);
+	} else {
+		bank->level_mask =
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+	}
 }
 #endif
 
@@ -783,12 +854,16 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 		reg += OMAP850_GPIO_INT_STATUS;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-				defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQSTATUS1;
 		break;
 #endif
+#if defined(CONFIG_ARCH_OMAP4)
+	case METHOD_GPIO_24XX:
+		reg += OMAP4_GPIO_IRQSTATUS0;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 		return;
@@ -798,12 +873,15 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+#endif
+#if defined(CONFIG_ARCH_OMAP4)
+	reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
+#endif
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		__raw_writel(gpio_mask, reg);
 
 	/* Flush posted write for the irq status to avoid spurious interrupts */
 	__raw_readl(reg);
-#endif
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
@@ -853,13 +931,18 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		inv = 1;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-				defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
 		mask = 0xffffffff;
 		break;
 #endif
+#if defined(CONFIG_ARCH_OMAP4)
+	case METHOD_GPIO_24XX:
+		reg += OMAP4_GPIO_IRQSTATUSSET0;
+		mask = 0xffffffff;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 		return 0;
@@ -927,8 +1010,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 			l |= gpio_mask;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-		defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETIRQENABLE1;
@@ -937,6 +1019,15 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 		l = gpio_mask;
 		break;
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+	case METHOD_GPIO_24XX:
+		if (enable)
+			reg += OMAP4_GPIO_IRQSTATUSSET0;
+		else
+			reg += OMAP4_GPIO_IRQSTATUSCLR0;
+		l = gpio_mask;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 		return;
@@ -1112,11 +1203,14 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_850)
 		isr_reg = bank->base + OMAP850_GPIO_INT_STATUS;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-				defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	if (bank->method == METHOD_GPIO_24XX)
 		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
+#if defined(CONFIG_ARCH_OMAP4)
+	if (bank->method == METHOD_GPIO_24XX)
+		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
+#endif
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
@@ -1547,7 +1641,7 @@ static int __init _omap_gpio_init(void)
 
 		gpio_bank_count = OMAP34XX_NR_GPIOS;
 		gpio_bank = gpio_bank_44xx;
-		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
+		rev = __raw_readl(gpio_bank[0].base + OMAP4_GPIO_REVISION);
 		printk(KERN_INFO "OMAP44xx GPIO hardware version %d.%d\n",
 			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
@@ -1582,9 +1676,16 @@ static int __init _omap_gpio_init(void)
 				0xe203ffc0, 0x08700040
 			};
 
+		if (cpu_is_omap44xx()) {
+			__raw_writel(0xffffffff, bank->base +
+						OMAP4_GPIO_IRQSTATUSCLR0);
+			__raw_writew(0x0015, bank->base +
+						OMAP4_GPIO_SYSCONFIG);
+		} else {
 			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
 			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
 			__raw_writew(0x0015, bank->base + OMAP24XX_GPIO_SYSCONFIG);
+		}
 
 			/* Initialize interface clock ungated, module enabled */
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
@@ -1679,14 +1780,20 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-				defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
 			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
 			break;
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+		case METHOD_GPIO_24XX:
+			wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
+			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
+			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
+			break;
+#endif
 		default:
 			continue;
 		}
@@ -1721,13 +1828,18 @@ static int omap_gpio_resume(struct sys_device *dev)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
 			break;
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+		case METHOD_GPIO_24XX:
+			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
+			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
+			break;
+#endif
 		default:
 			continue;
 		}
@@ -1771,21 +1883,29 @@ void omap2_gpio_prepare_for_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-				defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		bank->saved_datain = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+		bank->saved_datain = __raw_readl(bank->base +
+							OMAP4_GPIO_DATAIN);
+		l1 = __raw_readl(bank->base + OMAP4_GPIO_FALLINGDETECT);
+		l2 = __raw_readl(bank->base + OMAP4_GPIO_RISINGDETECT);
+#endif
 		bank->saved_fallingdetect = l1;
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+		__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
+#endif
 		c++;
 	}
 	if (!c) {
@@ -1807,13 +1927,18 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->saved_risingdetect,
 				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+		__raw_writel(bank->saved_fallingdetect,
+				 bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(bank->saved_risingdetect,
+				 bank->base + OMAP4_GPIO_RISINGDETECT);
+#endif
 		/* Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
 		 * horribly racy, but it's the best we can do to work around
@@ -1826,8 +1951,7 @@ void omap2_gpio_resume_after_retention(void)
 		l &= bank->non_wakeup_gpios;
 		if (l) {
 			u32 old0, old1;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
@@ -1835,6 +1959,20 @@ void omap2_gpio_resume_after_retention(void)
 			__raw_writel(old0, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			__raw_writel(old1, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+			old0 = __raw_readl(bank->base +
+						OMAP4_GPIO_LEVELDETECT0);
+			old1 = __raw_readl(bank->base +
+						OMAP4_GPIO_LEVELDETECT1);
+			__raw_writel(old0 | l, bank->base +
+						OMAP4_GPIO_LEVELDETECT0);
+			__raw_writel(old1 | l, bank->base +
+						OMAP4_GPIO_LEVELDETECT1);
+			__raw_writel(old0, bank->base +
+						OMAP4_GPIO_LEVELDETECT0);
+			__raw_writel(old1, bank->base +
+						OMAP4_GPIO_LEVELDETECT1);
+#endif
 		}
 	}
 
-- 
1.5.4.7

