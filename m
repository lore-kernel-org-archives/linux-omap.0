From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] ARM: OMAP: unwrap strings
Date: Tue, 07 Aug 2012 04:34:46 -0600
Message-ID: <20120807103443.8053.68917.stgit@dusk.lan>
References: <20120807103009.8053.69389.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32773 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab2HGKfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:35:41 -0400
In-Reply-To: <20120807103009.8053.69389.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Find and unwrap wrapped strings in the style:

	pr_debug("clockdomain: hardware cannot set/clear wake up of "
		 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);

Keeping these strings contiguous seems to be the current Linux kernel
policy.

The offending lines were found with the following command:

    pcregrep -rnM '"\s*$\s*"' arch/arm/*omap*

While here, some messages have been clarified, some pr_warning(
... calls have been converted to pr_warn( ..., and some printk(KERN_*
... have been converted to pr_*.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/board-htcherald.c       |    3 -
 arch/arm/mach-omap1/clock.c                 |    4 +
 arch/arm/mach-omap1/clock_data.c            |   13 ++---
 arch/arm/mach-omap1/dma.c                   |    5 +-
 arch/arm/mach-omap1/lcd_dma.c               |    6 +-
 arch/arm/mach-omap2/board-n8x0.c            |    7 +--
 arch/arm/mach-omap2/board-overo.c           |    6 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 +--
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c      |   10 +---
 arch/arm/mach-omap2/clkt_clksel.c           |   28 +++++-----
 arch/arm/mach-omap2/clkt_dpll.c             |    8 +--
 arch/arm/mach-omap2/clock.c                 |   20 +++----
 arch/arm/mach-omap2/clock3xxx.c             |    3 -
 arch/arm/mach-omap2/clockdomain.c           |   74 ++++++++++++---------------
 arch/arm/mach-omap2/common-board-devices.c  |    3 -
 arch/arm/mach-omap2/id.c                    |    5 +-
 arch/arm/mach-omap2/irq.c                   |    5 +-
 arch/arm/mach-omap2/omap_hwmod.c            |    4 +
 arch/arm/mach-omap2/opp.c                   |   15 ++---
 arch/arm/mach-omap2/pm.c                    |    4 +
 arch/arm/mach-omap2/pm34xx.c                |    8 +--
 arch/arm/mach-omap2/pm44xx.c                |    8 +--
 arch/arm/mach-omap2/powerdomain.c           |   36 ++++++-------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c  |    4 +
 arch/arm/mach-omap2/powerdomain44xx.c       |    4 +
 arch/arm/mach-omap2/prcm.c                  |    8 +--
 arch/arm/mach-omap2/serial.c                |    5 +-
 arch/arm/mach-omap2/sr_device.c             |   13 ++---
 arch/arm/mach-omap2/vc.c                    |    5 +-
 arch/arm/mach-omap2/voltage.c               |   12 ++--
 arch/arm/mach-omap2/vp.c                    |   16 +++---
 arch/arm/plat-omap/dma.c                    |   42 +++++++--------
 arch/arm/plat-omap/omap-pm-noop.c           |   39 +++++++-------
 arch/arm/plat-omap/omap_device.c            |   25 ++++-----
 34 files changed, 203 insertions(+), 252 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index b3f6e94..f0ef008 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -476,8 +476,7 @@ static void __init htcherald_lcd_init(void)
 				break;
 		}
 		if (!tries)
-			printk(KERN_WARNING "Timeout waiting for end of frame "
-			       "-- LCD may not be available\n");
+			pr_err("Timeout waiting for end of frame -- LCD may not be available\n");
 
 		/* turn off DMA */
 		reg = omap_readw(OMAP_DMA_LCD_CCR);
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index a9ee06b..638f407 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -587,8 +587,8 @@ void omap1_clk_disable_unused(struct clk *clk)
 	/* Clocks in the DSP domain need api_ck. Just assume bootloader
 	 * has not enabled any DSP clocks */
 	if (clk->enable_reg == DSP_IDLECT2) {
-		printk(KERN_INFO "Skipping reset check for DSP domain "
-		       "clock \"%s\"\n", clk->name);
+		pr_info("Skipping reset check for DSP domain clock \"%s\"\n",
+			clk->name);
 		return;
 	}
 
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index c007d80..243e8b2 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -776,11 +776,10 @@ static struct clk_functions omap1_clk_functions = {
 
 static void __init omap1_show_rates(void)
 {
-	pr_notice("Clocking rate (xtal/DPLL1/MPU): "
-			"%ld.%01ld/%ld.%01ld/%ld.%01ld MHz\n",
-		ck_ref.rate / 1000000, (ck_ref.rate / 100000) % 10,
-		ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
-		arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
+	pr_notice("Clocking rate (xtal/DPLL1/MPU): %ld.%01ld/%ld.%01ld/%ld.%01ld MHz\n",
+		  ck_ref.rate / 1000000, (ck_ref.rate / 100000) % 10,
+		  ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
+		  arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
 }
 
 u32 cpu_mask;
@@ -848,8 +847,8 @@ int __init omap1_clk_init(void)
 	if (cpu_is_omap16xx() && crystal_type == 2)
 		ck_ref.rate = 19200000;
 
-	pr_info("Clocks: ARM_SYSST: 0x%04x DPLL_CTL: 0x%04x ARM_CKCTL: "
-		"0x%04x\n", omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
+	pr_info("Clocks: ARM_SYSST: 0x%04x DPLL_CTL: 0x%04x ARM_CKCTL: 0x%04x\n",
+		omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
 		omap_readw(ARM_CKCTL));
 
 	/* We want to be in syncronous scalable mode */
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 3ef7d52..f51014d 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -330,8 +330,9 @@ static int __init omap1_system_dma_init(void)
 	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
 					(d->lch_count), GFP_KERNEL);
 	if (!d->chan) {
-		dev_err(&pdev->dev, "%s: Memory allocation failed"
-					"for d->chan!!!\n", __func__);
+		dev_err(&pdev->dev,
+			"%s: Memory allocation failed for d->chan!\n",
+			__func__);
 		goto exit_release_d;
 	}
 
diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dma.c
index 6ec931c..a4dc522 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -112,8 +112,7 @@ EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
 void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
 {
 	if (cpu_is_omap15xx()) {
-		printk(KERN_ERR "DMA virtual resolution is not supported "
-				"in 1510 mode\n");
+		pr_err("DMA virtual resolution is not supported in 1510 mode\n");
 		BUG();
 	}
 	lcd_dma.vxres = vxres;
@@ -432,8 +431,7 @@ static int __init omap_init_lcd_dma(void)
 	r = request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
 			"LCD DMA", NULL);
 	if (r != 0)
-		printk(KERN_ERR "unable to request IRQ for LCD DMA "
-			       "(error %d)\n", r);
+		pr_err("unable to request IRQ for LCD DMA (error %d)\n", r);
 
 	return r;
 }
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 677357f..807299a 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -553,8 +553,8 @@ static int n8x0_auto_sleep_regulators(void)
 
 	ret = menelaus_set_regulator_sleep(1, val);
 	if (ret < 0) {
-		printk(KERN_ERR "Could not set regulators to sleep on "
-			"menelaus: %u\n", ret);
+		pr_err("Could not set regulators to sleep on menelaus: %u\n",
+		       ret);
 		return ret;
 	}
 	return 0;
@@ -566,8 +566,7 @@ static int n8x0_auto_voltage_scale(void)
 
 	ret = menelaus_set_vcore_hw(1400, 1050);
 	if (ret < 0) {
-		printk(KERN_ERR "Could not set VCORE voltage on "
-			"menelaus: %u\n", ret);
+		pr_err("Could not set VCORE voltage on menelaus: %u\n", ret);
 		return ret;
 	}
 	return 0;
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 779734d..175135a 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -522,8 +522,7 @@ static void __init overo_init(void)
 		udelay(10);
 		gpio_set_value(OVERO_GPIO_W2W_NRESET, 1);
 	} else {
-		printk(KERN_ERR "could not obtain gpio for "
-					"OVERO_GPIO_W2W_NRESET\n");
+		pr_err("could not obtain gpio for OVERO_GPIO_W2W_NRESET\n");
 	}
 
 	ret = gpio_request_array(overo_bt_gpios, ARRAY_SIZE(overo_bt_gpios));
@@ -542,8 +541,7 @@ static void __init overo_init(void)
 	if (ret == 0)
 		gpio_export(OVERO_GPIO_USBH_CPEN, 0);
 	else
-		printk(KERN_ERR "could not obtain gpio for "
-					"OVERO_GPIO_USBH_CPEN\n");
+		pr_err("could not obtain gpio for OVERO_GPIO_USBH_CPEN\n");
 }
 
 MACHINE_START(OVERO, "Gumstix Overo")
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index f64f441..1873059 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -81,8 +81,7 @@ static inline void __init zoom_init_quaduart(void)
 	quart_cs = ZOOM_QUADUART_CS;
 
 	if (gpmc_cs_request(quart_cs, SZ_1M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem"
-				"for Quad UART(TL16CP754C)\n");
+		pr_err("Failed to request GPMC mem for Quad UART(TL16CP754C)\n");
 		return;
 	}
 
