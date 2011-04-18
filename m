From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 7/7] OMAP: GPIO: use PM runtime framework
Date: Mon, 18 Apr 2011 20:36:57 +0530
Message-ID: <1303139217-10285-8-git-send-email-charu@ti.com>
References: <no>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab1DRPDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 11:03:53 -0400
In-Reply-To: <no>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, paul@pwsan.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
for enabling/disabling the clocks, sysconfig settings and remove usage
of clock FW APIs.
Note: OMAP16xx & OMAP2 has interface and functional clocks whereas
OMAP3 & 4 has interface and debounce clocks.

GPIO driver is modified to use dev_pm_ops instead of sysdev_class.
With this approach, omap_gpio_suspend() & omap_gpio_resume()
are not part of sys_dev_class.

Usage of PM runtime get/put APIs in GPIO driver is as given below:
pm_runtime_get_sync():
* in the probe before accessing the GPIO registers
* at the beginning of omap_gpio_request()
	-only when one of the gpios is requested on a bank, in which,
	 no other gpio is being used (when mod_usage becomes non-zero).
	 This is because omap_gpio_request() is called for all the GPIOs in
	 a bank.
* at the beginning of omap_gpio_resume_after_idle()
* at the beginning of gpio_irq_handler()

pm_runtime_put_sync():
* in the probe after completing GPIO register access
* at the end of omap_gpio_free()
	- only when the last used gpio in the gpio bank is
	  freed (when mod_usage becomes 0).
* at the end of omap_gpio_prepare_for_idle()
* at the end of gpio_irq_handler()

In omap_gpio_suspend/resume() it is not required to call PM runtime APIs
because omap_gpio_prepare_for_idle()/omap_gpio_resume_after_idle() would
be handling them.

OMAP GPIO Request/ Free:
*During a gpio_request when mod_usage becomes non-zero, the bank
 registers are configured with init time configurations inorder to
 make sure that the GPIO init time configurations are not lost if
 the context was earlier lost when the GPIO bank was not in use.
*omap_gpio_request()/free() functions are called for each GPIO pin in a
 given bank whereas PM runtime get_sync/put_sync needs to be called only
 once per bank whenever it is required to enable/disable clocks. Hence it
 is required to use bank->mod_usage flag in omap_gpio_request()/free()
 functions.

TODO:
*Cleanup GPIO driver to avoid usage of gpio_bank_count &
 cpu_is_* checks. This would be sent very soon on top of
 this patch series.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |  298 +++++++++++++++++++++++---------------------
 1 files changed, 156 insertions(+), 142 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7660c06..88ef9d7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -179,6 +179,8 @@ struct gpio_bank {
 	bool off_mode_wkup_wa_enabled;
 };
 
