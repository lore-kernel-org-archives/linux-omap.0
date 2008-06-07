From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 20/21] ARM: OMAP: Turn CM and PRM access into functions
Date: Fri,  6 Jun 2008 18:30:52 -0700
Message-ID: <1212802253-17797-21-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
 <1212802253-17797-8-git-send-email-tony@atomide.com>
 <1212802253-17797-9-git-send-email-tony@atomide.com>
 <1212802253-17797-10-git-send-email-tony@atomide.com>
 <1212802253-17797-11-git-send-email-tony@atomide.com>
 <1212802253-17797-12-git-send-email-tony@atomide.com>
 <1212802253-17797-13-git-send-email-tony@atomide.com>
 <1212802253-17797-14-git-send-email-tony@atomide.com>
 <1212802253-17797-15-git-send-email-tony@atomide.com>
 <1212802253-17797-16-git-send-email-tony@atomide.com>
 <1212802253-17797-17-git-send-email-tony@atomide.com>
 <1212802253-17797-18-git-send-email-tony@atomide.com>
 <1212802253-17797-19-git-send-email-tony@atomide.com>
 <1212802253-17797-20-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55644 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933772AbYFGBbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:41 -0400
In-Reply-To: <1212802253-17797-20-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Otherwise compiling in omap2 and omap3 will not work.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d5980a9..f979485 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -42,6 +42,7 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
+void omap2_clk_prepare_for_reboot(void);
 
 extern u8 cpu_mask;
 
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index e2d404e..1dd873f 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -99,6 +99,17 @@
 
 extern u32 cm_read_mod_reg(s16 module, u16 idx);
 extern void cm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+
+static inline u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return cm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+static inline u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
 
 #endif
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 9584376..fd92a80 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -28,10 +28,9 @@
 static void __iomem *prm_base;
 static void __iomem *cm_base;
 
-extern void omap2_clk_prepare_for_reboot(void);
-
 u32 omap_prcm_get_reset_sources(void)
 {
+	/* XXX This presumably needs modification for 34XX */
 	return prm_read_mod_reg(WKUP_MOD, RM_RSTST) & 0x7f;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
@@ -39,13 +38,17 @@ EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 /* Resets clock rates and reboots the system. Only called from system.h */
 void omap_prcm_arch_reset(char mode)
 {
-	u32 wkup;
+	s16 prcm_offs;
 	omap2_clk_prepare_for_reboot();
 
-	if (cpu_is_omap24xx()) {
-		wkup = prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | OMAP_RST_DPLL3;
-		prm_write_mod_reg(wkup, WKUP_MOD, RM_RSTCTRL);
-	}
+	if (cpu_is_omap24xx())
+		prcm_offs = WKUP_MOD;
+	else if (cpu_is_omap34xx())
+		prcm_offs = OMAP3430_GR_MOD;
+	else
+		WARN_ON(1);
+
+	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
 }
 
 static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
@@ -75,6 +78,20 @@ void prm_write_mod_reg(u32 val, s16 module, u16 idx)
 }
 EXPORT_SYMBOL(prm_write_mod_reg);
 
+/* Read-modify-write a register in a PRM module. Caller must lock */
+u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{
+	u32 v;
+
+	v = prm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	prm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+EXPORT_SYMBOL(prm_rmw_mod_reg_bits);
+
 /* Read a register in a CM module */
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
@@ -89,6 +106,20 @@ void cm_write_mod_reg(u32 val, s16 module, u16 idx)
 }
 EXPORT_SYMBOL(cm_write_mod_reg);
 
+/* Read-modify-write a register in a CM module. Caller must lock */
+u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{
+	u32 v;
+
+	v = cm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	cm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+EXPORT_SYMBOL(cm_rmw_mod_reg_bits);
+
 void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
 	prm_base = omap2_globals->prm;
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index e901fb9..bbf41fc 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -168,6 +168,18 @@
 /* Power/reset management domain register get/set */
 extern u32 prm_read_mod_reg(s16 module, u16 idx);
 extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+
+/* Read-modify-write bits in a PRM register (by domain) */
+static inline u32 prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return prm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
 
 #endif
 