@@ -104,8 +103,8 @@ static inline int omap_zoom_debugboard_detect(void)
 
 	if (gpio_request_one(debug_board_detect, GPIOF_IN,
 			     "Zoom debug board detect") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for Zoom debug"
-		"board detect\n", debug_board_detect);
+		pr_err("Failed to request GPIO%d for Zoom debug board detect\n",
+		       debug_board_detect);
 		return 0;
 	}
 
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index d6e34dd..298887b 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -92,15 +92,13 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 
 	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
 		 validrate);
-	pr_debug("clock: SDRC CS0 timing params used:"
-		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+	pr_debug("clock: SDRC CS0 timing params used: RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
 		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
 		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
 	if (sdrc_cs1)
-		pr_debug("clock: SDRC CS1 timing params used: "
-		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+		pr_debug("clock: SDRC CS1 timing params used: RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+			 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+			 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
 
 	if (sdrc_cs1)
 		omap3_configure_core_dpll(
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index 04d551b..19a9809 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -71,8 +71,8 @@ static const struct clksel *_get_clksel_by_parent(struct clk *clk,
 
 	if (!clks->parent) {
 		/* This indicates a data problem */
-		WARN(1, "clock: Could not find parent clock %s in clksel array "
-		     "of clock %s\n", src_clk->name, clk->name);
+		WARN(1, "clock: %s: could not find parent clock %s in clksel array\n",
+		     clk->name, src_clk->name);
 		return NULL;
 	}
 
@@ -126,8 +126,8 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
 
 	if (max_div == 0) {
 		/* This indicates an error in the clksel data */
-		WARN(1, "clock: Could not find divisor for clock %s parent %s"
-		     "\n", clk->name, src_clk->parent->name);
+		WARN(1, "clock: %s: could not find divisor for parent %s\n",
+		     clk->name, src_clk->parent->name);
 		return 0;
 	}
 
@@ -191,8 +191,8 @@ static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
 
 	if (!clkr->div) {
 		/* This indicates a data error */
-		WARN(1, "clock: Could not find fieldval %d for clock %s parent "
-		     "%s\n", field_val, clk->name, clk->parent->name);
+		WARN(1, "clock: %s: could not find fieldval %d parent %s\n",
+		     clk->name, field_val, clk->parent->name);
 		return 0;
 	}
 
@@ -230,8 +230,8 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
 	}
 
 	if (!clkr->div) {
-		pr_err("clock: Could not find divisor %d for clock %s parent "
-		       "%s\n", div, clk->name, clk->parent->name);
+		pr_err("clock: %s: could not find divisor %d parent %s\n",
+		       clk->name, div, clk->parent->name);
 		return ~0;
 	}
 
@@ -300,8 +300,8 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 
 		/* Sanity check */
 		if (clkr->div <= last_div)
-			pr_err("clock: clksel_rate table not sorted "
-			       "for clock %s", clk->name);
+			pr_err("clock: %s: clksel_rate table not sorted",
+			       clk->name);
 
 		last_div = clkr->div;
 
@@ -312,9 +312,8 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	}
 
 	if (!clkr->div) {
-		pr_err("clock: Could not find divisor for target "
-		       "rate %ld for clock %s parent %s\n", target_rate,
-		       clk->name, clk->parent->name);
+		pr_err("clock: %s: could not find divisor for target rate %ld parent %s\n",
+		       clk->name, target_rate, clk->parent->name);
 		return ~0;
 	}
 
@@ -359,8 +358,7 @@ void omap2_init_clksel_parent(struct clk *clk)
 
 			if (clkr->val == r) {
 				if (clk->parent != clks->parent) {
-					pr_debug("clock: inited %s parent "
-						 "to %s (was %s)\n",
+					pr_debug("clock: %s: inited parent to %s (was %s)\n",
 						 clk->name, clks->parent->name,
 						 ((clk->parent) ?
 						  clk->parent->name : "NULL"));
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index cd7fd0f..f0b6b4b 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -105,13 +105,13 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
 	}
 
 	if (fint < fint_min) {
-		pr_debug("rejecting n=%d due to Fint failure, "
-			 "lowering max_divider\n", n);
+		pr_debug("rejecting n=%d due to Fint failure, lowering max_divider\n",
+			 n);
 		dd->max_divider = n;
 		ret = DPLL_FINT_UNDERFLOW;
 	} else if (fint > fint_max) {
-		pr_debug("rejecting n=%d due to Fint failure, "
-			 "boosting min_divider\n", n);
+		pr_debug("rejecting n=%d due to Fint failure, boosting min_divider\n",
+			 n);
 		dd->min_divider = n;
 		ret = DPLL_FINT_INVALID;
 	} else if (cpu_is_omap3430() && fint > OMAP3430_DPLL_FINT_BAND1_MAX &&
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ea3f565..eeaf353 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -102,8 +102,8 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 clk->name, clk->clkdm_name);
 		clk->clkdm = clkdm;
 	} else {
-		pr_debug("clock: could not associate clk %s to "
-			 "clkdm %s\n", clk->name, clk->clkdm_name);
+		pr_debug("clock: could not associate clk %s to clkdm %s\n",
+			 clk->name, clk->clkdm_name);
 	}
 }
 
@@ -226,8 +226,7 @@ void omap2_dflt_clk_disable(struct clk *clk)
 		 * 'Independent' here refers to a clock which is not
 		 * controlled by its parent.
 		 */
-		printk(KERN_ERR "clock: clk_disable called on independent "
-		       "clock %s which has no enable_reg\n", clk->name);
+		pr_err("clock: clk_disable called on independent clock %s which has no enable_reg\n", clk->name);
 		return;
 	}
 
@@ -270,8 +269,7 @@ const struct clkops clkops_omap2_dflt = {
 void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount == 0) {
-		WARN(1, "clock: %s: omap2_clk_disable() called, but usecount "
-		     "already 0?", clk->name);
+		WARN(1, "clock: %s: omap2_clk_disable() called, but usecount already 0?", clk->name);
 		return;
 	}
 
@@ -332,8 +330,8 @@ int omap2_clk_enable(struct clk *clk)
 	if (clkdm_control && clk->clkdm) {
 		ret = clkdm_clk_enable(clk->clkdm, clk);
 		if (ret) {
-			WARN(1, "clock: %s: could not enable clockdomain %s: "
-			     "%d\n", clk->name, clk->clkdm->name, ret);
+			WARN(1, "clock: %s: could not enable clockdomain %s: %d\n",
+			     clk->name, clk->clkdm->name, ret);
 			goto oce_err2;
 		}
 	}
@@ -501,10 +499,8 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 
 	hfclkin_rate = clk_get_rate(hfclkin_ck);
 
-	pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
-		"%ld.%01ld/%ld/%ld MHz\n",
-		(hfclkin_rate / 1000000),
-		((hfclkin_rate / 100000) % 10),
+	pr_info("Switched to new clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
+		(hfclkin_rate / 1000000), ((hfclkin_rate / 100000) % 10),
 		(clk_get_rate(core_ck) / 1000000),
 		(clk_get_rate(mpu_ck) / 1000000));
 }
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 794d827..912108e 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -49,8 +49,7 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 	 * on DPLL4.
 	 */
 	if (omap_rev() == OMAP3430_REV_ES1_0) {
-		pr_err("clock: DPLL4 cannot change rate due to "
-		       "silicon 'Limitation 2.5' on 3430ES1.\n");
+		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
 		return -EINVAL;
 	}
 
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8664f5a..a155562 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -174,9 +174,8 @@ void _clkdm_add_autodeps(struct clockdomain *clkdm)
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
 
-		pr_debug("clockdomain: adding %s sleepdep/wkdep for "
-			 "clkdm %s\n", autodep->clkdm.ptr->name,
-			 clkdm->name);
+		pr_debug("clockdomain: %s: adding %s sleepdep/wkdep\n",
+			 clkdm->name, autodep->clkdm.ptr->name);
 
 		clkdm_add_sleepdep(clkdm, autodep->clkdm.ptr);
 		clkdm_add_wkdep(clkdm, autodep->clkdm.ptr);
@@ -205,9 +204,8 @@ void _clkdm_del_autodeps(struct clockdomain *clkdm)
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
 
-		pr_debug("clockdomain: removing %s sleepdep/wkdep for "
-			 "clkdm %s\n", autodep->clkdm.ptr->name,
-			 clkdm->name);
+		pr_debug("clockdomain: %s: removing %s sleepdep/wkdep\n",
+			 clkdm->name, autodep->clkdm.ptr->name);
 
 		clkdm_del_sleepdep(clkdm, autodep->clkdm.ptr);
 		clkdm_del_wkdep(clkdm, autodep->clkdm.ptr);
@@ -469,14 +467,14 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		ret = -EINVAL;
 
 	if (ret) {
-		pr_debug("clockdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		pr_debug("clockdomain: hardware cannot set/clear wake up of %s when %s wakes up\n",
+			 clkdm1->name, clkdm2->name);
 		return ret;
 	}
 
 	if (atomic_inc_return(&cd->wkdep_usecount) == 1) {
-		pr_debug("clockdomain: hardware will wake up %s when %s wakes "
-			 "up\n", clkdm1->name, clkdm2->name);
+		pr_debug("clockdomain: hardware will wake up %s when %s wakes up\n",
+			 clkdm1->name, clkdm2->name);
 
 		ret = arch_clkdm->clkdm_add_wkdep(clkdm1, clkdm2);
 	}
@@ -510,14 +508,14 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		ret = -EINVAL;
 
 	if (ret) {
-		pr_debug("clockdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		pr_debug("clockdomain: hardware cannot set/clear wake up of %s when %s wakes up\n",
+			 clkdm1->name, clkdm2->name);
 		return ret;
 	}
 
 	if (atomic_dec_return(&cd->wkdep_usecount) == 0) {
-		pr_debug("clockdomain: hardware will no longer wake up %s "
-			 "after %s wakes up\n", clkdm1->name, clkdm2->name);
+		pr_debug("clockdomain: hardware will no longer wake up %s after %s wakes up\n",
+			 clkdm1->name, clkdm2->name);
 
 		ret = arch_clkdm->clkdm_del_wkdep(clkdm1, clkdm2);
 	}
@@ -555,8 +553,8 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		ret = -EINVAL;
 
 	if (ret) {
-		pr_debug("clockdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		pr_debug("clockdomain: hardware cannot set/clear wake up of %s when %s wakes up\n",
+			 clkdm1->name, clkdm2->name);
 		return ret;
 	}
 
@@ -613,15 +611,14 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		ret = -EINVAL;
 
 	if (ret) {
-		pr_debug("clockdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", clkdm1->name,
-			 clkdm2->name);
+		pr_debug("clockdomain: hardware cannot set/clear sleep dependency affecting %s from %s\n",
+			 clkdm1->name, clkdm2->name);
 		return ret;
 	}
 
 	if (atomic_inc_return(&cd->sleepdep_usecount) == 1) {
-		pr_debug("clockdomain: will prevent %s from sleeping if %s "
-			 "is active\n", clkdm1->name, clkdm2->name);
+		pr_debug("clockdomain: will prevent %s from sleeping if %s is active\n",
+			 clkdm1->name, clkdm2->name);
 
 		ret = arch_clkdm->clkdm_add_sleepdep(clkdm1, clkdm2);
 	}
@@ -657,16 +654,14 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		ret = -EINVAL;
 
 	if (ret) {
-		pr_debug("clockdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", clkdm1->name,
-			 clkdm2->name);
+		pr_debug("clockdomain: hardware cannot set/clear sleep dependency affecting %s from %s\n",
+			 clkdm1->name, clkdm2->name);
 		return ret;
 	}
 
 	if (atomic_dec_return(&cd->sleepdep_usecount) == 0) {
-		pr_debug("clockdomain: will no longer prevent %s from "
-			 "sleeping if %s is active\n", clkdm1->name,
-			 clkdm2->name);
+		pr_debug("clockdomain: will no longer prevent %s from sleeping if %s is active\n",
+			 clkdm1->name, clkdm2->name);
 
 		ret = arch_clkdm->clkdm_del_sleepdep(clkdm1, clkdm2);
 	}
@@ -706,9 +701,8 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		ret = -EINVAL;
 
 	if (ret) {
-		pr_debug("clockdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", clkdm1->name,
-			 clkdm2->name);
+		pr_debug("clockdomain: hardware cannot set/clear sleep dependency affecting %s from %s\n",
+			 clkdm1->name, clkdm2->name);
 		return ret;
 	}
 
@@ -755,8 +749,8 @@ int clkdm_sleep(struct clockdomain *clkdm)
 		return -EINVAL;
 
 	if (!(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
-		pr_debug("clockdomain: %s does not support forcing "
-			 "sleep via software\n", clkdm->name);
+		pr_debug("clockdomain: %s does not support forcing sleep via software\n",
+			 clkdm->name);
 		return -EINVAL;
 	}
 
@@ -790,8 +784,8 @@ int clkdm_wakeup(struct clockdomain *clkdm)
 		return -EINVAL;
 
 	if (!(clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
-		pr_debug("clockdomain: %s does not support forcing "
-			 "wakeup via software\n", clkdm->name);
+		pr_debug("clockdomain: %s does not support forcing wakeup via software\n",
+			 clkdm->name);
 		return -EINVAL;
 	}
 
@@ -826,8 +820,8 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
 		return;
 
 	if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO)) {
-		pr_debug("clock: automatic idle transitions cannot be enabled "
-			 "on clockdomain %s\n", clkdm->name);
+		pr_debug("clock: %s: automatic idle transitions cannot be enabled\n",
+			 clkdm->name);
 		return;
 	}
 
@@ -861,8 +855,8 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 		return;
 
 	if (!(clkdm->flags & CLKDM_CAN_DISABLE_AUTO)) {
-		pr_debug("clockdomain: automatic idle transitions cannot be "
-			 "disabled on %s\n", clkdm->name);
+		pr_debug("clockdomain: %s: automatic idle transitions cannot be disabled\n",
+			 clkdm->name);
 		return;
 	}
 
@@ -927,7 +921,7 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 
-	pr_debug("clockdomain: clkdm %s: enabled\n", clkdm->name);
+	pr_debug("clockdomain: %s: enabled\n", clkdm->name);
 
 	return 0;
 }
@@ -952,7 +946,7 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 
-	pr_debug("clockdomain: clkdm %s: disabled\n", clkdm->name);
+	pr_debug("clockdomain: %s: disabled\n", clkdm->name);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 1473474..e0385f0 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -130,8 +130,7 @@ void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
 	}
 
 	if (nandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				 "in GPMC\n ");