+static void omap_gpio_mod_init(struct gpio_bank *bank, int id);
+
 /*
  * TODO: Cleanup gpio_bank usage as it is having information
  * related to all instances of the device
@@ -1037,8 +1039,28 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
+	/*
+	 * If this is the first gpio_request for the bank,
+	 * enable the bank module
+	 */
+	if (!bank->mod_usage) {
+		struct platform_device *pdev = to_platform_device(bank->dev);
+
+		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev))) {
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
@@ -1053,22 +1075,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
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
@@ -1101,24 +1108,40 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
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
+		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
+			struct platform_device *pdev =
+					to_platform_device(bank->dev);
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_put_sync failed\n",
+					__func__, pdev->id);
+		}
+	}
 }
 
 /*
@@ -1142,6 +1165,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = irq_get_handler_data(irq);
+
+	pm_runtime_get_sync(bank->dev);
+
 #ifdef CONFIG_ARCH_OMAP1
 	if (bank->method == METHOD_MPUIO)
 		isr_reg = bank->base +
@@ -1233,6 +1259,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 exit:
 	if (!unmasked)
 		desc->irq_data.chip->irq_unmask(&desc->irq_data);
+
+	pm_runtime_put_sync(bank->dev);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
@@ -1735,12 +1763,25 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(bank->dev);
-	pm_runtime_get_sync(bank->dev);
+	pm_runtime_irq_safe(bank->dev);
+
+	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
+		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_get_sync "
+				"failed\n", __func__, id);
+		iounmap(bank->base);
+		return -EINVAL;
+	}
 
-	omap_gpio_mod_init(bank, id);
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
+	if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
+		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put_sync "
+				"failed\n", __func__, id);
+		iounmap(bank->base);
+		return -EINVAL;
+	}
+
 	if (!gpio_init_done)
 		gpio_init_done = 1;
 
@@ -1748,6 +1789,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
+static void omap_gpio_save_context(struct gpio_bank *bank);
+static void omap_gpio_restore_context(struct gpio_bank *bank);
+
 static int is_pwrdm_nxt_state_off;
 
 static inline void omap_gpio_idle_handle_errata_i468(struct gpio_bank *bank)
@@ -1876,9 +1920,11 @@ static inline void omap_gpio_resume_handle_errata_i468(struct gpio_bank *bank)
 		}
 	}
 }
+#endif
 
-static int gpio_bank_handle_idle(struct device *dev)
+static int omap_gpio_pm_runtime_suspend(struct device *dev)
 {
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank *bank = &gpio_bank[pdev->id];
 	int j;
@@ -1898,12 +1944,14 @@ static int gpio_bank_handle_idle(struct device *dev)
 		omap_gpio_idle_handle_errata_i468(bank);
 		omap_gpio_save_context(bank);
 	}
+#endif
 
 	return 0;
 }
 
-static int gpio_bank_handle_resume(struct device *dev)
+static int omap_gpio_pm_runtime_resume(struct device *dev)
 {
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank *bank = &gpio_bank[pdev->id];
 	u32 ctx_lost_cnt_after;
@@ -1923,124 +1971,89 @@ static int gpio_bank_handle_resume(struct device *dev)
 		omap_gpio_resume_handle_errata_i468(bank);
 		omap_gpio_restore_context(bank);
 	}
+#endif
 
 	return 0;
 }
-#endif
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
+static int omap_gpio_suspend(struct device *dev)
 {
-	int i;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
+	void __iomem *wake_status;
+	void __iomem *wake_clear;
+	void __iomem *wake_set;
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
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
+	case METHOD_GPIO_24XX:
+		wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
+		wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
+		wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
+		break;
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
+	case METHOD_GPIO_44XX:
+		wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		break;
+
+	default:
+		return 0;
 	}
 
+	bank->saved_wakeup = __raw_readl(wake_status);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->suspend_wakeup, wake_set);
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
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
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
+	case METHOD_GPIO_24XX:
+		wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
+		wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
+		break;
 
-		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
+	case METHOD_GPIO_44XX:
+		wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
+		break;
+
+	default:
+		return 0;
 	}
 
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->saved_wakeup, wake_set);
+
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
 #ifdef CONFIG_ARCH_OMAP2PLUS
-static void omap_gpio_save_context(struct gpio_bank *bank);
-static void omap_gpio_restore_context(struct gpio_bank *bank);
-
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	int i;
@@ -2050,7 +2063,10 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 
-		gpio_bank_handle_idle(bank->dev);
+		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0))
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_put_sync failed\n",
+					__func__, i);
 	}
 }
 
@@ -2063,7 +2079,10 @@ void omap2_gpio_resume_after_idle(void)
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 
-		gpio_bank_handle_resume(bank->dev);
+		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0))
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_get_sync failed\n",
+					__func__, i);
 	}
 }
 
@@ -2162,10 +2181,18 @@ void omap_gpio_restore_context(struct gpio_bank *bank)
 }
 #endif
 
+static const struct dev_pm_ops gpio_pm_ops = {
+	.runtime_suspend	= omap_gpio_pm_runtime_suspend,
+	.runtime_resume		= omap_gpio_pm_runtime_resume,
+	.suspend		= omap_gpio_suspend,
+	.resume			= omap_gpio_resume,
+};
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap_gpio",
+		.pm	= &gpio_pm_ops,
 	},
 };
 
@@ -2182,21 +2209,8 @@ postcore_initcall(omap_gpio_drv_reg);
 
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

