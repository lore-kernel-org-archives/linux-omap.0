From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 12/33] ARM: OMAP2+: clock: add support for static clock memmap indexes
Date: Fri, 13 Feb 2015 18:12:31 +0200
Message-ID: <1423843973-6050-10-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43365 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbBMQOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 11:14:08 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

All clock provider related drivers will now register their iomaps
individually, and provide index number to the provider init. The
clock related drivers also add support for providing init data
through the DT match functionality; this is initially used only
to provide the index variable, but can be expanded later to provide
more functionality.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c       |   32 +++++++++++++--------------
 arch/arm/mach-omap2/clock.h       |   10 ++++++++-
 arch/arm/mach-omap2/cm_common.c   |   43 +++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/control.c     |   37 ++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/prcm-common.h |    8 +++++++
 arch/arm/mach-omap2/prm_common.c  |   44 +++++++++++++++++++++++++++----------
 6 files changed, 131 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0f48cf1..62d1a89 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -117,30 +117,28 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 
 /**
  * omap2_clk_provider_init - initialize a clock provider
- * @match_table: DT device table to match for devices to init
+ * @np: device node for initializing the clock provider
+ * @index: memory map index for the clock provider
+ * @mem: iomem pointer for the memory map
  *
- * Initializes a clock provider module (CM/PRM etc.), allocating the
- * memory mapping, allocating the mapping index and initializing the
- * low level driver infrastructure. Returns 0 in success, -ENOMEM in
- * failure.
+ * Initializes a clock provider module (CM/PRM etc.), registering
+ * the iomap and initializing the low level driver infrastructure.
+ * Returns 0 in success, -EINVAL if multiple registration is attempted.
  */
