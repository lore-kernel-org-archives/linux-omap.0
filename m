From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 02/35] clk: ti: gate/interface: add support for clk_ops->disable_unused
Date: Wed, 15 Apr 2015 15:52:49 +0300
Message-ID: <1429102402-5276-3-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35724 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111AbbDOMwi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:38 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

While executing clk_disable_unused during boot, the dflt clk operations
to disable the clocks include usecounting mechanism for clockdomains,
which is indexed badly in case a direct clock disable call is made. This
can potentially cause the underlying clockdomain to be disabled in
certain cases. Fixed by adding a separate disable_unused clk_ops, which
does not access the clockdomain functionality at all, and won't mess up
the usecounting.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   27 +++++++++++++++++++++------
 drivers/clk/ti/composite.c  |    1 +
 drivers/clk/ti/gate.c       |    2 ++
 drivers/clk/ti/interface.c  |    1 +
 include/linux/clk/ti.h      |    1 +
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6124db5..2b096c7 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -345,15 +345,12 @@ err:
 }
 
 /**
- * omap2_dflt_clk_disable - disable a clock in the hardware
+ * omap2_dflt_clk_disable_ll - low level disable a clock in the hardware
  * @hw: struct clk_hw * of the clock to disable
  *
- * Disable the clock @hw in the hardware, and call into the OMAP
- * clockdomain code to "disable" the corresponding clockdomain if all
- * clocks/hwmods in that clockdomain are now disabled.  No return
- * value.
+ * Disable the clock @hw in the hardware. No return value.
  */
-void omap2_dflt_clk_disable(struct clk_hw *hw)
+void omap2_dflt_clk_disable_ll(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk;
 	u32 v;
@@ -376,6 +373,24 @@ void omap2_dflt_clk_disable(struct clk_hw *hw)
 		v &= ~(1 << clk->enable_bit);
 	omap2_clk_writel(v, clk, clk->enable_reg);
 	/* No OCP barrier needed here since it is a disable operation */
+}
+
+/**
+ * omap2_dflt_clk_disable - disable a clock in the hardware
+ * @hw: struct clk_hw * of the clock to disable
+ *
+ * Disable the clock @hw in the hardware, and call into the OMAP
+ * clockdomain code to "disable" the corresponding clockdomain if all
+ * clocks/hwmods in that clockdomain are now disabled.  No return
+ * value.
+ */
+void omap2_dflt_clk_disable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk;
+
+	clk = to_clk_hw_omap(hw);
+
+	omap2_dflt_clk_disable_ll(hw);
 
 	if (clkdm_control && clk->clkdm)
 		clkdm_clk_disable(clk->clkdm, hw->clk);
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 3654f61..9e10191 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -57,6 +57,7 @@ static const struct clk_ops ti_composite_divider_ops = {
 static const struct clk_ops ti_composite_gate_ops = {
 	.enable		= &omap2_dflt_clk_enable,
 	.disable	= &omap2_dflt_clk_disable,
+	.disable_unused	= &omap2_dflt_clk_disable_ll,
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index d493307..e2d4d1e 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -41,6 +41,7 @@ static const struct clk_ops omap_gate_clk_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_dflt_clk_enable,
 	.disable	= &omap2_dflt_clk_disable,
+	.disable_unused	= &omap2_dflt_clk_disable_ll,
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
@@ -48,6 +49,7 @@ static const struct clk_ops omap_gate_clk_hsdiv_restore_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap36xx_gate_clk_enable_with_hsdiv_restore,
 	.disable	= &omap2_dflt_clk_disable,
+	.disable_unused	= &omap2_dflt_clk_disable_ll,
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 265d91f..c037259 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -29,6 +29,7 @@ static const struct clk_ops ti_interface_clk_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_dflt_clk_enable,
 	.disable	= &omap2_dflt_clk_disable,
+	.disable_unused	= &omap2_dflt_clk_disable_ll,
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6784400..c8c0543 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -306,6 +306,7 @@ int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate, u8 index);
 int omap2_dflt_clk_enable(struct clk_hw *hw);
+void omap2_dflt_clk_disable_ll(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 void omap3_clk_lock_dpll5(void);
-- 
1.7.9.5

