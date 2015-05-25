From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 04/27] clk: ti: move interface clock implementation under drivers/clk
Date: Mon, 25 May 2015 18:00:09 +0300
Message-ID: <1432566032-10860-5-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33861 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbEYPBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2015 11:01:04 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With the legacy clock support gone, the OMAP interface clock implementation
can be moved under the clock driver. Some temporary header file tweaks are
also needed to make this change work properly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    3 +--
 arch/arm/mach-omap2/clock.h                        |   11 -----------
 drivers/clk/ti/Makefile                            |    2 +-
 .../arm/mach-omap2 => drivers/clk/ti}/clkt_iclk.c  |   12 +++++-------
 drivers/clk/ti/clock.h                             |    2 ++
 include/linux/clk/ti.h                             |   10 ++++++++--
 6 files changed, 17 insertions(+), 23 deletions(-)
 rename {arch/arm/mach-omap2 => drivers/clk/ti}/clkt_iclk.c (89%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5bcd282..a2f5156 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -185,13 +185,12 @@ obj-$(CONFIG_SOC_DRA7XX)		+= clockdomains7xx_data.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
-obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o clkt_iclk.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d7ed244..ca8c42c 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -198,16 +198,6 @@ int omap2_clksel_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate);
 int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
 
-/* clkt_iclk.c public functions */
-extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
-extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
-
-void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
-				   void __iomem **other_reg,
-				   u8 *other_bit);
-void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
-				void __iomem **idlest_reg,
-				u8 *idlest_bit, u8 *idlest_val);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
 int omap2_clk_deny_idle(struct clk *clk);
@@ -231,7 +221,6 @@ extern const struct clksel_rate gpt_sys_rates[];
 extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
 
-extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index c3ec301..23cd726 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,7 +1,7 @@
 obj-y					+= clk.o autoidle.o clockdomain.o
 clk-common				= dpll.o composite.o divider.o gate.o \
 					  fixed-factor.o mux.o apll.o \
-					  clkt_dpll.o
+					  clkt_dpll.o clkt_iclk.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
 obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/drivers/clk/ti/clkt_iclk.c
similarity index 89%
rename from arch/arm/mach-omap2/clkt_iclk.c
rename to drivers/clk/ti/clkt_iclk.c
index 55eb579..a03919d 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/drivers/clk/ti/clkt_iclk.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/clk/ti.h>
 
 #include "clock.h"
 
@@ -31,9 +32,9 @@ void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk)
 	r = (__force void __iomem *)
 		((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
 
-	v = omap2_clk_readl(clk, r);
+	v = ti_clk_ll_ops->clk_readl(r);
 	v |= (1 << clk->enable_bit);
-	omap2_clk_writel(v, clk, r);
+	ti_clk_ll_ops->clk_writel(v, r);
 }
 
 /* XXX */
@@ -45,9 +46,9 @@ void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk)
 	r = (__force void __iomem *)
 		((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
 
-	v = omap2_clk_readl(clk, r);
+	v = ti_clk_ll_ops->clk_readl(r);
 	v &= ~(1 << clk->enable_bit);
-	omap2_clk_writel(v, clk, r);
+	ti_clk_ll_ops->clk_writel(v, r);
 }
 
 /* Public data */
@@ -63,6 +64,3 @@ const struct clk_hw_omap_ops clkhwops_iclk_wait = {
 	.find_idlest	= omap2_clk_dflt_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
-
-
-
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index c75d4b4..a7256a9 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -170,6 +170,8 @@ struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
 
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
+extern const struct clk_hw_omap_ops clkhwops_iclk;
+extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 89deddf..63f2945 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -296,6 +296,14 @@ int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
+void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
+void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
+void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
+				   void __iomem **other_reg,
+				   u8 *other_bit);
+void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
+				void __iomem **idlest_reg,
+				u8 *idlest_bit, u8 *idlest_val);
 void omap3_clk_lock_dpll5(void);
 unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
@@ -358,8 +366,6 @@ extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
-extern const struct clk_hw_omap_ops clkhwops_iclk;
-extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
-- 
1.7.9.5

