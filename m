From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/2] CLK: Use virtual clock register for mcbsp clock
Date: Wed, 20 Aug 2008 15:04:39 +0300
Message-ID: <1219233879-28701-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1219233879-28701-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37442 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYHTMFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 08:05:03 -0400
In-Reply-To: <1219233879-28701-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, eduardo.valentin@indt.org.br, felipe.balbi@nokia.com, tony@atomide.com, daniel.stone@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c |  107 ++++++++++++++----------------------------
 1 files changed, 36 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index cedb9a6..410ce8b 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -22,105 +22,72 @@
 #include <mach/cpu.h>
 #include <mach/mcbsp.h>
 
-struct mcbsp_internal_clk {
-	struct clk clk;
-	struct clk **childs;
-	int n_childs;
-};
-
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
-{
-	const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
-	int i;
-
-	mclk->n_childs = ARRAY_SIZE(clk_names);
-	mclk->childs = kzalloc(mclk->n_childs * sizeof(struct clk *),
-				GFP_KERNEL);
-
-	for (i = 0; i < mclk->n_childs; i++) {
-		/* We fake a platform device to get correct device id */
-		struct platform_device pdev;
-
-		pdev.dev.bus = &platform_bus_type;
-		pdev.id = mclk->clk.id;
-		mclk->childs[i] = clk_get(&pdev.dev, clk_names[i]);
-		if (IS_ERR(mclk->childs[i]))
-			printk(KERN_ERR "Could not get clock %s (%d).\n",
-				clk_names[i], mclk->clk.id);
-	}
-}
-
-static int omap_mcbsp_clk_enable(struct clk *clk)
-{
-	struct mcbsp_internal_clk *mclk = container_of(clk,
-					struct mcbsp_internal_clk, clk);
-	int i;
-
-	for (i = 0; i < mclk->n_childs; i++)
-		clk_enable(mclk->childs[i]);
-	return 0;
-}
-
-static void omap_mcbsp_clk_disable(struct clk *clk)
-{
-	struct mcbsp_internal_clk *mclk = container_of(clk,
-					struct mcbsp_internal_clk, clk);
-	int i;
-
-	for (i = 0; i < mclk->n_childs; i++)
-		clk_disable(mclk->childs[i]);
-}
-
-static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
+static struct vclk omap_mcbsp_clks[] = {
 	{
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 1,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 2,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 3,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 4,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 5,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 };
+#define omap_mcbsp_clks_size   ARRAY_SIZE(omap_mcbsp_clks)
+
+static int omap_mcbsp_clk_init(void)
+{
+	int i, err;
+	struct vclk *p;
+	struct vclk_cci cci[] = {
+		{
+			.name = "mcbsp_ick",
+		},
+		{
+			.name = "mcbsp_fck",
+		},
+	};
+
+	p = omap_mcbsp_clks;
+	for (i = 0; i < omap_mcbsp_clks_size; i++, p++) {
+		int j;
+		for (j = 0; j < ARRAY_SIZE(cci); j++)
+			cci[j].id = p->clk.id;
 
-#define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
+		err = vclk_register(p, cci, ARRAY_SIZE(cci));
+		if (err)
+			goto err_out;
+	}
+	return 0;
+err_out:
+	while (--i >= 0)
+		vclk_unregister(&omap_mcbsp_clks[i]);
+	return err;
+}
 #else
-#define omap_mcbsp_clks_size	0
-static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
-static inline void omap_mcbsp_clk_init(struct clk *clk)
-{ }
+static inline int omap_mcbsp_clk_init(void) { return 0; }
 #endif
 
 static void omap2_mcbsp2_mux_setup(void)
@@ -222,13 +189,11 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 
 static int __init omap2_mcbsp_init(void)
 {
-	int i;
+	int err;
 
-	for (i = 0; i < omap_mcbsp_clks_size; i++) {
-		/* Once we call clk_get inside init, we do not register it */
-		omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
-		clk_register(&omap_mcbsp_clks[i].clk);
-	}
+	err = omap_mcbsp_clk_init();
+	if (err)
+		return err;
 
 	if (cpu_is_omap24xx())
 		omap_mcbsp_count = OMAP24XX_MCBSP_PDATA_SZ;
-- 
1.5.5.1.357.g1af8b

