From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
Date: Mon, 10 Sep 2018 13:06:24 -0700
Message-ID: <20180910200624.4494-1-tony@atomide.com>
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
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

I noticed that unlike omap2 and 3 based SoCs, omap4 based SoCs keep
the GPIO clocks enabled for GPIO level interrupts with wakeup enabled.
This blocks deeper idle states as the whole domain will stay busy.

The GPIO clock seems to stay enabled if the wakeup register is enabled
and a level interrupt is triggered. In that case the only way to have
the GPIO module idle is to reset it. It is possible this has gone
unnoticed with OSWR (Open SWitch Retention) and off mode during idle
resetting GPIO context most GPIO instances in the earlier Android trees
for example.

Looks like the way to deal with this is to have omap4 based SoCs
only set wake for the duration of idle and clear level registers for
the idle. With level interrupts we can do this as the level interrupt
from device will be still there on resume.

I've taken the long path to fixing this to avoid yet more hard to
read code. I've set up a quirks flag, and a struct for function
pointers so we can use these to clean up other quirk handling easier
in the later patches. The current level quirk handling is moved to
the new functions.

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c                | 145 ++++++++++++++++++------
 include/linux/platform_data/gpio-omap.h |   2 +
 2 files changed, 114 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -31,6 +31,8 @@
 #define OFF_MODE	1
 #define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
 
