From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] ARM: OMAP2+: Add support for initializing dm814x clocks
Date: Wed,  3 Jun 2015 09:23:14 -0700
Message-ID: <1433348601-8966-6-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:13248 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757756AbbFCQXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:23:51 -0400
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>

Let's add a minimal clocks for dm814x to get it booted. This is
mostly a placeholder and relies on the PLLs being on from the
bootloader.

Note that the divider clocks work the same way as on dm816x and
am335x.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c  |  4 ++--
 drivers/clk/ti/Makefile   |  2 +-
 drivers/clk/ti/clk-814x.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/clk/ti/clk-816x.c |  2 +-
 include/linux/clk/ti.h    |  3 ++-
 5 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/ti/clk-814x.c

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6779a9f..596af73 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -558,7 +558,7 @@ void __init ti814x_init_early(void)
 	ti81xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
-		omap_clk_soc_init = ti81xx_dt_clk_init;
+		omap_clk_soc_init = dm814x_dt_clk_init;
 }
 
 void __init ti816x_init_early(void)
@@ -575,7 +575,7 @@ void __init ti816x_init_early(void)
 	ti81xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
-		omap_clk_soc_init = ti81xx_dt_clk_init;
+		omap_clk_soc_init = dm816x_dt_clk_init;
 }
 #endif
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 105ffd0..80b4288 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -2,7 +2,7 @@ obj-y					+= clk.o autoidle.o clockdomain.o
 clk-common				= dpll.o composite.o divider.o gate.o \
 					  fixed-factor.o mux.o apll.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
-obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
+obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-814x.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clk-common) interface.o \
 					   clk-3xxx.o
diff --git a/drivers/clk/ti/clk-814x.c b/drivers/clk/ti/clk-814x.c
new file mode 100644
index 0000000..bd2353c
--- /dev/null
+++ b/drivers/clk/ti/clk-814x.c
@@ -0,0 +1,36 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
+
+static struct ti_dt_clk dm814_clks[] = {
+	DT_CLK(NULL, "devosc_ck", "devosc_ck"),
+	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
+	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
+	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
+	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
+	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
+	DT_CLK(NULL, "timer_sys_ck", "devosc_ck"),
+	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
+	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
+	{ .node_name = NULL },
+};
+
+static const char *enable_init_clks[] = {
+};
+
+int __init dm814x_dt_clk_init(void)
+{
+	ti_dt_clocks_register(dm814_clks);
+	omap2_clk_disable_autoidle_all();
+	omap2_clk_enable_init_clocks(enable_init_clks,
+				     ARRAY_SIZE(enable_init_clks));
+
+	return 0;
+}
diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 9451e65..43d0745 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -42,7 +42,7 @@ static const char *enable_init_clks[] = {
 	"ddr_pll_clk3",
 };
 
-int __init ti81xx_dt_clk_init(void)
+int __init dm816x_dt_clk_init(void)
 {
 	ti_dt_clocks_register(dm816x_clks);
 	omap2_clk_disable_autoidle_all();
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 79b76e1..1736e29 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -329,7 +329,8 @@ int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
 int omap3430_dt_clk_init(void);
 int omap3630_dt_clk_init(void);
 int am35xx_dt_clk_init(void);
-int ti81xx_dt_clk_init(void);
+int dm814x_dt_clk_init(void);
+int dm816x_dt_clk_init(void);
 int omap4xxx_dt_clk_init(void);
 int omap5xxx_dt_clk_init(void);
 int dra7xx_dt_clk_init(void);
-- 
2.1.4

