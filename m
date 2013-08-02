From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 27/31] CLK: TI: add omap3 clock init file
Date: Fri, 2 Aug 2013 19:25:46 +0300
Message-ID: <1375460751-23676-28-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56765 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763Ab3HBQ1y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:27:54 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

clk-3xxx.c now contains the clock init functionality for omap3, including
DT clock registration and adding of static clkdev entries.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock3xxx.h |    1 -
 drivers/clk/ti/Makefile         |    3 +-
 drivers/clk/ti/clk-3xxx.c       |  171 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h          |    1 +
 4 files changed, 174 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/ti/clk-3xxx.c

diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
index dab90e2..78d9f56 100644
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -11,7 +11,6 @@
 int omap3xxx_clk_init(void);
 int omap3_core_dpll_m2_set_rate(struct clk_hw *clk, unsigned long rate,
 					unsigned long parent_rate);
-void omap3_clk_lock_dpll5(void);
 
 extern struct clk *sdrc_ick_p;
 extern struct clk *arm_fck_p;
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 01925fd..119679b 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,5 +1,6 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
 					   apll.o clk-44xx.o clk-54xx.o \
-					   clk-7xx.o clk-33xx.o interface.o
+					   clk-7xx.o clk-33xx.o interface.o \
+					   clk-3xxx.o
 endif
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
new file mode 100644
index 0000000..727044b
--- /dev/null
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -0,0 +1,171 @@
+/*
+ * OMAP3 Clock init
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc
+ *     Tero Kristo (t-kristo@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
+
+
+static struct omap_dt_clk omap3xxx_clks[] = {
+	DT_CLK(NULL, "apb_pclk", "dummy_apb_pclk"),
+	DT_CLK("twl", "fck", "osc_sys_ck"),
+	DT_CLK("etb", "emu_core_alwon_ck", "emu_core_alwon_ck"),
+	DT_CLK("etb", "emu_per_alwon_ck", "emu_per_alwon_ck"),
+	DT_CLK("etb", "emu_mpu_alwon_ck", "emu_mpu_alwon_ck"),
+	DT_CLK("omap_hdq.0", "fck", "hdq_fck"),
+	DT_CLK("omap_hsmmc.1", "ick", "mmchs2_ick"),
+	DT_CLK("omap_hsmmc.0", "ick", "mmchs1_ick"),
+	DT_CLK("omap_hdq.0", "ick", "hdq_ick"),
+	DT_CLK("omap2_mcspi.4", "ick", "mcspi4_ick"),
+	DT_CLK("omap2_mcspi.3", "ick", "mcspi3_ick"),
+	DT_CLK("omap2_mcspi.2", "ick", "mcspi2_ick"),
+	DT_CLK("omap2_mcspi.1", "ick", "mcspi1_ick"),
+	DT_CLK("omap_i2c.3", "ick", "i2c3_ick"),
+	DT_CLK("omap_i2c.2", "ick", "i2c2_ick"),
+	DT_CLK("omap_i2c.1", "ick", "i2c1_ick"),
+	DT_CLK("omap_wdt", "ick", "wdt2_ick"),
+	DT_CLK(NULL, "mcbsp4_ick", "mcbsp2_ick"),
+	DT_CLK(NULL, "mcbsp2_ick", "mcbsp4_ick"),
+	DT_CLK("etb", "emu_src_ck", "emu_src_ck"),
+	DT_CLK(NULL, "timer_32k_ck", "omap_32k_fck"),
+	DT_CLK(NULL, "timer_sys_ck", "sys_ck"),
+	DT_CLK(NULL, "cpufreq_ck", "dpll1_ck"),
+	{ NULL },
+};
+
+static struct omap_dt_clk omap34xx_omap36xx_clks[] = {
+	DT_CLK("omap_rng", "ick", "rng_ick"),
+	{ NULL },
+};
+
+static struct omap_dt_clk omap36xx_omap3430es2plus_clks[] = {
+	DT_CLK(NULL, "ssi_ssr_fck", "ssi_ssr_fck_3430es2"),
+	DT_CLK(NULL, "ssi_sst_fck", "ssi_sst_fck_3430es2"),
+	DT_CLK(NULL, "hsotgusb_ick", "hsotgusb_ick_3430es2"),
+	DT_CLK(NULL, "ssi_ick", "ssi_ick_3430es2"),
+	{ NULL },
+};
+
+static struct omap_dt_clk omap3430es1_clks[] = {
+	DT_CLK(NULL, "ssi_ssr_fck", "ssi_ssr_fck_3430es1"),
+	DT_CLK(NULL, "ssi_sst_fck", "ssi_sst_fck_3430es1"),
+	DT_CLK(NULL, "hsotgusb_ick", "hsotgusb_ick_3430es1"),
+	DT_CLK(NULL, "ssi_ick", "ssi_ick_3430es1"),
+	DT_CLK(NULL, "dss1_alwon_fck", "dss1_alwon_fck_3430es1"),
+	DT_CLK("omapdss_dss", "ick", "dss_ick_3430es1"),
+	DT_CLK(NULL, "dss_ick", "dss_ick_3430es1"),
+	{ NULL },
+};
+
+static struct omap_dt_clk omap36xx_am35xx_omap3430es2plus_clks[] = {
+	DT_CLK("omap_hsmmc.2", "ick", "mmchs3_ick"),
+	DT_CLK(NULL, "dss1_alwon_fck", "dss1_alwon_fck_3430es2"),
+	DT_CLK("omapdss_dss", "ick", "dss_ick_3430es2"),
+	DT_CLK(NULL, "dss_ick", "dss_ick_3430es2"),
+	{ NULL },
+};
+
+static struct omap_dt_clk am35xx_clks[] = {
+	DT_CLK("davinci_emac.0", NULL, "emac_ick"),
+	DT_CLK("davinci_mdio.0", NULL, "emac_fck"),
+	DT_CLK("vpfe-capture", "master", "vpfe_ick"),
+	DT_CLK("vpfe-capture", "slave", "vpfe_fck"),
+	DT_CLK(NULL, "hsotgusb_ick", "hsotgusb_ick_am35xx"),
+	DT_CLK(NULL, "hsotgusb_fck", "hsotgusb_fck_am35xx"),
+	DT_CLK(NULL, "uart4_ick", "uart4_ick_am35xx"),
+	DT_CLK(NULL, "uart4_fck", "uart4_fck_am35xx"),
+	{ NULL },
+};
+
+static const char *enable_init_clks[] = {
+	"sdrc_ick",
+	"gpmc_fck",
+	"omapctrl_ick",
+};
+
+enum {
+	OMAP3_SOC_AM35XX,
+	OMAP3_SOC_OMAP3430_ES1,
+	OMAP3_SOC_OMAP3430_ES2_PLUS,
+	OMAP3_SOC_OMAP3630,
+	OMAP3_SOC_TI81XX,
+};
+
+static int __init omap3xxx_clk_init(int soc_type)
+{
+	of_clk_init(NULL);
+
+	if (soc_type == OMAP3_SOC_AM35XX || soc_type == OMAP3_SOC_OMAP3630 ||
+	    soc_type == OMAP3_SOC_OMAP3430_ES1 ||
+	    soc_type == OMAP3_SOC_OMAP3430_ES2_PLUS)
+		omap_dt_clocks_register(omap3xxx_clks);
+
+	if (soc_type == OMAP3_SOC_AM35XX)
+		omap_dt_clocks_register(am35xx_clks);
+
+	if (soc_type == OMAP3_SOC_OMAP3630 || soc_type == OMAP3_SOC_AM35XX ||
+	    soc_type == OMAP3_SOC_OMAP3430_ES2_PLUS)
+		omap_dt_clocks_register(omap36xx_am35xx_omap3430es2plus_clks);
+
+	if (soc_type == OMAP3_SOC_OMAP3430_ES1)
+		omap_dt_clocks_register(omap3430es1_clks);
+
+	if (soc_type == OMAP3_SOC_OMAP3430_ES2_PLUS ||
+	    soc_type == OMAP3_SOC_OMAP3630)
+		omap_dt_clocks_register(omap36xx_omap3430es2plus_clks);
+
+	if (soc_type == OMAP3_SOC_OMAP3430_ES1 ||
+	    soc_type == OMAP3_SOC_OMAP3430_ES2_PLUS ||
+	    soc_type == OMAP3_SOC_OMAP3630)
+		omap_dt_clocks_register(omap34xx_omap36xx_clks);
+
+	omap2_clk_disable_autoidle_all();
+
+	omap2_clk_enable_init_clocks(enable_init_clks,
+				     ARRAY_SIZE(enable_init_clks));
+
+	pr_info("Clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
+		(clk_get_rate(clk_get_sys(NULL, "osc_sys_ck")) / 1000000),
+		(clk_get_rate(clk_get_sys(NULL, "osc_sys_ck")) / 100000) % 10,
+		(clk_get_rate(clk_get_sys(NULL, "core_ck")) / 1000000),
+		(clk_get_rate(clk_get_sys(NULL, "arm_fck")) / 1000000));
+
+	if (soc_type != OMAP3_SOC_TI81XX && soc_type != OMAP3_SOC_OMAP3430_ES1)
+		omap3_clk_lock_dpll5();
+
+	return 0;
+}
+
+int __init omap3430_clk_init(void)
+{
+	return omap3xxx_clk_init(OMAP3_SOC_OMAP3430_ES2_PLUS);
+}
+
+int __init omap3630_clk_init(void)
+{
+	return omap3xxx_clk_init(OMAP3_SOC_OMAP3630);
+}
+
+int __init am35xx_clk_init(void)
+{
+	return omap3xxx_clk_init(OMAP3_SOC_AM35XX);
+}
+
+int __init ti81xx_clk_init(void)
+{
+	return omap3xxx_clk_init(OMAP3_SOC_TI81XX);
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 8076394..adeddb4 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -187,6 +187,7 @@ int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
+void omap3_clk_lock_dpll5(void);
 
 void omap_dt_clocks_register(struct omap_dt_clk *oclks);
 #ifdef CONFIG_OF
-- 
1.7.9.5

