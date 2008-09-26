From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 04/16] OMAP3: GPIO context save/restore
Date: Fri, 26 Sep 2008 17:47:48 +0530
Message-ID: <01f501c91fd1$e3aab050$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbYIZMR4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:17:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds the context save restore functions for GPIO

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/gpio.c              |   93 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/gpio.h |    3 -
 2 files changed, 95 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/gpio.c	2008-09-25 16:27:09.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/gpio.c	2008-09-25 16:27:14.000000000 +0530
@@ -101,6 +101,7 @@
 #define OMAP24XX_GPIO_IRQSTATUS2	0x0028
 #define OMAP24XX_GPIO_IRQENABLE2	0x002c
 #define OMAP24XX_GPIO_IRQENABLE1	0x001c
+#define OMAP24XX_GPIO_WAKE_EN		0x0020
 #define OMAP24XX_GPIO_CTRL		0x0030
 #define OMAP24XX_GPIO_OE		0x0034
 #define OMAP24XX_GPIO_DATAIN		0x0038
@@ -218,6 +219,23 @@ static struct gpio_bank gpio_bank_34xx[6
 	{ OMAP34XX_GPIO6_BASE, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160, METHOD_GPIO_24XX },
 };
 
+struct omap3_gpio_regs {
+	u32 sysconfig;
+	u32 irqenable1;
+	u32 irqenable2;
+	u32 wake_en;
+	u32 ctrl;
+	u32 oe;
+	u32 leveldetect0;
+	u32 leveldetect1;
+	u32 risingdetect;
+	u32 fallingdetect;
+	u32 dataout;
+	u32 setwkuena;
+	u32 setdataout;
+};
+
+static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
 #endif
 
 static struct gpio_bank *gpio_bank;
@@ -1711,6 +1729,81 @@ void omap2_gpio_resume_after_retention(v
 
 #endif
 
+#ifdef CONFIG_ARCH_OMAP34XX
+/* save the registers of bank 2-6 */
+void omap3_gpio_save_context(void)
+{
+	int i;
+	/* saving banks from 2-6 only */
+	for (i = 1; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+		gpio_context[i].sysconfig =
+			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
+		gpio_context[i].irqenable1 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
+		gpio_context[i].irqenable2 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
+		gpio_context[i].wake_en =
+			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
+		gpio_context[i].ctrl =
+			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+		gpio_context[i].oe =
+			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
+		gpio_context[i].leveldetect0 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+		gpio_context[i].leveldetect1 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+		gpio_context[i].risingdetect =
+			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+		gpio_context[i].fallingdetect =
+			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		gpio_context[i].dataout =
+			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+		gpio_context[i].setwkuena =
+			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
+		gpio_context[i].setdataout =
+			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
+	}
+}
+EXPORT_SYMBOL(omap3_gpio_save_context);
+
+/* restore the required registers of bank 2-6 */
+void omap3_gpio_restore_context(void)
+{
+	int i;
+	for (i = 1; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+		__raw_writel(gpio_context[i].sysconfig,
+				bank->base + OMAP24XX_GPIO_SYSCONFIG);
+		__raw_writel(gpio_context[i].irqenable1,
+				bank->base + OMAP24XX_GPIO_IRQENABLE1);
+		__raw_writel(gpio_context[i].irqenable2,
+				bank->base + OMAP24XX_GPIO_IRQENABLE2);
+		__raw_writel(gpio_context[i].wake_en,
+				bank->base + OMAP24XX_GPIO_WAKE_EN);
+		__raw_writel(gpio_context[i].ctrl,
+				bank->base + OMAP24XX_GPIO_CTRL);
+		__raw_writel(gpio_context[i].oe,
+				bank->base + OMAP24XX_GPIO_OE);
+		__raw_writel(gpio_context[i].leveldetect0,
+				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+		__raw_writel(gpio_context[i].leveldetect1,
+				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+		__raw_writel(gpio_context[i].risingdetect,
+				bank->base + OMAP24XX_GPIO_RISINGDETECT);
+		__raw_writel(gpio_context[i].fallingdetect,
+				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		__raw_writel(gpio_context[i].dataout,
+				bank->base + OMAP24XX_GPIO_DATAOUT);
+		__raw_writel(gpio_context[i].setwkuena,
+				bank->base + OMAP24XX_GPIO_SETWKUENA);
+		__raw_writel(gpio_context[i].setdataout,
+				bank->base + OMAP24XX_GPIO_SETDATAOUT);
+	}
+}
+EXPORT_SYMBOL(omap3_gpio_restore_context);
+#endif
+
 /*
  * This may get called early from board specific init
  * for boards that have interrupts routed via FPGA.
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/gpio.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/gpio.h	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/gpio.h	2008-09-25 16:27:14.000000000 +0530
@@ -80,7 +80,8 @@ extern void omap2_gpio_prepare_for_reten
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-
+extern void omap3_gpio_save_context(void);
+extern void omap3_gpio_restore_context(void);
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure

