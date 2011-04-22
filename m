From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 13/18] OMAP: GPIO: cleanup save/restore context
Date: Fri, 22 Apr 2011 16:38:27 +0530
Message-ID: <1303470512-19671-14-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60472 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab1DVLFC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:05:02 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Move GPIO save/restore context to SoC specific file.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |   78 +++++++++++++++++++++++++++
 arch/arm/plat-omap/gpio.c              |   91 ++++---------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    2 +
 3 files changed, 92 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index a0edaeb..a7bb005 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -34,6 +34,19 @@
 #define OMAP2_GPIO_DEBOUNCE_MAX_VAL	0xff
 #define OMAP2_GPIO_DEBOUNCE_VAL_DIV	0x1f
 
+struct omap_gpio_regs {
+	u32 irqenable1;
+	u32 irqenable2;
+	u32 wake_en;
+	u32 ctrl;
+	u32 oe;
+	u32 leveldetect0;
+	u32 leveldetect1;
+	u32 risingdetect;
+	u32 fallingdetect;
+	u32 dataout;
+};
+
 struct gpio_state {
 	struct list_head node;
 	u32 saved_datain;
@@ -42,6 +55,7 @@ struct gpio_state {
 	u32 dbck_enable_mask;
 	struct clk *dbck;
 	u16 id;
+	struct omap_gpio_regs gpio_ctx;
 };
 
 static int workaround_enabled;
@@ -345,6 +359,68 @@ static void gpio_resume_after_idle(u32 enabled_non_wakeup_gpios, u16 id,
 	}
 }
 
+static void gpio_save_ctx(void __iomem *base, u32 id)
+{
+	struct gpio_state *gpio_dev_state;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	list_for_each_entry(gpio_dev_state, &omap_gpio_ctx_list, node) {
+		/* saving banks from 2-6 only since GPIO1 is in WKUP */
+		if ((gpio_dev_state->id == 0) || (gpio_dev_state->id != id))
+			continue;
+
+		gpio_dev_state->gpio_ctx.irqenable1 = gpio_read(base,
+								IRQENABLE1);
+		gpio_dev_state->gpio_ctx.irqenable2 = gpio_read(base,
+								IRQENABLE2);
+		gpio_dev_state->gpio_ctx.wake_en = gpio_read(base, WAKE_EN);
+		gpio_dev_state->gpio_ctx.ctrl = gpio_read(base, CTRL);
+		gpio_dev_state->gpio_ctx.oe = gpio_read(base, OE);
+		gpio_dev_state->gpio_ctx.leveldetect0 = gpio_read(base,
+								LEVELDETECT0);
+		gpio_dev_state->gpio_ctx.leveldetect1 = gpio_read(base,
+								LEVELDETECT1);
+		gpio_dev_state->gpio_ctx.risingdetect = gpio_read(base,
+								RISINGDETECT);
+		gpio_dev_state->gpio_ctx.fallingdetect = gpio_read(base,
+								FALLINGDETECT);
+		gpio_dev_state->gpio_ctx.dataout = gpio_read(base, DATAOUT);
+	}
+}
+
+static void gpio_restore_ctx(void __iomem *base, u32 id)
+{
+	struct gpio_state *gpio_dev_state;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	list_for_each_entry(gpio_dev_state, &omap_gpio_ctx_list, node) {
+		/* restore the required registers of bank 2-6 */
+		if ((gpio_dev_state->id == 0) || (gpio_dev_state->id != id))
+			continue;
+
+		gpio_write(gpio_dev_state->gpio_ctx.irqenable1, base,
+				IRQENABLE1);
+		gpio_write(gpio_dev_state->gpio_ctx.irqenable2, base,
+				IRQENABLE2);
+		gpio_write(gpio_dev_state->gpio_ctx.wake_en, base, WAKE_EN);
+		gpio_write(gpio_dev_state->gpio_ctx.ctrl, base, CTRL);
+		gpio_write(gpio_dev_state->gpio_ctx.oe, base, OE);
+		gpio_write(gpio_dev_state->gpio_ctx.leveldetect0, base,
+				LEVELDETECT0);
+		gpio_write(gpio_dev_state->gpio_ctx.leveldetect1, base,
+				LEVELDETECT1);
+		gpio_write(gpio_dev_state->gpio_ctx.risingdetect, base,
+				RISINGDETECT);
+		gpio_write(gpio_dev_state->gpio_ctx.fallingdetect, base,
+				FALLINGDETECT);
+		gpio_write(gpio_dev_state->gpio_ctx.dataout, base, DATAOUT);
+	}
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
@@ -356,6 +432,8 @@ static struct omap_gpio_func gpio_fn = {
 	.gpio_debounce_set = gpio_debounce_set,
 	.gpio_idle = gpio_prepare_for_idle,
 	.gpio_resume_after_idle = gpio_resume_after_idle,
+	.gpio_save_ctx = gpio_save_ctx,
+	.gpio_restore_ctx = gpio_restore_ctx,
 };
 
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 55115df..fd710cd 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -160,25 +160,7 @@ struct gpio_bank {
 	int stride;
 };
 
-#ifdef CONFIG_ARCH_OMAP3
-struct omap3_gpio_regs {
-	u32 irqenable1;
-	u32 irqenable2;
-	u32 wake_en;
-	u32 ctrl;
-	u32 oe;
-	u32 leveldetect0;
-	u32 leveldetect1;
-	u32 risingdetect;
-	u32 fallingdetect;
-	u32 dataout;
-};
-
-static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
-#endif
-
 static struct omap_gpio_func gpio_fn;
-
 static int bank_width;
 
 static int check_gpio(int gpio)
@@ -1278,6 +1260,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		gpio_fn.gpio_idle = pdata->gpio_fn->gpio_idle;
 		gpio_fn.gpio_resume_after_idle =
 			pdata->gpio_fn->gpio_resume_after_idle;
+		gpio_fn.gpio_save_ctx = pdata->gpio_fn->gpio_save_ctx;
+		gpio_fn.gpio_restore_ctx = pdata->gpio_fn->gpio_restore_ctx;
 		gpio_init_done = 1;
 	}
 
