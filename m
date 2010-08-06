From: Charulatha V <charu@ti.com>
Subject: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of sys_dev_class
Date: Fri,  6 Aug 2010 18:04:24 +0530
Message-ID: <1281098065-24177-13-git-send-email-charu@ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
 <1281098065-24177-2-git-send-email-charu@ti.com>
 <1281098065-24177-3-git-send-email-charu@ti.com>
 <1281098065-24177-4-git-send-email-charu@ti.com>
 <1281098065-24177-5-git-send-email-charu@ti.com>
 <1281098065-24177-6-git-send-email-charu@ti.com>
 <1281098065-24177-7-git-send-email-charu@ti.com>
 <1281098065-24177-8-git-send-email-charu@ti.com>
 <1281098065-24177-9-git-send-email-charu@ti.com>
 <1281098065-24177-10-git-send-email-charu@ti.com>
 <1281098065-24177-11-git-send-email-charu@ti.com>
 <1281098065-24177-12-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48638 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934519Ab0HFMbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 08:31:47 -0400
In-Reply-To: <1281098065-24177-12-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, Charulatha V <charu@ti.com>, "Basak, Partha" <p-basak2@ti.com>

This patch makes GPIO driver to use dev_pm_ops instead of
sysdev_class. With this approach, gpio_bank_suspend & gpio_bank_resume
are not part of sys_dev_class.

According to this patch, a GPIO bank relinquishes the clock using
PM runtime APIs when all the gpios in that bank are freed. It also
relinquishes the clocks in the idle-path too, as it is possible to
have a GPIO bank requested and still allow PER domain to go to OFF state.

In the idle path (interrupt disabled context), PM runtime APIs cannot
be used as they are not mutex-free functions. Hence omap_device APIs
are used in the idle and resume after idle path.

To summarize,
1. pm_runtime_get_sync() for any gpio bank is called when one of the gpios
   is requested on the bank, in which, no other gpio is being used (when
   mod_usage becomes non-zero)
2. omap_device_enable() is called during gpio resume after idle, only
   if the particular bank is being used (if mod_usage is non-zero)
3. pm_runtime_put_sync() is called when the last used gpio in that
   gpio bank is freed (when mod_usage becomes zero)
4. omap_device_idle() is called during idle, if the particular bank
   is being used (if mod_usage is non-zero)

With this patch, GPIO's prepare_for_idle and resume_after_idle APIs
makes use of the parameter save_context and restore_context respectively
inorder to identify if save context/restore context needs to be done.

Links to related discussion:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32833.html

For suspend/resume path to work, this patch has dependency of
1. reverting the following patch:
OMAP: bus-level PM: enable use of runtime PM API for suspend/resume
http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=commitdiff;
h=8041359e18e49bf8a3d41f15894db9e476f3a8fc
(or)
2. Remove the locking in the omap_hwmod_for_each* function

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c           |    4 +-
 arch/arm/mach-omap2/pm34xx.c           |   23 +-
 arch/arm/plat-omap/gpio.c              |  561 ++++++++++++++++----------------
 arch/arm/plat-omap/include/plat/gpio.h |    6 +-
 4 files changed, 297 insertions(+), 297 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6aeedea..c01e156 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -106,7 +106,7 @@ static void omap2_enter_full_retention(void)
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
 	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
 
-	omap2_gpio_prepare_for_idle(PWRDM_POWER_RET);
+	omap2_gpio_prepare_for_idle(false);
 
 	if (omap2_pm_debug) {
 		omap2_pm_dump(0, 0, 0);
@@ -140,7 +140,7 @@ no_sleep:
 		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
 		omap2_pm_dump(0, 1, tmp);
 	}
-	omap2_gpio_resume_after_idle();
+	omap2_gpio_resume_after_idle(false);
 
 	clk_enable(osc_ck);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fb4994a..66c7e11 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -79,16 +79,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
-static inline void omap3_per_save_context(void)
-{
-	omap_gpio_save_context();
-}
-
-static inline void omap3_per_restore_context(void)
-{
-	omap_gpio_restore_context();
-}
-
 static void omap3_enable_io_chain(void)
 {
 	int timeout = 0;
@@ -395,15 +385,17 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
-		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF) {
 			if (core_next_state == PWRDM_POWER_ON) {
 				per_next_state = PWRDM_POWER_RET;
 				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
 				per_state_modified = 1;
-			} else
-				omap3_per_save_context();
+			}
 		}
