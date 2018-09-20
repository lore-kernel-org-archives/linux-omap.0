From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] gpio: omap: Remove custom PM calls and use cpu_pm instead
Date: Thu, 20 Sep 2018 12:35:31 -0700
Message-ID: <20180920193532.7714-3-tony@atomide.com>
References: <20180920193532.7714-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920193532.7714-1-tony@atomide.com>
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
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

For a long time the gpio-omap custom PM calls have been annoying me so
let's replace them with cpu_pm instead. This will enable GPIO PM for
deeper idle states on omap4. And we can handle GPIO PM for omap2/3/4
in the same way.

Note that with this patch we are also slightly changing GPIO PM to be
less aggressive for omap3 and only will idle GPIO when PER context
may be lost.

For omap2, we don't need to save context and don't want to remove any
triggering so let's add a quirk flag for that.

Let's do this all in a single patch to avoid a situation where old
custom calls still are used with new code.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm24xx.c            |   7 +-
 arch/arm/mach-omap2/pm34xx.c            |  14 +-
 drivers/gpio/gpio-omap.c                | 178 ++++++++++++++----------
 include/linux/platform_data/gpio-omap.h |  13 --
 4 files changed, 116 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -18,6 +18,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu_pm.h>
 #include <linux/suspend.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
@@ -29,8 +30,6 @@
 #include <linux/clk-provider.h>
 #include <linux/irq.h>
 #include <linux/time.h>
-#include <linux/gpio.h>
-#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/fncpy.h>
 
@@ -87,7 +86,7 @@ static int omap2_enter_full_retention(void)
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
 	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
 
-	omap2_gpio_prepare_for_idle(0);
+	cpu_cluster_pm_enter();
 
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
@@ -100,7 +99,7 @@ static int omap2_enter_full_retention(void)
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
 no_sleep:
-	omap2_gpio_resume_after_idle();
+	cpu_cluster_pm_exit();
 
 	clk_enable(osc_ck);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -18,19 +18,18 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu_pm.h>
 #include <linux/pm.h>
 #include <linux/suspend.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/omap-dma.h>
 #include <linux/omap-gpmc.h>
-#include <linux/platform_data/gpio-omap.h>
 
 #include <trace/events/power.h>
 
@@ -197,7 +196,6 @@ void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
-	int per_going_off;
 	u32 sdrc_pwr = 0;
 
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
@@ -227,10 +225,8 @@ void omap_sram_idle(void)
 	pwrdm_pre_transition(NULL);
 
 	/* PER */
-	if (per_next_state < PWRDM_POWER_ON) {
-		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
-		omap2_gpio_prepare_for_idle(per_going_off);
-	}
+	if (per_next_state == PWRDM_POWER_OFF)
+		cpu_cluster_pm_enter();
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
@@ -295,8 +291,8 @@ void omap_sram_idle(void)
 	pwrdm_post_transition(NULL);
 
 	/* PER */
-	if (per_next_state < PWRDM_POWER_ON)
-		omap2_gpio_resume_after_idle();
+	if (per_next_state == PWRDM_POWER_OFF)
+		cpu_cluster_pm_exit();
 }
 
 static void omap3_pm_idle(void)
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/cpu_pm.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
@@ -28,9 +29,9 @@
 #include <linux/bitops.h>
 #include <linux/platform_data/gpio-omap.h>
 
-#define OFF_MODE	1
 #define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
 
+#define OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER	BIT(2)
 #define OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN	BIT(1)
 
 static LIST_HEAD(omap_gpio_list);