+		pr_info("NAND: Unable to find configuration in GPMC\n");
 		return;
 	}
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 40373db..d0631468 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -161,9 +161,8 @@ void __init omap2xxx_check_revision(void)
 	}
 
 	if (j == ARRAY_SIZE(omap_ids)) {
-		printk(KERN_ERR "Unknown OMAP device type. "
-				"Handling it as OMAP%04x\n",
-				omap_ids[i].type >> 16);
+		pr_err("Unknown OMAP device type. Handling it as OMAP%04x\n",
+		       omap_ids[i].type >> 16);
 		j = i;
 	}
 
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index bcd83db..a4dd4cf 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -107,9 +107,8 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 	unsigned long tmp;
 
 	tmp = intc_bank_read_reg(bank, INTC_REVISION) & 0xff;
-	printk(KERN_INFO "IRQ: Found an INTC at 0x%p "
-			 "(revision %ld.%ld) with %d interrupts\n",
-			 bank->base_reg, tmp >> 4, tmp & 0xf, bank->nr_irqs);
+	pr_info("IRQ: Found an INTC at 0x%p (revision %ld.%ld) with %d interrupts\n",
+		bank->base_reg, tmp >> 4, tmp & 0xf, bank->nr_irqs);
 
 	tmp = intc_bank_read_reg(bank, INTC_SYSCONFIG);
 	tmp |= 1 << 1;	/* soft reset */
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bd69eae..ae0dd96 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1641,8 +1641,8 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 
 	/* clocks must be on for this operation */
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
-		pr_warning("omap_hwmod: %s: reset can only be entered from "
-			   "enabled state\n", oh->name);
+		pr_warn("omap_hwmod: %s: reset can only be entered from enabled state\n",
+			oh->name);
 		return -EINVAL;
 	}
 
diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index d8f6dbf..45ad7f7 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -64,25 +64,22 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 		}
 		oh = omap_hwmod_lookup(opp_def->hwmod_name);
 		if (!oh || !oh->od) {
-			pr_debug("%s: no hwmod or odev for %s, [%d] "
-				"cannot add OPPs.\n", __func__,
-				opp_def->hwmod_name, i);
+			pr_debug("%s: no hwmod or odev for %s, [%d] cannot add OPPs.\n",
+				 __func__, opp_def->hwmod_name, i);
 			continue;
 		}
 		dev = &oh->od->pdev->dev;
 
 		r = opp_add(dev, opp_def->freq, opp_def->u_volt);
 		if (r) {
-			dev_err(dev, "%s: add OPP %ld failed for %s [%d] "
-				"result=%d\n",
-			       __func__, opp_def->freq,
-			       opp_def->hwmod_name, i, r);
+			dev_err(dev, "%s: add OPP %ld failed for %s [%d] result=%d\n",
+				__func__, opp_def->freq,
+				opp_def->hwmod_name, i, r);
 		} else {
 			if (!opp_def->default_available)
 				r = opp_disable(dev, opp_def->freq);
 			if (r)
-				dev_err(dev, "%s: disable %ld failed for %s "
-					"[%d] result=%d\n",
+				dev_err(dev, "%s: disable %ld failed for %s [%d] result=%d\n",
 					__func__, opp_def->freq,
 					opp_def->hwmod_name, i, r);
 		}
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..939bd6f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -203,8 +203,8 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	bootup_volt = opp_get_voltage(opp);
 	rcu_read_unlock();
 	if (!bootup_volt) {
-		pr_err("%s: unable to find voltage corresponding "
-			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
+		pr_err("%s: unable to find voltage corresponding to the bootup OPP for vdd_%s\n",
+		       __func__, vdd_name);
 		goto exit;
 	}
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4fc88c..57f3e2e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -400,9 +400,8 @@ restore:
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
 		if (state > pwrst->next_state) {
-			pr_info("Powerdomain (%s) didn't enter "
-				"target state %d\n",
-			       pwrst->pwrdm->name, pwrst->next_state);
+			pr_info("Powerdomain (%s) didn't enter target state %d\n",
+				pwrst->pwrdm->name, pwrst->next_state);
 			ret = -1;
 		}
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
@@ -742,8 +741,7 @@ int __init omap3_pm_init(void)
 		omap3_secure_ram_storage =
 			kmalloc(0x803F, GFP_KERNEL);
 		if (!omap3_secure_ram_storage)
-			pr_err("Memory allocation failed when "
-			       "allocating for secure sram context\n");
+			pr_err("Memory allocation failed when allocating for secure sram context\n");
 
 		local_irq_disable();
 		local_fiq_disable();
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index ea24174..04922d1 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -69,9 +69,8 @@ static int omap4_pm_suspend(void)
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
 		if (state > pwrst->next_state) {
-			pr_info("Powerdomain (%s) didn't enter "
-			       "target state %d\n",
-			       pwrst->pwrdm->name, pwrst->next_state);
+			pr_info("Powerdomain (%s) didn't enter target state %d\n",
+				pwrst->pwrdm->name, pwrst->next_state);
 			ret = -1;
 		}
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
@@ -189,8 +188,7 @@ int __init omap4_pm_init(void)
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
-		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 "
-				"wakeup dependency\n");
+		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 wakeup dependency\n");
 		goto err2;
 	}
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 69b36e1..153cfe0 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -339,8 +339,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	if (!pwrdm || !clkdm)
 		return -EINVAL;
 
