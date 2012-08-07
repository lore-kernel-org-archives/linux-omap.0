From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] ARM: OMAP: clean up some smatch warnings,
 fix some printk(KERN_ERR ...
Date: Tue, 07 Aug 2012 04:34:43 -0600
Message-ID: <20120807103439.8053.65054.stgit@dusk.lan>
References: <20120807103009.8053.69389.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32771 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2HGKfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:35:41 -0400
In-Reply-To: <20120807103009.8053.69389.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Resolve the following warnings from smatch:

arch/arm/mach-omap2/gpmc.c:282 gpmc_cs_set_timings() info: why not propagate 'div' from gpmc_cs_calc_divider() instead of -1?
arch/arm/mach-omap2/gpmc.c:456 gpmc_cs_free() info: ignoring unreachable code.
arch/arm/mach-omap2/gpmc.c:456 gpmc_cs_free() info: ignoring unreachable code.
arch/arm/mach-omap2/serial.c:328 omap_serial_init_port() error: 'pdev' dereferencing possible ERR_PTR()
arch/arm/mach-omap2/timer.c:213 omap2_gp_clockevent_init() Error invalid range 4096 to -1
arch/arm/mach-omap2/gpio.c:63 omap2_gpio_dev_init() warn: possible memory leak of 'pdata'
arch/arm/mach-omap2/omap_hwmod.c:1478 _assert_hardreset() warn: assigning -22 to unsigned variable 'ret'
arch/arm/mach-omap2/omap_hwmod.c:1487 _assert_hardreset() warn: 4294963201 is more than 255 (max '(ret)' can be) so this is always the same.
arch/arm/mach-omap2/omap_hwmod.c:1545 _read_hardreset() warn: assigning -22 to unsigned variable 'ret'
arch/arm/mach-omap2/omap_hwmod.c:1554 _read_hardreset() warn: 4294963201 is more than 255 (max '(ret)' can be) so this is always the same.
arch/arm/mach-omap2/dpll3xxx.c:629 omap3_clkoutx2_recalc() error: we previously assumed 'pclk' could be null (see line 627)
arch/arm/mach-omap2/board-n8x0.c:422 n8x0_mmc_late_init() Error invalid range 14 to 13
arch/arm/mach-omap1/leds-h2p2-debug.c:71 h2p2_dbg_leds_event() error: potentially derefencing uninitialized 'fpga'.
arch/arm/mach-omap1/lcd_dma.c:97 omap_set_lcd_dma_b1_rotation() info: ignoring unreachable code.
arch/arm/mach-omap1/lcd_dma.c:157 set_b1_regs() info: ignoring unreachable code.
arch/arm/mach-omap1/lcd_dma.c:237 set_b1_regs() info: ignoring unreachable code.
arch/arm/mach-omap1/lcd_dma.c:313 omap_request_lcd_dma() info: ignoring unreachable code.
arch/arm/mach-omap1/lcd_dma.c:340 omap_free_lcd_dma() info: ignoring unreachable code.
arch/arm/plat-omap/dma.c:200 omap_set_dma_priority() info: ignoring unreachable code.
arch/arm/plat-omap/dma.c:567 omap_set_dma_dest_burst_mode() info: ignoring unreachable code.
arch/arm/plat-omap/dma.c:1152 omap_dma_link_lch() info: ignoring unreachable code.
arch/arm/plat-omap/dma.c:1179 omap_dma_unlink_lch() info: ignoring unreachable code.
arch/arm/plat-omap/mux.c:79 omap_cfg_reg() Error invalid range 4096 to -1
arch/arm/plat-omap/dma.c:200 omap_set_dma_priority() info: ignoring unreachable code.
arch/arm/plat-omap/dma.c:567 omap_set_dma_dest_burst_mode() info: ignoring unreachable code.

Also, convert some nearby "printk(KERN_ERR ..." into "pr_err( ...",
and unwrap some strings.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/lcd_dma.c         |    9 ++-------
 arch/arm/mach-omap1/leds-h2p2-debug.c |   12 +++++++-----
 arch/arm/mach-omap2/dpll3xxx.c        |    7 +++++--
 arch/arm/mach-omap2/gpio.c            |    1 +
 arch/arm/mach-omap2/gpmc.c            |    5 ++---
 arch/arm/mach-omap2/omap_hwmod.c      |   12 ++++++------
 arch/arm/mach-omap2/serial.c          |    7 +++++--
 arch/arm/mach-omap2/timer.c           |    2 +-
 arch/arm/plat-omap/dma.c              |   19 ++++++-------------
 arch/arm/plat-omap/mux.c              |    2 +-
 10 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dma.c
index 5769c71..6ec931c 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -94,7 +94,6 @@ void omap_set_lcd_dma_b1_rotation(int rotate)
 	if (cpu_is_omap15xx()) {
 		printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
 		BUG();
-		return;
 	}
 	lcd_dma.rotate = rotate;
 }
