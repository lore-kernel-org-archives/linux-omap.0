From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 1/2] ARM: OMAP2+: clock: Add omap2_clks_register API
Date: Thu, 18 Oct 2012 19:38:16 +0300
Message-ID: <1350578297-22572-2-git-send-email-grygorii.strashko@ti.com>
References: <1350578297-22572-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35841 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756693Ab2JRQir (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 12:38:47 -0400
In-Reply-To: <1350578297-22572-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>

Now the cpu_mask is used to differentiate clocks per each OMAP
platform, SoC version or revision. Such approach has few disadvantages:
- the specific CK_XXX flag need to be added and maintained for each OMAP
SoC;
- it's difficult to update clock tree data in case of differences
between OMAP SoC revisions.
In addition, there are duplicated code in each clockXXX_data.c
files, so it seems, reasonable to remove it:
- call clk_preinit() for each clock;
- call clkdev_add(); clk_register(); omap2_init_clk_clkdm();  for each
clock;

Hence, add omap4_clks_register() API which would allow to register
and init few set of clocks and to organize clocks data in the following
way (for example for OMAP4):
- struct omap_clk omap44xx_clks[]; - common clocks set for all OMAP4
SoCs
- struct omap_clk omap443x_clks[]; - specific clocks set for OMAP443x SoCs
- struct omap_clk omap446x_clks[]; - specific clocks set for OMAP446x SoCs

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-omap2/clock.c |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h |    3 +++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 961ac8f..d84f174 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -521,3 +521,39 @@ struct clk_functions omap2_clk_functions = {
 	.clk_disable_unused	= omap2_clk_disable_unused,
 };
 
+/**
+ * omap_clks_register() - register set of clocks
+ * @clks:	array of clock definitions
+ *
+ * The last array item should contain NULL value in c->lk.clk.
+ */
+int __init omap2_clks_register(struct omap_clk *clks)
+{
+	struct omap_clk *c;
+	int r;
+
+	if (!clks)
+		return -EINVAL;
+
+	c = clks;
+	while (c->lk.clk) {
+		clk_preinit(c->lk.clk);
+		c++;
+	}
+
+	c = clks;
+	while (c->lk.clk) {
+		clkdev_add(&c->lk);
+		r = clk_register(c->lk.clk);
+		if (r < 0) {
+			pr_warn("%s: Clock register failure %d.\n",
+				c->lk.clk->name, r);
+		}
+
+		omap2_init_clk_clkdm(c->lk.clk);
+
+		c++;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 35ec5f3..920f3f2 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 
 #include <plat/clock.h>
+#include <plat/clkdev_omap.h>
 
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
 #define CORE_CLK_SRC_32K		0x0
@@ -132,6 +133,8 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
 
+int omap2_clks_register(struct omap_clk *clks);
+
 extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
-- 
1.7.9.5

