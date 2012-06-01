From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 11/24] ARM: omap: clk: list all clk_hw_omap clks to enable/disable autoidle
Date: Fri, 1 Jun 2012 17:37:52 +0530
Message-ID: <1338552485-31325-12-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54064 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759511Ab2FAMIo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:08:44 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Platforms can call omap2_init_clk_hw_omap_clocks() to register a clock
using clk_hw_omap. omap2_clk_enable_autoidle_all() and
omap2_clk_disable_autoidle_all() can then be used to run through
all the clocks which support autoidle to enable/disable them.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h |    3 +++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6139ab6..4c7fa4b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -50,6 +50,7 @@ u16 cpu_mask;
 static bool clkdm_control = true;
 
 #ifdef CONFIG_COMMON_CLK
+LIST_HEAD(clk_hw_omap_clocks);
 
 /*
  * Used for clocks that have the same value as the parent clock,
@@ -343,6 +344,37 @@ static int __init omap_clk_setup(char *str)
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
@@ -359,6 +391,8 @@ const struct clk_hw_omap_ops clkhwops_wait = {
 	.find_idlest	= omap2_clk_dflt_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
+late_initcall(omap2_clk_enable_autoidle_all);
+
 #else
 int omap2_dflt_clk_enable(struct clk *clk)
 {
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index f09ca8d..fd73f7a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -401,6 +401,9 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk, void __iomem **other
 				   u8 *other_bit);
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk, void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
+void omap2_init_clk_hw_omap_clocks(struct clk *clk);
+int omap2_clk_enable_autoidle_all(void);
+int omap2_clk_disable_autoidle_all(void);
 #else
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
-- 
1.7.1

