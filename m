From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/10] omap: GPIO: Fix OMAP4 GPIO reg access issues
Date: Fri, 14 May 2010 14:28:10 -0700
Message-ID: <20100514212810.25599.99703.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56666 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757394Ab0ENV2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:28:10 -0400
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>

From: Tony Lindgren <charu@ti.com>

Access to some of the OMAP4 GPIO registers are not properly handled.
This patch fixes it.

This patch is tested on 3430SDP and 4430SDP boards

Signed-off-by: Charulatha V <charu@ti.com>
cc: Kevin Hilman <khilman@deeprootsystems.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |   59 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 955597f..dc2ac42 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -138,7 +138,11 @@
 #define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
 #define OMAP4_GPIO_IRQWAKEN0		0x0044
 #define OMAP4_GPIO_IRQWAKEN1		0x0048
-#define OMAP4_GPIO_SYSSTATUS		0x0104
+#define OMAP4_GPIO_SYSSTATUS		0x0114
+#define OMAP4_GPIO_IRQENABLE1		0x011c
+#define OMAP4_GPIO_WAKE_EN		0x0120
+#define OMAP4_GPIO_IRQSTATUS2		0x0128
+#define OMAP4_GPIO_IRQENABLE2		0x012c
 #define OMAP4_GPIO_CTRL			0x0130
 #define OMAP4_GPIO_OE			0x0134
 #define OMAP4_GPIO_DATAIN		0x0138
@@ -149,6 +153,10 @@
 #define OMAP4_GPIO_FALLINGDETECT	0x014c
 #define OMAP4_GPIO_DEBOUNCENABLE	0x0150
 #define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
+#define OMAP4_GPIO_CLEARIRQENABLE1	0x0160
+#define OMAP4_GPIO_SETIRQENABLE1	0x0164
+#define OMAP4_GPIO_CLEARWKUENA		0x0180
+#define OMAP4_GPIO_SETWKUENA		0x0184
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
 /*
@@ -591,12 +599,16 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		reg += OMAP7XX_GPIO_DATA_OUTPUT;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
 		reg += OMAP24XX_GPIO_DATAOUT;
 		break;
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+	case METHOD_GPIO_44XX:
+		reg += OMAP4_GPIO_DATAOUT;
+		break;
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -1213,11 +1225,17 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 #endif
 	if (!cpu_class_is_omap1()) {
 		if (!bank->mod_usage) {
+			void __iomem *reg = bank->base;
 			u32 ctrl;
-			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
-			ctrl &= 0xFFFFFFFE;
+
+			if (cpu_is_omap24xx() || cpu_is_omap34xx())
+				reg += OMAP24XX_GPIO_CTRL;
+			else if (cpu_is_omap44xx())
+				reg += OMAP4_GPIO_CTRL;
+			ctrl = __raw_readl(reg);
 			/* Module is enabled, clocks are not gated */
-			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+			ctrl &= 0xFFFFFFFE;
+			__raw_writel(ctrl, reg);
 		}
 		bank->mod_usage |= 1 << offset;
 	}
@@ -1239,22 +1257,34 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if ((bank->method == METHOD_GPIO_24XX) ||
-			(bank->method == METHOD_GPIO_44XX)) {
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+	if (bank->method == METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 		__raw_writel(1 << offset, reg);
 	}
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+	if (bank->method == METHOD_GPIO_44XX) {
+		/* Disable wake-up during idle for dynamic tick */
+		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		__raw_writel(1 << offset, reg);
+	}
+#endif
 	if (!cpu_class_is_omap1()) {
 		bank->mod_usage &= ~(1 << offset);
 		if (!bank->mod_usage) {
+			void __iomem *reg = bank->base;
 			u32 ctrl;
-			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+
+			if (cpu_is_omap24xx() || cpu_is_omap34xx())
+				reg += OMAP24XX_GPIO_CTRL;
+			else if (cpu_is_omap44xx())
+				reg += OMAP4_GPIO_CTRL;
+			ctrl = __raw_readl(reg);
 			/* Module is disabled, clocks are gated */
 			ctrl |= 1;
-			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+			__raw_writel(ctrl, reg);
 		}
 	}
 	_reset_gpio(bank, bank->chip.base + offset);
@@ -1583,9 +1613,14 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 		reg += OMAP7XX_GPIO_DIR_CONTROL;
 		break;
 	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
+	case METHOD_GPIO_44XX:
+		reg += OMAP4_GPIO_OE;
+		break;
+	default:
+		WARN_ONCE(1, "gpio_is_input: incorrect OMAP GPIO method");
+		return -EINVAL;
 	}
 	return __raw_readl(reg) & mask;
 }

