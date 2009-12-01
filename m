From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 5/5] ARM: OMAP4: PM: Add init api for DPLL nodes
Date: Tue,  1 Dec 2009 17:57:28 +0530
Message-ID: <1259670448-19840-5-git-send-email-rnayak@ti.com>
References: <1259670448-19840-1-git-send-email-rnayak@ti.com>
 <1259670448-19840-2-git-send-email-rnayak@ti.com>
 <1259670448-19840-3-git-send-email-rnayak@ti.com>
 <1259670448-19840-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52978 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663AbZLAM1i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Dec 2009 07:27:38 -0500
In-Reply-To: <1259670448-19840-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

An api at init for all dpll nodes seem to be
needed to reparent the dpll clk node to its
bypass clk in case the dpll is in bypass.
If not done this causes sequencing issues at init
during propogate_rate.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock.c     |   34 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock.h     |    1 +
 arch/arm/mach-omap2/clock44xx.h |    7 +++++++
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 88b53b9..d0d4bb9 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -70,9 +70,41 @@
 u8 cpu_mask;
 
 /*-------------------------------------------------------------------------
- * OMAP2/3 specific clock functions
+ * OMAP2/3/4 specific clock functions
  *-------------------------------------------------------------------------*/
 
+void omap2_init_dpll_parent(struct clk *clk)
+{
+	u32 v;
+	struct dpll_data *dd;
+
+	dd = clk->dpll_data;
+	if (!dd)
+		return;
+
+	/* Return bypass rate if DPLL is bypassed */
+	v = __raw_readl(dd->control_reg);
+	v &= dd->enable_mask;
+	v >>= __ffs(dd->enable_mask);
+
+	/* Reparent in case the dpll is in bypass */
+	if (cpu_is_omap24xx()) {
+		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
+			clk_reparent(clk, dd->clk_bypass);
+	} else if (cpu_is_omap34xx()) {
+		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
+			clk_reparent(clk, dd->clk_bypass);
+	} else if (cpu_is_omap44xx()) {
+		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
+		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
+			clk_reparent(clk, dd->clk_bypass);
+	}
+	return;
+}
+
 /**
  * _omap2xxx_clk_commit - commit clock parent/rate changes in hardware
  * @clk: struct clk *
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 29e6a1a..e914156 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -82,6 +82,7 @@ unsigned long omap2_fixed_divisor_recalc(struct clk *clk);
 long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
+void omap2_init_dpll_parent(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
 void omap2_clk_prepare_for_reboot(void);
 int omap2_dflt_clk_enable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 0f980df..957ede0 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -281,6 +281,7 @@ static struct clk dpll_abe_ck = {
 	.name		= "dpll_abe_ck",
 	.parent		= &abe_dpll_refclk_mux_ck,
 	.dpll_data	= &dpll_abe_dd,
+	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -442,6 +443,7 @@ static struct clk dpll_core_ck = {
 	.name		= "dpll_core_ck",
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_core_dd,
+	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_null,
 	.recalc		= &omap3_dpll_recalc,
 	.flags		= CLOCK_IN_OMAP4430,
@@ -668,6 +670,7 @@ static struct clk dpll_iva_ck = {
 	.name		= "dpll_iva_ck",
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_iva_dd,
+	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -730,6 +733,7 @@ static struct clk dpll_mpu_ck = {
 	.name		= "dpll_mpu_ck",
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_mpu_dd,
+	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -805,6 +809,7 @@ static struct clk dpll_per_ck = {
 	.name		= "dpll_per_ck",
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_per_dd,
+	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -927,6 +932,7 @@ static struct clk dpll_unipro_ck = {
 	.name		= "dpll_unipro_ck",
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_unipro_dd,
+	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -984,6 +990,7 @@ static struct clk dpll_usb_ck = {
 	.name		= "dpll_usb_ck",
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_usb_dd,
+	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
-- 
1.5.4.7

