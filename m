From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] gpio: gpio-omap: configure edge detection for level IRQs for
 idle wakeup
Date: Mon,  8 Apr 2019 12:46:53 -0700
Message-ID: <20190408194653.26012-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

The GPIO block can enter idle independently of the CPU power management
calls via smart-idle.  When the GPIO block enters idle, level detection
stops working due to clocks being shut off, and an alternative form of
edge detection is used.  However, this needs the edge detection
registers set to mark the appropriate edges.

Arrange to configure the edge detection enables along with the level
detection to ensure that any transition to active interrupt state that
occurs while the block is idle is detected as a wake-up event.

Since we enable the edge detection when configuring the IRQ, both
omap2_gpio_enable_level_quirk() nor omap2_gpio_disable_level_quirk()
become redundant, which also means OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER
can be removed. This can be now done without regressions as patch
"gpio: gpio-omap: fix level interrupt idling" allows level interrupts
to idle on omap4 without a workaround.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[tony@atomide.com: update description for the fix dependency]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c                | 90 +++----------------------
 include/linux/platform_data/gpio-omap.h |  2 -
 2 files changed, 11 insertions(+), 81 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -31,8 +31,6 @@
 
 #define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
 
-#define OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER	BIT(2)
-
 struct gpio_regs {
 	u32 irqenable1;
 	u32 irqenable2;
@@ -48,13 +46,6 @@ struct gpio_regs {
 	u32 debounce_en;
 };
 
-struct gpio_bank;
-
-struct gpio_omap_funcs {
-	void (*idle_enable_level_quirk)(struct gpio_bank *bank);
-	void (*idle_disable_level_quirk)(struct gpio_bank *bank);
-};
-
 struct gpio_bank {
 	struct list_head node;
 	void __iomem *base;
@@ -62,7 +53,6 @@ struct gpio_bank {
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
-	struct gpio_omap_funcs funcs;
 	u32 saved_datain;
 	u32 level_mask;
 	u32 toggle_mask;
@@ -83,7 +73,6 @@ struct gpio_bank {
 	int stride;
 	u32 width;
 	int context_loss_count;
-	u32 quirks;
 
 	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
 	void (*set_dataout_multiple)(struct gpio_bank *bank,
@@ -378,10 +367,16 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 		      trigger & IRQ_TYPE_LEVEL_LOW);
 	omap_gpio_rmw(base, bank->regs->leveldetect1, gpio_bit,
 		      trigger & IRQ_TYPE_LEVEL_HIGH);
+
+	/*
+	 * We need the edge detection enabled for to allow the GPIO block
+	 * to be woken from idle state.  Set the appropriate edge detection
+	 * in addition to the level detection.
+	 */
 	omap_gpio_rmw(base, bank->regs->risingdetect, gpio_bit,
-		      trigger & IRQ_TYPE_EDGE_RISING);
+		      trigger & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH));
 	omap_gpio_rmw(base, bank->regs->fallingdetect, gpio_bit,
-		      trigger & IRQ_TYPE_EDGE_FALLING);
+		      trigger & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW));
 
 	bank->context.leveldetect0 =
 			readl_relaxed(bank->base + bank->regs->leveldetect0);
@@ -909,44 +904,6 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-/*
- * Only edges can generate a wakeup event to the PRCM.
- *
- * Therefore, ensure any wake-up capable GPIOs have
- * edge-detection enabled before going idle to ensure a wakeup
- * to the PRCM is generated on a GPIO transition. (c.f. 34xx
- * NDA TRM 25.5.3.1)
- *
- * The normal values will be restored upon ->runtime_resume()
- * by writing back the values saved in bank->context.
- */
-static void __maybe_unused
-omap2_gpio_enable_level_quirk(struct gpio_bank *bank)
-{
-	u32 wake_low, wake_hi;
-
-	/* Enable additional edge detection for level gpios for idle */
-	wake_low = bank->context.leveldetect0 & bank->context.wake_en;
-	if (wake_low)
-		writel_relaxed(wake_low | bank->context.fallingdetect,
-			       bank->base + bank->regs->fallingdetect);
-
-	wake_hi = bank->context.leveldetect1 & bank->context.wake_en;
-	if (wake_hi)
-		writel_relaxed(wake_hi | bank->context.risingdetect,
-			       bank->base + bank->regs->risingdetect);
-}
-
-static void __maybe_unused
-omap2_gpio_disable_level_quirk(struct gpio_bank *bank)
-{
-	/* Disable edge detection for level gpios after idle */
-	writel_relaxed(bank->context.fallingdetect,
-		       bank->base + bank->regs->fallingdetect);
-	writel_relaxed(bank->context.risingdetect,
-		       bank->base + bank->regs->risingdetect);
-}
-
 /*---------------------------------------------------------------------*/
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
@@ -1329,9 +1286,6 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 
 	bank->saved_datain = readl_relaxed(base + bank->regs->datain);
 
