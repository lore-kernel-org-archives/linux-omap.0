From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 10/27] clk: ti: move omap2_clk_enable_init_clocks under clock driver
Date: Mon, 11 May 2015 11:54:36 +0300
Message-ID: <1431334493-24455-11-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45730 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbbEKIzL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 04:55:11 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This is no longer used outside clock driver, so move it under the driver
and remove the export for it from the global header file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   24 ------------------------
 drivers/clk/ti/clk-2xxx.c   |    2 ++
 drivers/clk/ti/clk-33xx.c   |    2 ++
 drivers/clk/ti/clk-3xxx.c   |    1 +
 drivers/clk/ti/clk-816x.c   |    2 ++
 drivers/clk/ti/clk.c        |   24 ++++++++++++++++++++++++
 drivers/clk/ti/clock.h      |    1 +
 include/linux/clk/ti.h      |    1 -
 8 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 42ce860..234cedf 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -576,30 +576,6 @@ static int __init omap_clk_setup(char *str)
 }
 __setup("mpurate=", omap_clk_setup);
 
-/**
- * omap2_clk_enable_init_clocks - prepare & enable a list of clocks
- * @clk_names: ptr to an array of strings of clock names to enable
- * @num_clocks: number of clock names in @clk_names
- *
- * Prepare and enable a list of clocks, named by @clk_names.  No
- * return value. XXX Deprecated; only needed until these clocks are
- * properly claimed and enabled by the drivers or core code that uses
- * them.  XXX What code disables & calls clk_put on these clocks?
- */
-void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
-{
-	struct clk *init_clk;
-	int i;
-
-	for (i = 0; i < num_clocks; i++) {
-		init_clk = clk_get(NULL, clk_names[i]);
-		if (WARN(IS_ERR(init_clk), "could not find init clock %s\n",
-				clk_names[i]))
-			continue;
-		clk_prepare_enable(init_clk);
-	}
-}
-
 const struct clk_hw_omap_ops clkhwops_wait = {
 	.find_idlest	= omap2_clk_dflt_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
diff --git a/drivers/clk/ti/clk-2xxx.c b/drivers/clk/ti/clk-2xxx.c
index c808ab3..bd8790b 100644
--- a/drivers/clk/ti/clk-2xxx.c
+++ b/drivers/clk/ti/clk-2xxx.c
@@ -19,6 +19,8 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 static struct ti_dt_clk omap2xxx_clks[] = {
 	DT_CLK(NULL, "func_32k_ck", "func_32k_ck"),
 	DT_CLK(NULL, "secure_32k_ck", "secure_32k_ck"),
diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 028b337..733f9d3 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -19,6 +19,8 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 static struct ti_dt_clk am33xx_clks[] = {
 	DT_CLK(NULL, "clk_32768_ck", "clk_32768_ck"),
 	DT_CLK(NULL, "clk_rc32k_ck", "clk_rc32k_ck"),
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 757636d..bb3b883 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -19,6 +19,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
 
 static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "apb_pclk", "dummy_apb_pclk"),
diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 9451e65..c69352b 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -14,6 +14,8 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 static struct ti_dt_clk dm816x_clks[] = {
 	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 567f8b9..f1dcd20 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -335,4 +335,28 @@ struct ti_clk_features *ti_clk_get_features(void)
 {
 	return &ti_clk_features;
 }
+
+/**
+ * omap2_clk_enable_init_clocks - prepare & enable a list of clocks
+ * @clk_names: ptr to an array of strings of clock names to enable
+ * @num_clocks: number of clock names in @clk_names
+ *
+ * Prepare and enable a list of clocks, named by @clk_names.  No
+ * return value. XXX Deprecated; only needed until these clocks are
+ * properly claimed and enabled by the drivers or core code that uses
+ * them.  XXX What code disables & calls clk_put on these clocks?
+ */
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
+{
+	struct clk *init_clk;
+	int i;
+
+	for (i = 0; i < num_clocks; i++) {
+		init_clk = clk_get(NULL, clk_names[i]);
+		if (WARN(IS_ERR(init_clk), "could not find init clock %s\n",
+			 clk_names[i]))
+			continue;
+		clk_prepare_enable(init_clk);
+	}
+}
 #endif
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 9b51021..4b26af8 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -171,6 +171,7 @@ int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
 
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int of_ti_clk_autoidle_setup(struct device_node *node);
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 2e4b4fb..43184c2 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -290,7 +290,6 @@ int omap2_clk_disable_autoidle_all(void);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
 int omap2_clk_deny_idle(struct clk *clk);
-void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
-- 
1.7.9.5

