From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 13/27] ARM: OMAP2+: clock: add support for specific CM ops to ti_clk_ll_ops
Date: Mon, 11 May 2015 11:54:39 +0300
Message-ID: <1431334493-24455-14-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272AbbEKIzN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 04:55:13 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Clock driver requires access to some CM API functions once the code
is being moved under the clock driver from the platform directory.
Gate type clock requires access to cm_wait_module_ready and
cm_split_idlest_reg functions, which are both used for waiting until
the module being clocked has been successfully activated. These CM
APIs are now exported through the ti_clk_ll_ops struct.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |    2 ++
 include/linux/clk/ti.h      |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d6afc12..7a5713d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -122,6 +122,8 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_writel = clk_memmap_writel,
 	.clkdm_clk_enable = clkdm_clk_enable,
 	.clkdm_clk_disable = clkdm_clk_disable,
+	.cm_wait_module_ready = omap_cm_wait_module_ready,
+	.cm_split_idlest_reg = cm_split_idlest_reg,
 };
 
 /**
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 43b406c..3ca818e 100644
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

