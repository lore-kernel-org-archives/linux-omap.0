From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 REPOST 07/24] gpio/omap: avoid cpu checks during module ena/disable
Date: Tue, 27 Sep 2011 05:44:03 +0530
Message-ID: <1317082460-31706-8-git-send-email-tarun.kanti@ti.com>
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43685 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab1I0AOh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 20:14:37 -0400
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Remove cpu-is checks while enabling/disabling OMAP GPIO module during a gpio
request/free.

Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    2 +
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio-omap.c               |   53 ++++++++++++++------------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index a430fb1..72a640d 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -98,6 +98,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_irqenable = OMAP24XX_GPIO_CLEARIRQENABLE1;
 		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
+		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -114,6 +115,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_irqenable = OMAP4_GPIO_IRQSTATUSCLR0;
 		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
+		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index a93adeb..eaa6de3 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -188,6 +188,7 @@ struct omap_gpio_reg_offs {
 	u16 clr_irqenable;
 	u16 debounce;
 	u16 debounce_en;
+	u16 ctrl;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 090feb8..84cd934 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -83,6 +83,7 @@ struct gpio_bank {
 
 #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
+#define GPIO_MOD_CTRL_BIT	BIT(0)
 
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 {
@@ -577,22 +578,18 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
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
+	if (bank->regs->ctrl && !bank->mod_usage) {
+		void __iomem *reg = bank->base + bank->regs->ctrl;
+		u32 ctrl;
+
+		ctrl = __raw_readl(reg);
+		/* Module is enabled, clocks are not gated */
+		ctrl &= ~GPIO_MOD_CTRL_BIT;
+		__raw_writel(ctrl, reg);
 	}
+
+	bank->mod_usage |= 1 << offset;
+
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -625,22 +622,18 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
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
+
+	if (bank->regs->ctrl && !bank->mod_usage) {
+		void __iomem *reg = bank->base + bank->regs->ctrl;
+		u32 ctrl;
+
+		ctrl = __raw_readl(reg);
+		/* Module is disabled, clocks are gated */
+		ctrl |= GPIO_MOD_CTRL_BIT;
+		__raw_writel(ctrl, reg);
 	}
+
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
-- 
1.7.0.4

