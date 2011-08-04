From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 08/22] gpio/omap: further cleanup using wakeup_status register
Date: Thu, 4 Aug 2011 16:34:39 +0530
Message-ID: <1312455893-14922-9-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50355 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab1HDLFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 07:05:20 -0400
In-Reply-To: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

Wakeup istatus register offset initialized according to OMAP versions
during device registration. Use this to avoid version checks.
Starting with OMAP4, legacy registers should not be used in combination
with the updated regsiters. Use wkup_status register consistently for
all SoCs wherever applicable.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio16xx.c         |    1 +
 arch/arm/mach-omap2/gpio.c             |    2 +
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio-omap.c               |  109 ++++++--------------------------
 4 files changed, 24 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index df4bb44..ed9f285 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -89,6 +89,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 	.irqenable	= OMAP1610_GPIO_IRQENABLE1,
 	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
 	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
+	.wkup_status	= OMAP1610_GPIO_WAKEUPENABLE,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index cdbc728..fd05cea 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -108,6 +108,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
 		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
+		pdata->regs->wkup_status = OMAP24XX_GPIO_WAKE_EN;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -125,6 +126,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
 		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
+		pdata->regs->wkup_status = OMAP4_GPIO_IRQWAKEN0;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index cf41743..817997d 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -189,6 +189,7 @@ struct omap_gpio_reg_offs {
 	u16 debounce;
 	u16 debounce_en;
 	u16 ctrl;
+	u16 wkup_status;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4d26ba7..996e54b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -50,10 +50,8 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
-#endif
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
@@ -598,30 +596,15 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
+	void __iomem *base = bank->base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-#ifdef CONFIG_ARCH_OMAP16XX
-	if (bank->method == METHOD_GPIO_1610) {
-		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	if (bank->method == METHOD_GPIO_24XX) {
-		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	if (bank->method == METHOD_GPIO_44XX) {
+
+	if (bank->regs->wkup_status)
 		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
+		_gpio_rmw(base, bank->regs->wkup_status, 1 << offset, 0);
+
 	bank->mod_usage &= ~(1 << offset);
 
 	if (bank->regs->ctrl && !bank->mod_usage) {
@@ -1066,8 +1049,8 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 	ct->chip.irq_mask = irq_gc_mask_set_bit;
 	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
 	ct->chip.irq_set_type = gpio_irq_type;
-	/* REVISIT: assuming only 16xx supports MPUIO wake events */
-	if (cpu_is_omap16xx())
+
+	if (bank->regs->wkup_status)
 		ct->chip.irq_set_wake = gpio_wake_enable,
 
 	ct->regs.mask = OMAP_MPUIO_GPIO_INT / bank->stride;
@@ -1096,7 +1079,8 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	if (bank_is_mpuio(bank)) {
 		bank->chip.label = "mpuio";
 #ifdef CONFIG_ARCH_OMAP16XX
-		bank->chip.dev = &omap_mpuio_device.dev;
+		if (bank->regs->wkup_status)
+			bank->chip.dev = &omap_mpuio_device.dev;
 #endif
 		bank->chip.base = OMAP_MPUIO(0);
 	} else {
@@ -1207,50 +1191,24 @@ err_exit:
 	return ret;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 static int omap_gpio_suspend(void)
 {
 	struct gpio_bank *bank;
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
-		return 0;
-
 	list_for_each_entry(bank, &omap_gpio_list, node) {
+		void __iomem *base = bank->base;
 		void __iomem *wake_status;
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
 		unsigned long flags;
 
-		switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
-		case METHOD_GPIO_1610:
-			wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
-			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
-			break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		case METHOD_GPIO_24XX:
-			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
-			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
-			break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_44XX:
-			wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			break;
-#endif
-		default:
-			continue;
-		}
+		if (!bank->regs->wkup_status)
+			return 0;
+
+		wake_status = bank->base + bank->regs->wkup_status;
 
 		spin_lock_irqsave(&bank->lock, flags);
 		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
+		_gpio_rmw(base, bank->regs->wkup_status,
+					bank->suspend_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 
@@ -1261,40 +1219,15 @@ static void omap_gpio_resume(void)
 {
 	struct gpio_bank *bank;
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
-		return;
-
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
+		void __iomem *base = bank->base;
 		unsigned long flags;
 
-		switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
-		case METHOD_GPIO_1610:
-			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
-			break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		case METHOD_GPIO_24XX:
-			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
-			break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_44XX:
-			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			break;
-#endif
-		default:
-			continue;
-		}
+		if (!bank->regs->wkup_status)
+			return;
 
 		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
+		_gpio_rmw(base, bank->regs->wkup_status, bank->saved_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 }
@@ -1304,8 +1237,6 @@ static struct syscore_ops omap_gpio_syscore_ops = {
 	.resume		= omap_gpio_resume,
 };
 
-#endif
-
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
 static void omap_gpio_save_context(struct gpio_bank *bank);
-- 
1.7.0.4