-	pr_debug("powerdomain: associating clockdomain %s with powerdomain "
-		 "%s\n", clkdm->name, pwrdm->name);
+	pr_debug("powerdomain: %s: associating clockdomain %s\n",
+		 pwrdm->name, clkdm->name);
 
 	for (i = 0; i < PWRDM_MAX_CLKDMS; i++) {
 		if (!pwrdm->pwrdm_clkdms[i])
@@ -354,8 +354,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	}
 
 	if (i == PWRDM_MAX_CLKDMS) {
-		pr_debug("powerdomain: increase PWRDM_MAX_CLKDMS for "
-			 "pwrdm %s clkdm %s\n", pwrdm->name, clkdm->name);
+		pr_debug("powerdomain: %s: increase PWRDM_MAX_CLKDMS for clkdm %s\n",
+			 pwrdm->name, clkdm->name);
 		WARN_ON(1);
 		ret = -ENOMEM;
 		goto pac_exit;
@@ -387,16 +387,16 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	if (!pwrdm || !clkdm)
 		return -EINVAL;
 
-	pr_debug("powerdomain: dissociating clockdomain %s from powerdomain "
-		 "%s\n", clkdm->name, pwrdm->name);
+	pr_debug("powerdomain: %s: dissociating clockdomain %s\n",
+		 pwrdm->name, clkdm->name);
 
 	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
 		if (pwrdm->pwrdm_clkdms[i] == clkdm)
 			break;
 
 	if (i == PWRDM_MAX_CLKDMS) {
-		pr_debug("powerdomain: clkdm %s not associated with pwrdm "
-			 "%s ?!\n", clkdm->name, pwrdm->name);
+		pr_debug("powerdomain: %s: clkdm %s not associated?!\n",
+			 pwrdm->name, clkdm->name);
 		ret = -ENOENT;
 		goto pdc_exit;
 	}
@@ -485,7 +485,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	if (!(pwrdm->pwrsts & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
+	pr_debug("powerdomain: %s: setting next powerstate to %0x\n",
 		 pwrdm->name, pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
@@ -587,7 +587,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	if (!(pwrdm->pwrsts_logic_ret & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next logic powerstate for %s to %0x\n",
+	pr_debug("powerdomain: %s: setting next logic powerstate to %0x\n",
 		 pwrdm->name, pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_logic_retst)
@@ -624,8 +624,8 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	if (!(pwrdm->pwrsts_mem_on[bank] & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next memory powerstate for domain %s "
-		 "bank %0x while pwrdm-ON to %0x\n", pwrdm->name, bank, pwrst);
+	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-ON to %0x\n",
+		 pwrdm->name, bank, pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst)
 		ret = arch_pwrdm->pwrdm_set_mem_onst(pwrdm, bank, pwrst);
@@ -662,8 +662,8 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	if (!(pwrdm->pwrsts_mem_ret[bank] & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next memory powerstate for domain %s "
-		 "bank %0x while pwrdm-RET to %0x\n", pwrdm->name, bank, pwrst);
+	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-RET to %0x\n",
+		 pwrdm->name, bank, pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst)
 		ret = arch_pwrdm->pwrdm_set_mem_retst(pwrdm, bank, pwrst);
@@ -841,7 +841,7 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 	 * warn & fail if it is not ON.
 	 */
 
-	pr_debug("powerdomain: clearing previous power state reg for %s\n",
+	pr_debug("powerdomain: %s: clearing previous power state reg\n",
 		 pwrdm->name);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_clear_all_prev_pwrst)
@@ -871,8 +871,7 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
 		return ret;
 
-	pr_debug("powerdomain: %s: setting SAVEANDRESTORE bit\n",
-		 pwrdm->name);
+	pr_debug("powerdomain: %s: setting SAVEANDRESTORE bit\n", pwrdm->name);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_enable_hdwr_sar)
 		ret = arch_pwrdm->pwrdm_enable_hdwr_sar(pwrdm);
@@ -901,8 +900,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
 		return ret;
 
-	pr_debug("powerdomain: %s: clearing SAVEANDRESTORE bit\n",
-		 pwrdm->name);
+	pr_debug("powerdomain: %s: clearing SAVEANDRESTORE bit\n", pwrdm->name);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_disable_hdwr_sar)
 		ret = arch_pwrdm->pwrdm_disable_hdwr_sar(pwrdm);
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index 0f0a9f1..3950ccf 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -122,8 +122,8 @@ static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
 			udelay(1);
 
 	if (c > PWRDM_TRANSITION_BAILOUT) {
-		printk(KERN_ERR "powerdomain: waited too long for "
-			"powerdomain %s to complete transition\n", pwrdm->name);
+		pr_err("powerdomain: %s: waited too long to complete transition\n",
+		       pwrdm->name);
 		return -EAGAIN;
 	}
 
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 601325b..aeac6f3 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -198,8 +198,8 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 		udelay(1);
 
 	if (c > PWRDM_TRANSITION_BAILOUT) {
-		printk(KERN_ERR "powerdomain: waited too long for "
-		       "powerdomain %s to complete transition\n", pwrdm->name);
+		pr_err("powerdomain: %s: waited too long to complete transition\n",
+		       pwrdm->name);
 		return -EAGAIN;
 	}
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 053e24e..d1dd175 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -140,11 +140,11 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			  MAX_MODULE_ENABLE_WAIT, i);
 
 	if (i < MAX_MODULE_ENABLE_WAIT)
-		pr_debug("cm: Module associated with clock %s ready after %d "
-			 "loops\n", name, i);
+		pr_debug("cm: Module associated with clock %s ready after %d loops\n",
+			 name, i);
 	else
-		pr_err("cm: Module associated with clock %s didn't enable in "
-		       "%d tries\n", name, MAX_MODULE_ENABLE_WAIT);
+		pr_err("cm: Module associated with clock %s didn't enable in %d tries\n",
+		       name, MAX_MODULE_ENABLE_WAIT);
 
 	return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
 };
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0cc79d3..62763ef 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -229,9 +229,8 @@ static int __init omap_serial_early_init(void)
 
 			if (console_loglevel >= 10) {
 				uart_debug = true;
-				pr_info("%s used as console in debug mode"
-						" uart%d clocks will not be"
-						" gated", uart_name, uart->num);
+				pr_info("%s used as console in debug mode: uart%d clocks will not be gated",
+					uart_name, uart->num);
 			}
 
 			if (cmdline_find_option("no_console_suspend"))
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index d033a65..cbeae56 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -104,16 +104,15 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 
 	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
 	if (!sr_data) {
-		pr_err("%s: Unable to allocate memory for %s sr_data.Error!\n",
-			__func__, oh->name);
+		pr_err("%s: Unable to allocate memory for %s sr_data\n",
+		       __func__, oh->name);
 		return -ENOMEM;
 	}
 
 	sr_dev_attr = (struct omap_smartreflex_dev_attr *)oh->dev_attr;
 	if (!sr_dev_attr || !sr_dev_attr->sensor_voltdm_name) {
-		pr_err("%s: No voltage domain specified for %s."
-				"Cannot initialize\n", __func__,
-					oh->name);
+		pr_err("%s: No voltage domain specified for %s. Cannot initialize\n",
+		       __func__, oh->name);
 		goto exit;
 	}
 
@@ -131,8 +130,8 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 
 	omap_voltage_get_volttable(sr_data->voltdm, &volt_data);
 	if (!volt_data) {
-		pr_warning("%s: No Voltage table registered fo VDD%d."
-			"Something really wrong\n\n", __func__, i + 1);
+		pr_err("%s: No Voltage table registered for VDD%d\n",
+		       __func__, i + 1);
 		goto exit;
 	}
 
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 84da34f..4577764 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -116,9 +116,8 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 	}
 
 	if (!voltdm->pmic->uv_to_vsel) {
-		pr_err("%s: PMIC function to convert voltage in uV to"
-			"vsel not registered. Hence unable to scale voltage"
-			"for vdd_%s\n", __func__, voltdm->name);
+		pr_err("%s: PMIC function to convert voltage in uV to vsel not registered. Hence unable to scale voltage for vdd_%s\n",
+		       __func__, voltdm->name);
 		return -ENODATA;
 	}
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 4dc60e8..3ac8fe1 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -195,8 +195,8 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 			return &voltdm->volt_data[i];
 	}
 
