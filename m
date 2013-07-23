From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 24/33] CLK: OMAP: move some defines from machine to driver header
Date: Tue, 23 Jul 2013 10:20:19 +0300
Message-ID: <1374564028-11352-25-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46763 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab3GWHXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 03:23:10 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

This is done in preparation for adding support for OMAP3 clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.h |   10 ----------
 include/linux/clk/omap.h    |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 6273f14..949d293 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -257,9 +257,6 @@ extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
 
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
-int omap2_dflt_clk_enable(struct clk_hw *hw);
-void omap2_dflt_clk_disable(struct clk_hw *hw);
-int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 				   void __iomem **other_reg,
 				   u8 *other_bit);
@@ -286,14 +283,7 @@ extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
 extern struct clk dummy_ck;
 
-extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
-extern const struct clk_hw_omap_ops clkhwops_wait;
-extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
index c8d9468..24bdd83 100644
--- a/include/linux/clk/omap.h
+++ b/include/linux/clk/omap.h
@@ -183,19 +183,35 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
+int omap2_dflt_clk_enable(struct clk_hw *hw);
+void omap2_dflt_clk_disable(struct clk_hw *hw);
+int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
+
+int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
+			 unsigned long parent_rate);
+
 int omap2_clk_disable_autoidle_all(void);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_wait;
+extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
+extern const struct clk_hw_omap_ops clkhwops_iclk;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 
 /* DT functions */
 int dt_omap_clk_init(void);
 extern void omap_dt_clocks_register(struct omap_dt_clk *oclks, int cnt);
 void of_omap4_dpll_setup(struct device_node *node);
+void of_omap3_dpll_setup(struct device_node *node);
 void of_omap_fixed_factor_setup(struct device_node *node);
 void of_omap_divider_setup(struct device_node *node);
 void of_omap_gate_clk_setup(struct device_node *node);
+void of_omap_interface_clk_setup(struct device_node *node);
 void of_omap_clk_allow_autoidle_all(void);
 void of_omap_clk_deny_autoidle_all(void);
 
-- 
1.7.9.5