@@ -1385,78 +1369,27 @@ void omap2_gpio_resume_after_idle(void)
 	}
 }
 
-#ifdef CONFIG_ARCH_OMAP3
-/* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
 {
 	struct gpio_bank *bank;
-	int i = 0;
 
-	/* saving banks from 2-6 only since GPIO1 is in WKUP */
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		i++;
-
-		if (bank->id == 0)
-			continue;
-
-		gpio_context[i].irqenable1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		gpio_context[i].irqenable2 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		gpio_context[i].wake_en =
-			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
-		gpio_context[i].ctrl =
-			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
-		gpio_context[i].oe =
-			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
-		gpio_context[i].leveldetect0 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		gpio_context[i].leveldetect1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		gpio_context[i].risingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		gpio_context[i].fallingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		gpio_context[i].dataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
-	}
+	if (!gpio_fn.gpio_save_ctx)
+		return;
+
+	list_for_each_entry(bank, &omap_gpio_list, node)
+		gpio_fn.gpio_save_ctx(bank->base, bank->id);
 }
 
-/* restore the required registers of bank 2-6 */
 void omap_gpio_restore_context(void)
 {
 	struct gpio_bank *bank;
-	int i = 0;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		i++;
-
-		if (bank->id == 0)
-			continue;
-
-		__raw_writel(gpio_context[i].irqenable1,
-				bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		__raw_writel(gpio_context[i].irqenable2,
-				bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		__raw_writel(gpio_context[i].wake_en,
-				bank->base + OMAP24XX_GPIO_WAKE_EN);
-		__raw_writel(gpio_context[i].ctrl,
-				bank->base + OMAP24XX_GPIO_CTRL);
-		__raw_writel(gpio_context[i].oe,
-				bank->base + OMAP24XX_GPIO_OE);
-		__raw_writel(gpio_context[i].leveldetect0,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		__raw_writel(gpio_context[i].leveldetect1,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		__raw_writel(gpio_context[i].risingdetect,
-				bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		__raw_writel(gpio_context[i].fallingdetect,
-				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(gpio_context[i].dataout,
-				bank->base + OMAP24XX_GPIO_DATAOUT);
-	}
+	if (!gpio_fn.gpio_restore_ctx)
+		return;
+
+	list_for_each_entry(bank, &omap_gpio_list, node)
+		gpio_fn.gpio_restore_ctx(bank->base, bank->id);
 }
-#endif
 
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index bfd5b6c..0925a6c 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -122,6 +122,8 @@ struct omap_gpio_func {
 			void __iomem *base, int offmode);
 	void (*gpio_resume_after_idle)(u32 enabled_non_wakeup_gpios, u16 id,
 			void __iomem *base);
+	void (*gpio_save_ctx)(void __iomem *base, u32 id);
+	void (*gpio_restore_ctx)(void __iomem *base, u32 id);
 };
 
 struct omap_gpio_platform_data {
-- 
1.7.1

