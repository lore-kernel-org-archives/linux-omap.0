From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 07/26] ARM: OMAP: clock: list all clk_hw_omap clks to enable/disable autoidle
Date: Wed, 7 Nov 2012 17:12:42 -0800
Message-ID: <1352337181-29427-8-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45950 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab2KHBNd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:33 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Platforms can call omap2_init_clk_hw_omap_clocks() to register a clock
using clk_hw_omap. omap2_clk_enable_autoidle_all() and
omap2_clk_disable_autoidle_all() can then be used to run through
all the clocks which support autoidle to enable/disable them.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clock.c      |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h      |    3 +++
 arch/arm/mach-omap2/io.c         |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 3a4c1c5..2b4cfae 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -57,6 +57,7 @@ static DEFINE_MUTEX(clocks_mutex);
 static DEFINE_SPINLOCK(clockfw_lock);
 
 #ifdef CONFIG_COMMON_CLK
+LIST_HEAD(clk_hw_omap_clocks);
 
 /*
  * Used for clocks that have the same value as the parent clock,
@@ -426,6 +427,37 @@ static int __init omap_clk_setup(char *str)
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
+		if (c->ops && c->ops->deny_idle)
+			c->ops->deny_idle(c);
+	return 0;
+}
+
 const struct clk_hw_omap_ops clkhwops_wait = {
 	.find_idlest	= omap2_clk_dflt_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d78f90e..b075831 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -562,6 +562,9 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
+void omap2_init_clk_hw_omap_clocks(struct clk *clk);
+int omap2_clk_enable_autoidle_all(void);
+int omap2_clk_disable_autoidle_all(void);
 #else
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4fadc78..a62010e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -393,6 +393,9 @@ void __init omap2420_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap2_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
@@ -415,6 +418,9 @@ void __init omap2430_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap2_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
@@ -476,6 +482,9 @@ void __init omap3_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init omap3430_init_late(void)
@@ -483,6 +492,9 @@ void __init omap3430_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init omap35xx_init_late(void)
@@ -490,6 +502,9 @@ void __init omap35xx_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init omap3630_init_late(void)
@@ -497,6 +512,9 @@ void __init omap3630_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init am35xx_init_late(void)
@@ -504,6 +522,9 @@ void __init am35xx_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init ti81xx_init_late(void)
@@ -511,6 +532,9 @@ void __init ti81xx_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap3_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
@@ -550,6 +574,9 @@ void __init omap4430_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap4_pm_init();
+#ifdef CONFIG_COMMON_CLK
+	omap2_clk_enable_autoidle_all();
+#endif
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1754d7e..ce93ec0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -623,12 +623,12 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
 {
-	struct clk_hw_omap *clk;
-
 	if (oh->clkdm) {
 		return oh->clkdm;
 	} else if (oh->_clk) {
 #ifdef CONFIG_COMMON_CLK
+		struct clk_hw_omap *clk;
+
 		clk = to_clk_hw_omap(__clk_get_hw(oh->_clk));
 		return  clk->clkdm;
 #else
-- 
1.7.9.5

