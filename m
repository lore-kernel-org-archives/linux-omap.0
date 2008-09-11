From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/29] gpio context save/restore
Date: Thu, 11 Sep 2008 15:33:56 +0300
Message-ID: <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18954 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbYIKMes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:48 -0400
In-Reply-To: <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds the context save restore functions for GPIO
---
 arch/arm/plat-omap/gpio.c                |   92 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/common.h |    2 +
 2 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index ac55616..401120f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -101,6 +101,7 @@
 #define OMAP24XX_GPIO_IRQSTATUS2	0x0028
 #define OMAP24XX_GPIO_IRQENABLE2	0x002c
 #define OMAP24XX_GPIO_IRQENABLE1	0x001c
+#define OMAP24XX_GPIO_WAKE_EN		0x0020
 #define OMAP24XX_GPIO_CTRL		0x0030
 #define OMAP24XX_GPIO_OE		0x0034
 #define OMAP24XX_GPIO_DATAIN		0x0038
@@ -217,6 +218,22 @@ static struct gpio_bank gpio_bank_34xx[6] = {
 	{ OMAP34XX_GPIO6_BASE, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160, METHOD_GPIO_24XX },
 };
 
+struct gpio_restore_regs {
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
+static struct gpio_restore_regs gpio_restore_banks[6];
 #endif
 
 static struct gpio_bank *gpio_bank;
@@ -1707,6 +1724,81 @@ void omap2_gpio_resume_after_retention(void)
 
 #endif
 
+#ifdef CONFIG_ARCH_OMAP34XX
+/* save the registers of bank 2-6 */
+void omap_gpio_save(void)
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
+EXPORT_SYMBOL(omap_gpio_save);
+
+/* restore the required registers of bank 2-6 */
+void omap_gpio_restore(void)
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
+EXPORT_SYMBOL(omap_gpio_restore);
+#endif
+
 /*
  * This may get called early from board specific init
  * for boards that have interrupts routed via FPGA.
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 003c08e..489add6 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -36,6 +36,8 @@ extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
 extern void omap_serial_enable_clocks(int enable);
 extern int omap_serial_can_sleep(void);
+extern void omap_gpio_save(void);
+extern void omap_gpio_restore(void);
 extern void omap_serial_fclk_mask(u32 *f1, u32 *f2);
 void omap_serial_check_wakeup(void);
 #ifdef CONFIG_I2C_OMAP
-- 
1.6.0