-	pr_notice("%s: Unable to match the current voltage with the voltage"
-		"table for vdd_%s\n", __func__, voltdm->name);
+	pr_notice("%s: Unable to match the current voltage with the voltage table for vdd_%s\n",
+		  __func__, voltdm->name);
 
 	return ERR_PTR(-ENODATA);
 }
@@ -249,8 +249,8 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		voltdm->scale = omap_vc_bypass_scale;
 		return;
 	default:
-		pr_warning("%s: Trying to change the method of voltage scaling"
-			"to an unsupported one!\n", __func__);
+		pr_warn("%s: Trying to change the method of voltage scaling to an unsupported one!\n",
+			__func__);
 	}
 }
 
@@ -331,8 +331,8 @@ int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm)
 	if (!voltdm || !pwrdm)
 		return -EINVAL;
 
-	pr_debug("voltagedomain: associating powerdomain %s with voltagedomain "
-		 "%s\n", pwrdm->name, voltdm->name);
+	pr_debug("voltagedomain: %s: associating powerdomain %s\n",
+		 voltdm->name, pwrdm->name);
 
 	list_add(&pwrdm->voltdm_node, &voltdm->pwrdm_list);
 
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index f95c1ba..85241b8 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -138,8 +138,8 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 		udelay(1);
 	}
 	if (timeout >= VP_TRANXDONE_TIMEOUT) {
-		pr_warning("%s: vdd_%s TRANXDONE timeout exceeded."
-			"Voltage change aborted", __func__, voltdm->name);
+		pr_warn("%s: vdd_%s TRANXDONE timeout exceeded. Voltage change aborted",
+			__func__, voltdm->name);
 		return -ETIMEDOUT;
 	}
 
