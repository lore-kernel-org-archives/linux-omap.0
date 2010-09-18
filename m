From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 12/13] OMAP: GPIO: Use dev_pm_ops instead of sys_dev_class
Date: Sat, 18 Sep 2010 19:45:52 +0530
Message-ID: <1284819353-8512-13-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56493 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755507Ab0IROQT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Sep 2010 10:16:19 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
for enabling/disabling the clocks, sysconfig settings instead of using
clock FW APIs.
Note: OMAP16xx & OMAP2 has interface and functional clocks whereas
OMAP3&4 has interface and debounce clocks.

GPIO driver is modified to use dev_pm_ops instead of sysdev_class.
With this approach, gpio_bank_suspend() & gpio_bank_resume()
are not part of sys_dev_class.

1. pm_runtime_get_sync() is called from omap_gpio_request()
   when one of the gpios is requested on a bank, in which, no other
   gpio is being used (when mod_usage becomes non-zero).
2. pm_runtime_put_sync() is called in omap_gpio_free() when the
   last used gpio in that gpio bank is freed(when mod_usage becomes 0).
3. pm_runtime_put_sync() and pm_runtime_get_sync() for GPIO banks
   are called in cpu idle and resume after idle paths respectively
   only if the GPIOs are in non-wakeup domain and if the bank is
   being used.

