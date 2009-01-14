From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCHv3] OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 14 Jan 2009 09:53:05 +0800
Message-ID: <1231897985-5274-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51310 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbZANBo2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 20:44:28 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n0E1iN3f029741
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 17:44:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

A spin_lock deadlock will occur when omap_mcbsp_request() is invoked.

omap_mcbsp_request()         -->
clk_enable(mcbsp->clk)       --> clk_enable get clockfw_lock, then call ->
omap2_clk_enable()           -->
_omap2_clk_enable()          -->
omap_mcbsp_clk_enable()      -->
clk_enable(mcbsp_ick)        --> now clk_enable acquire clockfw_lock again.

mcbsp_clk is not the true clock, so delete it and ask omap_mcbsp_request
enable mcbsp_ick and mcbsp_fck directly.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap1/mcbsp.c             |  103 +++-----------------
 arch/arm/mach-omap2/mcbsp.c             |  162 +++++++------------------------
 arch/arm/plat-omap/include/mach/mcbsp.h |    6 +-
 arch/arm/plat-omap/mcbsp.c              |   47 ++++++---
 4 files changed, 85 insertions(+), 233 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 7de7c69..5291e64 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -26,83 +26,6 @@
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
 
-struct mcbsp_internal_clk {
-	struct clk clk;
-	struct clk **childs;
-	int n_childs;
-};
-
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
-{
-	const char *clk_names[] = { "dsp_ck", "api_ck", "dspxor_ck" };
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
-	{
-		.clk = {
-			.name 		= "mcbsp_clk",
-			.id		= 1,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name 		= "mcbsp_clk",
-			.id		= 3,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-};
-
-#define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
-#else
-#define omap_mcbsp_clks_size	0
-static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
-static inline void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
-{ }
-#endif
-
 static void omap1_mcbsp_request(unsigned int id)
 {
 	/*
@@ -165,8 +88,9 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP1RX,
 		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
-		},
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+	},
 	{
 		.phys_base	= OMAP1510_MCBSP2_BASE,
 		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
@@ -182,7 +106,9 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP3RX,
 		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 };
 #define OMAP15XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap15xx_mcbsp_pdata)
@@ -200,7 +126,9 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP1RX,
 		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP1610_MCBSP2_BASE,
@@ -217,7 +145,9 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP3RX,
 		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 };
 #define OMAP16XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap16xx_mcbsp_pdata)
@@ -228,15 +158,6 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 
 int __init omap1_mcbsp_init(void)
 {
-	int i;
-
-	for (i = 0; i < omap_mcbsp_clks_size; i++) {
-		if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
-			omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
-			clk_register(&omap_mcbsp_clks[i].clk);
-		}
-	}
-
 	if (cpu_is_omap730())
 		omap_mcbsp_count = OMAP730_MCBSP_PDATA_SZ;
 	if (cpu_is_omap15xx())
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index b40b29a..3799ed6 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -22,112 +22,6 @@
 #include <mach/cpu.h>
 #include <mach/mcbsp.h>
 
-struct mcbsp_internal_clk {
-	struct clk clk;
-	struct clk **childs;
-	int n_childs;
-};
-
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
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
-	{
-		.clk = {
-			.name 		= "mcbsp_clk",
-			.id		= 1,
-			.clkdm		= { .name = "virt_opp_clkdm" },
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name 		= "mcbsp_clk",
-			.id		= 2,
-			.clkdm		= { .name = "virt_opp_clkdm" },
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name		= "mcbsp_clk",
-			.id		= 3,
-			.clkdm		= { .name = "virt_opp_clkdm" },
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name		= "mcbsp_clk",
-			.id		= 4,
-			.clkdm		= { .name = "virt_opp_clkdm" },
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name		= "mcbsp_clk",
-			.id		= 5,
-			.clkdm		= { .name = "virt_opp_clkdm" },
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-};
-
-#define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
-#else
-#define omap_mcbsp_clks_size	0
-static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
-static inline void omap_mcbsp_clk_init(struct clk *clk)
-{ }
-#endif
-
 static void omap2_mcbsp2_mux_setup(void)
 {
 	omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
@@ -159,7 +53,9 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -168,7 +64,9 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 };
 #define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
@@ -186,7 +84,9 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -195,7 +95,9 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP3_BASE,
@@ -204,7 +106,9 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP4_BASE,
@@ -213,7 +117,9 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP5_BASE,
@@ -222,7 +128,9 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 };
 #define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
@@ -240,7 +148,9 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
@@ -249,7 +159,9 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
@@ -258,7 +170,9 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
@@ -267,7 +181,9 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
@@ -276,7 +192,9 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name       = "mcbsp_ick",
+		.fck_name       = "mcbsp_fck",
+
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
@@ -287,14 +205,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 
 static int __init omap2_mcbsp_init(void)
 {
-	int i;
-
-	for (i = 0; i < omap_mcbsp_clks_size; i++) {
-		/* Once we call clk_get inside init, we do not register it */
-		omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
-		clk_register(&omap_mcbsp_clks[i].clk);
-	}
-
 	if (cpu_is_omap2420())
 		omap_mcbsp_count = OMAP2420_MCBSP_PDATA_SZ;
 	if (cpu_is_omap2430())
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index cc48f2f..4b7a938 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -340,7 +340,8 @@ struct omap_mcbsp_platform_data {
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
-	char const *clk_name;
+	char const *ick_name;
+	char const *fck_name;
 };
 
 struct omap_mcbsp {
@@ -372,7 +373,8 @@ struct omap_mcbsp {
 	/* Protect the field .free, while checking if the mcbsp is in use */
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
-	struct clk *clk;
+	struct clk *ick;
+	struct clk *fck;
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f2401a8..64fee7d 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -225,7 +225,8 @@ int omap_mcbsp_request(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
 
-	clk_enable(mcbsp->clk);
+	clk_enable(mcbsp->ick);
+	clk_enable(mcbsp->fck);
 
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
@@ -286,7 +287,8 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	clk_disable(mcbsp->clk);
+	clk_disable(mcbsp->fck);
+	clk_disable(mcbsp->ick);
 
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free) {
@@ -916,14 +918,26 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dma_rx_sync = pdata->dma_rx_sync;
 	mcbsp->dma_tx_sync = pdata->dma_tx_sync;
 
-	if (pdata->clk_name)
-		mcbsp->clk = clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(mcbsp->clk)) {
-		dev_err(&pdev->dev,
-			"Invalid clock configuration for McBSP%d.\n",
-			mcbsp->id);
-		ret = PTR_ERR(mcbsp->clk);
-		goto err_clk;
+	if (pdata->ick_name) {
+		mcbsp->ick = clk_get(&pdev->dev, pdata->ick_name);
+		if (IS_ERR(mcbsp->ick)) {
+			dev_err(&pdev->dev,
+				"Invalid ick configuration for McBSP%d.\n",
+				mcbsp->id);
+			ret = PTR_ERR(mcbsp->ick);
+			goto err_clk2;
+		}
+	}
+
+	if (pdata->fck_name) {
+		mcbsp->fck = clk_get(&pdev->dev, pdata->fck_name);
+		if (IS_ERR(mcbsp->fck)) {
+			dev_err(&pdev->dev,
+				"Invalid fck configuration for McBSP%d.\n",
+				mcbsp->id);
+			ret = PTR_ERR(mcbsp->fck);
+			goto err_clk1;
+		}
 	}
 
 	mcbsp->pdata = pdata;
@@ -931,7 +945,9 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mcbsp);
 	return 0;
 
-err_clk:
+err_clk1:
+	clk_put(mcbsp->ick);
+err_clk2:
 	iounmap(mcbsp->io_base);
 err_ioremap:
 	mcbsp->free = 0;
@@ -950,12 +966,15 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 				mcbsp->pdata->ops->free)
 			mcbsp->pdata->ops->free(mcbsp->id);
 
-		clk_disable(mcbsp->clk);
-		clk_put(mcbsp->clk);
+		clk_disable(mcbsp->fck);
+		clk_disable(mcbsp->ick);
+		clk_put(mcbsp->fck);
+		clk_put(mcbsp->ick);
 
 		iounmap(mcbsp->io_base);
 
-		mcbsp->clk = NULL;
+		mcbsp->fck = NULL;
+		mcbsp->ick = NULL;
 		mcbsp->free = 0;
 		mcbsp->dev = NULL;
 	}
-- 
1.5.6.3