@@ -157,9 +157,8 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	omap_test_timeout(vp->common->ops->check_txdone(vp->id),
 			  VP_TRANXDONE_TIMEOUT, timeout);
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
-		pr_err("%s: vdd_%s TRANXDONE timeout exceeded."
-			"TRANXDONE never got set after the voltage update\n",
-			__func__, voltdm->name);
+		pr_err("%s: vdd_%s TRANXDONE timeout exceeded. TRANXDONE never got set after the voltage update\n",
+		       __func__, voltdm->name);
 
 	omap_vc_post_scale(voltdm, target_volt, target_vsel, current_vsel);
 
@@ -176,8 +175,7 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	}
 
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
-		pr_warning("%s: vdd_%s TRANXDONE timeout exceeded while trying"
-			"to clear the TRANXDONE status\n",
+		pr_warn("%s: vdd_%s TRANXDONE timeout exceeded while trying to clear the TRANXDONE status\n",
 			__func__, voltdm->name);
 
 	/* Clear force bit */
@@ -257,8 +255,8 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 
 	/* If VP is already disabled, do nothing. Return */
 	if (!vp->enabled) {
-		pr_warning("%s: Trying to disable VP for vdd_%s when"
-			"it is already disabled\n", __func__, voltdm->name);
+		pr_warn("%s: Trying to disable VP for vdd_%s when it is already disabled\n",
+			__func__, voltdm->name);
 		return;
 	}
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7f70235..8ddada5 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -967,8 +967,7 @@ void omap_stop_dma(int lch)
 			l = p->dma_read(CCR, lch);
 		}
 		if (i >= 100)
-			printk(KERN_ERR "DMA drain did not complete on "
-					"lch %d\n", lch);
+			pr_err("DMA drain did not complete on lch %d\n", lch);
 		/* Restore OCP_SYSCONFIG */
 		p->dma_write(sys_cf, OCP_SYSCONFIG, lch);
 	} else {
@@ -1824,16 +1823,15 @@ static int omap1_dma_handle_ch(int ch)
 	if ((csr & 0x3f) == 0)
 		return 0;
 	if (unlikely(dma_chan[ch].dev_id == -1)) {
-		printk(KERN_WARNING "Spurious interrupt from DMA channel "
-		       "%d (CSR %04x)\n", ch, csr);
+		pr_warn("Spurious interrupt from DMA channel %d (CSR %04x)\n",
+			ch, csr);
 		return 0;
 	}
 	if (unlikely(csr & OMAP1_DMA_TOUT_IRQ))
-		printk(KERN_WARNING "DMA timeout with device %d\n",
-		       dma_chan[ch].dev_id);
+		pr_warn("DMA timeout with device %d\n", dma_chan[ch].dev_id);
 	if (unlikely(csr & OMAP_DMA_DROP_IRQ))
-		printk(KERN_WARNING "DMA synchronization event drop occurred "
-		       "with device %d\n", dma_chan[ch].dev_id);
+		pr_warn("DMA synchronization event drop occurred with device %d\n",
+			dma_chan[ch].dev_id);
 	if (likely(csr & OMAP_DMA_BLOCK_IRQ))
 		dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
 	if (likely(dma_chan[ch].callback != NULL))
@@ -1873,21 +1871,19 @@ static int omap2_dma_handle_ch(int ch)
 
 	if (!status) {
 		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
-				ch);
+			pr_warn("Spurious DMA IRQ for lch %d\n", ch);
 		p->dma_write(1 << ch, IRQSTATUS_L0, ch);
 		return 0;
 	}
 	if (unlikely(dma_chan[ch].dev_id == -1)) {
 		if (printk_ratelimit())
-			printk(KERN_WARNING "IRQ %04x for non-allocated DMA"
-					"channel %d\n", status, ch);
+			pr_warn("IRQ %04x for non-allocated DMA channel %d\n",
+				status, ch);
 		return 0;
 	}
 	if (unlikely(status & OMAP_DMA_DROP_IRQ))
-		printk(KERN_INFO
-		       "DMA synchronization event drop occurred with device "
-		       "%d\n", dma_chan[ch].dev_id);
+		pr_info("DMA synchronization event drop occurred with device %d\n",
+			dma_chan[ch].dev_id);
 	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
 		printk(KERN_INFO "DMA transaction error with device %d\n",
 		       dma_chan[ch].dev_id);
@@ -2007,8 +2003,9 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 
 	p = pdev->dev.platform_data;
 	if (!p) {
-		dev_err(&pdev->dev, "%s: System DMA initialized without"
-			"platform data\n", __func__);
+		dev_err(&pdev->dev,
+			"%s: System DMA initialized without platform data\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -2083,8 +2080,8 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		}
 		ret = setup_irq(dma_irq, &omap24xx_dma_irq);
 		if (ret) {
-			dev_err(&pdev->dev, "set_up failed for IRQ %d"
-				"for DMA (error %d)\n", dma_irq, ret);
+			dev_err(&pdev->dev, "set_up failed for IRQ %d for DMA (error %d)\n",
+				dma_irq, ret);
 			goto exit_dma_lch_fail;
 		}
 	}
@@ -2092,8 +2089,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 	/* reserve dma channels 0 and 1 in high security devices */
 	if (cpu_is_omap34xx() &&
 		(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
-		printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
-				"HS ROM code\n");
+		pr_info("Reserving DMA channels 0 and 1 for HS ROM code\n");
 		dma_chan[0].dev_id = 0;
 		dma_chan[1].dev_id = 1;
 	}
@@ -2101,8 +2097,8 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 	return 0;
 
 exit_dma_irq_fail:
-	dev_err(&pdev->dev, "unable to request IRQ %d"
-			"for DMA (error %d)\n", dma_irq, ret);
+	dev_err(&pdev->dev, "unable to request IRQ %d for DMA (error %d)\n",
+		dma_irq, ret);
 	for (irq_rel = 0; irq_rel < ch;	irq_rel++) {
 		dma_irq = platform_get_irq(pdev, irq_rel);
 		free_irq(dma_irq, (void *)(irq_rel + 1));
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 5a97b4d..9f64133 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -41,11 +41,11 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
 	};
 
 	if (t == -1)
-		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
-			 "dev %s\n", dev_name(dev));
+		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: dev %s\n",
+			 dev_name(dev));
 	else
