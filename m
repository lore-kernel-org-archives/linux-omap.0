From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 25/27] clk: ti: remove exported ll_ops struct, instead add an API for registration
Date: Mon, 25 May 2015 18:00:30 +0300
Message-ID: <1432566032-10860-26-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49008 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbbEYPB5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:57 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

We should avoid exporting data from drivers, instead use an API for
registering the clock low level operations.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c  |   17 +++++++++++++----
 arch/arm/mach-omap2/clock.h  |    1 +
 arch/arm/mach-omap2/io.c     |    2 ++
 drivers/clk/ti/clk.c         |   21 +++++++++++++++++++++
 drivers/clk/ti/clock.h       |    2 ++
 drivers/clk/ti/clockdomain.c |    2 ++
 include/linux/clk/ti.h       |    3 +--
 7 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 99875db..40a88c2 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -113,6 +113,19 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 };
 
 /**
+ * omap2_clk_setup_ll_ops - setup clock driver low-level ops
+ *
+ * Sets up clock driver low-level platform ops. These are needed
+ * for register accesses and various other misc platform operations.
+ * Returns 0 on success, -EBUSY if low level ops have been registered
+ * already.
+ */
+int __init omap2_clk_setup_ll_ops(void)
+{
+	return ti_clk_setup_ll_ops(&omap_clk_ll_ops);
+}
+
+/**
  * omap2_clk_provider_init - initialize a clock provider
  * @match_table: DT device table to match for devices to init
  * @np: device node pointer for the this clock provider
@@ -130,8 +143,6 @@ int __init omap2_clk_provider_init(struct device_node *np, int index,
 {
 	struct clk_iomap *io;
 
-	ti_clk_ll_ops = &omap_clk_ll_ops;
-
 	io = kzalloc(sizeof(*io), GFP_KERNEL);
 
 	io->regmap = syscon;
@@ -155,8 +166,6 @@ void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem)
 {
 	struct clk_iomap *io;
 
-	ti_clk_ll_ops = &omap_clk_ll_ops;
-
 	io = memblock_virt_alloc(sizeof(*io), 0);
 
 	io->mem = mem;
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 1986ab2..a7051d6 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -83,6 +83,7 @@ struct regmap;
 int __init omap2_clk_provider_init(struct device_node *np, int index,
 				   struct regmap *syscon, void __iomem *mem);
 void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem);
+int __init omap2_clk_setup_ll_ops(void);
 
 void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 7467856..a253aaf 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -722,6 +722,8 @@ int __init omap_clk_init(void)
 
 	ti_clk_init_features();
 
+	omap2_clk_setup_ll_ops();
+
 	if (of_have_populated_dt()) {
 		ret = omap_control_init();
 		if (ret)
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index f1dcd20..dc6b759 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -33,6 +33,27 @@ static struct device_node *clocks_node_ptr[CLK_MAX_MEMMAPS];
 struct ti_clk_features ti_clk_features;
 
 /**
+ * ti_clk_setup_ll_ops - setup low level clock operations
+ * @ops: low level clock ops descriptor
+ *
+ * Sets up low level clock operations for TI clock driver. This is used
+ * to provide various callbacks for the clock driver towards platform
+ * specific code. Returns 0 on success, -EBUSY if ll_ops have been
+ * registered already.
+ */
+int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
+{
+	if (ti_clk_ll_ops) {
+		pr_err("Attempt to register ll_ops multiple times.\n");
+		return -EBUSY;
+	}
+
+	ti_clk_ll_ops = ops;
+
+	return 0;
+}
+
+/**
  * ti_dt_clocks_register - register DT alias clocks during boot
  * @oclks: list of clocks to register
  *
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 3c43125..d4d232fd 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -280,4 +280,6 @@ long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk);
 
+extern struct ti_clk_ll_ops *ti_clk_ll_ops;
+
 #endif
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 61ef87b..80a7b69 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -21,6 +21,8 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 53fe38f..267cca0 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -235,8 +235,6 @@ struct ti_clk_ll_ops {
 				       u8 *idlest_reg_id);
 };
 
-extern struct ti_clk_ll_ops *ti_clk_ll_ops;
-
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 void omap2_init_clk_clkdm(struct clk_hw *clk);
@@ -255,6 +253,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 void ti_dt_clk_init_provider(struct device_node *np, int index);
 void ti_dt_clk_init_retry_clks(void);
 void ti_dt_clockdomains_setup(void);
+int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops);
 
 int omap3430_dt_clk_init(void);
 int omap3630_dt_clk_init(void);
-- 
1.7.9.5