During a gpio_request when mod_usage becomes non-zero, the bank
registers are configured with init time configurations inorder to
make sure that the GPIO init time configurations are not lost if the
context was earlier lost when the GPIO bank was not in use.

Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/plat-omap/gpio.c |  602 +++++++++++++++++++++++++--------------------
 1 files changed, 331 insertions(+), 271 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index aa0d510..1f07317 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -29,9 +29,6 @@
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
-#include <plat/powerdomain.h>
-
-static struct powerdomain *per_pwrdm;
 
 /*
  * OMAP1510 GPIO registers
@@ -171,11 +168,12 @@ struct gpio_bank {
 	u32 dbck_enable_mask;
 	struct device *dev;
 	struct omap_gpio_regs gpio_context;
+	struct powerdomain *pwrdm;
 	bool dbck_flag;
 };
 
-static void omap3_gpio_restore_context(void);
-static void omap3_gpio_save_context(void);
+static void omap_gpio_save_context(struct device *dev);
+static void omap_gpio_restore_context(struct device *dev);
 
 /*
  * TODO: Cleanup gpio_bank usage as it is having information
@@ -188,6 +186,8 @@ static int bank_width;
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
+static void omap_gpio_mod_init(struct gpio_bank *bank, int id);
+
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
 	if (cpu_is_omap15xx()) {
@@ -1039,6 +1039,20 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
+	/*
+	 * If this is the first gpio_request for the bank,
+	 * enable the bank module
+	 */
+	if (!bank->mod_usage) {
+		struct platform_device *pdev = to_platform_device(bank->dev);
+
+		pm_runtime_get_sync(bank->dev);
+
+		/* Initialize the gpio bank registers to init time value */
+		omap_gpio_mod_init(bank, pdev->id);
+	}
+	bank->mod_usage |= 1 << offset;
+
 	spin_lock_irqsave(&bank->lock, flags);
 
 	/* Set trigger to none. You need to enable the desired trigger with
@@ -1055,22 +1069,6 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
 #endif
-	if (!cpu_class_is_omap1()) {
-		if (!bank->mod_usage) {
-			void __iomem *reg = bank->base;
-			u32 ctrl;
-
-			if (cpu_is_omap24xx() || cpu_is_omap34xx())
-				reg += OMAP24XX_GPIO_CTRL;
-			else if (cpu_is_omap44xx())
-				reg += OMAP4_GPIO_CTRL;
-			ctrl = __raw_readl(reg);
-			/* Module is enabled, clocks are not gated */
-			ctrl &= 0xFFFFFFFE;
-			__raw_writel(ctrl, reg);
-		}
-		bank->mod_usage |= 1 << offset;
-	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1103,24 +1101,32 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-	if (!cpu_class_is_omap1()) {
-		bank->mod_usage &= ~(1 << offset);
-		if (!bank->mod_usage) {
-			void __iomem *reg = bank->base;
-			u32 ctrl;
+	_reset_gpio(bank, bank->chip.base + offset);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	bank->mod_usage &= ~(1 << offset);
+	/*
+	 * If this is the last gpio to be freed in the bank,
+	 * disable the bank module
+	 */
+	if (!bank->mod_usage) {
+		void __iomem *reg = NULL;
+		u32 ctrl;
+
+		pm_runtime_put_sync(bank->dev);
 
-			if (cpu_is_omap24xx() || cpu_is_omap34xx())
-				reg += OMAP24XX_GPIO_CTRL;
-			else if (cpu_is_omap44xx())
-				reg += OMAP4_GPIO_CTRL;
+		if (bank->method == METHOD_GPIO_24XX)
+			reg = bank->base + OMAP24XX_GPIO_CTRL;
+		else if (bank->method == METHOD_GPIO_44XX)
+			reg = bank->base + OMAP4_GPIO_CTRL;
+
+		if (reg) {
 			ctrl = __raw_readl(reg);
 			/* Module is disabled, clocks are gated */
 			ctrl |= 1;
 			__raw_writel(ctrl, reg);
 		}
 	}
-	_reset_gpio(bank, bank->chip.base + offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 /*
@@ -1569,9 +1575,6 @@ static inline int init_gpio_info(struct platform_device *pdev)
 static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 {
 	if (cpu_class_is_omap2()) {
-
-		per_pwrdm = pwrdm_lookup("per_pwrdm");
-
 		if (cpu_is_omap44xx()) {
 			__raw_writel(0xffffffff, bank->base +
 					OMAP4_GPIO_IRQSTATUSCLR0);
@@ -1710,6 +1713,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->gpio_attr->dbck_flag;
 	bank_width = pdata->gpio_attr->bank_width;
+	bank->pwrdm = pdata->pwrdm;
 
 	spin_lock_init(&bank->lock);
 
@@ -1729,7 +1733,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
-	omap_gpio_mod_init(bank, id);
 	omap_gpio_chip_init(bank);
 
 	if (!gpio_init_done) {
@@ -1737,248 +1740,177 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		gpio_init_done = 1;
 	}
 
+	pm_runtime_put_sync(bank->dev);
+
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
+static int omap_gpio_suspend(struct device *dev)
 {
-	int i;
+	struct platform_device *pdev = to_platform_device(dev);
+	void __iomem *wake_status;
+	void __iomem *wake_clear;
+	void __iomem *wake_set;
+	unsigned long flags;
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
+	/* If the gpio bank is not used, do nothing */
+	if (!bank->mod_usage)
 		return 0;
 
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-		void __iomem *wake_status;
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
-		unsigned long flags;
+	if (strcmp(bank->pwrdm->name, "wkup_pwrdm"))
+		omap_gpio_save_context(dev);
 
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
-
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
+	switch (bank->method) {
+	case METHOD_GPIO_1610:
+		wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
+		wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
+		wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
+		break;
+	case METHOD_GPIO_24XX:
+		wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
+		wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
+		wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
+		break;
+	case METHOD_GPIO_44XX:
+		wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		break;
+	default:
+		return 0;
 	}
 
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wake_status);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->suspend_wakeup, wake_set);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
 	return 0;
 }
 
-static int omap_gpio_resume(struct sys_device *dev)
+static int omap_gpio_resume(struct device *dev)
 {
-	int i;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
+	void __iomem *wake_clear;
+	void __iomem *wake_set;
+	unsigned long flags;
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
+	/* If the gpio bank is not used, do nothing */
+	if (!bank->mod_usage)
 		return 0;
 
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
-		unsigned long flags;
+	switch (bank->method) {
+	case METHOD_GPIO_1610:
+		wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
+		wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
+		break;
+	case METHOD_GPIO_24XX:
+		wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
+		wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
+		break;
+	case METHOD_GPIO_44XX:
+		wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		break;
+	default:
+		return 0;
+	}
 
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
+	spin_lock_irqsave(&bank->lock, flags);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->saved_wakeup, wake_set);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
-		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	if (strcmp(bank->pwrdm->name, "wkup_pwrdm"))
+		omap_gpio_restore_context(dev);
 
 	return 0;
 }
 
-static struct sysdev_class omap_gpio_sysclass = {
-	.name		= "gpio",
-	.suspend	= omap_gpio_suspend,
-	.resume		= omap_gpio_resume,
-};
-
-static struct sys_device omap_gpio_device = {
-	.id		= 0,
-	.cls		= &omap_gpio_sysclass,
-};
-
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
 static int workaround_enabled;
 
