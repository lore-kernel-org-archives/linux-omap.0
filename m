From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 08/15] clk: ti: add clkdm_lookup to the exported functions
Date: Tue, 18 Oct 2016 18:46:01 +0300
Message-ID: <1476805568-19264-9-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This will be needed to move some additional clockdomain functionality
under clock driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c | 1 +
 include/linux/clk/ti.h      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d058125..5391b66 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -57,6 +57,7 @@
 static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clkdm_clk_enable = clkdm_clk_enable,
 	.clkdm_clk_disable = clkdm_clk_disable,
+	.clkdm_lookup = clkdm_lookup,
 	.cm_wait_module_ready = omap_cm_wait_module_ready,
 	.cm_split_idlest_reg = cm_split_idlest_reg,
 };
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 07308db..bc7fd8f 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -213,6 +213,7 @@ struct clk_omap_reg {
  * @clk_writel: pointer to register write function
  * @clkdm_clk_enable: pointer to clockdomain enable function
  * @clkdm_clk_disable: pointer to clockdomain disable function
+ * @clkdm_lookup: pointer to clockdomain lookup function
  * @cm_wait_module_ready: pointer to CM module wait ready function
  * @cm_split_idlest_reg: pointer to CM module function to split idlest reg
  *
@@ -228,6 +229,7 @@ struct ti_clk_ll_ops {
 	int	(*clkdm_clk_enable)(struct clockdomain *clkdm, struct clk *clk);
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm,
 				     struct clk *clk);
+	struct clockdomain * (*clkdm_lookup)(const char *name);
 	int	(*cm_wait_module_ready)(u8 part, s16 prcm_mod, u16 idlest_reg,
 					u8 idlest_shift);
 	int	(*cm_split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
-- 
1.9.1