@@ -72,6 +73,8 @@ struct gpio_bank {
 	raw_spinlock_t wa_lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
+	struct notifier_block nb;
+	unsigned int is_suspended:1;
 	u32 mod_usage;
 	u32 irq_usage;
 	u32 dbck_enable_mask;
@@ -83,7 +86,6 @@ struct gpio_bank {
 	int stride;
 	u32 width;
 	int context_loss_count;
-	int power_mode;
 	bool workaround_enabled;
 	u32 quirks;
 
@@ -1314,6 +1316,38 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	return ret;
 }
 
+static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context);
+static void omap_gpio_unidle(struct gpio_bank *bank);
+
+static int gpio_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v)
+{
+	struct gpio_bank *bank;
+	struct device *dev;
+	unsigned long flags;
+
+	bank = container_of(nb, struct gpio_bank, nb);
+	dev = bank->chip.parent;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (bank->is_suspended)
+			break;
+		omap_gpio_idle(bank, true);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if (bank->is_suspended)
+			break;
+		omap_gpio_unidle(bank);
+		break;
+	}
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	return NOTIFY_OK;
+}
+
 static const struct of_device_id omap_gpio_match[];
 
 static int omap_gpio_probe(struct platform_device *pdev)
@@ -1401,7 +1435,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 			omap4_gpio_enable_level_quirk;
 		bank->funcs.idle_disable_level_quirk =
 			omap4_gpio_disable_level_quirk;
-	} else {
+	} else if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
 		bank->funcs.idle_enable_level_quirk =
 			omap2_gpio_enable_level_quirk;
 		bank->funcs.idle_disable_level_quirk =
@@ -1451,6 +1485,12 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	omap_gpio_show_rev(bank);
 
+	if (bank->funcs.idle_enable_level_quirk &&
+	    bank->funcs.idle_disable_level_quirk) {
+		bank->nb.notifier_call = gpio_omap_cpu_notifier;
+		cpu_pm_register_notifier(&bank->nb);
+	}
+
 	pm_runtime_put(dev);
 
 	list_add_tail(&bank->node, &omap_gpio_list);
@@ -1462,6 +1502,8 @@ static int omap_gpio_remove(struct platform_device *pdev)
 {
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 
+	if (bank->nb.notifier_call)
+		cpu_pm_unregister_notifier(&bank->nb);
 	list_del(&bank->node);
 	gpiochip_remove(&bank->chip);
 	pm_runtime_disable(&pdev->dev);
@@ -1471,19 +1513,12 @@ static int omap_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
-#if defined(CONFIG_PM)
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
-static int omap_gpio_runtime_suspend(struct device *dev)
+static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	struct device *dev = bank->chip.parent;
 	u32 l1 = 0, l2 = 0;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&bank->lock, flags);
 
 	if (bank->funcs.idle_enable_level_quirk)
 		bank->funcs.idle_enable_level_quirk(bank);
@@ -1491,10 +1526,9 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	if (!bank->enabled_non_wakeup_gpios)
 		goto update_gpio_context_count;
 
