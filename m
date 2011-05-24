From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 09/15] OMAP: GPIO: cleanup suspend and resume functions
Date: Tue, 24 May 2011 19:54:48 +0530
Message-ID: <1306247094-25372-10-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43540 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095Ab1EXOZX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:23 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

Since wake_status, wake_clear, wake_set is common for all banks on a given
OMAP version it is enough to get their values once during probe().
Also, register offsets are already initialzed according to OMAP versions
during device registration. We no longer need these explicit checks.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    6 ++
 arch/arm/mach-omap1/gpio16xx.c         |    6 ++
 arch/arm/mach-omap1/gpio7xx.c          |    6 ++
 arch/arm/mach-omap2/gpio.c             |    6 ++
 arch/arm/plat-omap/include/plat/gpio.h |    3 +
 drivers/gpio/gpio_omap.c               |  102 +++++++-------------------------
 6 files changed, 49 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index f18a4a9..b0bd21e 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -43,6 +43,9 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
 	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
 	.irqenable_inv	= true,
 	.ctrl		= USHRT_MAX,
+	.wkupstatus	= USHRT_MAX,
+	.wkupclear	= USHRT_MAX,
+	.wkupset	= USHRT_MAX,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
@@ -85,6 +88,9 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 	.irqenable	= OMAP1510_GPIO_INT_MASK,
 	.irqenable_inv	= true,
 	.ctrl		= USHRT_MAX,
+	.wkupstatus	= USHRT_MAX,
+	.wkupclear	= USHRT_MAX,
+	.wkupset	= USHRT_MAX,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index d886b88..403437b 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -46,6 +46,9 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
 	.irqenable_inv	= true,
 	.ctrl		= USHRT_MAX,
+	.wkupstatus	= USHRT_MAX,
+	.wkupclear	= USHRT_MAX,
+	.wkupset	= USHRT_MAX,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
@@ -91,6 +94,9 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
 	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
 	.ctrl		= USHRT_MAX,
+	.wkupstatus	= OMAP1610_GPIO_WAKEUPENABLE,
+	.wkupclear	= OMAP1610_GPIO_CLEAR_WAKEUPENA,
+	.wkupset	= OMAP1610_GPIO_SET_WAKEUPENA,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index c7684ce..d5a4aaf 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -48,6 +48,9 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 	.irqenable	= OMAP_MPUIO_GPIO_MASKIT / 2,
 	.irqenable_inv	= true,
 	.ctrl		= USHRT_MAX,
+	.wkupstatus	= USHRT_MAX,
+	.wkupclear	= USHRT_MAX,
+	.wkupset	= USHRT_MAX,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
@@ -90,6 +93,9 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
 	.irqenable	= OMAP7XX_GPIO_INT_MASK,
 	.irqenable_inv	= true,
 	.ctrl		= USHRT_MAX,
+	.wkupstatus	= USHRT_MAX,
+	.wkupclear	= USHRT_MAX,
+	.wkupset	= USHRT_MAX,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 0782e06..7e79999 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -111,6 +111,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
 		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
+		pdata->regs->wkupstatus = OMAP24XX_GPIO_WAKE_EN;
+		pdata->regs->wkupclear = OMAP24XX_GPIO_CLEARWKUENA;
+		pdata->regs->wkupset = OMAP24XX_GPIO_SETWKUENA;
 		break;
 	case 3:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -128,6 +131,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
 		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
+		pdata->regs->wkupstatus = OMAP4_GPIO_IRQWAKEN0;
+		pdata->regs->wkupclear = OMAP4_GPIO_IRQWAKEN0;
+		pdata->regs->wkupset = OMAP4_GPIO_IRQWAKEN0;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 5718a45..2d1a5d6 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -189,6 +189,9 @@ struct omap_gpio_reg_offs {
 	u16 debounce;
 	u16 debounce_en;
 	u16 ctrl;
+	u16 wkupstatus;
+	u16 wkupclear;
+	u16 wkupset;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index fcc60be..c189416 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -77,6 +77,9 @@ struct gpio_bank {
 	u32 width;
 	u32 ctx_lost_cnt_before;
 	u16 id;
+	void __iomem *wake_status;
+	void __iomem *wake_clear;
+	void __iomem *wake_set;
 
 	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
 
@@ -606,27 +609,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
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
+	if (bank->regs->wkupclear != USHRT_MAX)
 		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
+		__raw_writel(1 << offset, bank->wake_clear);
+
 	bank->mod_usage &= ~(1 << offset);
 
 	if ((bank->regs->ctrl != USHRT_MAX) && (!bank->mod_usage)) {
@@ -1189,6 +1176,15 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	/*
+	 * Storing these addresses avoids redundant computation of these
+	 * values every time in suspend/resume functions and for all the
+	 * gpio banks.
+	 */
+	bank->wake_status = bank->base + bank->regs->wkupstatus;
+	bank->wake_clear = bank->base + bank->regs->wkupclear;
+	bank->wake_set = bank->base + bank->regs->wkupset;
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
@@ -1207,7 +1203,7 @@ err_exit:
 }
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
+static int omap_gpio_suspend(struct sys_device *dev, pm_message_t unused)
 {
 	struct gpio_bank *bank;
 
@@ -1215,41 +1211,12 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 		return 0;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *wake_status;
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
-
 		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
+		bank->saved_wakeup = __raw_readl(bank->wake_status);
+		__raw_writel(0xffffffff, bank->wake_clear);
+		__raw_writel(bank->suspend_wakeup, bank->wake_set);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 
@@ -1264,36 +1231,11 @@ static int omap_gpio_resume(struct sys_device *dev)
 		return 0;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
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
-
 		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
+		__raw_writel(0xffffffff, bank->wake_clear);
+		__raw_writel(bank->saved_wakeup, bank->wake_set);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 
-- 
1.6.0.4

