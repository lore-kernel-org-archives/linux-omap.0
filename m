From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/13] ARM: OMAP2+: clock: introduce ti_clk_features flags
Date: Wed, 2 Jul 2014 11:47:39 +0300
Message-ID: <1404290867-6768-6-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39730 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbaGBIsD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 04:48:03 -0400
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

This shall be used to replace the cpu type checks around the clock code.
Actual bit values will be introduced in patches later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   14 ++++++++++++++
 arch/arm/mach-omap2/clock.h |   10 ++++++++++
 arch/arm/mach-omap2/io.c    |    2 ++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 591581a..7897053 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -47,6 +47,11 @@
 u16 cpu_mask;
 
 /*
+ * Clock features setup. Used instead of CPU type checks.
+ */
+struct ti_clk_features ti_clk_features;
+
+/*
  * clkdm_control: if true, then when a clock is enabled in the
  * hardware, its clockdomain will first be enabled; and when a clock
  * is disabled in the hardware, its clockdomain will be disabled
@@ -731,3 +736,12 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 		(clk_get_rate(core_ck) / 1000000),
 		(clk_get_rate(mpu_ck) / 1000000));
 }
+
+/**
+ * ti_clk_init_features - init clock features struct for the SoC
+ *
+ * Initializes the clock features struct based on the SoC type.
+ */
+void __init ti_clk_init_features(void)
+{
+}
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e29f982..9b89cc0 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -223,6 +223,14 @@ void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg);
 
 extern u16 cpu_mask;
 
+/*
+ * Clock features setup. Used instead of CPU type checks.
+ */
+struct ti_clk_features {
+	u32 flags;
+};
+extern struct ti_clk_features ti_clk_features;
+
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_dummy;
 extern const struct clkops clkops_omap2_dflt;
@@ -261,4 +269,6 @@ extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
 extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
+
+void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8f55945..1fae5c1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -728,6 +728,8 @@ int __init omap_clk_init(void)
 	if (!omap_clk_soc_init)
 		return 0;
 
+	ti_clk_init_features();
+
 	ret = of_prcm_init();
 	if (!ret)
 		ret = omap_clk_soc_init();
-- 
1.7.9.5