-	if (bank->power_mode != OFF_MODE) {
-		bank->power_mode = 0;
+	if (!may_lose_context)
 		goto update_gpio_context_count;
-	}
+
 	/*
 	 * If going to OFF, remove triggering for all
 	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
@@ -1519,23 +1553,16 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 				bank->get_context_loss_count(dev);
 
 	omap_gpio_dbck_disable(bank);
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
 }
 
 static void omap_gpio_init_context(struct gpio_bank *p);
 
-static int omap_gpio_runtime_resume(struct device *dev)
+static void omap_gpio_unidle(struct gpio_bank *bank)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	struct device *dev = bank->chip.parent;
 	u32 l = 0, gen, gen0, gen1;
-	unsigned long flags;
 	int c;
 
-	raw_spin_lock_irqsave(&bank->lock, flags);
-
 	/*
 	 * On the first resume during the probe, the context has not
 	 * been initialised and so initialise it now. Also initialise
@@ -1562,16 +1589,13 @@ static int omap_gpio_runtime_resume(struct device *dev)
 			if (c != bank->context_loss_count) {
 				omap_gpio_restore_context(bank);
 			} else {
-				raw_spin_unlock_irqrestore(&bank->lock, flags);
-				return 0;
+				return;
 			}
 		}
 	}
 
-	if (!bank->workaround_enabled) {
-		raw_spin_unlock_irqrestore(&bank->lock, flags);
-		return 0;
-	}
+	if (!bank->workaround_enabled)
+		return;
 
 	l = readl_relaxed(bank->base + bank->regs->datain);
 
@@ -1624,41 +1648,8 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	}
 
 	bank->workaround_enabled = false;
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
 }
-#endif /* CONFIG_PM */
-
-#if IS_BUILTIN(CONFIG_GPIO_OMAP)
-void omap2_gpio_prepare_for_idle(int pwr_mode)
-{
-	struct gpio_bank *bank;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
-			continue;
-
-		bank->power_mode = pwr_mode;
-
-		pm_runtime_put_sync_suspend(bank->chip.parent);
-	}
-}
-
-void omap2_gpio_resume_after_idle(void)
-{
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
-			continue;
-
-		pm_runtime_get_sync(bank->chip.parent);
-	}
-}
-#endif
-
-#if defined(CONFIG_PM)
 static void omap_gpio_init_context(struct gpio_bank *p)
 {
 	struct omap_gpio_reg_offs *regs = p->regs;
@@ -1715,17 +1706,57 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 	writel_relaxed(bank->context.irqenable2,
 				bank->base + bank->regs->irqenable2);
 }
-#endif /* CONFIG_PM */
-#else
-#define omap_gpio_runtime_suspend NULL
-#define omap_gpio_runtime_resume NULL
-static inline void omap_gpio_init_context(struct gpio_bank *p) {}
-#endif
 
+static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	unsigned long flags;
+	int error = 0;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	/* Must be idled only by CPU_CLUSTER_PM_ENTER? */
+	if (bank->irq_usage) {
+		error = -EBUSY;
+		goto unlock;
+	}
+	omap_gpio_idle(bank, true);
+	bank->is_suspended = true;
+unlock:
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	return error;
+}
+
+static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	unsigned long flags;
+	int error = 0;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	/* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
+	if (bank->irq_usage) {
+		error = -EBUSY;
+		goto unlock;
+	}
+	omap_gpio_unidle(bank);
+	bank->is_suspended = false;
+unlock:
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	return error;
+}
+
+#ifdef CONFIG_ARCH_OMAP2PLUS
 static const struct dev_pm_ops gpio_pm_ops = {
 	SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
 									NULL)
 };
+#else
+static const struct dev_pm_ops gpio_pm_ops;
+#endif	/* CONFIG_ARCH_OMAP2PLUS */
 
 #if defined(CONFIG_OF)
 static struct omap_gpio_reg_offs omap2_gpio_regs = {
@@ -1774,6 +1805,11 @@ static struct omap_gpio_reg_offs omap4_gpio_regs = {
 	.fallingdetect =	OMAP4_GPIO_FALLINGDETECT,
 };
 
+/*
+ * Note that omap2 does not currently support idle modes with context loss so
+ * no need to add OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER quirk flag to save
+ * and restore context.
+ */
 static const struct omap_gpio_platform_data omap2_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
@@ -1784,13 +1820,15 @@ static const struct omap_gpio_platform_data omap3_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
+	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER,
 };
 
 static const struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-	.quirks = OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN,
+	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER |
+		  OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN,
 };
 
 static const struct of_device_id omap_gpio_match[] = {
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -205,17 +205,4 @@ struct omap_gpio_platform_data {
 	int (*get_context_loss_count)(struct device *dev);
 };
 
-#if IS_BUILTIN(CONFIG_GPIO_OMAP)
-extern void omap2_gpio_prepare_for_idle(int off_mode);
-extern void omap2_gpio_resume_after_idle(void);
-#else
-static inline void omap2_gpio_prepare_for_idle(int off_mode)
-{
-}
-
-static inline void omap2_gpio_resume_after_idle(void)
-{
-}
-#endif
-
 #endif
-- 
2.19.0