@@ -154,7 +153,6 @@ static void set_b1_regs(void)
 		break;
 	default:
 		BUG();
-		return;
 	}
 
 	vxres = lcd_dma.vxres ? lcd_dma.vxres : lcd_dma.xres;
@@ -234,7 +232,6 @@ static void set_b1_regs(void)
 		break;
 	default:
 		BUG();
-		return;	/* Suppress warning about uninitialized vars */
 	}
 
 	if (cpu_is_omap15xx()) {
@@ -308,9 +305,8 @@ int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
 	spin_lock_irq(&lcd_dma.lock);
 	if (lcd_dma.reserved) {
 		spin_unlock_irq(&lcd_dma.lock);
-		printk(KERN_ERR "LCD DMA channel already reserved\n");
+		pr_err("LCD DMA channel already reserved\n");
 		BUG();
-		return -EBUSY;
 	}
 	lcd_dma.reserved = 1;
 	spin_unlock_irq(&lcd_dma.lock);
@@ -335,9 +331,8 @@ void omap_free_lcd_dma(void)
 	spin_lock(&lcd_dma.lock);
 	if (!lcd_dma.reserved) {
 		spin_unlock(&lcd_dma.lock);
-		printk(KERN_ERR "LCD DMA is not reserved\n");
+		pr_err("LCD DMA is not reserved\n");
 		BUG();
-		return;
 	}
 	if (!cpu_is_omap15xx())
 		omap_writew(omap_readw(OMAP1610_DMA_LCD_CCR) & ~1,
diff --git a/arch/arm/mach-omap1/leds-h2p2-debug.c b/arch/arm/mach-omap1/leds-h2p2-debug.c
index f6b14a1..78acaa9 100644
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -68,11 +68,13 @@ void h2p2_dbg_leds_event(led_event_t evt)
 			gpio_set_value(GPIO_IDLE, 0);
 		}
 
-		__raw_writew(~0, &fpga->leds);
 		led_state &= ~LED_STATE_ENABLED;
-		if (evt == led_halted) {
-			iounmap(fpga);
-			fpga = NULL;
+		if (fpga) {
+			__raw_writew(~0, &fpga->leds);
+			if (evt == led_halted) {
+				iounmap(fpga);
+				fpga = NULL;
+			}
 		}
 
 		goto done;
@@ -158,7 +160,7 @@ void h2p2_dbg_leds_event(led_event_t evt)
 	/*
 	 *  Actually burn the LEDs
 	 */
-	if (led_state & LED_STATE_ENABLED)
+	if (led_state & LED_STATE_ENABLED && fpga)
 		__raw_writew(~hw_led_state, &fpga->leds);
 
 done:
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index b9c8d2f..4d0e645 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -623,8 +623,11 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 	while (pclk && !pclk->dpll_data)
 		pclk = pclk->parent;
 
-	/* clk does not have a DPLL as a parent? */
-	WARN_ON(!pclk);
+	/* clk does not have a DPLL as a parent?  error in the clock data */
+	if (!pclk) {
+		WARN_ON(1);
+		return 0;
+	}
 
 	dd = pclk->dpll_data;
 
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9ad7d48..30a3a94 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -60,6 +60,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->regs = kzalloc(sizeof(struct omap_gpio_reg_offs), GFP_KERNEL);
 	if (!pdata->regs) {
 		pr_err("gpio%d: Memory allocation failed\n", id);
+		kfree(pdata);
 		return -ENOMEM;
 	}
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index b2b5759..ba1bebc 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -279,7 +279,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	div = gpmc_cs_calc_divider(cs, t->sync_clk);
 	if (div < 0)
-		return -1;
+		return div;
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG2,  0,  3, cs_on);
 	GPMC_SET_ONE(GPMC_CS_CONFIG2,  8, 12, cs_rd_off);
@@ -451,9 +451,8 @@ void gpmc_cs_free(int cs)
 {
 	spin_lock(&gpmc_mem_lock);
 	if (cs >= GPMC_CS_NUM || cs < 0 || !gpmc_cs_reserved(cs)) {
-		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
-		BUG();
 		spin_unlock(&gpmc_mem_lock);
+		pr_err("Trying to free non-reserved GPMC CS%d\n", cs);
 		return;
 	}
 	gpmc_cs_disable_mem(cs);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6ca8e51..bd69eae 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1438,8 +1438,8 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
  * Return the bit position of the reset line that match the
  * input name. Return -ENOENT if not found.
  */
-static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name,
-			    struct omap_hwmod_rst_info *ohri)
+static int _lookup_hardreset(struct omap_hwmod *oh, const char *name,
+			     struct omap_hwmod_rst_info *ohri)
 {
 	int i;
 
@@ -1475,7 +1475,7 @@ static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name,
 static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	u8 ret = -EINVAL;
+	int ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
@@ -1484,7 +1484,7 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 		return -ENOSYS;
 
 	ret = _lookup_hardreset(oh, name, &ohri);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	ret = soc_ops.assert_hardreset(oh, &ohri);
@@ -1542,7 +1542,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	u8 ret = -EINVAL;
+	int ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
@@ -1551,7 +1551,7 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 		return -ENOSYS;
 
 	ret = _lookup_hardreset(oh, name, &ohri);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	return soc_ops.is_hardreset_asserted(oh, &ohri);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c1b93c7..0cc79d3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -313,8 +313,11 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	pdev = omap_device_build(name, uart->num, oh, pdata, pdata_size,
 				 NULL, 0, false);
-	WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\n",
-	     name, oh->name);
+	if (IS_ERR(pdev)) {
+		WARN(1, "Could not build omap_device for %s: %s.\n", name,
+		     oh->name);
+		return;
+	}
 
 	if ((console_uart_id == bdata->id) && no_console_suspend)
 		omap_device_disable_idle_on_suspend(pdev);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2ff6d41..7e688c7 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -211,7 +211,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source);
 	BUG_ON(res);
 
