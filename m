From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 12/18] OMAP: GPIO: cleanup set_debounce, idle/resume_after_idle
Date: Fri, 22 Apr 2011 16:38:26 +0530
Message-ID: <1303470512-19671-13-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38697 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab1DVLE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:59 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

gpio_set_debounce(), gpio_prepare_for_idle() and gpio_resume_after_idle()
are specific to OMAP2PLUS CPUs. These functions rely on "dbck_enable_mask"
which is part of GPIO bank structure.

The above mentioned functions are moved to mach-omap2/gpio.c and the
required information is passed from the OMAP GPIO driver.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |  201 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/gpio.c              |  223 +++-----------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    6 +
 3 files changed, 222 insertions(+), 208 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index a46f4a5..a0edaeb 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -21,13 +21,31 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/clk.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
 #define OMAP2_GPIO_INDEX_MASK		0x1f
 #define OMAP2_GPIO_IRQENA_MASK		0xffffffff
+#define OMAP2_GPIO_DEBOUNCE_MIN_CHK	32
+#define OMAP2_GPIO_DEBOUNCE_MAX_CHK	7936
+#define OMAP2_GPIO_DEBOUNCE_MIN_VAL	0x01
+#define OMAP2_GPIO_DEBOUNCE_MAX_VAL	0xff
+#define OMAP2_GPIO_DEBOUNCE_VAL_DIV	0x1f
 
+struct gpio_state {
+	struct list_head node;
+	u32 saved_datain;
+	u32 saved_fallingdetect;
+	u32 saved_risingdetect;
+	u32 dbck_enable_mask;
+	struct clk *dbck;
+	u16 id;
+};
+
+static int workaround_enabled;
+static LIST_HEAD(omap_gpio_ctx_list);
 int gpio_bank_count;
 int bank_width;
 static u16 *reg_map;
@@ -172,6 +190,161 @@ static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
 	}
 }
 