+		if (per_next_state == PWRDM_POWER_OFF)
+			omap2_gpio_prepare_for_idle(true);
+		else
+			omap2_gpio_prepare_for_idle(false);
 	}
 
 	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
@@ -471,9 +463,10 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
-		omap2_gpio_resume_after_idle();
 		if (per_prev_state == PWRDM_POWER_OFF)
-			omap3_per_restore_context();
+			omap2_gpio_resume_after_idle(true);
+		else
+			omap2_gpio_resume_after_idle(false);
 		omap_uart_resume_idle(2);
 		if (per_state_modified)
 			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 6a5cf43..6686f9f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -25,12 +25,12 @@
 #include <linux/pm_runtime.h>
 
 #include <plat/omap_device.h>
+#include <plat/powerdomain.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
-#include <plat/powerdomain.h>
 
 /*
  * OMAP1510 GPIO registers
@@ -179,7 +179,6 @@ struct gpio_bank {
  * related to all instances of the device
  */
 static struct gpio_bank *gpio_bank;
-
 static int bank_width;
 
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
@@ -1045,6 +1044,9 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
+	if (!bank->mod_usage)
+		pm_runtime_get_sync(bank->dev);
+
 	spin_lock_irqsave(&bank->lock, flags);
 
 	/* Set trigger to none. You need to enable the desired trigger with
@@ -1061,22 +1063,19 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
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
+	if ((!bank->mod_usage) && (!cpu_class_is_omap1())) {
+		void __iomem *reg = bank->base;
+		u32 ctrl;
+		if (bank->method == METHOD_GPIO_24XX)
+			reg += OMAP24XX_GPIO_CTRL;
+		else if (bank->method == METHOD_GPIO_44XX)
+			reg += OMAP4_GPIO_CTRL;
+		ctrl = __raw_readl(reg);
+		/* Module is enabled, clocks are not gated */
+		ctrl &= 0xFFFFFFFE;
+		__raw_writel(ctrl, reg);
 	}
+	bank->mod_usage |= 1 << offset;
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1109,24 +1108,26 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
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
+	if ((!bank->mod_usage) && (!cpu_class_is_omap1())) {
+		void __iomem *reg = bank->base;
+		u32 ctrl;
+
+		if (bank->method == METHOD_GPIO_24XX)
+			reg += OMAP24XX_GPIO_CTRL;
+		else if (bank->method == METHOD_GPIO_44XX)
+			reg += OMAP4_GPIO_CTRL;
+		ctrl = __raw_readl(reg);
+		/* Module is disabled, clocks are gated */
+		ctrl |= 1;
+		__raw_writel(ctrl, reg);
 	}
