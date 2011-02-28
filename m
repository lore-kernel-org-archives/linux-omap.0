From: Charulatha V <charu@ti.com>
Subject: [PATCH 5/5] OMAP: GPIO: use PM runtime framework
Date: Mon, 28 Feb 2011 16:27:50 +0530
Message-ID: <1298890670-5481-6-git-send-email-charu@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37844 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525Ab1B1K4g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 05:56:36 -0500
In-Reply-To: <1298890670-5481-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, paul@pwsan.com, Charulatha V <charu@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get()
for enabling/disabling the clocks, sysconfig settings instead of using
clock FW APIs.
Note: OMAP16xx & OMAP2 has interface and functional clocks whereas
OMAP3&4 has interface and debounce clocks.

GPIO driver is modified to use dev_pm_ops instead of sysdev_class.
With this approach, gpio_bank_suspend() & gpio_bank_resume()
are not part of sys_dev_class.

Usage of PM runtime get/put APIs in GPIO driver is as given below:
pm_runtime_get_sync():
* In the probe before accessing the GPIO registers
* at the beginning of omap_gpio_request()
	-only when one of the gpios is requested on a bank, in which,
	 no other gpio is being used (when mod_usage becomes non-zero).
* at the beginning of gpio_resume_after_idle()
	- only if the GPIO bank is under use
	(and)
	- if the bank is in non-wkup power domain
* at the beginning of gpio_irq_handler()
	- only if the specific GPIO bank is pm_runtime_suspended()
* at the beginning of omap_gpio_resume()
	- only if the GPIO bank is under use

pm_runtime_put():
* In the probe after completing GPIO register access
* at the end of omap_gpio_free()
	- only when the last used gpio in the gpio bank is
	  freed (when mod_usage becomes 0).
* at the end of gpio_prepare_for_idle()
	- only if the GPIO bank is under use
	(and)
	- if the bank is in non-wkup power domain
* at the end of gpio_irq_handler()
	- only if a corresponding pm_runtime_get_sync() was done
	  in gpio_irq_handler()
* at the end of omap_gpio_suspend()
	- only if the GPIO bank is under use

OMAP GPIO Request/ Free:
*During a gpio_request when mod_usage becomes non-zero, the bank
 registers are configured with init time configurations inorder to
 make sure that the GPIO init time configurations are not lost if
 the context was earlier lost when the GPIO bank was not in use.

 TODO:
 Cleanup GPIO driver to avoid usage of gpio_bank_count &
 cpu_is_* checks

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/gpio.c |  305 +++++++++++++++++++++++++--------------------
 1 files changed, 167 insertions(+), 138 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 10792b6..908bad2 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -177,6 +177,7 @@ struct gpio_bank {
 
 static void omap_gpio_save_context(struct gpio_bank *bank);
 static void omap_gpio_restore_context(struct gpio_bank *bank);
+static void omap_gpio_mod_init(struct gpio_bank *bank, int id);
 
 /*
  * TODO: Cleanup gpio_bank usage as it is having information
@@ -1042,8 +1043,28 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
+	/*
+	 * If this is the first gpio_request for the bank,
+	 * enable the bank module
+	 */
+	if (!bank->mod_usage) {
+		struct platform_device *pdev = to_platform_device(bank->dev);
+
+		if (unlikely(pm_runtime_get_sync(bank->dev) < 0)) {
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_get_sync failed\n",
+					__func__, pdev->id);
+			return -EINVAL;
+		}
+
+		/* Initialize the gpio bank registers to init time value */
+		omap_gpio_mod_init(bank, pdev->id);
+	}
+
 	spin_lock_irqsave(&bank->lock, flags);
 
+	bank->mod_usage |= 1 << offset;
+
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type().
 	 */