+static void gpio_debounce_set(void __iomem *base, unsigned gpio,
+		unsigned debounce, u16 id)
+{
+	u32 val;
+	u32 l = 0;
+	struct gpio_state *gpio_dev_state;
+
+	if (debounce < OMAP2_GPIO_DEBOUNCE_MIN_CHK)
+		debounce = OMAP2_GPIO_DEBOUNCE_MIN_VAL;
+	else if (debounce > OMAP2_GPIO_DEBOUNCE_MAX_CHK)
+		debounce = OMAP2_GPIO_DEBOUNCE_MAX_VAL;
+	else
+		debounce = (debounce / OMAP2_GPIO_DEBOUNCE_VAL_DIV) - 1;
+
+	gpio_write(debounce, base, DEBOUNCE_VAL);
+
+	val = gpio_read(base, DEBOUNCE_EN);
+	l = 1 << get_gpio_index(gpio);
+
+	list_for_each_entry(gpio_dev_state, &omap_gpio_ctx_list, node) {
+		if (gpio_dev_state->id == id) {
+			if (debounce) {
+				val |= l;
+				clk_enable(gpio_dev_state->dbck);
+			} else {
+				val &= ~l;
+				clk_disable(gpio_dev_state->dbck);
+			}
+			gpio_dev_state->dbck_enable_mask = val;
+			gpio_write(val, base, DEBOUNCE_EN);
+		}
+	}
+}
+
+static void gpio_prepare_for_idle(u32 enabled_non_wakeup_gpios, u16 id,
+		void __iomem *base, int off_mode)
+{
+	int c = 0;
+	struct gpio_state *gpio_dev_state;
+
+	list_for_each_entry(gpio_dev_state, &omap_gpio_ctx_list, node) {
+		u32 l1 = 0, l2 = 0;
+		int j;
+
+		if (!gpio_dev_state->id == id)
+			continue;
+
+		if ((cpu_is_omap34xx()) && (id == 0))
+			continue;
+
+		for (j = 0; j < hweight_long(gpio_dev_state->dbck_enable_mask);
+				j++)
+			clk_disable(gpio_dev_state->dbck);
+
+		if (!off_mode)
+			continue;
+
+		/*
+		 * If going to OFF, remove triggering for all
+		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+		 * generated.  See OMAP2420 Errata item 1.101.
+		 */
+		if (!enabled_non_wakeup_gpios)
+			continue;
+
+		gpio_dev_state->saved_datain = gpio_read(base, DATAIN);
+		l1 = gpio_read(base, FALLINGDETECT);
+		l2 = gpio_read(base, RISINGDETECT);
+
+		gpio_dev_state->saved_fallingdetect = l1;
+		gpio_dev_state->saved_risingdetect = l2;
+		l1 &= ~enabled_non_wakeup_gpios;
+		l2 &= ~enabled_non_wakeup_gpios;
+
+		gpio_write(l1, base, FALLINGDETECT);
+		gpio_write(l2, base, RISINGDETECT);
+
+		c++;
+	}
+	if (!c) {
+		workaround_enabled = 0;
+		return;
+	}
+	workaround_enabled = 1;
+}
+
+static void gpio_resume_after_idle(u32 enabled_non_wakeup_gpios, u16 id,
+		void __iomem *base)
+{
+	struct gpio_state *gpio_dev_state;
+
+	list_for_each_entry(gpio_dev_state, &omap_gpio_ctx_list, node) {
+		u32 l = 0, gen, gen0, gen1;
+		int j;
+
+		if (!gpio_dev_state->id == id)
+			continue;
+
+		if ((cpu_is_omap34xx()) && (id == 0))
+			continue;
+
+		for (j = 0; j < hweight_long(gpio_dev_state->dbck_enable_mask);
+				j++)
+			clk_enable(gpio_dev_state->dbck);
+
+		if (!workaround_enabled)
+			continue;
+
+		if (!enabled_non_wakeup_gpios)
+			continue;
+
+		gpio_write(gpio_dev_state->saved_fallingdetect, base,
+				FALLINGDETECT);
+		gpio_write(gpio_dev_state->saved_risingdetect, base,
+				RISINGDETECT);
+
+		l = gpio_read(base, DATAIN);
+		/*
+		 * Check if any of the non-wakeup interrupt GPIOs have changed
+		 * state.  If so, generate an IRQ by software.  This is
+		 * horribly racy, but it's the best we can do to work around
+		 * this silicon bug.
+		 */
+		l ^= gpio_dev_state->saved_datain;
+		l &= enabled_non_wakeup_gpios;
+
+		/*
+		 * No need to generate IRQs for the rising edge for gpio IRQs
+		 * configured with falling edge only; and vice versa.
+		 */
+		gen0 = l & gpio_dev_state->saved_fallingdetect;
+		gen0 &= gpio_dev_state->saved_datain;
+
+		gen1 = l & gpio_dev_state->saved_risingdetect;
+		gen1 &= ~(gpio_dev_state->saved_datain);
+
+		/* FIXME: Consider GPIO IRQs with level detections properly! */
+		gen = l & (~(gpio_dev_state->saved_fallingdetect) &
+				~(gpio_dev_state->saved_risingdetect));
+		/* Consider all GPIO IRQs needed to be updated */
+		gen |= gen0 | gen1;
+
+		if (gen) {
+			u32 old0, old1;
+
+			old0 = gpio_read(base, LEVELDETECT0);
+			old1 = gpio_read(base, LEVELDETECT1);
+			gpio_write(old0 | gen, base, LEVELDETECT0);
+			gpio_write(old1 | gen, base, LEVELDETECT1);
+			gpio_write(old0, base, LEVELDETECT0);
+			gpio_write(old1, base, LEVELDETECT1);
+		}
+	}
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
@@ -180,6 +353,9 @@ static struct omap_gpio_func gpio_fn = {
 	.gpio_set_trigger = gpio_set_trigger,
 	.gpio_is_irqena = gpio_is_irqena,
 	.gpio_enable_irq = gpio_enable_irq,
+	.gpio_debounce_set = gpio_debounce_set,
+	.gpio_idle = gpio_prepare_for_idle,
+	.gpio_resume_after_idle = gpio_resume_after_idle,
 };
 
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
@@ -189,6 +365,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	struct omap_gpio_dev_attr *dev_attr;
 	char *name = "omap_gpio";
 	int id;
+	struct gpio_state *gpio_dev_state;
 
 	/*
 	 * extract the device id from name field available in the
@@ -229,19 +406,39 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -EINVAL;
 	}
 
+	gpio_dev_state = kzalloc(sizeof(struct gpio_state), GFP_KERNEL);
+	if (!gpio_dev_state) {
+		pr_err("%s:, Memory alloc failed for gpio_dev_state\n",
+				__func__);
+		kfree(pdata);
+		return -ENOMEM;
+	}
+
+	gpio_dev_state->id = id - 1;
+	list_add_tail(&gpio_dev_state->node, &omap_gpio_ctx_list);
+
 	od = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
 				false);
-	kfree(pdata);
-
 	if (IS_ERR(od)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 					name, oh->name);
+		kfree(gpio_dev_state);
+		kfree(pdata);
 		return PTR_ERR(od);
 	}
 
 	gpio_bank_count++;
+	if (pdata->dbck_flag) {
+		gpio_dev_state->dbck = clk_get(&od->pdev.dev, "dbclk");
+		if (IS_ERR(gpio_dev_state->dbck))
+			dev_err(&od->pdev.dev, "Could not get gpio%d dbck\n",
+					id);
+	}
+
+	kfree(pdata);
+
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f2cd2dd..55115df 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -150,16 +150,11 @@ struct gpio_bank {
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	u16 id;
-	u32 saved_datain;
-	u32 saved_fallingdetect;
-	u32 saved_risingdetect;
 	u32 level_mask;
 	u32 toggle_mask;
 	spinlock_t lock;
 	struct gpio_chip chip;
-	struct clk *dbck;
 	u32 mod_usage;
-	u32 dbck_enable_mask;
 	struct device *dev;
 	bool dbck_flag;
 	int stride;
@@ -331,47 +326,12 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 		unsigned debounce)
 {
-	void __iomem		*reg = bank->base;
-	u32			val;
-	u32			l;
-
 	if (!bank->dbck_flag)
 		return;
 
-	if (debounce < 32)
-		debounce = 0x01;
-	else if (debounce > 7936)
-		debounce = 0xff;
-	else
-		debounce = (debounce / 0x1f) - 1;
-
-	l = 1 << gpio_fn.get_index(gpio);
-
-	if (bank->method == METHOD_GPIO_44XX)
-		reg += OMAP4_GPIO_DEBOUNCINGTIME;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
-
-	__raw_writel(debounce, reg);
-
-	reg = bank->base;
-	if (bank->method == METHOD_GPIO_44XX)
-		reg += OMAP4_GPIO_DEBOUNCENABLE;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
-
-	val = __raw_readl(reg);
-
-	if (debounce) {
-		val |= l;
-		clk_enable(bank->dbck);
-	} else {
-		val &= ~l;
-		clk_disable(bank->dbck);
-	}
-	bank->dbck_enable_mask = val;
-
-	__raw_writel(val, reg);
+	if (!gpio_fn.gpio_debounce_set)
+		gpio_fn.gpio_debounce_set(bank->base, gpio, debounce,
+				bank->id);
 }
 
 /*
@@ -1083,12 +1043,6 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 
 	bank = container_of(chip, struct gpio_bank, chip);
 
-	if (!bank->dbck) {
-		bank->dbck = clk_get(bank->dev, "dbclk");
-		if (IS_ERR(bank->dbck))
-			dev_err(bank->dev, "Could not get gpio dbck\n");
-	}
-
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_debounce(bank, offset, debounce);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -1320,6 +1274,10 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		gpio_fn.gpio_set_trigger = pdata->gpio_fn->gpio_set_trigger;
 		gpio_fn.gpio_is_irqena = pdata->gpio_fn->gpio_is_irqena;
 		gpio_fn.gpio_enable_irq = pdata->gpio_fn->gpio_enable_irq;
+		gpio_fn.gpio_debounce_set = pdata->gpio_fn->gpio_debounce_set;
+		gpio_fn.gpio_idle = pdata->gpio_fn->gpio_idle;
+		gpio_fn.gpio_resume_after_idle =
+			pdata->gpio_fn->gpio_resume_after_idle;
 		gpio_init_done = 1;
 	}
 
@@ -1401,179 +1359,32 @@ static struct sys_device omap_gpio_device = {
 	.cls		= &omap_gpio_sysclass,
 };
 
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
-static int workaround_enabled;
-
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
-	int c = 0;
 	struct gpio_bank *bank;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 l1 = 0, l2 = 0;
-		int j;
-
-		/* TODO: Do not use cpu_is_omap34xx */
-		if ((cpu_is_omap34xx()) && (bank->id == 0))
-			continue;
-
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_disable(bank->dbck);
-
-		if (!off_mode)
-			continue;
-
-		/* If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
-		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
-
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
-
-		bank->saved_fallingdetect = l1;
-		bank->saved_risingdetect = l2;
-		l1 &= ~bank->enabled_non_wakeup_gpios;
-		l2 &= ~bank->enabled_non_wakeup_gpios;
-
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
-
-		c++;
-	}
-	if (!c) {
-		workaround_enabled = 0;
+	if (!gpio_fn.gpio_idle)
 		return;
+
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		gpio_fn.gpio_idle(bank->enabled_non_wakeup_gpios,
+					bank->id, bank->base, off_mode);
 	}
-	workaround_enabled = 1;
 }
 
 void omap2_gpio_resume_after_idle(void)
 {
 	struct gpio_bank *bank;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 l = 0, gen, gen0, gen1;
-		int j;
-
-		/* TODO: Do not use cpu_is_omap34xx */
-		if ((cpu_is_omap34xx()) && (bank->id == 0))
-			continue;
-
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_enable(bank->dbck);
-
-		if (!workaround_enabled)
-			continue;
-
-		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
-
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
-
-		/* Check if any of the non-wakeup interrupt GPIOs have changed
-		 * state.  If so, generate an IRQ by software.  This is
-		 * horribly racy, but it's the best we can do to work around
-		 * this silicon bug. */
-		l ^= bank->saved_datain;
-		l &= bank->enabled_non_wakeup_gpios;
-
-		/*
-		 * No need to generate IRQs for the rising edge for gpio IRQs
-		 * configured with falling edge only; and vice versa.
-		 */
-		gen0 = l & bank->saved_fallingdetect;
-		gen0 &= bank->saved_datain;
-
-		gen1 = l & bank->saved_risingdetect;
-		gen1 &= ~(bank->saved_datain);
-
-		/* FIXME: Consider GPIO IRQs with level detections properly! */
-		gen = l & (~(bank->saved_fallingdetect) &
-				~(bank->saved_risingdetect));
-		/* Consider all GPIO IRQs needed to be updated */
-		gen |= gen0 | gen1;
-
-		if (gen) {
-			u32 old0, old1;
-
-			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
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
-			}
+	if (!gpio_fn.gpio_resume_after_idle)
+		return;
 
-			if (cpu_is_omap44xx()) {
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
-			}
-		}
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		gpio_fn.gpio_resume_after_idle(bank->enabled_non_wakeup_gpios,
+					bank->id, bank->base);
 	}
-
 }
 
-#endif
-
 #ifdef CONFIG_ARCH_OMAP3
 /* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 331ee4c..bfd5b6c 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -116,6 +116,12 @@ struct omap_gpio_func {
 	int (*gpio_set_trigger)(void __iomem *base, int gpio, int trigger);
 	u32 (*gpio_is_irqena)(void __iomem *base);
 	void (*gpio_enable_irq)(void __iomem *base, int gpio_mask, int enable);
+	void (*gpio_debounce_set)(void __iomem *base, unsigned gpio,
+			unsigned debounce, u16 id);
+	void (*gpio_idle)(u32 enabled_non_wakeup_gpios, u16 id,
+			void __iomem *base, int offmode);
+	void (*gpio_resume_after_idle)(u32 enabled_non_wakeup_gpios, u16 id,
+			void __iomem *base);
 };
 
 struct omap_gpio_platform_data {
-- 
1.7.1