-		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+		pr_debug("OMAP PM: add max MPU wakeup latency constraint: dev %s, t = %ld usec\n",
+			 dev_name(dev), t);
 
 	/*
 	 * For current Linux, this needs to map the MPU to a
@@ -70,11 +70,10 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 	};
 
 	if (r == 0)
-		pr_debug("OMAP PM: remove min bus tput constraint: "
-			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
+		pr_debug("OMAP PM: remove min bus tput constraint: dev %s for agent_id %d\n",
+			 dev_name(dev), agent_id);
 	else
-		pr_debug("OMAP PM: add min bus tput constraint: "
-			 "dev %s for agent_id %d: rate %ld KiB\n",
+		pr_debug("OMAP PM: add min bus tput constraint: dev %s for agent_id %d: rate %ld KiB\n",
 			 dev_name(dev), agent_id, r);
 
 	/*
@@ -97,11 +96,11 @@ int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 	};
 
 	if (t == -1)
-		pr_debug("OMAP PM: remove max device latency constraint: "
-			 "dev %s\n", dev_name(dev));
+		pr_debug("OMAP PM: remove max device latency constraint: dev %s\n",
+			 dev_name(dev));
 	else
-		pr_debug("OMAP PM: add max device latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+		pr_debug("OMAP PM: add max device latency constraint: dev %s, t = %ld usec\n",
+			 dev_name(dev), t);
 
 	/*
 	 * For current Linux, this needs to map the device to a
@@ -127,11 +126,11 @@ int omap_pm_set_max_sdma_lat(struct device *dev, long t)
 	};
 
 	if (t == -1)
-		pr_debug("OMAP PM: remove max DMA latency constraint: "
-			 "dev %s\n", dev_name(dev));
+		pr_debug("OMAP PM: remove max DMA latency constraint: dev %s\n",
+			 dev_name(dev));
 	else
-		pr_debug("OMAP PM: add max DMA latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+		pr_debug("OMAP PM: add max DMA latency constraint: dev %s, t = %ld usec\n",
+			 dev_name(dev), t);
 
 	/*
 	 * For current Linux PM QOS params, this code should scan the
@@ -156,11 +155,11 @@ int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
 	}
 
 	if (r == 0)
-		pr_debug("OMAP PM: remove min clk rate constraint: "
-			 "dev %s\n", dev_name(dev));
+		pr_debug("OMAP PM: remove min clk rate constraint: dev %s\n",
+			 dev_name(dev));
 	else
-		pr_debug("OMAP PM: add min clk rate constraint: "
-			 "dev %s, rate = %ld Hz\n", dev_name(dev), r);
+		pr_debug("OMAP PM: add min clk rate constraint: dev %s, rate = %ld Hz\n",
+			 dev_name(dev), r);
 
 	/*
 	 * Code in a real implementation should keep track of these
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c490240..b59edb0 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1,4 +1,3 @@
-
 /*
  * omap_device implementation
  *
@@ -153,21 +152,19 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		act_lat = timespec_to_ns(&c);
 
 		dev_dbg(&od->pdev->dev,
-			"omap_device: pm_lat %d: activate: elapsed time "
-			"%llu nsec\n", od->pm_lat_level, act_lat);
+			"omap_device: pm_lat %d: activate: elapsed time %llu nsec\n",
+			od->pm_lat_level, act_lat);
 
 		if (act_lat > odpl->activate_lat) {
 			odpl->activate_lat_worst = act_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->activate_lat = act_lat;
 				dev_dbg(&od->pdev->dev,
-					"new worst case activate latency "
-					"%d: %llu\n",
+					"new worst case activate latency %d: %llu\n",
 					od->pm_lat_level, act_lat);
 			} else
 				dev_warn(&od->pdev->dev,
-					 "activate latency %d "
-					 "higher than exptected. (%llu > %d)\n",
+					 "activate latency %d higher than expected. (%llu > %d)\n",
 					 od->pm_lat_level, act_lat,
 					 odpl->activate_lat);
 		}
@@ -220,21 +217,19 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		deact_lat = timespec_to_ns(&c);
 
 		dev_dbg(&od->pdev->dev,
-			"omap_device: pm_lat %d: deactivate: elapsed time "
-			"%llu nsec\n", od->pm_lat_level, deact_lat);
+			"omap_device: pm_lat %d: deactivate: elapsed time %llu nsec\n",
+			od->pm_lat_level, deact_lat);
 
 		if (deact_lat > odpl->deactivate_lat) {
 			odpl->deactivate_lat_worst = deact_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->deactivate_lat = deact_lat;
 				dev_dbg(&od->pdev->dev,
-					"new worst case deactivate latency "
-					"%d: %llu\n",
+					"new worst case deactivate latency %d: %llu\n",
 					od->pm_lat_level, deact_lat);
 			} else
 				dev_warn(&od->pdev->dev,
-					 "deactivate latency %d "
-					 "higher than exptected. (%llu > %d)\n",
+					 "deactivate latency %d higher than expected. (%llu > %d)\n",
 					 od->pm_lat_level, deact_lat,
 					 odpl->deactivate_lat);
 		}
@@ -449,8 +444,8 @@ static int omap_device_count_resources(struct omap_device *od)
 	for (i = 0; i < od->hwmods_cnt; i++)
 		c += omap_hwmod_count_resources(od->hwmods[i]);
 
-	pr_debug("omap_device: %s: counted %d total resources across %d "
-		 "hwmods\n", od->pdev->name, c, od->hwmods_cnt);
+	pr_debug("omap_device: %s: counted %d total resources across %d hwmods\n",
+		 od->pdev->name, c, od->hwmods_cnt);
 
 	return c;
 }