+
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
+
+	if (!bank->mod_usage)
+		pm_runtime_put_sync(bank->dev);
 }
 
 /*
@@ -1728,7 +1729,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(bank->dev);
-	pm_runtime_get_sync(bank->dev);
 
 	omap_gpio_mod_init(bank, id);
 	omap_gpio_chip_init(bank);
@@ -1741,294 +1741,222 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
-{
-	int i;
-
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
-		return 0;
+static void omap_gpio_save_context(struct device *dev);
+static void omap_gpio_restore_context(struct device *dev);
 
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-		void __iomem *wake_status;
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
-		unsigned long flags;
+static int omap_gpio_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	void __iomem *wake_status;
+	void __iomem *wake_clear;
+	void __iomem *wake_set;
+	unsigned long flags;
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
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
+	omap_gpio_save_context(dev);
 
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
 		return 0;
+	}
 
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
+	spin_lock_irqsave(&bank->lock, flags);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->saved_wakeup, wake_set);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
-		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	omap_gpio_restore_context(dev);
 
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
 
-void omap2_gpio_prepare_for_idle(int power_state)
+static int gpio_bank_runtime_suspend(struct device *dev)
 {
-	int i, c = 0;
-	int min = 0;
-
-	if (cpu_is_omap34xx())
-		min = 1;
-
-	for (i = min; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l1, l2;
-
-		if (bank->dbck_enable_mask)
-			clk_disable(bank->dbck);
+	u32 l1, l2;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
-		if (power_state > PWRDM_POWER_OFF)
-			continue;
+	if (bank->dbck_enable_mask)
+		clk_disable(bank->dbck);
 
-		/* If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
-		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
+	/* If going to OFF, remove triggering for all
+	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+	 * generated.  See OMAP2420 Errata item 1.101. */
+	if (!(bank->enabled_non_wakeup_gpios))
+		return 0;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
+	if (bank->method == METHOD_GPIO_24XX) {
+		bank->saved_datain = __raw_readl(bank->base +
 					OMAP24XX_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-						OMAP4_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-						OMAP4_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-						OMAP4_GPIO_RISINGDETECT);
-		}
-
-		bank->saved_fallingdetect = l1;
-		bank->saved_risingdetect = l2;
-		l1 &= ~bank->enabled_non_wakeup_gpios;
-		l2 &= ~bank->enabled_non_wakeup_gpios;
-
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(l1, bank->base +
+		l1 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
+		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		bank->saved_datain = __raw_readl(bank->base +
+					OMAP4_GPIO_DATAIN);
+		l1 = __raw_readl(bank->base + OMAP4_GPIO_FALLINGDETECT);
+		l2 = __raw_readl(bank->base + OMAP4_GPIO_RISINGDETECT);
+	}
 
-		if (cpu_is_omap44xx()) {
-			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
-		}
+	bank->saved_fallingdetect = l1;
+	bank->saved_risingdetect = l2;
+	l1 &= ~bank->enabled_non_wakeup_gpios;
+	l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		c++;
-	}
-	if (!c) {
-		workaround_enabled = 0;
-		return;
+	if (bank->method == METHOD_GPIO_24XX) {
+		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
 	}
+
 	workaround_enabled = 1;
+
+	return 0;
 }
 