-	if (bank->funcs.idle_enable_level_quirk)
-		bank->funcs.idle_enable_level_quirk(bank);
-
 	if (!bank->enabled_non_wakeup_gpios)
 		goto update_gpio_context_count;
 
@@ -1378,9 +1332,6 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
 
 	omap_gpio_dbck_enable(bank);
 
-	if (bank->funcs.idle_disable_level_quirk)
-		bank->funcs.idle_disable_level_quirk(bank);
-
 	if (bank->loses_context) {
 		if (!bank->get_context_loss_count) {
 			omap_gpio_restore_context(bank);
@@ -1524,11 +1475,6 @@ static struct omap_gpio_reg_offs omap4_gpio_regs = {
 	.fallingdetect =	OMAP4_GPIO_FALLINGDETECT,
 };
 
-/*
- * Note that omap2 does not currently support idle modes with context loss so
- * no need to add OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER quirk flag to save
- * and restore context.
- */
 static const struct omap_gpio_platform_data omap2_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
@@ -1539,14 +1485,12 @@ static const struct omap_gpio_platform_data omap3_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER,
 };
 
 static const struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER,
 };
 
 static const struct of_device_id omap_gpio_match[] = {
@@ -1616,7 +1560,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	bank->chip.parent = dev;
 	bank->chip.owner = THIS_MODULE;
 	bank->dbck_flag = pdata->dbck_flag;
-	bank->quirks = pdata->quirks;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
 	bank->is_mpuio = pdata->is_mpuio;
@@ -1646,13 +1589,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				omap_set_gpio_dataout_mask_multiple;
 	}
 
-	if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
-		bank->funcs.idle_enable_level_quirk =
-			omap2_gpio_enable_level_quirk;
-		bank->funcs.idle_disable_level_quirk =
-			omap2_gpio_disable_level_quirk;
-	}
-
 	raw_spin_lock_init(&bank->lock);
 	raw_spin_lock_init(&bank->wa_lock);
 
@@ -1694,11 +1630,8 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	omap_gpio_show_rev(bank);
 
-	if (bank->funcs.idle_enable_level_quirk &&
-	    bank->funcs.idle_disable_level_quirk) {
-		bank->nb.notifier_call = gpio_omap_cpu_notifier;
-		cpu_pm_register_notifier(&bank->nb);
-	}
+	bank->nb.notifier_call = gpio_omap_cpu_notifier;
+	cpu_pm_register_notifier(&bank->nb);
 
 	pm_runtime_put(dev);
 
@@ -1709,8 +1642,7 @@ static int omap_gpio_remove(struct platform_device *pdev)
 {
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 
-	if (bank->nb.notifier_call)
-		cpu_pm_unregister_notifier(&bank->nb);
+	cpu_pm_unregister_notifier(&bank->nb);
 	list_del(&bank->node);
 	gpiochip_remove(&bank->chip);
 	pm_runtime_disable(&pdev->dev);
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -200,8 +200,6 @@ struct omap_gpio_platform_data {
 	bool is_mpuio;		/* whether the bank is of type MPUIO */
 	u32 non_wakeup_gpios;
 
-	u32 quirks;		/* Version specific quirks mask */
-
 	struct omap_gpio_reg_offs *regs;
 
 	/* Return context loss count due to PM states changing */
-- 
2.21.0
