From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 12/20] GPIO: OMAP: Use wkup_status for all SoCs
Date: Fri, 1 Jul 2011 15:17:06 +0530
Message-ID: <1309513634-20971-13-git-send-email-tarun.kanti@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50443 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755882Ab1GAJrl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 05:47:41 -0400
In-Reply-To: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On OMAP4 we are not allowed to access wakeup_set/clear registers.
So instead of having additional check and separate logics for
manipulating the status register use wakup_status regisre consistently
for all SoCs wherever applicable. Use the MOD_REG_BIT macro to read,
modify and write the status register.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/gpio16xx.c         |    2 -
 arch/arm/mach-omap2/gpio.c             |    4 ---
 arch/arm/plat-omap/include/plat/gpio.h |    2 -
 drivers/gpio/gpio-omap.c               |   35 +++++++++++---------------------
 4 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index abde9e9..08dda3c 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -91,8 +91,6 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
 	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
 	.wkup_status	= OMAP1610_GPIO_WAKEUPENABLE,
-	.wkup_clear	= OMAP1610_GPIO_CLEAR_WAKEUPENA,
-	.wkup_set	= OMAP1610_GPIO_SET_WAKEUPENA,
 	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
 	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
 };
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index be5a906..c99eea4 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -114,8 +114,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
 		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
 		pdata->regs->wkup_status = OMAP24XX_GPIO_WAKE_EN;
-		pdata->regs->wkup_clear = OMAP24XX_GPIO_CLEARWKUENA;
-		pdata->regs->wkup_set = OMAP24XX_GPIO_SETWKUENA;
 		pdata->regs->leveldetect0 = OMAP24XX_GPIO_LEVELDETECT0;
 		pdata->regs->leveldetect1 = OMAP24XX_GPIO_LEVELDETECT1;
 		pdata->regs->risingdetect = OMAP24XX_GPIO_RISINGDETECT;
@@ -139,8 +137,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
 		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
 		pdata->regs->wkup_status = OMAP4_GPIO_IRQWAKEN0;
-		pdata->regs->wkup_clear = OMAP4_GPIO_IRQWAKEN0;
-		pdata->regs->wkup_set = OMAP4_GPIO_IRQWAKEN0;
 		pdata->regs->leveldetect0 = OMAP4_GPIO_LEVELDETECT0;
 		pdata->regs->leveldetect1 = OMAP4_GPIO_LEVELDETECT1;
 		pdata->regs->risingdetect = OMAP4_GPIO_RISINGDETECT;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 6dcbe7d..4f584de 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -191,8 +191,6 @@ struct omap_gpio_reg_offs {
 	u16 debounce_en;
 	u16 ctrl;
 	u16 wkup_status;
-	u16 wkup_clear;
-	u16 wkup_set;
 	u16 leveldetect0;
 	u16 leveldetect1;
 	u16 risingdetect;
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 42f0411..769fae7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -261,10 +261,11 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio) {}
 
 static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 {
+	void __iomem *base = bank->base;
 	void __iomem *reg = bank->base;
 	u32 l = 0;
 
-	if (bank->regs->leveldetect0 && bank->regs->wkup_status) {
+	if (bank->regs->leveldetect0) {
 		set_gpio_trigger(bank, gpio, trigger);
 	} else if (bank->regs->irqctrl) {
 		reg += bank->regs->irqctrl;
@@ -295,13 +296,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 		if (trigger & IRQ_TYPE_EDGE_FALLING)
 			l |= 1 << (gpio << 1);
 
-		if (trigger)
-			/* Enable wake-up during idle for dynamic tick */
-			__raw_writel(1 << gpio, bank->base
-						+ bank->regs->wkup_set);
-		else
-			__raw_writel(1 << gpio, bank->base
-						+ bank->regs->wkup_clear);
+		MOD_REG_BIT(bank->regs->wkup_status, 1 << gpio, trigger != 0);
 
 		__raw_writel(l, reg);
 	}
@@ -515,13 +510,14 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
+	void __iomem *base = bank->base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
 
-	if (bank->regs->wkup_clear)
+	if (bank->regs->wkup_status)
 		/* Disable wake-up during idle for dynamic tick */
-		__raw_writel(1 << offset, bank->base + bank->regs->wkup_clear);
+		MOD_REG_BIT(bank->regs->wkup_status, 1 << offset, 0);
 
 	bank->mod_usage &= ~(1 << offset);
 
@@ -1091,22 +1087,19 @@ static int omap_gpio_suspend(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
+		void __iomem *base = bank->base;
 		void __iomem *wake_status;
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
 		unsigned long flags;
 
 		if (!bank->regs->wkup_status)
 			return 0;
 
 		wake_status = bank->base + bank->regs->wkup_status;
-		wake_clear = bank->base + bank->regs->wkup_clear;
-		wake_set = bank->base + bank->regs->wkup_set;
 
 		spin_lock_irqsave(&bank->lock, flags);
 		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
+		MOD_REG_BIT(bank->regs->wkup_status, 0xffffffff, 0);
+		MOD_REG_BIT(bank->regs->wkup_status, bank->suspend_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 
@@ -1118,19 +1111,15 @@ static void omap_gpio_resume(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
+		void __iomem *base = bank->base;
 		unsigned long flags;
 
 		if (!bank->regs->wkup_status)
 			return;
 
-		wake_clear = bank->base + bank->regs->wkup_clear;
-		wake_set = bank->base + bank->regs->wkup_set;
-
 		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
+		MOD_REG_BIT(bank->regs->wkup_status, 0xffffffff, 0);
+		MOD_REG_BIT(bank->regs->wkup_status, bank->saved_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 }
-- 
1.6.0.4

