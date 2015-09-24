From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 09/25] ARM: davinci: Use platform_device_register_full() to
 create pdev for eDMA
Date: Thu, 24 Sep 2015 13:01:56 +0300
Message-ID: <1443088932-21731-10-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Convert the eDMA platform device creation to use
struct platform_device_info XXXXXX __initconst and
platform_device_register_full()
This will allow us to cleanly specify the dma_mask for the devices in an
upcoming patch.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 38 ++++++++++++++++++-----------------
 arch/arm/mach-davinci/dm355.c         | 20 +++++++++++-------
 arch/arm/mach-davinci/dm644x.c        | 20 +++++++++++-------
 arch/arm/mach-davinci/dm646x.c        | 18 ++++++++++-------
 4 files changed, 57 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 9ae049ae816a..9f7d266faa0c 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -213,48 +213,50 @@ static struct resource da850_edma1_resources[] = {
 	},
 };
 
-static struct platform_device da8xx_edma0_device = {
+static const struct platform_device_info da8xx_edma0_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
-	.dev = {
-		.platform_data = &da8xx_edma0_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(da8xx_edma0_resources),
-	.resource	= da8xx_edma0_resources,
+	.res		= da8xx_edma0_resources,
+	.num_res	= ARRAY_SIZE(da8xx_edma0_resources),
+	.data		= &da8xx_edma0_pdata,
+	.size_data	= sizeof(da8xx_edma0_pdata),
 };
 
-static struct platform_device da850_edma1_device = {
+static const struct platform_device_info da850_edma1_device __initconst = {
 	.name		= "edma",
 	.id		= 1,
-	.dev = {
-		.platform_data = &da850_edma1_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(da850_edma1_resources),
-	.resource	= da850_edma1_resources,
+	.res		= da850_edma1_resources,
+	.num_res	= ARRAY_SIZE(da850_edma1_resources),
+	.data		= &da850_edma1_pdata,
+	.size_data	= sizeof(da850_edma1_pdata),
 };
 
 int __init da830_register_edma(struct edma_rsv_info *rsv)
 {
+	struct platform_device *edma_pdev;
+
 	da8xx_edma0_pdata.rsv = rsv;
 
-	return platform_device_register(&da8xx_edma0_device);
+	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
+	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
 
 int __init da850_register_edma(struct edma_rsv_info *rsv[2])
 {
-	int ret;
+	struct platform_device *edma_pdev;
 
 	if (rsv) {
 		da8xx_edma0_pdata.rsv = rsv[0];
 		da850_edma1_pdata.rsv = rsv[1];
 	}
 
-	ret = platform_device_register(&da8xx_edma0_device);
-	if (ret) {
+	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
+	if (IS_ERR(edma_pdev)) {
 		pr_warn("%s: Failed to register eDMA0\n", __func__);
-		return ret;
+		return PTR_ERR(edma_pdev);
 	}
-	return platform_device_register(&da850_edma1_device);
+	edma_pdev = platform_device_register_full(&da850_edma1_device);
+	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
 
 static struct resource da8xx_i2c_resources0[] = {
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a50bb9c66952..5f10c6695e31 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -613,12 +613,13 @@ static struct resource edma_resources[] = {
 	/* not using (or muxing) TC*_ERR */
 };
 
-static struct platform_device dm355_edma_device = {
-	.name			= "edma",
-	.id			= 0,
-	.dev.platform_data	= &dm355_edma_pdata,
-	.num_resources		= ARRAY_SIZE(edma_resources),
-	.resource		= edma_resources,
+static const struct platform_device_info dm355_edma_device __initconst = {
+	.name		= "edma",
+	.id		= 0,
+	.res		= edma_resources,
+	.num_res	= ARRAY_SIZE(edma_resources),
+	.data		= &dm355_edma_pdata,
+	.size_data	= sizeof(dm355_edma_pdata),
 };
 
 static struct resource dm355_asp1_resources[] = {
@@ -1057,13 +1058,18 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 
 static int __init dm355_init_devices(void)
 {
+	struct platform_device *edma_pdev;
 	int ret = 0;
 
 	if (!cpu_is_davinci_dm355())
 		return 0;
 
 	davinci_cfg_reg(DM355_INT_EDMA_CC);
-	platform_device_register(&dm355_edma_device);
+	edma_pdev = platform_device_register_full(&dm355_edma_device);
+	if (IS_ERR(edma_pdev)) {
+		pr_warn("%s: Failed to register eDMA\n", __func__);
+		return PTR_ERR(edma_pdev);
+	}
 
 	ret = davinci_init_wdt();
 	if (ret)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index d759ca8e58e8..aa3453b40d5f 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -542,12 +542,13 @@ static struct resource edma_resources[] = {
 	/* not using TC*_ERR */
 };
 
-static struct platform_device dm644x_edma_device = {
-	.name			= "edma",
-	.id			= 0,
-	.dev.platform_data	= &dm644x_edma_pdata,
-	.num_resources		= ARRAY_SIZE(edma_resources),
-	.resource		= edma_resources,
+static const struct platform_device_info dm644x_edma_device __initconst = {
+	.name		= "edma",
+	.id		= 0,
+	.res		= edma_resources,
+	.num_res	= ARRAY_SIZE(edma_resources),
+	.data		= &dm644x_edma_pdata,
+	.size_data	= sizeof(dm644x_edma_pdata),
 };
 
 /* DM6446 EVM uses ASP0; line-out is a pair of RCA jacks */
@@ -945,12 +946,17 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 
 static int __init dm644x_init_devices(void)
 {
+	struct platform_device *edma_pdev;
 	int ret = 0;
 
 	if (!cpu_is_davinci_dm644x())
 		return 0;
 
-	platform_device_register(&dm644x_edma_device);
+	edma_pdev = platform_device_register_full(&dm644x_edma_device);
+	if (IS_ERR(edma_pdev)) {
+		pr_warn("%s: Failed to register eDMA\n", __func__);
+		return PTR_ERR(edma_pdev);
+	}
 
 	platform_device_register(&dm644x_mdio_device);
 	platform_device_register(&dm644x_emac_device);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 219ebc8f674a..79c1d8917dd3 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -589,12 +589,13 @@ static struct resource edma_resources[] = {
 	/* not using TC*_ERR */
 };
 
-static struct platform_device dm646x_edma_device = {
-	.name			= "edma",
-	.id			= 0,
-	.dev.platform_data	= &dm646x_edma_pdata,
-	.num_resources		= ARRAY_SIZE(edma_resources),
-	.resource		= edma_resources,
+static const struct platform_device_info dm646x_edma_device __initconst = {
+	.name		= "edma",
+	.id		= 0,
+	.res		= edma_resources,
+	.num_res	= ARRAY_SIZE(edma_resources),
+	.data		= &dm646x_edma_pdata,
+	.size_data	= sizeof(dm646x_edma_pdata),
 };
 
 static struct resource dm646x_mcasp0_resources[] = {
@@ -931,9 +932,12 @@ void dm646x_setup_vpif(struct vpif_display_config *display_config,
 
 int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 {
+	struct platform_device *edma_pdev;
+
 	dm646x_edma_pdata.rsv = rsv;
 
-	return platform_device_register(&dm646x_edma_device);
+	edma_pdev = platform_device_register_full(&dm646x_edma_device);
+	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
 
 void __init dm646x_init(void)
-- 
2.5.2