-void omap2_gpio_resume_after_idle(void)
+static int gpio_bank_runtime_resume(struct device *dev)
 {
-	int i;
-	int min = 0;
-
-	if (cpu_is_omap34xx())
-		min = 1;
-	for (i = min; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l, gen, gen0, gen1;
-
-		if (bank->dbck_enable_mask)
-			clk_enable(bank->dbck);
+	u32 l, gen, gen0, gen1;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
-		if (!workaround_enabled)
-			continue;
+	if (bank->dbck_enable_mask)
+		clk_enable(bank->dbck);
 
-		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
+	if ((!workaround_enabled) || (!(bank->enabled_non_wakeup_gpios)))
+		return 0;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(bank->saved_fallingdetect,
+	if (bank->method == METHOD_GPIO_24XX) {
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
+		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
+		__raw_writel(bank->saved_risingdetect,
 				 bank->base + OMAP4_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
-		}
+		l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
+	}
 
-		/* Check if any of the non-wakeup interrupt GPIOs have changed
-		 * state.  If so, generate an IRQ by software.  This is
-		 * horribly racy, but it's the best we can do to work around
-		 * this silicon bug. */
-		l ^= bank->saved_datain;
-		l &= bank->enabled_non_wakeup_gpios;
+	/* Check if any of the non-wakeup interrupt GPIOs have changed
+	 * state.  If so, generate an IRQ by software.  This is
+	 * horribly racy, but it's the best we can do to work around
+	 * this silicon bug. */
+	l ^= bank->saved_datain;
+	l &= bank->enabled_non_wakeup_gpios;
 
-		/*
-		 * No need to generate IRQs for the rising edge for gpio IRQs
-		 * configured with falling edge only; and vice versa.
-		 */
-		gen0 = l & bank->saved_fallingdetect;
-		gen0 &= bank->saved_datain;
+	/*
+	 * No need to generate IRQs for the rising edge for gpio IRQs
+	 * configured with falling edge only; and vice versa.
+	 */
+	gen0 = l & bank->saved_fallingdetect;
+	gen0 &= bank->saved_datain;
 
-		gen1 = l & bank->saved_risingdetect;
-		gen1 &= ~(bank->saved_datain);
+	gen1 = l & bank->saved_risingdetect;
+	gen1 &= ~(bank->saved_datain);
 
-		/* FIXME: Consider GPIO IRQs with level detections properly! */
-		gen = l & (~(bank->saved_fallingdetect) &
-				~(bank->saved_risingdetect));
-		/* Consider all GPIO IRQs needed to be updated */
-		gen |= gen0 | gen1;
+	/* FIXME: Consider GPIO IRQs with level detections properly! */
+	gen = l & (~(bank->saved_fallingdetect) & ~(bank->saved_risingdetect));
+	/* Consider all GPIO IRQs needed to be updated */
+	gen |= gen0 | gen1;
 
-		if (gen) {
-			u32 old0, old1;
+	if (gen) {
+		u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-				old0 = __raw_readl(bank->base +
+		if (bank->method == METHOD_GPIO_24XX) {
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
-
-			if (cpu_is_omap44xx()) {
-				old0 = __raw_readl(bank->base +
+		} else if (bank->method == METHOD_GPIO_44XX) {
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
 
+	return 0;
 }
 
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-/* save the registers of bank 2-6 */
-void omap_gpio_save_context(void)
+/* save the registers of bank */
+static void omap_gpio_save_context(struct device *dev)
 {
-	int i;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
-	/* saving banks from 2-6 only since GPIO1 is in WKUP */
-	for (i = 1; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	if (bank->method == METHOD_GPIO_24XX) {
 		bank->gpio_context.irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		bank->gpio_context.irqenable2 =
@@ -2049,17 +1977,37 @@ void omap_gpio_save_context(void)
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
 
 /* restore the required registers of bank 2-6 */
-void omap_gpio_restore_context(void)
+static void omap_gpio_restore_context(struct device *dev)
 {
-	int i;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
 
-	for (i = 1; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-		__raw_writel(gpio_context[i].irqenable1,
+	if (bank->method == METHOD_GPIO_24XX) {
 		__raw_writel(bank->gpio_context.irqenable1,
 				bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		__raw_writel(bank->gpio_context.irqenable2,
@@ -2080,14 +2028,88 @@ void omap_gpio_restore_context(void)
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
+
+void omap2_gpio_prepare_for_idle(bool save_context)
+{
+#if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ARCH_OMAP2PLUS)
+	int i;
+
+	for (i = 0; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+		struct platform_device *pdev = to_platform_device(bank->dev);
+
+		/*
+		 * Only if the device is used & if it supports off-mode,
+		 * prepare for idle.
+		 */
+		if ((!bank->off_mode_support) || (!bank->mod_usage))
+			continue;
+
+		gpio_bank_runtime_suspend(bank->dev);
+		if (save_context)
+			omap_gpio_save_context(bank->dev);
+		omap_device_idle(pdev);
+	}
+#endif
+}
+
+void omap2_gpio_resume_after_idle(bool restore_context)
+{
+#if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ARCH_OMAP2PLUS)
+	int i;
+
+	for (i = 0; i < gpio_bank_count; i++) {
+		struct gpio_bank *bank = &gpio_bank[i];
+		if ((bank->off_mode_support) && (bank->mod_usage)) {
+			struct platform_device *pdev =
+						to_platform_device(bank->dev);
+
+			omap_device_enable(pdev);
+			if (restore_context)
+				omap_gpio_restore_context(bank->dev);
+			gpio_bank_runtime_resume(bank->dev);
+		}
+	}
+
+	workaround_enabled = 0;
 #endif
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
 
@@ -2110,21 +2132,8 @@ int __init omap_gpio_init(void)
 
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
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 6d95eb2..b84b179 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -95,12 +95,10 @@ struct omap_gpio_platform_data {
 extern int gpio_bank_count;
 
 extern int omap_gpio_init(void);	/* Call from board init only */
-extern void omap2_gpio_prepare_for_idle(int power_state);
-extern void omap2_gpio_resume_after_idle(void);
+extern void omap2_gpio_prepare_for_idle(bool save_context);
+extern void omap2_gpio_resume_after_idle(bool restore_context);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-extern void omap_gpio_save_context(void);
-extern void omap_gpio_restore_context(void);
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
-- 
1.6.3.3

