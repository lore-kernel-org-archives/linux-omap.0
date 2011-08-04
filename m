From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 07/22] gpio/omap: avoid cpu checks during module ena/disable
Date: Thu, 4 Aug 2011 16:34:38 +0530
Message-ID: <1312455893-14922-8-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235Ab1HDLFZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 07:05:25 -0400
In-Reply-To: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Remove cpu-is checks while enabling/disabling OMAP GPIO module during a gpio
request/free.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    2 +
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio-omap.c               |   53 ++++++++++++++------------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 4952a9d..cdbc728 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -107,6 +107,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_irqenable = OMAP24XX_GPIO_CLEARIRQENABLE1;
 		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
+		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -123,6 +124,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_irqenable = OMAP4_GPIO_IRQSTATUSCLR0;
 		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
+		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index ce417cd..cf41743 100644
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
index 35ab3e9..4d26ba7 100644
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

