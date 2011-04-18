From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 6/7] OMAP: GPIO: Cleanup prepare_for_idle/resume
Date: Mon, 18 Apr 2011 20:36:56 +0530
Message-ID: <1303139217-10285-7-git-send-email-charu@ti.com>
References: <no>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346Ab1DRPDt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 11:03:49 -0400
In-Reply-To: <no>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, paul@pwsan.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Use a function named gpio_bank_handle_idle() in
omap_gpio_prepare_for_idle() to do the following:

* debounce clock disable
* if the next powerdomain state for the bank is off-mode:
  - remove triggering for all non-wakeup GPIOs (this is handled by
    a new function named omap_gpio_idle_handle_errata_i468())
  - save context

Also handle omap_gpio_resume_after_idle() in a
similar way, using a function gpio_bank_handle_resume().

This would be helpful while modifying OMAP GPIO driver to use
PM runtime framework.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |  350 ++++++++++++++++++++++++---------------------
 1 files changed, 187 insertions(+), 163 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 5933c98..7660c06 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1747,6 +1747,187 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
+static int is_pwrdm_nxt_state_off;
+
+static inline void omap_gpio_idle_handle_errata_i468(struct gpio_bank *bank)
+{
+	u32 l1 = 0, l2 = 0;
+
+	/*
+	 * If going to OFF, remove triggering for all
+	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+	 * generated.  See OMAP2420 Errata item 1.101.
+	 */
+	if (!(bank->enabled_non_wakeup_gpios))
+		return;
+
+	if (bank->method == METHOD_GPIO_24XX) {
+		bank->saved_datain = __raw_readl(bank->base +
+						OMAP24XX_GPIO_DATAIN);
+
+		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		bank->saved_datain = __raw_readl(bank->base +
+						OMAP4_GPIO_DATAIN);
+
+		l1 = __raw_readl(bank->base + OMAP4_GPIO_FALLINGDETECT);
+		l2 = __raw_readl(bank->base + OMAP4_GPIO_RISINGDETECT);
+	}
+
+	bank->saved_fallingdetect = l1;
+	bank->saved_risingdetect = l2;
+	l1 &= ~bank->enabled_non_wakeup_gpios;
+	l2 &= ~bank->enabled_non_wakeup_gpios;
+
+	if (bank->method == METHOD_GPIO_24XX) {
+		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
+	}
+
+	bank->off_mode_wkup_wa_enabled = true;
+}
+
+static inline void omap_gpio_resume_handle_errata_i468(struct gpio_bank *bank)
+{
+	u32 l = 0, gen, gen0, gen1;
+
+	if (!bank->off_mode_wkup_wa_enabled)
+		return;
+
+	bank->off_mode_wkup_wa_enabled = false;
+
+	if (!(bank->enabled_non_wakeup_gpios))
+		return;
+
+	if (bank->method == METHOD_GPIO_24XX) {
+		__raw_writel(bank->saved_fallingdetect,
+				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+		__raw_writel(bank->saved_risingdetect,
+				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
+
+		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		__raw_writel(bank->saved_fallingdetect,
+				 bank->base + OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(bank->saved_risingdetect,
+				 bank->base + OMAP4_GPIO_RISINGDETECT);
+
+		l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
+	}
+
+	/*
+	 * Check if any of the non-wakeup interrupt GPIOs have changed
+	 * state.  If so, generate an IRQ by software.  This is
+	 * horribly racy, but it's the best we can do to work around
+	 * this silicon bug.
+	 */
+	l ^= bank->saved_datain;
+	l &= bank->enabled_non_wakeup_gpios;
+
+	/*
+	 * No need to generate IRQs for the rising edge for gpio IRQs
+	 * configured with falling edge only; and vice versa.
+	 */
+	gen0 = l & bank->saved_fallingdetect;
+	gen0 &= bank->saved_datain;
+	gen1 = l & bank->saved_risingdetect;
+	gen1 &= ~(bank->saved_datain);
+
+	/* FIXME: Consider GPIO IRQs with level detections properly! */
+	gen = l & (~(bank->saved_fallingdetect) & ~(bank->saved_risingdetect));
+
+	/* Consider all GPIO IRQs needed to be updated */
+	gen |= gen0 | gen1;
+
+	if (gen) {
+		u32 old0, old1;
+
+		if (bank->method == METHOD_GPIO_24XX) {
+			old0 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+			old1 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
+			__raw_writel(old0 | gen, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_writel(old1 | gen, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
+			__raw_writel(old0, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_writel(old1, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
+		} else if (bank->method == METHOD_GPIO_44XX) {
+			old0 = __raw_readl(bank->base +
+					OMAP4_GPIO_LEVELDETECT0);
+			old1 = __raw_readl(bank->base +
+					OMAP4_GPIO_LEVELDETECT1);
+			__raw_writel(old0 | l, bank->base +
+					OMAP4_GPIO_LEVELDETECT0);
+			__raw_writel(old1 | l, bank->base +
+					OMAP4_GPIO_LEVELDETECT1);
+			__raw_writel(old0, bank->base +
+					OMAP4_GPIO_LEVELDETECT0);
+			__raw_writel(old1, bank->base +
+					OMAP4_GPIO_LEVELDETECT1);
+		}
+	}
+}
+
+static int gpio_bank_handle_idle(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
+	int j;
+
+	/* If the gpio bank is not used, do nothing */
+	if (!bank->mod_usage || !bank->looses_context)
+		return 0;
+
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_disable(bank->dbck);
+
+	/* Save the context lost count */
+	bank->ctx_lost_cnt_before =
+				omap_device_get_context_loss_count(pdev);
+
+	if (is_pwrdm_nxt_state_off) {
+		omap_gpio_idle_handle_errata_i468(bank);
+		omap_gpio_save_context(bank);
+	}
+
+	return 0;
+}
+
+static int gpio_bank_handle_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = &gpio_bank[pdev->id];
+	u32 ctx_lost_cnt_after;
+	int j;
+
+	/* If the gpio bank is not used, do nothing */
+	if (!bank->mod_usage || !bank->looses_context)
+		return 0;
+
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_enable(bank->dbck);
+
+	pdev = to_platform_device(bank->dev);
+	ctx_lost_cnt_after = omap_device_get_context_loss_count(pdev);
+
+	if (ctx_lost_cnt_after != bank->ctx_lost_cnt_before) {
+		omap_gpio_resume_handle_errata_i468(bank);
+		omap_gpio_restore_context(bank);
+	}
+
+	return 0;
+}
+#endif
+
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
@@ -1864,183 +2045,26 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	int i;
 
+	is_pwrdm_nxt_state_off = off_mode;
+
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		struct platform_device *pdev;
-		u32 l1 = 0, l2 = 0;
-		int j;
-
-		/* If the gpio bank is not used, do nothing */
-		if (!bank->mod_usage)
-			continue;
-
-		if (!bank->looses_context)
-			continue;
-
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_disable(bank->dbck);
-
-		if (!off_mode)
-			continue;
-
-		/*
-		 * If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101.
-		 */
-		if (!(bank->enabled_non_wakeup_gpios))
-			goto save_gpio_ctx;
-
-		if (bank->method == METHOD_GPIO_24XX) {
-			bank->saved_datain = __raw_readl(bank->base +
-					OMAP24XX_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		} else if (bank->method == METHOD_GPIO_44XX) {
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
-		if (bank->method == METHOD_GPIO_24XX) {
-			__raw_writel(l1, bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		} else if (bank->method == METHOD_GPIO_44XX) {
-			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
-		}
-
-		bank->off_mode_wkup_wa_enabled = true;
 
-save_gpio_ctx:
-		pdev = to_platform_device(bank->dev);
-		bank->ctx_lost_cnt_before =
-				omap_device_get_context_loss_count(pdev);
-		omap_gpio_save_context(bank);
+		gpio_bank_handle_idle(bank->dev);
 	}
 }
 
 void omap2_gpio_resume_after_idle(void)
 {
 	int i;
-	u32 ctx_lost_cnt_after;
+
+	is_pwrdm_nxt_state_off = 0;
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		struct platform_device *pdev;
-		u32 l = 0, gen, gen0, gen1;
-		int j;
-
-		/* If the gpio bank is not used, do nothing */
-		if (!bank->mod_usage)
-			continue;
-
-		if (!bank->looses_context)
-			continue;
-
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_enable(bank->dbck);
-
-		pdev = to_platform_device(bank->dev);
-		ctx_lost_cnt_after = omap_device_get_context_loss_count(pdev);
-
-		if (ctx_lost_cnt_after == bank->ctx_lost_cnt_before)
-			continue;
-
-		if (!bank->off_mode_wkup_wa_enabled)
-			goto restore_gpio_ctx;
-
-		if (!(bank->enabled_non_wakeup_gpios))
-			goto restore_gpio_ctx;
-
-		if (bank->method == METHOD_GPIO_24XX) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
-		} else if (bank->method == METHOD_GPIO_44XX) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP4_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
-		}
-
-		/*
-		 * Check if any of the non-wakeup interrupt GPIOs have changed
-		 * state.  If so, generate an IRQ by software.  This is
-		 * horribly racy, but it's the best we can do to work around
-		 * this silicon bug.
-		 */
-		l ^= bank->saved_datain;
-		l &= bank->enabled_non_wakeup_gpios;
 
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
-			if (bank->method == METHOD_GPIO_24XX) {
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
-			} else if (bank->method == METHOD_GPIO_44XX) {
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
-
-restore_gpio_ctx:
-		bank->off_mode_wkup_wa_enabled = false;
-		omap_gpio_restore_context(bank);
+		gpio_bank_handle_resume(bank->dev);
 	}
-
 }
 
 void omap_gpio_save_context(struct gpio_bank *bank)
-- 
1.7.1

