From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH][RFC] OMAP4: GPIO Support for OMAP_4430SDP
Date: Sat, 23 May 2009 17:41:54 +0530 (IST)
Message-ID: <45444.192.168.10.89.1243080714.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54401 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbZEWML6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 May 2009 08:11:58 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4NCBsBD009244
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 07:11:59 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4NCBqLT001148
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 07:11:53 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch updates register and offset address with respect to OMAP4.

Signed-off-by: <rafiuddin.syed@ti.com>
---
 arch/arm/plat-omap/gpio.c |  133 +++++++++++++++++++++++++++++++++++-----------
 1 files changed, 102 insertions(+), 31 deletions(-)

Index: linux-2.6/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/gpio.c	2009-05-18 14:24:54.000000000 +0530
+++ linux-2.6/arch/arm/plat-omap/gpio.c	2009-05-18 15:36:35.000000000 +0530
@@ -113,30 +113,70 @@
 #define OMAP243X_GPIO4_BASE		IO_ADDRESS(0x49012000)
 #define OMAP243X_GPIO5_BASE		IO_ADDRESS(0x480B6000)

+
 #define OMAP24XX_GPIO_REVISION		0x0000
 #define OMAP24XX_GPIO_SYSCONFIG		0x0010
-#define OMAP24XX_GPIO_SYSSTATUS		0x0014
-#define OMAP24XX_GPIO_IRQSTATUS1	0x0018
-#define OMAP24XX_GPIO_IRQSTATUS2	0x0028
-#define OMAP24XX_GPIO_IRQENABLE2	0x002c
-#define OMAP24XX_GPIO_IRQENABLE1	0x001c
-#define OMAP24XX_GPIO_WAKE_EN		0x0020
-#define OMAP24XX_GPIO_CTRL		0x0030
-#define OMAP24XX_GPIO_OE		0x0034
-#define OMAP24XX_GPIO_DATAIN		0x0038
-#define OMAP24XX_GPIO_DATAOUT		0x003c
-#define OMAP24XX_GPIO_LEVELDETECT0	0x0040
-#define OMAP24XX_GPIO_LEVELDETECT1	0x0044
-#define OMAP24XX_GPIO_RISINGDETECT	0x0048
-#define OMAP24XX_GPIO_FALLINGDETECT	0x004c
-#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0050
-#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0054
-#define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0060
-#define OMAP24XX_GPIO_SETIRQENABLE1	0x0064
-#define OMAP24XX_GPIO_CLEARWKUENA	0x0080
-#define OMAP24XX_GPIO_SETWKUENA		0x0084
-#define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
-#define OMAP24XX_GPIO_SETDATAOUT	0x0094
+
+
+#ifdef CONFIG_ARCH_OMAP4
+#define OMAP24XX_GPIO_SYSSTATUS		0x0114
+#define OMAP24XX_GPIO_IRQSTATUS1	0x0118
+#define OMAP24XX_GPIO_IRQSTATUS2	0x0128
+#define OMAP24XX_GPIO_IRQENABLE2	0x012c
+#define OMAP24XX_GPIO_IRQENABLE1	0x011c
+#define OMAP24XX_GPIO_WAKE_EN		0x0120
+#define OMAP24XX_GPIO_CTRL		0x0130
+#define OMAP24XX_GPIO_OE		0x0134
+#define OMAP24XX_GPIO_DATAIN		0x0138
+#define OMAP24XX_GPIO_DATAOUT		0x013c
+#define OMAP24XX_GPIO_LEVELDETECT0	0x0140
+#define OMAP24XX_GPIO_LEVELDETECT1	0x0144
+#define OMAP24XX_GPIO_RISINGDETECT	0x0148
+#define OMAP24XX_GPIO_FALLINGDETECT	0x014c
+#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0150
+#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0154
+#define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0160
+#define OMAP24XX_GPIO_SETIRQENABLE1	0x0164
+#define OMAP24XX_GPIO_CLEARWKUENA	0x0180
+#define OMAP24XX_GPIO_SETWKUENA		0x0184
+#define OMAP24XX_GPIO_CLEARDATAOUT	0x0190
+#define OMAP24XX_GPIO_SETDATAOUT	0x0194
+#define OMAP24XX_GPIO_STATUS_RAW_0	0x0024
+#define OMAP24XX_GPIO_STATUS_RAW_1	0x0028
+#define OMAP24XX_GPIO_IRQ_STATUS_0	0x002C
+#define OMAP24XX_GPIO_IRQ_STATUS_1	0x0030
+#define OMAP24XX_GPIO_IRQ_STATUS_SET_0	0x0034
+#define OMAP24XX_GPIO_IRQ_STATUS_SET_1	0x0038
+#define OMAP24XX_GPIO_IRQ_STATUS_CLR_0	0x003C
+#define OMAP24XX_GPIO_IRQ_STATUS_CLR_1	0x0040
+#define OMAP24XX_GPIO_IRQ_WAKE_ENABLE_0	0x0044
+#define OMAP24XX_GPIO_IRQ_WAKE_ENABLE_1	0x0048
+
+#else
+#define OMAP24XX_GPIO_SYSSTATUS         0x0014
+#define OMAP24XX_GPIO_IRQSTATUS1        0x0018
+#define OMAP24XX_GPIO_IRQSTATUS2        0x0028
+#define OMAP24XX_GPIO_IRQENABLE2        0x002c
+#define OMAP24XX_GPIO_IRQENABLE1        0x001c
+#define OMAP24XX_GPIO_WAKE_EN           0x0020
+#define OMAP24XX_GPIO_CTRL              0x0030
+#define OMAP24XX_GPIO_OE                0x0034
+#define OMAP24XX_GPIO_DATAIN            0x0038
+#define OMAP24XX_GPIO_DATAOUT           0x003c
+#define OMAP24XX_GPIO_LEVELDETECT0      0x0040
+#define OMAP24XX_GPIO_LEVELDETECT1      0x0044
+#define OMAP24XX_GPIO_RISINGDETECT      0x0048
+#define OMAP24XX_GPIO_FALLINGDETECT     0x004c
+#define OMAP24XX_GPIO_DEBOUNCE_EN       0x0050
+#define OMAP24XX_GPIO_DEBOUNCE_VAL      0x0054
+#define OMAP24XX_GPIO_CLEARIRQENABLE1   0x0060
+#define OMAP24XX_GPIO_SETIRQENABLE1     0x0064
+#define OMAP24XX_GPIO_CLEARWKUENA       0x0080
+#define OMAP24XX_GPIO_SETWKUENA         0x0084
+#define OMAP24XX_GPIO_CLEARDATAOUT      0x0090
+#define OMAP24XX_GPIO_SETDATAOUT        0x0094
+
+#endif

 /*
  * omap34xx specific GPIO registers
@@ -783,12 +823,16 @@
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
+		reg += OMAP24XX_GPIO_IRQ_STATUS_0;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 		return;
@@ -804,6 +848,15 @@
 	/* Flush posted write for the irq status to avoid spurious interrupts */
 	__raw_readl(reg);
 #endif
