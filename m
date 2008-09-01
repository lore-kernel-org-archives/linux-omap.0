From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/12] GPIO context save/restore
Date: Mon, 1 Sep 2008 19:07:58 +0530 (IST)
Message-ID: <59641.192.168.10.89.1220276278.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46896 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbYIANiE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 09:38:04 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81DbxrI028003
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:38:04 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m81DbvCV003056
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:37:58 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the context save restore functions for GPIO

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/gpio.c              |   77 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/gpio.h |   19 +++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/gpio.c	2008-09-01 18:11:28.000000000
+0530
+++ linux-omap-2.6/arch/arm/plat-omap/gpio.c	2008-09-01 18:11:51.000000000 +0530
@@ -102,6 +102,7 @@
 #define OMAP24XX_GPIO_IRQSTATUS2	0x0028
 #define OMAP24XX_GPIO_IRQENABLE2	0x002c
 #define OMAP24XX_GPIO_IRQENABLE1	0x001c
+#define OMAP24XX_GPIO_WAKE_EN		0x0020
 #define OMAP24XX_GPIO_CTRL		0x0030
 #define OMAP24XX_GPIO_OE		0x0034
 #define OMAP24XX_GPIO_DATAIN		0x0038
@@ -1708,6 +1709,82 @@ void omap2_gpio_resume_after_retention(v

 #endif

+#ifdef CONFIG_ARCH_OMAP34XX
+static struct omap3_gpio_regs gpio_restore_banks[6];
+/* save the registers of bank 2-6 */
+void omap3_gpio_save(void)
+{
+	int i;
+	/* saving banks from 2-6 only */
+	for (i = 1; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+		gpio_restore_banks[i].gpio_sysconfig =
+			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
+		gpio_restore_banks[i].gpio_irqenable1 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
+		gpio_restore_banks[i].gpio_irqenable2 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
+		gpio_restore_banks[i].gpio_wake_en =
+			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
+		gpio_restore_banks[i].gpio_ctrl =
+			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+		gpio_restore_banks[i].gpio_oe =
+			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
+		gpio_restore_banks[i].gpio_leveldetect0 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+		gpio_restore_banks[i].gpio_leveldetect1 =
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+		gpio_restore_banks[i].gpio_risingdetect =
+			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+		gpio_restore_banks[i].gpio_fallingdetect =
+			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		gpio_restore_banks[i].gpio_dataout =
+			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+		gpio_restore_banks[i].gpio_setwkuena =
+			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
+		gpio_restore_banks[i].gpio_setdataout =
+			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
+	}
+}
+EXPORT_SYMBOL(omap3_gpio_save);
+
+/* restore the required registers of bank 2-6 */
+void omap3_gpio_restore(void)
+{
+	int i;
+	for (i = 1; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+		__raw_writel(gpio_restore_banks[i].gpio_sysconfig,
+				bank->base + OMAP24XX_GPIO_SYSCONFIG);
+		__raw_writel(gpio_restore_banks[i].gpio_irqenable1,
+				bank->base + OMAP24XX_GPIO_IRQENABLE1);
+		__raw_writel(gpio_restore_banks[i].gpio_irqenable2,
+				bank->base + OMAP24XX_GPIO_IRQENABLE2);
+		__raw_writel(gpio_restore_banks[i].gpio_wake_en,
+				bank->base + OMAP24XX_GPIO_WAKE_EN);
+		__raw_writel(gpio_restore_banks[i].gpio_ctrl,
+				bank->base + OMAP24XX_GPIO_CTRL);
+		__raw_writel(gpio_restore_banks[i].gpio_oe,
+				bank->base + OMAP24XX_GPIO_OE);
+		__raw_writel(gpio_restore_banks[i].gpio_leveldetect0,
+				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+		__raw_writel(gpio_restore_banks[i].gpio_leveldetect1,
+				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+		__raw_writel(gpio_restore_banks[i].gpio_risingdetect,
+				bank->base + OMAP24XX_GPIO_RISINGDETECT);
+		__raw_writel(gpio_restore_banks[i].gpio_fallingdetect,
+				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		__raw_writel(gpio_restore_banks[i].gpio_dataout,
+				bank->base + OMAP24XX_GPIO_DATAOUT);
+		__raw_writel(gpio_restore_banks[i].gpio_setwkuena,
+				bank->base + OMAP24XX_GPIO_SETWKUENA);
+		__raw_writel(gpio_restore_banks[i].gpio_setdataout,
+				bank->base + OMAP24XX_GPIO_SETDATAOUT);
+	}
+}
+EXPORT_SYMBOL(omap3_gpio_restore);
+#endif
+
 /*
  * This may get called early from board specific init
  * for boards that have interrupts routed via FPGA.
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/gpio.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/gpio.h	2008-09-01
18:11:28.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/gpio.h	2008-09-01
18:11:51.000000000 +0530
@@ -70,6 +70,22 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))

+struct omap3_gpio_regs {
+	u32 gpio_sysconfig;
+	u32 gpio_irqenable1;
+	u32 gpio_irqenable2;
+	u32 gpio_wake_en;
+	u32 gpio_ctrl;
+	u32 gpio_oe;
+	u32 gpio_leveldetect0;
+	u32 gpio_leveldetect1;
+	u32 gpio_risingdetect;
+	u32 gpio_fallingdetect;
+	u32 gpio_dataout;
+	u32 gpio_setwkuena;
+	u32 gpio_setdataout;
+};
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern int omap_request_gpio(int gpio);
 extern void omap_free_gpio(int gpio);
@@ -80,7 +96,8 @@ extern void omap2_gpio_prepare_for_reten
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-
+extern void omap3_gpio_save(void);
+extern void omap3_gpio_restore(void);
 /*-------------------------------------------------------------------------*/

 /* Wrappers for "new style" GPIO calls, using the new infrastructure


