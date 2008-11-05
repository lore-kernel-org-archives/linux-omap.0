From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] OMAP: Fix McBSP spin_lock deadlock.
Date: Wed,  5 Nov 2008 20:00:29 +0800
Message-ID: <1225886429-28058-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33166 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328AbYKELyz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Nov 2008 06:54:55 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mA5Bssu6000608
	for <linux-omap@vger.kernel.org>; Wed, 5 Nov 2008 03:54:54 -0800 (PST)
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

mcbsp_clk is not the true clock, so delete it and ask omap_mcbsp_request enable
mcbsp_ick and mcbsp_fck directly.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/mcbsp.c             |  145 +++++--------------------------
 arch/arm/plat-omap/include/mach/mcbsp.h |    6 +-
 arch/arm/plat-omap/mcbsp.c              |   38 ++++++---
 3 files changed, 54 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index cae3ebe..237bdef 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -22,107 +22,6 @@
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
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name 		= "mcbsp_clk",
-			.id		= 2,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name		= "mcbsp_clk",
-			.id		= 3,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name		= "mcbsp_clk",
-			.id		= 4,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
-		},
-	},
-	{
-		.clk = {
-			.name		= "mcbsp_clk",
-			.id		= 5,
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
@@ -154,7 +53,8 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -163,7 +63,8 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 };
 #define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
@@ -181,7 +82,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -190,7 +92,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP3_BASE,
@@ -199,7 +102,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP4_BASE,
@@ -208,7 +112,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP5_BASE,
@@ -217,7 +122,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 };
 #define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
@@ -235,7 +141,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
@@ -244,7 +151,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
@@ -253,7 +161,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
@@ -262,7 +171,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
@@ -271,7 +181,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.ick_name	= "mcbsp_ick",
+		.fck_name	= "mcbsp_fck",
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
@@ -282,14 +193,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 
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
index 6a0d1a0..8e98aad 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -333,7 +333,8 @@ struct omap_mcbsp_platform_data {
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
-	char const *clk_name;
+	char const *ick_name;
+	char const *fck_name;
 };
 
 struct omap_mcbsp {
@@ -365,7 +366,8 @@ struct omap_mcbsp {
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
index af33fc7..e3d01ec 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -221,7 +221,8 @@ int omap_mcbsp_request(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
 
-	clk_enable(mcbsp->clk);
+	clk_enable(mcbsp->ick);
+	clk_enable(mcbsp->fck);
 
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
@@ -282,7 +283,8 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	clk_disable(mcbsp->clk);
+	clk_disable(mcbsp->fck);
+	clk_disable(mcbsp->ick);
 
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free) {
@@ -912,14 +914,21 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dma_rx_sync = pdata->dma_rx_sync;
 	mcbsp->dma_tx_sync = pdata->dma_tx_sync;
 
-	if (pdata->clk_name)
-		mcbsp->clk = clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(mcbsp->clk)) {
+	mcbsp->ick = clk_get(&pdev->dev, pdata->ick_name);
+	if (IS_ERR(mcbsp->ick)) {
 		dev_err(&pdev->dev,
-			"Invalid clock configuration for McBSP%d.\n",
+			"Invalid McBSP_ick configuration for McBSP%d.\n",
 			mcbsp->id);
-		ret = PTR_ERR(mcbsp->clk);
-		goto err_clk;
+		ret = PTR_ERR(mcbsp->ick);
+		goto err_clk2;
+	}
+	mcbsp->fck = clk_get(&pdev->dev, pdata->fck_name);
+	if (IS_ERR(mcbsp->fck)) {
+		dev_err(&pdev->dev,
+			"Invalid McBSP_fck configuration for McBSP%d.\n",
+			mcbsp->id);
+		ret = PTR_ERR(mcbsp->fck);
+		goto err_clk1;
 	}
 
 	mcbsp->pdata = pdata;
@@ -927,7 +936,9 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mcbsp);
 	return 0;
 
-err_clk:
+err_clk1:
+	clk_put(mcbsp->ick);
+err_clk2:
 	iounmap(mcbsp->io_base);
 err_ioremap:
 	mcbsp->free = 0;
@@ -946,12 +957,15 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
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

