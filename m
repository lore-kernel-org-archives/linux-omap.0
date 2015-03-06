From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/24] ARM: OMAP2+: clock: add support for specific CM ops to ti_clk_ll_ops
Date: Fri, 6 Mar 2015 14:28:48 +0200
Message-ID: <1425644939-3232-14-git-send-email-t-kristo@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57392 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbbCFM3w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 07:29:52 -0500
In-Reply-To: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Clock driver requires access to some CM API functions once the code
is being moved under the clock driver from the platform directory.
Gate type clock requires access to cm_wait_module_ready and
cm_split_idlest_reg functions, which are both used for waiting until
the module being clocked has been successfully activated. These CM
APIs are now exported through the ti_clk_ll_ops struct.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm_common.c |    2 ++
 include/linux/clk/ti.h           |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 6fcb932..b9ad113 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -626,6 +626,8 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_writel = prm_clk_writel,
 	.clkdm_clk_enable = clkdm_clk_enable,
 	.clkdm_clk_disable = clkdm_clk_disable,
+	.cm_wait_module_ready = omap_cm_wait_module_ready,
+	.cm_split_idlest_reg = cm_split_idlest_reg,
 };
 
 int __init of_prcm_init(void)
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 4778783..339cc38 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -243,6 +243,8 @@ struct clk_omap_reg {
  * @clk_writel: pointer to register write function
  * @clkdm_clk_enable: pointer to clockdomain enable function
  * @clkdm_clk_disable: pointer to clockdomain disable function
+ * @cm_wait_module_ready: pointer to CM module wait ready function
+ * @cm_split_idlest_reg: pointer to CM module function to split idlest reg
  *
  * Low-level ops are generally used by the basic clock types (clk-gate,
  * clk-mux, clk-divider etc.) to provide support for various low-level
@@ -256,6 +258,10 @@ struct ti_clk_ll_ops {
 	int	(*clkdm_clk_enable)(struct clockdomain *clkdm, struct clk *clk);
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm,
 				     struct clk *clk);
+	int	(*cm_wait_module_ready)(u8 part, s16 prcm_mod, u16 idlest_reg,
+					u8 idlest_shift);
+	int	(*cm_split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
+				       u8 *idlest_reg_id);
 };
 
 extern struct ti_clk_ll_ops *ti_clk_ll_ops;
-- 
1.7.9.5