-int __init omap2_clk_provider_init(struct of_device_id *match_table)
+int __init omap2_clk_provider_init(struct device_node *np, int index,
+				   void __iomem *mem)
 {
-	struct device_node *np;
-	void __iomem *mem;
-	static int memmap_index;
-
 	ti_clk_ll_ops = &omap_clk_ll_ops;
 
-	for_each_matching_node(np, match_table) {
-		mem = of_iomap(np, 0);
-		if (!mem)
-			return -ENOMEM;
-		clk_memmaps[memmap_index] = mem;
-		ti_dt_clk_init_provider(np, memmap_index);
-		memmap_index++;
+	if (clk_memmaps[index]) {
+		pr_err("%s: duplicate registration for index %d!\n", __func__,
+		       index);
+		return -EINVAL;
 	}
 
+	clk_memmaps[index] = mem;
+	ti_dt_clk_init_provider(np, index);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 265a9dc..a229622 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -236,6 +236,13 @@ struct ti_clk_features {
 #define TI_CLK_DPLL_HAS_FREQSEL		(1 << 0)
 #define TI_CLK_DPLL4_DENY_REPROGRAM	(1 << 1)
 
+enum {
+	CLK_MEMMAP_INDEX_PRM = 0,
+	CLK_MEMMAP_INDEX_CM1,
+	CLK_MEMMAP_INDEX_CM2,
+	CLK_MEMMAP_INDEX_SCRM,
+};
+
 extern struct ti_clk_features ti_clk_features;
 
 extern const struct clkops clkops_omap2_dflt_wait;
@@ -273,7 +280,8 @@ extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
 extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
 
-int __init omap2_clk_provider_init(struct of_device_id *match_table);
+int __init omap2_clk_provider_init(struct device_node *np, int index,
+				   void __iomem *mem);
 
 void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index f0a44aa..ff76cb7 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/bug.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
@@ -215,14 +216,22 @@ int cm_unregister(struct cm_ll_data *cld)
 	return 0;
 }
 
+static const struct omap_prcm_init_data cm_data = {
+	.index = CLK_MEMMAP_INDEX_CM1,
+};
+
+static const struct omap_prcm_init_data cm2_data = {
+	.index = CLK_MEMMAP_INDEX_CM2,
+};
+
 static struct of_device_id omap_cm_dt_match_table[] = {
-	{ .compatible = "ti,omap3-cm" },
-	{ .compatible = "ti,omap4-cm1" },
-	{ .compatible = "ti,omap4-cm2" },
-	{ .compatible = "ti,omap5-cm-core-aon" },
-	{ .compatible = "ti,omap5-cm-core" },
-	{ .compatible = "ti,dra7-cm-core-aon" },
-	{ .compatible = "ti,dra7-cm-core" },
+	{ .compatible = "ti,omap3-cm", .data = &cm_data },
+	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
+	{ .compatible = "ti,omap4-cm2", .data = &cm2_data },
+	{ .compatible = "ti,omap5-cm-core-aon", .data = &cm_data },
+	{ .compatible = "ti,omap5-cm-core", .data = &cm2_data },
+	{ .compatible = "ti,dra7-cm-core-aon", .data = &cm_data },
+	{ .compatible = "ti,dra7-cm-core", .data = &cm2_data },
 	{ }
 };
 
@@ -234,5 +243,23 @@ static struct of_device_id omap_cm_dt_match_table[] = {
  */
 int __init omap_cm_init(void)
 {
-	return omap2_clk_provider_init(omap_cm_dt_match_table);
+	struct device_node *np;
+	const struct of_device_id *match;
+	const struct omap_prcm_init_data *data;
+	void __iomem *mem;
+	int ret;
+
+	for_each_matching_node_and_match(np, omap_cm_dt_match_table, &match) {
+		data = match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		ret = omap2_clk_provider_init(np, data->index, mem);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a53341f..f9519f1 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 
 #include "soc.h"
 #include "iomap.h"
@@ -613,11 +614,19 @@ void __init omap3_ctrl_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
+struct control_init_data {
+	int index;
+};
+
+static const struct control_init_data ctrl_data = {
+	.index = CLK_MEMMAP_INDEX_SCRM,
+};
+
 static struct of_device_id omap_scrm_dt_match_table[] = {
-	{ .compatible = "ti,am3-scrm" },
-	{ .compatible = "ti,am4-scrm" },
-	{ .compatible = "ti,omap2-scrm" },
-	{ .compatible = "ti,omap3-scrm" },
+	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap2-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap3-scrm", .data = &ctrl_data },
 	{ }
 };
 
@@ -629,5 +638,23 @@ static struct of_device_id omap_scrm_dt_match_table[] = {
  */
 int __init omap_control_init(void)
 {
-	return omap2_clk_provider_init(omap_scrm_dt_match_table);
+	struct device_node *np;
+	const struct of_device_id *match;
+	const struct control_init_data *data;
+	void __iomem *mem;
+	int ret;
+
+	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
+		data = match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		ret = omap2_clk_provider_init(np, data->index, mem);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 22afef0..e260567 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -519,6 +519,14 @@ struct omap_prcm_irq_setup {
 
 struct of_device_id;
 
+/**
+ * struct omap_prcm_init_data - PRCM driver init data
+ * @index: clock memory mapping index to be used
+ */
+struct omap_prcm_init_data {
+	int index;
+};
+
 extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index c0bfc92..637780e 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -622,16 +622,24 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
+static const struct omap_prcm_init_data prm_data = {
+	.index = CLK_MEMMAP_INDEX_PRM,
+};
+
+static const struct omap_prcm_init_data scrm_data = {
+	.index = CLK_MEMMAP_INDEX_SCRM,
+};
+
 static const struct of_device_id omap_prcm_dt_match_table[] = {
-	{ .compatible = "ti,am3-prcm" },
-	{ .compatible = "ti,am4-prcm" },
-	{ .compatible = "ti,omap2-prcm" },
-	{ .compatible = "ti,omap3-prm" },
-	{ .compatible = "ti,omap4-prm" },
-	{ .compatible = "ti,omap4-scrm" },
-	{ .compatible = "ti,omap5-prm" },
-	{ .compatible = "ti,omap5-scrm" },
-	{ .compatible = "ti,dra7-prm" },
+	{ .compatible = "ti,am3-prcm", .data = &prm_data },
+	{ .compatible = "ti,am4-prcm", .data = &prm_data },
+	{ .compatible = "ti,omap2-prcm", .data = &prm_data },
+	{ .compatible = "ti,omap3-prm", .data = &prm_data },
+	{ .compatible = "ti,omap4-prm", .data = &prm_data },
+	{ .compatible = "ti,omap4-scrm", .data = &scrm_data },
+	{ .compatible = "ti,omap5-prm", .data = &prm_data },
+	{ .compatible = "ti,omap5-scrm", .data = &scrm_data },
+	{ .compatible = "ti,dra7-prm", .data = &prm_data },
 	{ }
 };
 
@@ -643,11 +651,23 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
  */
 int __init omap_prcm_init(void)
 {
+	struct device_node *np;
+	const struct of_device_id *match;
+	const struct omap_prcm_init_data *data;
+	void __iomem *mem;
 	int ret;
 
-	ret = omap2_clk_provider_init(omap_prcm_dt_match_table);
-	if (ret)
-		return ret;
+	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
+		data = match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		ret = omap2_clk_provider_init(np, data->index, mem);
+		if (ret)
+			return ret;
+	}
 
 	return omap_cm_init();
 }
-- 
1.7.9.5

