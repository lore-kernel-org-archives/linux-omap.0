From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 06/25] gpio/omap: avoid cpu checks during module ena/disable
Date: Thu, 2 Feb 2012 23:00:32 +0530
Message-ID: <1328203851-20435-7-git-send-email-tarun.kanti@ti.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Charulatha V <charu@ti.com>

Remove cpu-is checks while enabling/disabling OMAP GPIO module during a gpio
request/free.

Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpio.c             |    2 +
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio-omap.c               |   53 ++++++++++++++------------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 1d60fff..bc9271a 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -88,6 +88,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_irqenable = OMAP24XX_GPIO_CLEARIRQENABLE1;
 		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
+		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -104,6 +105,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_irqenable = OMAP4_GPIO_IRQSTATUSCLR0;
 		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
+		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 49ec751..db94bd1 100644
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
index 2eed159..5cc2c04 100644
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
