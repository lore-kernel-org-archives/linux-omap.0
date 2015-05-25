From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 23/27] clk: ti: move some public definitions to private header
Date: Mon, 25 May 2015 18:00:28 +0300
Message-ID: <1432566032-10860-24-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50075 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbbEYPBy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:54 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Several exported TI clock driver features are no longer needed outside
the clock driver itself, thus move all of these to the driver private
header file. Also, update some of the driver files to actually include
this header.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/apll.c     |    2 ++
 drivers/clk/ti/autoidle.c |    2 ++
 drivers/clk/ti/clk-43xx.c |    2 ++
 drivers/clk/ti/clk-44xx.c |    2 ++
 drivers/clk/ti/clk-54xx.c |    2 ++
 drivers/clk/ti/clk-7xx.c  |    3 ++-
 drivers/clk/ti/clock.h    |   47 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h    |   45 -------------------------------------------
 8 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 49baf38..594b759 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -27,6 +27,8 @@
 #include <linux/clk/ti.h>
 #include <linux/delay.h>
 
+#include "clock.h"
+
 #define APLL_FORCE_LOCK 0x1
 #define APLL_AUTO_IDLE	0x2
 #define MAX_APLL_WAIT_TRIES		1000000
diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 3dbcc36..94f0dcd 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -22,6 +22,8 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 struct clk_ti_autoidle {
 	void __iomem		*reg;
 	u8			shift;
diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 3795fce..8943167 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -19,6 +19,8 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 static struct ti_dt_clk am43xx_clks[] = {
 	DT_CLK(NULL, "clk_32768_ck", "clk_32768_ck"),
 	DT_CLK(NULL, "clk_rc32k_ck", "clk_rc32k_ck"),
diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 581db77..7a8b51b 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -16,6 +16,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 /*
  * OMAP4 ABE DPLL default frequency. In OMAP4460 TRM version V, section
  * "3.6.3.2.3 CM1_ABE Clock Generator" states that the "DPLL_ABE_X2_CLK
diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 96c69a3..59ce2fa 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -17,6 +17,8 @@
 #include <linux/io.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 #define OMAP5_DPLL_ABE_DEFFREQ				98304000
 
 /*
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 5d2217a..8b82721 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -16,11 +16,12 @@
 #include <linux/clkdev.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 #define DRA7_DPLL_ABE_DEFFREQ				180633600
 #define DRA7_DPLL_GMAC_DEFFREQ				1000000000
 #define DRA7_DPLL_USB_DEFFREQ				960000000
 
-
 static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "atl_clkin0_ck", "atl_clkin0_ck"),
 	DT_CLK(NULL, "atl_clkin1_ck", "atl_clkin1_ck"),
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 0ca5a36..3c43125 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -154,6 +154,35 @@ struct ti_clk_dpll {
 	u8 recal_st_bit;
 };
 
+/* Composite clock component types */
+enum {
+	CLK_COMPONENT_TYPE_GATE = 0,
+	CLK_COMPONENT_TYPE_DIVIDER,
+	CLK_COMPONENT_TYPE_MUX,
+	CLK_COMPONENT_TYPE_MAX,
+};
+
+/**
+ * struct ti_dt_clk - OMAP DT clock alias declarations
+ * @lk: clock lookup definition
+ * @node_name: clock DT node to map to
+ */
+struct ti_dt_clk {
+	struct clk_lookup		lk;
+	char				*node_name;
+};
+
+#define DT_CLK(dev, con, name)		\
+	{				\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+		},			\
+		.node_name = name,	\
+	}
+
+typedef void (*ti_of_clk_init_cb_t)(struct clk_hw *, struct device_node *);
+
 struct clk *ti_clk_register_gate(struct ti_clk *setup);
 struct clk *ti_clk_register_interface(struct ti_clk *setup);
 struct clk *ti_clk_register_mux(struct ti_clk *setup);
@@ -169,6 +198,12 @@ void ti_clk_patch_legacy_clks(struct ti_clk **patch);
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
 
+void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
+void ti_dt_clocks_register(struct ti_dt_clk *oclks);
+int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
+		      ti_of_clk_init_cb_t func);
+int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
+
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int of_ti_clk_autoidle_setup(struct device_node *node);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
@@ -186,12 +221,24 @@ extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 
+extern const struct clk_ops ti_clk_divider_ops;
+extern const struct clk_ops ti_clk_mux_ops;
+
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
+void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
+				   void __iomem **other_reg,
+				   u8 *other_bit);
+void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
+				void __iomem **idlest_reg,
+				u8 *idlest_bit, u8 *idlest_val);
+
+void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
+void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
 
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index fc8e9ad..53fe38f 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -188,33 +188,6 @@ struct clk_hw_omap {
 /* DPLL Type and DCO Selection Flags */
 #define DPLL_J_TYPE		0x1
 
-/* Composite clock component types */
-enum {
-	CLK_COMPONENT_TYPE_GATE = 0,
-	CLK_COMPONENT_TYPE_DIVIDER,
-	CLK_COMPONENT_TYPE_MUX,
-	CLK_COMPONENT_TYPE_MAX,
-};
-
-/**
- * struct ti_dt_clk - OMAP DT clock alias declarations
- * @lk: clock lookup definition
- * @node_name: clock DT node to map to
- */
-struct ti_dt_clk {
-	struct clk_lookup		lk;
-	char				*node_name;
-};
-
-#define DT_CLK(dev, con, name)		\
-	{				\
-		.lk = {			\
-			.dev_id = dev,	\
-			.con_id = con,	\
-		},			\
-		.node_name = name,	\
-	}
-
 /* Static memmap indices */
 enum {
 	TI_CLKM_CM = 0,
@@ -225,8 +198,6 @@ enum {
 	CLK_MAX_MEMMAPS
 };
 
-typedef void (*ti_of_clk_init_cb_t)(struct clk_hw *, struct device_node *);
-
 /**
  * struct clk_omap_reg - OMAP register declaration
  * @offset: offset from the master IP module base address
@@ -266,9 +237,6 @@ struct ti_clk_ll_ops {
 
 extern struct ti_clk_ll_ops *ti_clk_ll_ops;
 
-extern const struct clk_ops ti_clk_divider_ops;
-extern const struct clk_ops ti_clk_mux_ops;
-
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 void omap2_init_clk_clkdm(struct clk_hw *clk);
@@ -276,14 +244,6 @@ int omap2_clk_disable_autoidle_all(void);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
 int omap2_clk_deny_idle(struct clk *clk);
-void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
-void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
-void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
-				   void __iomem **other_reg,
-				   u8 *other_bit);
-void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
-				void __iomem **idlest_reg,
-				u8 *idlest_bit, u8 *idlest_val);
 unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
 int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
@@ -292,14 +252,9 @@ void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
 void omap2xxx_clkt_vps_init(void);
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
-void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
-void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void ti_dt_clk_init_provider(struct device_node *np, int index);
 void ti_dt_clk_init_retry_clks(void);
 void ti_dt_clockdomains_setup(void);
-int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
-		      ti_of_clk_init_cb_t func);
-int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
 
 int omap3430_dt_clk_init(void);
 int omap3630_dt_clk_init(void);
-- 
1.7.9.5

