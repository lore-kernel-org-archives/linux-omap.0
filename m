From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 10/35] ARM: OMAP2+: PRCM: add support for static clock memmap indices
Date: Wed, 25 Feb 2015 21:04:20 +0200
Message-ID: <1424891085-10392-11-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49479 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbbBYTFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:03 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

All clock provider related drivers will now register their iomaps
with a static index. This makes it easier to split up the individual
drivers to their own files in subsequent patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    8 ++++
 arch/arm/mach-omap2/prm_common.c  |   79 +++++++++++++++++++++++--------------
 include/linux/clk/ti.h            |    1 +
 3 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 6163d66..ee38356 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -518,6 +518,14 @@ struct omap_prcm_irq_setup {
 	.priority = _priority				\
 	}
 
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
index 79cee11..8ec5201 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -633,31 +633,47 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
+static struct omap_prcm_init_data prm_data = {
+	.index = TI_CLKM_PRM,
+};
+
+static struct omap_prcm_init_data cm_data = {
+	.index = TI_CLKM_CM,
+};
+
+static struct omap_prcm_init_data cm2_data = {
+	.index = TI_CLKM_CM2,
+};
+
+static struct omap_prcm_init_data scrm_data = {
+	.index = TI_CLKM_SCRM,
+};
+
 static const struct of_device_id omap_prcm_dt_match_table[] = {
-	{ .compatible = "ti,am3-prcm" },
-	{ .compatible = "ti,am3-scrm" },
-	{ .compatible = "ti,am4-prcm" },
-	{ .compatible = "ti,am4-scrm" },
-	{ .compatible = "ti,dm814-prcm" },
-	{ .compatible = "ti,dm814-scrm" },
-	{ .compatible = "ti,dm816-prcm" },
-	{ .compatible = "ti,dm816-scrm" },
-	{ .compatible = "ti,omap2-prcm" },
-	{ .compatible = "ti,omap2-scrm" },
-	{ .compatible = "ti,omap3-prm" },
-	{ .compatible = "ti,omap3-cm" },
-	{ .compatible = "ti,omap3-scrm" },
-	{ .compatible = "ti,omap4-cm1" },
-	{ .compatible = "ti,omap4-prm" },
-	{ .compatible = "ti,omap4-cm2" },
-	{ .compatible = "ti,omap4-scrm" },
-	{ .compatible = "ti,omap5-prm" },
-	{ .compatible = "ti,omap5-cm-core-aon" },
-	{ .compatible = "ti,omap5-scrm" },
-	{ .compatible = "ti,omap5-cm-core" },
-	{ .compatible = "ti,dra7-prm" },
-	{ .compatible = "ti,dra7-cm-core-aon" },
-	{ .compatible = "ti,dra7-cm-core" },
+	{ .compatible = "ti,am3-prcm", .data = &prm_data },
+	{ .compatible = "ti,am3-scrm", .data = &scrm_data },
+	{ .compatible = "ti,am4-prcm", .data = &prm_data },
+	{ .compatible = "ti,am4-scrm", .data = &scrm_data },
+	{ .compatible = "ti,dm814-prcm", .data = &prm_data },
+	{ .compatible = "ti,dm814-scrm", .data = &scrm_data },
+	{ .compatible = "ti,dm816-prcm", .data = &prm_data },
+	{ .compatible = "ti,dm816-scrm", .data = &scrm_data },
+	{ .compatible = "ti,omap2-prcm", .data = &prm_data },
+	{ .compatible = "ti,omap2-scrm", .data = &scrm_data },
+	{ .compatible = "ti,omap3-prm", .data = &prm_data },
+	{ .compatible = "ti,omap3-cm", .data = &cm_data },
+	{ .compatible = "ti,omap3-scrm", .data = &scrm_data },
+	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
+	{ .compatible = "ti,omap4-prm", .data = &prm_data },
+	{ .compatible = "ti,omap4-cm2", .data = &cm2_data },
+	{ .compatible = "ti,omap4-scrm", .data = &scrm_data },
+	{ .compatible = "ti,omap5-prm", .data = &prm_data },
+	{ .compatible = "ti,omap5-cm-core-aon", .data = &cm_data },
+	{ .compatible = "ti,omap5-scrm", .data = &scrm_data },
+	{ .compatible = "ti,omap5-cm-core", .data = &cm2_data },
+	{ .compatible = "ti,dra7-prm", .data = &prm_data },
+	{ .compatible = "ti,dra7-cm-core-aon", .data = &cm_data },
+	{ .compatible = "ti,dra7-cm-core", .data = &cm2_data },
 	{ }
 };
 
@@ -690,15 +706,20 @@ int __init omap_prcm_init(void)
 {
 	struct device_node *np;
 	void __iomem *mem;
-	int memmap_index = 0;
+	const struct of_device_id *match;
+	const struct omap_prcm_init_data *data;
 
 	ti_clk_ll_ops = &omap_clk_ll_ops;
 
-	for_each_matching_node(np, omap_prcm_dt_match_table) {
+	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
+		data = match->data;
+
 		mem = of_iomap(np, 0);
-		clk_memmaps[memmap_index] = mem;
-		ti_dt_clk_init_provider(np, memmap_index);
-		memmap_index++;
+		if (!mem)
+			return -ENOMEM;
+
+		clk_memmaps[data->index] = mem;
+		ti_dt_clk_init_provider(np, data->index);
 	}
 
 	return 0;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6784400..19895a3 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -221,6 +221,7 @@ struct ti_dt_clk {
 /* Static memmap indices */
 enum {
 	TI_CLKM_CM = 0,
+	TI_CLKM_CM2,
 	TI_CLKM_PRM,
 	TI_CLKM_SCRM,
 };
-- 
1.7.9.5