-void omap2_gpio_prepare_for_idle(void)
+static int gpio_bank_runtime_suspend(struct device *dev)
 {
-	int i, c = 0, min = 0;
-	int per_next_state;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
-	if (!per_pwrdm)
-		return;
+	if (bank->dbck_enable_mask)
+		clk_disable(bank->dbck);
 
-	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-	if (per_next_state >= PWRDM_POWER_INACTIVE)
-		return;
+	if (!bank->pwrdm) {
+		int pwrdm_next_state;
+
+		pwrdm_next_state = pwrdm_read_next_pwrst(bank->pwrdm);
+		if (pwrdm_next_state > PWRDM_POWER_OFF)
+			return 0;
+	}
 
-	if (cpu_is_omap34xx())
-		min = 1;
+	/* If going to OFF, remove triggering for all
+	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+	 * generated.  See OMAP2420 Errata item 1.101. */
+	if (!(bank->enabled_non_wakeup_gpios))
+		return 0;
 
-	workaround_enabled = 0;
-	for (i = min; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	if (bank->method == METHOD_GPIO_24XX) {
 		u32 l1, l2;
 
-		if (bank->dbck_enable_mask)
-			clk_disable(bank->dbck);
+		bank->saved_datain = __raw_readl(bank->base +
+							OMAP24XX_GPIO_DATAIN);
+		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
 
-		if (per_next_state > PWRDM_POWER_OFF)
-			continue;
+		bank->saved_fallingdetect = l1;
+		bank->saved_risingdetect = l2;
+		l1 &= ~bank->enabled_non_wakeup_gpios;
+		l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		/* If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
-		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
+		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-					OMAP24XX_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		u32 l1, l2;
 
-		if (cpu_is_omap44xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-						OMAP4_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-						OMAP4_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-						OMAP4_GPIO_RISINGDETECT);
-		}
+		bank->saved_datain = __raw_readl(bank->base +
+							OMAP4_GPIO_DATAIN);
+		l1 = __raw_readl(bank->base + OMAP4_GPIO_FALLINGDETECT);
+		l2 = __raw_readl(bank->base + OMAP4_GPIO_RISINGDETECT);
 
 		bank->saved_fallingdetect = l1;
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(l1, bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
-			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
-		}
-
-		c++;
+		__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
 	}
-	if (c)
-		workaround_enabled = 1;
 
-	if (cpu_is_omap34xx() && (per_next_state == PWRDM_POWER_OFF))
-		omap3_gpio_save_context();
+	workaround_enabled = 1;
+
+	return 0;
 }
 
-void omap2_gpio_resume_after_idle(void)
+static int gpio_bank_runtime_resume(struct device *dev)
 {
-	int i, min = 0;
-	int per_next_state;
-
-	if (!per_pwrdm)
-		return;
-
-	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-	if (per_next_state >= PWRDM_POWER_INACTIVE)
-		return;
-
-	if (cpu_is_omap34xx() && (per_next_state == PWRDM_POWER_OFF)) {
-		int per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
-		if (per_prev_state == PWRDM_POWER_OFF)
-			omap3_gpio_restore_context();
-	}
+	if (bank->dbck_enable_mask)
+		clk_enable(bank->dbck);
 
-	if (cpu_is_omap34xx())
-		min = 1;
+	if ((!workaround_enabled) || (!(bank->enabled_non_wakeup_gpios)))
+		return 0;
 
-	for (i = min; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	if (bank->method == METHOD_GPIO_24XX) {
 		u32 l, gen, gen0, gen1;
 
-		if (bank->dbck_enable_mask)
-			clk_enable(bank->dbck);
-
-		if (!workaround_enabled)
-			continue;
-
-		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
-
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(bank->saved_fallingdetect,
+		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
+		__raw_writel(bank->saved_risingdetect,
 				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
-		}
-
-		if (cpu_is_omap44xx()) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP4_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
-		}
+		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 
 		/* Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
@@ -2006,51 +1938,79 @@ void omap2_gpio_resume_after_idle(void)
 		if (gen) {
 			u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-				old0 = __raw_readl(bank->base +
+			old0 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
+			old1 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | gen, bank->base +
+			__raw_writel(old0 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | gen, bank->base +
+			__raw_writel(old1 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
+			__raw_writel(old0, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
+			__raw_writel(old1, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			}
+		}
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		u32 l, gen, gen0, gen1;
+
+		__raw_writel(bank->saved_fallingdetect,
+				 bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(bank->saved_risingdetect,
+				 bank->base + OMAP4_GPIO_RISINGDETECT);
+		l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
+
+		/* Check if any of the non-wakeup interrupt GPIOs have changed
+		 * state.  If so, generate an IRQ by software.  This is
+		 * horribly racy, but it's the best we can do to work around
+		 * this silicon bug. */
+		l ^= bank->saved_datain;
+		l &= bank->enabled_non_wakeup_gpios;
+
+		/*
+		 * No need to generate IRQs for the rising edge for gpio IRQs
+		 * configured with falling edge only; and vice versa.
+		 */
+		gen0 = l & bank->saved_fallingdetect;
+		gen0 &= bank->saved_datain;
+
+		gen1 = l & bank->saved_risingdetect;
+		gen1 &= ~(bank->saved_datain);
 
-			if (cpu_is_omap44xx()) {
-				old0 = __raw_readl(bank->base +
+		/* FIXME: Consider GPIO IRQs with level detections properly! */
+		gen = l & (~(bank->saved_fallingdetect) &
+				~(bank->saved_risingdetect));
+		/* Consider all GPIO IRQs needed to be updated */
+		gen |= gen0 | gen1;
+
+		if (gen) {
+			u32 old0, old1;
+
+			old0 = __raw_readl(bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
+			old1 = __raw_readl(bank->base +
 						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | l, bank->base +
+			__raw_writel(old0 | l, bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | l, bank->base +
+			__raw_writel(old1 | l, bank->base +
 						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
+			__raw_writel(old0, bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
+			__raw_writel(old1, bank->base +
 						OMAP4_GPIO_LEVELDETECT1);
-			}
 		}
 	}
-}
 
-#endif
+	return 0;
+}
 
-#ifdef CONFIG_ARCH_OMAP3
-/* save the registers of bank 2-6 */
-static void omap3_gpio_save_context(void)
+/* save the registers of bank */
+static void omap_gpio_save_context(struct device *dev)
 {
-	int i;
-
-	/* saving banks from 2-6 only since GPIO1 is in WKUP */
-	for (i = 1; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
+	if (bank->method == METHOD_GPIO_24XX) {
 		bank->gpio_context.irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		bank->gpio_context.irqenable2 =
@@ -2071,17 +2031,37 @@ static void omap3_gpio_save_context(void)
 			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		bank->gpio_context.dataout =
 			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		bank->gpio_context.irqenable1 =
+			__raw_readl(bank->base + OMAP4_GPIO_IRQENABLE1);
+		bank->gpio_context.irqenable2 =
+			__raw_readl(bank->base + OMAP4_GPIO_IRQENABLE2);
+		bank->gpio_context.wake_en =
+			__raw_readl(bank->base + OMAP4_GPIO_WAKE_EN);
+		bank->gpio_context.ctrl =
+			__raw_readl(bank->base + OMAP4_GPIO_CTRL);
+		bank->gpio_context.oe =
+			__raw_readl(bank->base + OMAP4_GPIO_OE);
+		bank->gpio_context.leveldetect0 =
+			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0);
+		bank->gpio_context.leveldetect1 =
+			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT1);
+		bank->gpio_context.risingdetect =
+			__raw_readl(bank->base + OMAP4_GPIO_RISINGDETECT);
+		bank->gpio_context.fallingdetect =
+			__raw_readl(bank->base + OMAP4_GPIO_FALLINGDETECT);
+		bank->gpio_context.dataout =
+			__raw_readl(bank->base + OMAP4_GPIO_DATAOUT);
 	}
 }
 
-/* restore the required registers of bank 2-6 */
-static void omap3_gpio_restore_context(void)
+/* restore the required registers of bank */
+static void omap_gpio_restore_context(struct device *dev)
 {
-	int i;
-
-	for (i = 1; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
+	if (bank->method == METHOD_GPIO_24XX) {
 		__raw_writel(bank->gpio_context.irqenable1,
 				bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		__raw_writel(bank->gpio_context.irqenable2,
@@ -2102,14 +2082,107 @@ static void omap3_gpio_restore_context(void)
 				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->gpio_context.dataout,
 				bank->base + OMAP24XX_GPIO_DATAOUT);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		__raw_writel(bank->gpio_context.irqenable1,
+				bank->base + OMAP4_GPIO_IRQENABLE1);
+		__raw_writel(bank->gpio_context.irqenable2,
+				bank->base + OMAP4_GPIO_IRQENABLE2);
+		__raw_writel(bank->gpio_context.wake_en,
+				bank->base + OMAP4_GPIO_WAKE_EN);
+		__raw_writel(bank->gpio_context.ctrl,
+				bank->base + OMAP4_GPIO_CTRL);
+		__raw_writel(bank->gpio_context.oe,
+				bank->base + OMAP4_GPIO_OE);
+		__raw_writel(bank->gpio_context.leveldetect0,
+				bank->base + OMAP4_GPIO_LEVELDETECT0);
+		__raw_writel(bank->gpio_context.leveldetect1,
+				bank->base + OMAP4_GPIO_LEVELDETECT1);
+		__raw_writel(bank->gpio_context.risingdetect,
+				bank->base + OMAP4_GPIO_RISINGDETECT);
+		__raw_writel(bank->gpio_context.fallingdetect,
+				bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(bank->gpio_context.dataout,
+				bank->base + OMAP4_GPIO_DATAOUT);
 	}
 }
-#endif
+
+void omap2_gpio_prepare_for_idle(void)
+{
+	int i;
+
+	workaround_enabled = 0;
+
+	for (i = 0; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+
+		/* If the gpio bank is not used, do nothing */
+		if ((!bank->pwrdm) || !(bank->mod_usage))
+			continue;
+
+		if (strcmp(bank->pwrdm->name, "wkup_pwrdm")) {
+			int pwrdm_next_state;
+
+			pwrdm_next_state = pwrdm_read_next_pwrst(bank->pwrdm);
+			if (pwrdm_next_state >= PWRDM_POWER_INACTIVE)
+				continue;
+
+			if (pwrdm_next_state == PWRDM_POWER_OFF)
+				omap_gpio_save_context(bank->dev);
+
+			pm_runtime_put_sync(bank->dev);
+		}
+	}
+}
+
+void omap2_gpio_resume_after_idle(void)
+{
+	int i;
+
+	for (i = 0; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+
+		/* If the gpio bank is not used, do nothing */
+		if ((!bank->pwrdm) || !(bank->mod_usage))
+			continue;
+
+		if (strcmp(bank->pwrdm->name, "wkup_pwrdm")) {
+			int pwrdm_next_state;
+
+			pwrdm_next_state = pwrdm_read_next_pwrst(bank->pwrdm);
+			if (pwrdm_next_state >= PWRDM_POWER_INACTIVE)
+				continue;
+
+			pm_runtime_get_sync(bank->dev);
+
+			/*
+			 * Reading the prev-state takes long time (11us@OPP2),
+			 * only do it, if we really tried to put PER in OFF
+			 */
+			if (pwrdm_next_state == PWRDM_POWER_OFF) {
+				int pwrdm_prev_state;
+
+				pwrdm_prev_state =
+					pwrdm_read_prev_pwrst(bank->pwrdm);
+
+				if (pwrdm_prev_state == PWRDM_POWER_OFF)
+					omap_gpio_restore_context(bank->dev);
+			}
+		}
+	}
+}
+
+static const struct dev_pm_ops gpio_pm_ops = {
+	.suspend	 = omap_gpio_suspend,
+	.resume		 = omap_gpio_resume,
+	.runtime_suspend = gpio_bank_runtime_suspend,
+	.runtime_resume	 = gpio_bank_runtime_resume,
+};
 
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap-gpio",
+		.pm	= &gpio_pm_ops,
 	},
 };
 
@@ -2132,21 +2205,8 @@ int __init omap_gpio_init(void)
 
 static int __init omap_gpio_sysinit(void)
 {
-	int ret = 0;
-
 	mpuio_init();
-
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		if (ret == 0) {
-			ret = sysdev_class_register(&omap_gpio_sysclass);
-			if (ret == 0)
-				ret = sysdev_register(&omap_gpio_device);
-		}
-	}
-#endif
-
-	return ret;
+	return 0;
 }
 
 arch_initcall(omap_gpio_sysinit);
-- 
1.7.0.4