-	omap2_gp_timer_irq.dev_id = (void *)&clkev;
+	omap2_gp_timer_irq.dev_id = &clkev;
 	setup_irq(clkev.irq, &omap2_gp_timer_irq);
 
 	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7fe6267..7f70235 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -197,7 +197,6 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 			break;
 		default:
 			BUG();
-			return;
 		}
 		l = omap_readl(reg);
 		l &= ~(0xf << 8);
@@ -562,9 +561,8 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 		 * fall through
 		 */
 	default:
-		printk(KERN_ERR "Invalid DMA burst mode\n");
+		pr_err("Invalid DMA burst mode\n");
 		BUG();
-		return;
 	}
 	l |= (burst << 14);
 	p->dma_write(l, CSDP, lch);
@@ -1147,15 +1145,13 @@ void omap_dma_link_lch(int lch_head, int lch_queue)
 								CCR, lch_head);
 			return;
 		}
-		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
+		pr_err("DMA linking is not supported in 1510 mode\n");
 		BUG();
-		return;
 	}
 
 	if ((dma_chan[lch_head].dev_id == -1) ||
 	    (dma_chan[lch_queue].dev_id == -1)) {
-		printk(KERN_ERR "omap_dma: trying to link "
-		       "non requested channels\n");
+		pr_err("omap_dma: trying to link non requested channels\n");
 		dump_stack();
 	}
 
@@ -1174,22 +1170,19 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 								CCR, lch_head);
 			return;
 		}
-		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
+		pr_err("DMA linking is not supported in 1510 mode\n");
 		BUG();
-		return;
 	}
 
 	if (dma_chan[lch_head].next_lch != lch_queue ||
 	    dma_chan[lch_head].next_lch == -1) {
-		printk(KERN_ERR "omap_dma: trying to unlink "
-		       "non linked channels\n");
+		pr_err("omap_dma: trying to unlink non linked channels\n");
 		dump_stack();
 	}
 
 	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
 	    (dma_chan[lch_queue].flags & OMAP_DMA_ACTIVE)) {
-		printk(KERN_ERR "omap_dma: You need to stop the DMA channels "
-		       "before unlinking\n");
+		pr_err("omap_dma: You need to stop the DMA channels before unlinking\n");
 		dump_stack();
 	}
 
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index cff8712..fd0d3aa 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -76,7 +76,7 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 		return -ENODEV;
 	}
 
-	reg = (struct pin_config *)&mux_cfg->pins[index];
+	reg = &mux_cfg->pins[index];
 
 	if (!mux_cfg->cfg_reg)
 		return -ENODEV;


