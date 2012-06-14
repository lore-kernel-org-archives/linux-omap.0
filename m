From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 15/29] ARM: omap: clk: list all clk_hw_omap clks to enable/disable autoidle
Date: Thu, 14 Jun 2012 18:17:04 +0530
Message-ID: <1339678038-23082-16-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39673 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab2FNMsK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:48:10 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Platforms can call omap2_init_clk_hw_omap_clocks() to register a clock
using clk_hw_omap. omap2_clk_enable_autoidle_all() and
omap2_clk_disable_autoidle_all() can then be used to run through
all the clocks which support autoidle to enable/disable them.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h |    3 +++
 arch/arm/mach-omap2/io.c    |   27 +++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 42cdd9f..df7062d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -50,6 +50,7 @@ u16 cpu_mask;
 static bool clkdm_control = true;
 
 #ifdef CONFIG_COMMON_CLK
+LIST_HEAD(clk_hw_omap_clocks);
 
 /*
  * Used for clocks that have the same value as the parent clock,
@@ -359,6 +360,37 @@ static int __init omap_clk_setup(char *str)
 }
 __setup("mpurate=", omap_clk_setup);
 
+void omap2_init_clk_hw_omap_clocks(struct clk *clk)
+{
+	struct clk_hw_omap *c;
+
+	if (__clk_get_flags(clk) & CLK_IS_BASIC)
+		return;
+
+	c = to_clk_hw_omap(__clk_get_hw(clk));
+	list_add(&c->node, &clk_hw_omap_clocks);
+}
+
+int omap2_clk_enable_autoidle_all(void)
+{
+	struct clk_hw_omap *c;
+
+	list_for_each_entry(c, &clk_hw_omap_clocks, node)
+		if (c->ops && c->ops->allow_idle)
+			c->ops->allow_idle(c);
+	return 0;
+}
+
+int omap2_clk_disable_autoidle_all(void)
+{
+	struct clk_hw_omap *c;
+
+	list_for_each_entry(c, &clk_hw_omap_clocks, node)
+		if (c->ops && c->ops->allow_idle)
+			c->ops->allow_idle(c);
+	return 0;
+}
+
 const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
 	.allow_idle	= omap3_dpll_allow_idle,
 	.deny_idle	= omap3_dpll_deny_idle,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 4fa1dda..0a38b56 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -175,6 +175,9 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk, void __iomem **other
 				   u8 *other_bit);
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk, void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
+void omap2_init_clk_hw_omap_clocks(struct clk *clk);
+int omap2_clk_enable_autoidle_all(void);
+int omap2_clk_disable_autoidle_all(void);
 #else
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8d014ba..43365df 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -356,6 +356,9 @@ void __init omap2420_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap2_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
@@ -378,6 +381,9 @@ void __init omap2430_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap2_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
@@ -439,6 +445,9 @@ void __init omap3_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init omap3430_init_late(void)
@@ -446,6 +455,9 @@ void __init omap3430_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init omap35xx_init_late(void)
@@ -453,6 +465,9 @@ void __init omap35xx_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init omap3630_init_late(void)
@@ -460,6 +475,9 @@ void __init omap3630_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init am35xx_init_late(void)
@@ -467,6 +485,9 @@ void __init am35xx_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init ti81xx_init_late(void)
@@ -474,6 +495,9 @@ void __init ti81xx_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
@@ -497,6 +521,9 @@ void __init omap4430_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap4_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
-- 
1.7.1

