From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 12/27] ARM: OMAP2+: clock: add support for clkdm ops to the low level clk ops
Date: Mon, 25 May 2015 18:00:17 +0300
Message-ID: <1432566032-10860-13-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbEYPBY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2015 11:01:24 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Clock driver requires access to certain clockdomain handling ops once
the code is being moved over under clock driver. Example of this is
clk_enable / clk_disable under omap3 DPLL code. The required clkdm
APIs are now exported through the ti_clk_ll_ops struct.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |    2 ++
 include/linux/clk/ti.h      |   16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 94a4949..d6afc12 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -120,6 +120,8 @@ u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
 static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_readl = clk_memmap_readl,
 	.clk_writel = clk_memmap_writel,
+	.clkdm_clk_enable = clkdm_clk_enable,
+	.clkdm_clk_disable = clkdm_clk_disable,
 };
 
 /**
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 43184c2..43b406c 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -238,18 +238,24 @@ struct clk_omap_reg {
 };
 
 /**
- * struct ti_clk_ll_ops - low-level register access ops for a clock
+ * struct ti_clk_ll_ops - low-level ops for clocks
  * @clk_readl: pointer to register read function
  * @clk_writel: pointer to register write function
+ * @clkdm_clk_enable: pointer to clockdomain enable function
+ * @clkdm_clk_disable: pointer to clockdomain disable function
  *
- * Low-level register access ops are generally used by the basic clock types
- * (clk-gate, clk-mux, clk-divider etc.) to provide support for various
- * low-level hardware interfaces (direct MMIO, regmap etc.), but can also be
- * used by other hardware-specific clock drivers if needed.
+ * Low-level ops are generally used by the basic clock types (clk-gate,
+ * clk-mux, clk-divider etc.) to provide support for various low-level
+ * hadrware interfaces (direct MMIO, regmap etc.), and is initialized
+ * by board code. Low-level ops also contain some other platform specific
+ * operations not provided directly by clock drivers.
  */
 struct ti_clk_ll_ops {
 	u32	(*clk_readl)(void __iomem *reg);
 	void	(*clk_writel)(u32 val, void __iomem *reg);
+	int	(*clkdm_clk_enable)(struct clockdomain *clkdm, struct clk *clk);
+	int	(*clkdm_clk_disable)(struct clockdomain *clkdm,
+				     struct clk *clk);
 };
 
 extern struct ti_clk_ll_ops *ti_clk_ll_ops;
-- 
1.7.9.5

