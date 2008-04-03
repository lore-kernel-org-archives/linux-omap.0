From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] PRM/CM: Convert existing code to use PRM/CM RMW functions
Date: Thu, 03 Apr 2008 16:34:41 -0600
Message-ID: <20080403223535.907471961@pwsan.com>
References: <20080403223439.820599556@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51594 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757808AbYDCWiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 18:38:08 -0400
Content-Disposition: inline; filename=convert_code_to_use_cm_prm_rmw_funcs.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: toshihiro.kobayashi@nokia.com

Convert existing code that reads, modifies, and writes back CM/PRM
register values to use the rmw functions introduced in the previous
patch.  This code should eventually disappear once clockdomain handling
is integrated into the 24xx clock framework.

Also restructure arch/arm/mach-omap2/prcm.c slightly while we
are here. 

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |    8 +++-----
 arch/arm/mach-omap2/clock24xx.c   |   15 ++++-----------
 arch/arm/mach-omap2/pm.c          |   19 +++++--------------
 arch/arm/mach-omap2/prcm.c        |   14 ++++++++------
 drivers/dsp/dspgateway/dsp_core.c |   14 +++++---------
 5 files changed, 25 insertions(+), 45 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2008-04-03 16:10:12.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2008-04-03 16:21:43.000000000 -0600
@@ -577,7 +577,7 @@
 
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 {
-	u32 field_mask, field_val, reg_val, validrate, new_div = 0;
+	u32 field_mask, field_val, validrate, new_div = 0;
 	void __iomem *div_addr;
 
 	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
@@ -592,10 +592,8 @@
 	if (field_val == ~0)
 		return -EINVAL;
 
-	reg_val = cm_read_reg(div_addr);
-	reg_val &= ~field_mask;
-	reg_val |= (field_val << __ffs(field_mask));
-	cm_write_reg(reg_val, div_addr);
+	cm_rmw_reg_bits(field_mask, field_val << __ffs(field_mask), div_addr);
+
 	wmb();
 
 	clk->rate = clk->parent->rate / new_div;
Index: linux-omap/arch/arm/mach-omap2/clock24xx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock24xx.c	2008-04-03 16:10:12.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock24xx.c	2008-04-03 16:21:43.000000000 -0600
@@ -77,24 +77,17 @@
 
 static int omap2_enable_osc_ck(struct clk *clk)
 {
-	u32 pcc;
 
-	pcc = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
-
-	prm_write_reg(pcc & ~OMAP_AUTOEXTCLKMODE_MASK,
-		      OMAP24XX_PRCM_CLKSRC_CTRL);
+	prm_rmw_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, ~OMAP_AUTOEXTCLKMODE_MASK,
+			 OMAP24XX_PRCM_CLKSRC_CTRL);
 
 	return 0;
 }
 
 static void omap2_disable_osc_ck(struct clk *clk)
 {
-	u32 pcc;
-
-	pcc = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
-
-	prm_write_reg(pcc | OMAP_AUTOEXTCLKMODE_MASK,
-		      OMAP24XX_PRCM_CLKSRC_CTRL);
+	prm_rmw_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, OMAP_AUTOEXTCLKMODE_MASK,
+			 OMAP24XX_PRCM_CLKSRC_CTRL);
 }
 
 /* Enable an APLL if off */
Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c	2008-04-03 16:10:12.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/pm.c	2008-04-03 16:21:43.000000000 -0600
@@ -162,7 +162,6 @@
 {
 	const struct omap_serial_console_config *conf;
 	char name[16];
-	u32 l;
 
 	conf = omap_get_config(OMAP_TAG_SERIAL_CONSOLE,
 			       struct omap_serial_console_config);
@@ -185,19 +184,13 @@
 	}
 	switch (serial_console_uart) {
 	case 1:
-		l = prm_read_mod_reg(CORE_MOD, PM_WKEN1);
-		l |= OMAP24XX_ST_UART1;
-		prm_write_mod_reg(l, CORE_MOD, PM_WKEN1);
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1)
 		break;
 	case 2:
-		l = prm_read_mod_reg(CORE_MOD, PM_WKEN1);
-		l |= OMAP24XX_ST_UART2;
-		prm_write_mod_reg(l, CORE_MOD, PM_WKEN1);
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1)
 		break;
 	case 3:
-		l = prm_read_mod_reg(CORE_MOD, OMAP24XX_PM_WKEN2);
-		l |= OMAP24XX_ST_UART3;
-		prm_write_mod_reg(l, CORE_MOD, OMAP24XX_PM_WKEN2);
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, PM_WKEN2)
 		break;
 	}
 }
@@ -445,10 +438,8 @@
 	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
 	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
 
-	/* wakeup domain events */
-	l = prm_read_mod_reg(WKUP_MOD, PM_WKST);
-	l &= 0x5;  /* bit 1: GPT1, bit5 GPIO */
-	prm_write_mod_reg(l, WKUP_MOD, PM_WKST);
+	/* wakeup domain events - bit 1: GPT1, bit5 GPIO */
+	prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
 
 	/* MPU domain wake events */
 	l = prm_read_reg(OMAP24XX_PRCM_IRQSTATUS_MPU);
Index: linux-omap/arch/arm/mach-omap2/prcm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prcm.c	2008-04-03 16:10:12.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/prcm.c	2008-04-03 16:21:43.000000000 -0600
@@ -25,6 +25,7 @@
 
 u32 omap_prcm_get_reset_sources(void)
 {
+	/* XXX This presumably needs modification for 34XX */
 	return prm_read_mod_reg(WKUP_MOD, RM_RSTST) & 0x7f;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
@@ -32,15 +33,16 @@
 /* Resets clock rates and reboots the system. Only called from system.h */
 void omap_prcm_arch_reset(char mode)
 {
-	u32 wkup;
+	s16 prcm_offs;
 	omap2_clk_prepare_for_reboot();
 
 	if (cpu_is_omap24xx()) {
-		wkup = prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | OMAP_RST_DPLL3;
-		prm_write_mod_reg(wkup, WKUP_MOD, RM_RSTCTRL);
+		prcm_offs = WKUP_MOD;
 	} else if (cpu_is_omap34xx()) {
-		wkup = prm_read_mod_reg(OMAP3430_GR_MOD, RM_RSTCTRL)
-							| OMAP_RST_DPLL3;
-		prm_write_mod_reg(wkup, OMAP3430_GR_MOD, RM_RSTCTRL);
+		prcm_offs = OMAP3430_GR_MOD;
+	} else {
+		WARN_ON(1);
 	}
+
+	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
 }
Index: linux-omap/drivers/dsp/dspgateway/dsp_core.c
===================================================================
--- linux-omap.orig/drivers/dsp/dspgateway/dsp_core.c	2008-04-03 16:10:12.000000000 -0600
+++ linux-omap/drivers/dsp/dspgateway/dsp_core.c	2008-04-03 16:23:08.000000000 -0600
@@ -460,19 +460,15 @@
 #elif defined(CONFIG_ARCH_OMAP2)
 static inline void dsp_clk_enable(void)
 {
-	u32 r;
-
 	/*XXX should be handled in mach-omap[1,2] XXX*/
 	prm_write_mod_reg(OMAP24XX_FORCESTATE | (1 << OMAP_POWERSTATE_SHIFT),
 			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
 
-	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-	r |= OMAP2420_AUTO_DSP_IPI;
-	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-
-	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
-	r |= OMAP24XX_AUTOSTATE_DSP;
-	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+	cm_set_mod_reg_bits(OMAP2420_AUTO_DSP_IPI, OMAP24XX_DSP_MOD,
+			    CM_AUTOIDLE);
+
+	cm_set_mod_reg_bits(OMAP24XX_AUTOSTATE_DSP, OMAP24XX_DSP_MOD,
+			    CM_CLKSTCTRL);
 
 	clk_enable(dsp_fck_handle);
 	clk_enable(dsp_ick_handle);

-- 