@@ -1058,22 +1079,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
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
+
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1106,24 +1112,39 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-	if (!cpu_class_is_omap1()) {
-		bank->mod_usage &= ~(1 << offset);
-		if (!bank->mod_usage) {
-			void __iomem *reg = bank->base;
-			u32 ctrl;
-
-			if (cpu_is_omap24xx() || cpu_is_omap34xx())
-				reg += OMAP24XX_GPIO_CTRL;
-			else if (cpu_is_omap44xx())
-				reg += OMAP4_GPIO_CTRL;
-			ctrl = __raw_readl(reg);
-			/* Module is disabled, clocks are gated */
-			ctrl |= 1;
-			__raw_writel(ctrl, reg);
-		}
+	bank->mod_usage &= ~(1 << offset);
+	if (!bank->mod_usage) {
+		void __iomem *reg = bank->base;
+		u32 ctrl;
+
+		if (bank->method == METHOD_GPIO_24XX)
+			reg += OMAP24XX_GPIO_CTRL;
+		else if (bank->method == METHOD_GPIO_44XX)
+			reg += OMAP4_GPIO_CTRL;
+		else
+			goto reset_gpio;
+
+		ctrl = __raw_readl(reg);
+		/* Module is disabled, clocks are gated */
+		ctrl |= 1;
+		__raw_writel(ctrl, reg);
 	}
+reset_gpio:
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
+
+	/*
+	 * If this is the last gpio to be freed in the bank,
+	 * disable the bank module
+	 */
+	if (!bank->mod_usage) {
+		if (unlikely(pm_runtime_put(bank->dev) < 0)) {
+			struct platform_device *pdev =
+					to_platform_device(bank->dev);
+			dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put "
+					"failed\n", __func__, pdev->id);
+		}
+	}
 }
 
 /*
@@ -1143,10 +1164,17 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct gpio_bank *bank;
 	u32 retrigger = 0;
 	int unmasked = 0;
+	int enable_gpio = 0;
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = get_irq_data(irq);
+
+	if (pm_runtime_suspended(bank->dev)) {
+		if (unlikely(pm_runtime_get_sync(bank->dev) == 0))
+			enable_gpio = 1;
+	}
+
 #ifdef CONFIG_ARCH_OMAP1
 	if (bank->method == METHOD_MPUIO)
 		isr_reg = bank->base +
@@ -1238,6 +1266,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 exit:
 	if (!unmasked)
 		desc->irq_data.chip->irq_unmask(&desc->irq_data);
+
+	if (enable_gpio)
+		pm_runtime_put(bank->dev);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
@@ -1742,126 +1773,121 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(bank->dev);
-	pm_runtime_get_sync(bank->dev);
+	pm_runtime_irq_safe(bank->dev);
+
+	if (unlikely(pm_runtime_get_sync(bank->dev) < 0)) {
+		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_get_sync "
+				"failed\n", __func__, id);
+		iounmap(bank->base);
+		return -EINVAL;
+	}
 
-	omap_gpio_mod_init(bank, id);
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
+	if (unlikely(pm_runtime_put(bank->dev) < 0)) {
+		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put "
+				"failed\n", __func__, id);
+		iounmap(bank->base);
+		return -EINVAL;
+	}
+
 	if (!gpio_init_done)
 		gpio_init_done = 1;
 
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
+	}
 
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
+	if (strcmp(bank->pwrdm_name, "wkup_pwrdm"))
+		omap_gpio_save_context(bank);
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wake_status);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->suspend_wakeup, wake_set);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	if (unlikely(pm_runtime_put(bank->dev) < 0))
+		return -EINVAL;
 
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
-
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
-
-		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
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
 	}
 
-	return 0;
-}
+	if (unlikely(pm_runtime_get_sync(bank->dev) < 0))
+		return -EINVAL;
 
-static struct sysdev_class omap_gpio_sysclass = {
-	.name		= "gpio",
-	.suspend	= omap_gpio_suspend,
-	.resume		= omap_gpio_resume,
-};
+	spin_lock_irqsave(&bank->lock, flags);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->saved_wakeup, wake_set);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
-static struct sys_device omap_gpio_device = {
-	.id		= 0,
-	.cls		= &omap_gpio_sysclass,
-};
+	if (strcmp(bank->pwrdm_name, "wkup_pwrdm"))
+		omap_gpio_restore_context(bank);
 
-#endif
+	return 0;
+}
 
 static int workaround_enabled;
 
@@ -1885,7 +1911,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 			clk_disable(bank->dbck);
 
 		if (!off_mode)
-			continue;
+			goto disable_gpio_bank;
 
 		/*
 		 * If going to OFF, remove triggering for all
@@ -1930,6 +1956,10 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 
 save_gpio_ctx:
 		omap_gpio_save_context(bank);
+disable_gpio_bank:
+		if (unlikely(pm_runtime_put(bank->dev) < 0))
+			dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put "
+					"failed\n", __func__, i);
 	}
 	if (!c) {
 		workaround_enabled = 0;
@@ -1957,6 +1987,13 @@ void omap2_gpio_resume_after_idle(int off_mode)
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
+		if (unlikely(pm_runtime_get_sync(bank->dev) < 0)) {
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_get_sync failed\n",
+					__func__, i);
+			continue;
+		}
+
 		if (!off_mode)
 			continue;
 
@@ -2040,7 +2077,6 @@ void omap2_gpio_resume_after_idle(int off_mode)
 restore_gpio_ctx:
 		omap_gpio_restore_context(bank);
 	}
-
 }
 
 void omap_gpio_save_context(struct gpio_bank *bank)
@@ -2137,10 +2173,16 @@ void omap_gpio_restore_context(struct gpio_bank *bank)
 	}
 }
 
+static const struct dev_pm_ops gpio_pm_ops = {
+	.suspend	 = omap_gpio_suspend,
+	.resume		 = omap_gpio_resume,
+};
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap_gpio",
+		.pm	= &gpio_pm_ops,
 	},
 };
 
@@ -2157,21 +2199,8 @@ postcore_initcall(omap_gpio_drv_reg);
 
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
1.7.1

