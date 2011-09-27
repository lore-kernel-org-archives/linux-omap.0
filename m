From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 REPOST 09/24] gpio/omap: use level/edge detect reg offsets
Date: Tue, 27 Sep 2011 05:44:05 +0530
Message-ID: <1317082460-31706-10-git-send-email-tarun.kanti@ti.com>
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51051 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab1I0AOo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 20:14:44 -0400
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

By adding level and edge detection register offsets and then initializing them
correctly according to OMAP versions during device registrations we can now remove
lot of revision checks in these functions.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    8 ++
 arch/arm/plat-omap/include/plat/gpio.h |    4 +
 drivers/gpio/gpio-omap.c               |  118 ++++++++++----------------------
 3 files changed, 48 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index b1364b6..06fa913 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -100,6 +100,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
 		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
 		pdata->regs->wkup_en = OMAP24XX_GPIO_WAKE_EN;
+		pdata->regs->leveldetect0 = OMAP24XX_GPIO_LEVELDETECT0;
+		pdata->regs->leveldetect1 = OMAP24XX_GPIO_LEVELDETECT1;
+		pdata->regs->risingdetect = OMAP24XX_GPIO_RISINGDETECT;
+		pdata->regs->fallingdetect = OMAP24XX_GPIO_FALLINGDETECT;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -118,6 +122,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
 		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
 		pdata->regs->wkup_en = OMAP4_GPIO_IRQWAKEN0;
+		pdata->regs->leveldetect0 = OMAP4_GPIO_LEVELDETECT0;
+		pdata->regs->leveldetect1 = OMAP4_GPIO_LEVELDETECT1;
+		pdata->regs->risingdetect = OMAP4_GPIO_RISINGDETECT;
+		pdata->regs->fallingdetect = OMAP4_GPIO_FALLINGDETECT;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 7ea1608..9590532 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -190,6 +190,10 @@ struct omap_gpio_reg_offs {
 	u16 debounce_en;
 	u16 ctrl;
 	u16 wkup_en;
+	u16 leveldetect0;
+	u16 leveldetect1;
+	u16 risingdetect;
+	u16 fallingdetect;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 82707e3..d9bf7ac 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -257,15 +257,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
 
-	if (cpu_is_omap44xx()) {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT1);
-	} else {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-	}
+	bank->level_mask =
+		__raw_readl(bank->base + bank->regs->leveldetect0) |
+		__raw_readl(bank->base + bank->regs->leveldetect1);
 }
 #endif
 
@@ -405,12 +399,12 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
-	/* OMAP1 allows only only edge triggering */
-	if (!cpu_class_is_omap2()
-			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
+	bank = irq_data_get_irq_chip_data(d);
+
+	if (!bank->regs->leveldetect0 &&
+		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
-	bank = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), type);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -658,9 +652,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
 			isr &= 0x0000ffff;
 
-		if (cpu_class_is_omap2()) {
+		if (bank->level_mask)
 			level_mask = bank->level_mask & enabled;
-		}
 
 		/* clear edge sensitive interrupts before handler(s) are
 		called so that we don't miss any interrupt occurred while
@@ -1269,40 +1262,18 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		if (!(bank->enabled_non_wakeup_gpios))
 			goto save_gpio_context;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-					OMAP24XX_GPIO_DATAIN);
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
+		bank->saved_datain = __raw_readl(bank->base +
+							bank->regs->datain);
+		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
+		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
 
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
+		__raw_writel(l1, bank->base + bank->regs->fallingdetect);
+		__raw_writel(l2, bank->base + bank->regs->risingdetect);
 
 save_gpio_context:
 		if (bank->get_context_loss_count)
@@ -1339,21 +1310,11 @@ void omap2_gpio_resume_after_idle(void)
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
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
+		__raw_writel(bank->saved_fallingdetect,
+				bank->base + bank->regs->fallingdetect);
+		__raw_writel(bank->saved_risingdetect,
+				bank->base + bank->regs->risingdetect);
+		l = __raw_readl(bank->base + bank->regs->datain);
 
 		/* Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
@@ -1381,35 +1342,28 @@ void omap2_gpio_resume_after_idle(void)
 		if (gen) {
 			u32 old0, old1;
 
+			old0 = __raw_readl(bank->base +
+						bank->regs->leveldetect0);
+			old1 = __raw_readl(bank->base +
+						bank->regs->leveldetect1);
+
+			__raw_writel(old0, bank->base +
+						bank->regs->leveldetect0);
+			__raw_writel(old1, bank->base +
+						bank->regs->leveldetect1);
 			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-				old0 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | gen, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | gen, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
+				old0 |= gen;
+				old1 |= gen;
 			}
 
 			if (cpu_is_omap44xx()) {
-				old0 = __raw_readl(bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | l, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | l, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
+				old0 |= l;
+				old1 |= l;
 			}
+			__raw_writel(old0, bank->base +
+						bank->regs->leveldetect0);
+			__raw_writel(old1, bank->base +
+						bank->regs->leveldetect1);
 		}
 	}
 }
-- 
1.7.0.4

