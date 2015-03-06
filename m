From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/24] ARM: OMAP2+: clock: add support for clkdm ops to the low level clk ops
Date: Fri, 6 Mar 2015 14:28:47 +0200
Message-ID: <1425644939-3232-13-git-send-email-t-kristo@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58181 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237AbbCFM3w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 07:29:52 -0500
In-Reply-To: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Clock driver requires access to certain clockdomain handling ops once
the code is being moved over under clock driver. Example of this is
clk_enable / clk_disable under omap3 DPLL code. The required clkdm
APIs are now exported through the ti_clk_ll_ops struct.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm_common.c |    3 +++
 include/linux/clk/ti.h           |   16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index bfaa7ba..6fcb932 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -37,6 +37,7 @@
 #include "clock.h"
 #include "cm.h"
 #include "control.h"
+#include "clockdomain.h"
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
@@ -623,6 +624,8 @@ static void prm_clk_writel(u32 val, void __iomem *reg)
 static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_readl = prm_clk_readl,
 	.clk_writel = prm_clk_writel,
+	.clkdm_clk_enable = clkdm_clk_enable,
+	.clkdm_clk_disable = clkdm_clk_disable,
 };
 
 int __init of_prcm_init(void)
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index b1ecb7a..4778783 100644
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

