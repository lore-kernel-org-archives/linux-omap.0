From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH -pm] OMAP3: GPIO: introduce per-bank context save/restore
Date: Tue, 15 Dec 2009 14:29:32 -0800
Message-ID: <1260916172-8226-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52244 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827AbZLOW3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 17:29:35 -0500
Received: by pwj9 with SMTP id 9so225420pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 14:29:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Prepare for moving to an on-demand, per-bank context save/restore by
moving the regs into the gpio_bank struct and adding bank save/restore
functions.

Currently bank save/restore is done for every GPIO bank during idle,
even banks that have no active/allocated GPIOs.  This is not needed,
only banks with active GPIOs should need a context save/restore.  This
patch does not change the current behavior, but just makes per-bank
save/restore functions available so that a move to a per-bank
save/restore is possible.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to PM branch.

 arch/arm/plat-omap/gpio.c |  142 +++++++++++++++++++++++++--------------------
 1 files changed, 78 insertions(+), 64 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 57a46be..283ed2e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -174,6 +174,21 @@
 #define OMAP44XX_GPIO5_BASE             0x4805B000
 #define OMAP44XX_GPIO6_BASE             0x4805D000
 
+struct omap3_gpio_bank_regs {
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
+};
+
+
 struct gpio_bank {
 	unsigned long pbase;
 	void __iomem *base;
@@ -200,6 +215,10 @@ struct gpio_bank {
 	struct clk *dbck;
 	u32 mod_usage;
 	u32 dbck_enable_mask;
+
+#ifdef CONFIG_ARCH_OMAP34XX
+	struct omap3_gpio_bank_regs context;
+#endif
 };
 
 #define METHOD_MPUIO		0
@@ -280,7 +299,7 @@ static struct gpio_bank gpio_bank_243x[5] = {
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
-static struct gpio_bank gpio_bank_34xx[6] = {
+static struct gpio_bank gpio_bank_34xx[] = {
 	{ OMAP34XX_GPIO1_BASE, NULL, INT_34XX_GPIO_BANK1, IH_GPIO_BASE,
 		METHOD_GPIO_24XX },
 	{ OMAP34XX_GPIO2_BASE, NULL, INT_34XX_GPIO_BANK2, IH_GPIO_BASE + 32,
@@ -299,22 +318,6 @@ static struct gpio_bank gpio_bank_34xx[6] = {
 #define OMAP34XX_PAD_IN_PU_GPIO 0x11c
 #define OMAP34XX_PAD_IN_PD_GPIO 0x10c
 
-struct omap3_gpio_regs {
-	u32 sysconfig;
-	u32 irqenable1;
-	u32 irqenable2;
-	u32 wake_en;
-	u32 ctrl;
-	u32 oe;
-	u32 leveldetect0;
-	u32 leveldetect1;
-	u32 risingdetect;
-	u32 fallingdetect;
-	u32 dataout;
-};
-
-static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
-
 /* GPIO -> PAD init configuration struct */
 struct gpio_pad_range {
 	/* Range start GPIO # */
@@ -2252,6 +2255,58 @@ void omap2_gpio_resume_after_idle(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
+static void omap_gpio_save_bank_context(struct gpio_bank *bank)
+{
+	bank->context.sysconfig =
+		__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
+	bank->context.irqenable1 =
+		__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
+	bank->context.irqenable2 =
+		__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
+	bank->context.wake_en =
+		__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
+	bank->context.ctrl =
+		__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+	bank->context.oe =
+		__raw_readl(bank->base + OMAP24XX_GPIO_OE);
+	bank->context.leveldetect0 =
+		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+	bank->context.leveldetect1 =
+		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+	bank->context.risingdetect =
+			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+	bank->context.fallingdetect =
+			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+	bank->context.dataout =
+		__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+}
+
+static void omap_gpio_restore_bank_context(struct gpio_bank *bank)
+{
+	__raw_writel(bank->context.sysconfig,
+		     bank->base + OMAP24XX_GPIO_SYSCONFIG);
+	__raw_writel(bank->context.irqenable1,
+		     bank->base + OMAP24XX_GPIO_IRQENABLE1);
+	__raw_writel(bank->context.irqenable2,
+		     bank->base + OMAP24XX_GPIO_IRQENABLE2);
+	__raw_writel(bank->context.wake_en,
+		     bank->base + OMAP24XX_GPIO_WAKE_EN);
+	__raw_writel(bank->context.ctrl,
+		     bank->base + OMAP24XX_GPIO_CTRL);
+	__raw_writel(bank->context.leveldetect0,
+		     bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+	__raw_writel(bank->context.leveldetect1,
+		     bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+	__raw_writel(bank->context.risingdetect,
+		     bank->base + OMAP24XX_GPIO_RISINGDETECT);
+	__raw_writel(bank->context.fallingdetect,
+		     bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+	__raw_writel(bank->context.dataout,
+		     bank->base + OMAP24XX_GPIO_DATAOUT);
+	__raw_writel(bank->context.oe,
+		     bank->base + OMAP24XX_GPIO_OE);
+}
+
 /* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
 {
@@ -2266,29 +2321,8 @@ void omap_gpio_save_context(void)
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
 	for (i = 1; i < gpio_bank_count; i++) {
 		bank = &gpio_bank[i];
-		gpio_context[i].sysconfig =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
-		gpio_context[i].irqenable1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		gpio_context[i].irqenable2 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		gpio_context[i].wake_en =
-			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
-		gpio_context[i].ctrl =
-			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
-		gpio_context[i].oe =
-			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
-		tmp_oe[i] = gpio_context[i].oe;
-		gpio_context[i].leveldetect0 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		gpio_context[i].leveldetect1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		gpio_context[i].risingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		gpio_context[i].fallingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		gpio_context[i].dataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+		omap_gpio_save_bank_context(bank);
+		tmp_oe[i] = bank->context.oe;
 	}
 	pad = gpio_pads;
 
@@ -2310,7 +2344,7 @@ void omap_gpio_save_context(void)
 		if (!(tmp_oe[i] & pin)) {
 			/* save current padconf setting */
 			pad->save = omap_ctrl_readw(offset);
-			out = gpio_context[i].dataout;
+			out = bank->context.dataout;
 			if (out & pin)
 				/* High: PU + input */
 				conf = OMAP34XX_PAD_IN_PU_GPIO;
@@ -2338,28 +2372,8 @@ void omap_gpio_restore_context(void)
 
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		__raw_writel(gpio_context[i].sysconfig,
-				bank->base + OMAP24XX_GPIO_SYSCONFIG);
-		__raw_writel(gpio_context[i].irqenable1,
-				bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		__raw_writel(gpio_context[i].irqenable2,
-				bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		__raw_writel(gpio_context[i].wake_en,
-				bank->base + OMAP24XX_GPIO_WAKE_EN);
-		__raw_writel(gpio_context[i].ctrl,
-				bank->base + OMAP24XX_GPIO_CTRL);
-		__raw_writel(gpio_context[i].leveldetect0,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		__raw_writel(gpio_context[i].leveldetect1,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		__raw_writel(gpio_context[i].risingdetect,
-				bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		__raw_writel(gpio_context[i].fallingdetect,
-				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(gpio_context[i].dataout,
-				bank->base + OMAP24XX_GPIO_DATAOUT);
-		__raw_writel(gpio_context[i].oe,
-				bank->base + OMAP24XX_GPIO_OE);
+		
+		omap_gpio_restore_bank_context(bank);
 	}
 }
 
@@ -2373,7 +2387,7 @@ void omap3_gpio_restore_pad_context(int restore_oe)
 	if (restore_oe) {
 		for (i = 1; i < gpio_bank_count; i++) {
 			struct gpio_bank *bank = &gpio_bank[i];
-			__raw_writel(gpio_context[i].oe,
+			__raw_writel(bank->context.oe,
 				     bank->base + OMAP24XX_GPIO_OE);
 		}
 	}
-- 
1.6.5.1

