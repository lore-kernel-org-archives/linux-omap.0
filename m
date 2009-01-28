From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] ARM: OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 28 Jan 2009 10:24:22 -0800
Message-ID: <20090128182422.21007.97536.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54702 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbZA1SY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:24:27 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

From: Stanley.Miao <stanley.miao@windriver.com>

A spin_lock deadlock will occur when omap_mcbsp_request() is invoked.

omap_mcbsp_request()
\- clk_enable(mcbsp->clk)         [takes and holds clockfw_lock]
    \- omap2_clk_enable()
       \- _omap2_clk_enable()
           \- omap_mcbsp_clk_enable()
              \- clk_enable(child clock)   [tries for clockfw_lock again]

mcbsp_clk is a virtual clock and it comprises several child clocks. when
enable mcbsp_clk in omap_mcbsp_request(), the enable function of mcbsp_clk
will enable its child clocks, then the deadlock occurs.

The solution is to remove the virtual clock and enable these child clocks in
omap_mcbsp_request() directly.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mcbsp.c             |   98 ++-------------------
 arch/arm/mach-omap2/mcbsp.c             |  145 +++++--------------------------
 arch/arm/plat-omap/include/mach/mcbsp.h |    6 +
 arch/arm/plat-omap/mcbsp.c              |   52 ++++++++---
 4 files changed, 78 insertions(+), 223 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index ca7a0cc..575ba31 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -28,81 +28,8 @@
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
 
-struct mcbsp_internal_clk {
-	struct clk clk;
-	struct clk **childs;
-	int n_childs;
-};
-
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
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
+const char *clk_names[] = { "dsp_ck", "api_ck", "dspxor_ck" };
 #endif
 
 static void omap1_mcbsp_request(unsigned int id)
@@ -167,8 +94,9 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP1RX,
 		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
-		},
+		.clk_names	= clk_names,
+		.num_clks	= 3,
+	},
 	{
 		.phys_base	= OMAP1510_MCBSP2_BASE,
 		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
@@ -184,7 +112,8 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP3RX,
 		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 3,
 	},
 };
 #define OMAP15XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap15xx_mcbsp_pdata)
@@ -202,7 +131,8 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP1RX,
 		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 3,
 	},
 	{
 		.phys_base	= OMAP1610_MCBSP2_BASE,
@@ -219,7 +149,8 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP3RX,
 		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 3,
 	},
 };
 #define OMAP16XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap16xx_mcbsp_pdata)
@@ -230,15 +161,6 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 
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
index e20023c..a9e631f 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -24,106 +24,7 @@
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
+const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
 
 static void omap2_mcbsp2_mux_setup(void)
 {
@@ -156,7 +57,8 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -165,7 +67,8 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 };
 #define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
@@ -183,7 +86,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -192,7 +96,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP3_BASE,
@@ -201,7 +106,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP4_BASE,
@@ -210,7 +116,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP5_BASE,
@@ -219,7 +126,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 };
 #define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
@@ -237,7 +145,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
@@ -246,7 +155,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
@@ -255,7 +165,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
@@ -264,7 +175,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
@@ -273,7 +185,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_name	= "mcbsp_clk",
+		.clk_names	= clk_names,
+		.num_clks	= 2,
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
@@ -284,14 +197,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 
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
index eef873d..113c246 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -344,7 +344,8 @@ struct omap_mcbsp_platform_data {
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
-	char const *clk_name;
+	char const **clk_names;
+	int num_clks;
 };
 
 struct omap_mcbsp {
@@ -376,7 +377,8 @@ struct omap_mcbsp {
 	/* Protect the field .free, while checking if the mcbsp is in use */
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
-	struct clk *clk;
+	struct clk **clks;
+	int num_clks;
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f2401a8..e5842e3 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -214,6 +214,7 @@ EXPORT_SYMBOL(omap_mcbsp_set_io_type);
 int omap_mcbsp_request(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
+	int i;
 	int err;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -225,7 +226,8 @@ int omap_mcbsp_request(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
 
-	clk_enable(mcbsp->clk);
+	for (i = 0; i < mcbsp->num_clks; i++)
+		clk_enable(mcbsp->clks[i]);
 
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
@@ -276,6 +278,7 @@ EXPORT_SYMBOL(omap_mcbsp_request);
 void omap_mcbsp_free(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
+	int i;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -286,7 +289,8 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	clk_disable(mcbsp->clk);
+	for (i = mcbsp->num_clks - 1; i >= 0; i--)
+		clk_disable(mcbsp->clks[i]);
 
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free) {
@@ -872,6 +876,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
 	struct omap_mcbsp *mcbsp;
 	int id = pdev->id - 1;
+	int i;
 	int ret = 0;
 
 	if (!pdata) {
@@ -916,14 +921,25 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
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
+	if (pdata->num_clks) {
+		mcbsp->num_clks = pdata->num_clks;
+		mcbsp->clks = kzalloc(mcbsp->num_clks * sizeof(struct clk *),
+					GFP_KERNEL);
+		if (!mcbsp->clks) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+		for (i = 0; i < mcbsp->num_clks; i++) {
+			mcbsp->clks[i] = clk_get(&pdev->dev, pdata->clk_names[i]);
+			if (IS_ERR(mcbsp->clks[i])) {
+				dev_err(&pdev->dev,
+					"Invalid %s configuration for McBSP%d.\n",
+					pdata->clk_names[i], mcbsp->id);
+				ret = PTR_ERR(mcbsp->clks[i]);
+				goto err_clk;
+			}
+		}
+
 	}
 
 	mcbsp->pdata = pdata;
@@ -932,6 +948,9 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk:
+	while (i--)
+		clk_put(mcbsp->clks[i]);
+	kfree(mcbsp->clks);
 	iounmap(mcbsp->io_base);
 err_ioremap:
 	mcbsp->free = 0;
@@ -942,6 +961,7 @@ exit:
 static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
+	int i;
 
 	platform_set_drvdata(pdev, NULL);
 	if (mcbsp) {
@@ -950,12 +970,18 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 				mcbsp->pdata->ops->free)
 			mcbsp->pdata->ops->free(mcbsp->id);
 
-		clk_disable(mcbsp->clk);
-		clk_put(mcbsp->clk);
+		for (i = mcbsp->num_clks - 1; i >= 0; i--) {
+			clk_disable(mcbsp->clks[i]);
+			clk_put(mcbsp->clks[i]);
+		}
 
 		iounmap(mcbsp->io_base);
 
-		mcbsp->clk = NULL;
+		if (mcbsp->num_clks) {
+			kfree(mcbsp->clks);
+			mcbsp->clks = NULL;
+			mcbsp->num_clks = 0;
+		}
 		mcbsp->free = 0;
 		mcbsp->dev = NULL;
 	}