+
+#if defined(CONFIG_ARCH_OMAP4)
+	reg = bank->base + OMAP24XX_GPIO_IRQ_STATUS_1;
+	if (cpu_is_omap44xx())
+		__raw_writel(gpio_mask, reg);
+
+	/* Flush posted write for the irq status to avoid spurious interrupts */
+	__raw_readl(reg);
+#endif
 }

 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
@@ -853,13 +906,18 @@
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
+		reg += OMAP24XX_GPIO_IRQ_STATUS_SET_0;
+		mask = 0xffffffff;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 		return 0;
@@ -1112,11 +1170,15 @@
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
+		isr_reg = bank->base + OMAP24XX_GPIO_IRQ_STATUS_0;
+#endif
+
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
@@ -1582,9 +1644,18 @@
 				0xe203ffc0, 0x08700040
 			};

-			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
-			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
-			__raw_writew(0x0015, bank->base + OMAP24XX_GPIO_SYSCONFIG);
+#if defined(CONFIG_ARCH_OMAP4)
+		__raw_writel(0x00000000, bank->base +
+					OMAP24XX_GPIO_IRQ_STATUS_CLR_0);
+		__raw_writel(0xffffffff, bank->base +
+					OMAP24XX_GPIO_IRQ_STATUS_0);
+#else
+		__raw_writel(0x00000000, bank->base +
+					MAP24XX_GPIO_IRQENABLE1);
+		__raw_writel(0xffffffff, bank->base +
+					OMAP24XX_GPIO_IRQSTATUS1);
+#endif
+		__raw_writew(0x0015, bank->base + OMAP24XX_GPIO_SYSCONFIG);

 			/* Initialize interface clock ungated, module enabled */
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);


---
Syed Rafiuddin