+#define OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN	BIT(1)
+
 static LIST_HEAD(omap_gpio_list);
 
 struct gpio_regs {
@@ -48,6 +50,13 @@ struct gpio_regs {
 	u32 debounce_en;
 };
 
+struct gpio_bank;
+
+struct gpio_omap_funcs {
+	void (*idle_enable_level_quirk)(struct gpio_bank *bank);
+	void (*idle_disable_level_quirk)(struct gpio_bank *bank);
+};
+
 struct gpio_bank {
 	struct list_head node;
 	void __iomem *base;
@@ -55,6 +64,7 @@ struct gpio_bank {
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
+	struct gpio_omap_funcs funcs;
 	u32 saved_datain;
 	u32 level_mask;
 	u32 toggle_mask;
@@ -75,6 +85,7 @@ struct gpio_bank {
 	int context_loss_count;
 	int power_mode;
 	bool workaround_enabled;
+	u32 quirks;
 
 	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
 	void (*set_dataout_multiple)(struct gpio_bank *bank,
@@ -368,9 +379,18 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 			readl_relaxed(bank->base + bank->regs->fallingdetect);
 
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
-		bank->context.wake_en =
-			readl_relaxed(bank->base + bank->regs->wkup_en);
+		/* Defer wkup_en register write until we idle? */
+		if (bank->quirks & OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN) {
+			if (trigger)
+				bank->context.wake_en |= gpio_bit;
+			else
+				bank->context.wake_en &= ~gpio_bit;
+		} else {
+			omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit,
+				      trigger != 0);
+			bank->context.wake_en =
+				readl_relaxed(bank->base + bank->regs->wkup_en);
+		}
 	}
 
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
@@ -899,6 +919,76 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+/*
+ * Only edges can generate a wakeup event to the PRCM.
+ *
+ * Therefore, ensure any wake-up capable GPIOs have
+ * edge-detection enabled before going idle to ensure a wakeup
+ * to the PRCM is generated on a GPIO transition. (c.f. 34xx
+ * NDA TRM 25.5.3.1)
+ *
+ * The normal values will be restored upon ->runtime_resume()
+ * by writing back the values saved in bank->context.
+ */
+static void __maybe_unused
+omap2_gpio_enable_level_quirk(struct gpio_bank *bank)
+{
+	u32 wake_low, wake_hi;
+
+	/* Enable additional edge detection for level gpios for idle */
+	wake_low = bank->context.leveldetect0 & bank->context.wake_en;
+	if (wake_low)
+		writel_relaxed(wake_low | bank->context.fallingdetect,
+			       bank->base + bank->regs->fallingdetect);
+
+	wake_hi = bank->context.leveldetect1 & bank->context.wake_en;
+	if (wake_hi)
+		writel_relaxed(wake_hi | bank->context.risingdetect,
+			       bank->base + bank->regs->risingdetect);
+}
+
+static void __maybe_unused
+omap2_gpio_disable_level_quirk(struct gpio_bank *bank)
+{
+	/* Disable edge detection for level gpios after idle */
+	writel_relaxed(bank->context.fallingdetect,
+		       bank->base + bank->regs->fallingdetect);
+	writel_relaxed(bank->context.risingdetect,
+		       bank->base + bank->regs->risingdetect);
+}
+
+/*
+ * On omap4 and later SoC variants a level interrupt with wkup_en
+ * enabled blocks the GPIO clocks from idling until the GPIO
+ * instance been reset. To avoid that, we must set wkup_en only for
+ * idle and clear level registers for the duration of idle. The level
+ * interrupt will be still there on wakeup by it's nature.
+ */
+static void __maybe_unused
+omap4_gpio_enable_level_quirk(struct gpio_bank *bank)
+{
+	/* Set wake only for idle */
+	writel_relaxed(bank->context.wake_en,
+		       bank->base + bank->regs->wkup_en);
+
+	/* Clear level registers for idle */
+	writel_relaxed(0, bank->base + bank->regs->leveldetect0);
+	writel_relaxed(0, bank->base + bank->regs->leveldetect1);
+}
+
+static void __maybe_unused
+omap4_gpio_disable_level_quirk(struct gpio_bank *bank)
+{
+	/* Restore level registers after idle */
+	writel_relaxed(bank->context.leveldetect0,
+		       bank->base + bank->regs->leveldetect0);
+	writel_relaxed(bank->context.leveldetect1,
+		       bank->base + bank->regs->leveldetect1);
+
+	/* Clear wake after idle */
+	writel_relaxed(0, bank->base + bank->regs->wkup_en);
+}
+
 /*---------------------------------------------------------------------*/
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
@@ -1270,6 +1360,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	bank->chip.parent = dev;
 	bank->chip.owner = THIS_MODULE;
 	bank->dbck_flag = pdata->dbck_flag;
+	bank->quirks = pdata->quirks;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
 	bank->is_mpuio = pdata->is_mpuio;
@@ -1278,6 +1369,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF_GPIO
 	bank->chip.of_node = of_node_get(node);
 #endif
+
 	if (node) {
 		if (!of_property_read_bool(node, "ti,gpio-always-on"))
 			bank->loses_context = true;
@@ -1298,6 +1390,18 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				omap_set_gpio_dataout_mask_multiple;
 	}
 
+	if (bank->quirks & OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN) {
+		bank->funcs.idle_enable_level_quirk =
+			omap4_gpio_enable_level_quirk;
+		bank->funcs.idle_disable_level_quirk =
+			omap4_gpio_disable_level_quirk;
+	} else {
+		bank->funcs.idle_enable_level_quirk =
+			omap2_gpio_enable_level_quirk;
+		bank->funcs.idle_disable_level_quirk =
+			omap2_gpio_disable_level_quirk;
+	}
+
 	raw_spin_lock_init(&bank->lock);
 	raw_spin_lock_init(&bank->wa_lock);
 
@@ -1372,29 +1476,11 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 	u32 l1 = 0, l2 = 0;
 	unsigned long flags;
-	u32 wake_low, wake_hi;
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 
-	/*
-	 * Only edges can generate a wakeup event to the PRCM.
-	 *
-	 * Therefore, ensure any wake-up capable GPIOs have
-	 * edge-detection enabled before going idle to ensure a wakeup
-	 * to the PRCM is generated on a GPIO transition. (c.f. 34xx
-	 * NDA TRM 25.5.3.1)
-	 *
-	 * The normal values will be restored upon ->runtime_resume()
-	 * by writing back the values saved in bank->context.
-	 */
-	wake_low = bank->context.leveldetect0 & bank->context.wake_en;
-	if (wake_low)
-		writel_relaxed(wake_low | bank->context.fallingdetect,
-			     bank->base + bank->regs->fallingdetect);
-	wake_hi = bank->context.leveldetect1 & bank->context.wake_en;
-	if (wake_hi)
-		writel_relaxed(wake_hi | bank->context.risingdetect,
-			     bank->base + bank->regs->risingdetect);
+	if (bank->funcs.idle_enable_level_quirk)
+		bank->funcs.idle_enable_level_quirk(bank);
 
 	if (!bank->enabled_non_wakeup_gpios)
 		goto update_gpio_context_count;
@@ -1459,16 +1545,8 @@ static int omap_gpio_runtime_resume(struct device *dev)
 
 	omap_gpio_dbck_enable(bank);
 
-	/*
-	 * In ->runtime_suspend(), level-triggered, wakeup-enabled
-	 * GPIOs were set to edge trigger also in order to be able to
-	 * generate a PRCM wakeup.  Here we restore the
-	 * pre-runtime_suspend() values for edge triggering.
-	 */
-	writel_relaxed(bank->context.fallingdetect,
-		     bank->base + bank->regs->fallingdetect);
-	writel_relaxed(bank->context.risingdetect,
-		     bank->base + bank->regs->risingdetect);
+	if (bank->funcs.idle_disable_level_quirk)
+		bank->funcs.idle_disable_level_quirk(bank);
 
 	if (bank->loses_context) {
 		if (!bank->get_context_loss_count) {
@@ -1706,6 +1784,7 @@ static const struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
+	.quirks = OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN,
 };
 
 static const struct of_device_id omap_gpio_match[] = {
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -197,6 +197,8 @@ struct omap_gpio_platform_data {
 	bool is_mpuio;		/* whether the bank is of type MPUIO */
 	u32 non_wakeup_gpios;
 
+	u32 quirks;		/* Version specific quirks mask */
+
 	struct omap_gpio_reg_offs *regs;
 
 	/* Return context loss count due to PM states changing */
-- 
2.18.0
