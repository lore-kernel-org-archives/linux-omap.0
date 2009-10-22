From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 02/32] OMAP3: PM: GPIO context save/restore
Date: Thu, 22 Oct 2009 16:09:23 -0700
Message-ID: <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:3282 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZJVXJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:09:59 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1260502qwb.37
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:10:04 -0700 (PDT)
In-Reply-To: <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Add context save and restore to enable off-mode.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c              |   92 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpio.h |    3 +-
 2 files changed, 94 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 487bea7..4f81ea3 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -290,6 +290,23 @@ static struct gpio_bank gpio_bank_34xx[6] = {
 		METHOD_GPIO_24XX },
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
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -2036,6 +2053,81 @@ void omap2_gpio_resume_after_retention(void)
 
 #endif
 
+#ifdef CONFIG_ARCH_OMAP34XX
+/* save the registers of bank 2-6 */
+void omap_gpio_save_context(void)
+{
+	int i;
+
+	/* saving banks from 2-6 only since GPIO1 is in WKUP */
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
+
+/* restore the required registers of bank 2-6 */
+void omap_gpio_restore_context(void)
+{
+	int i;
+
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
+#endif
+
 /*
  * This may get called early from board specific init
  * for boards that have interrupts routed via FPGA.
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 633ff68..de7c547 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -76,7 +76,8 @@ extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-
+extern void omap_gpio_save_context(void);
+extern void omap_gpio_restore_context(void);
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
-- 
1.6.4.3

