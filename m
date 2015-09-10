From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 09/21] ARM: davinci: Add set dma_mask to eDMA devices
Date: Thu, 10 Sep 2015 11:37:38 +0300
Message-ID: <1441874270-2399-10-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The upcoming change to merge the arch/arm/common/edma.c into
drivers/dma/edma.c will need this change when booting daVinci devices in
no DT mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 8 ++++++++
 arch/arm/mach-davinci/dm355.c         | 8 +++++++-
 arch/arm/mach-davinci/dm644x.c        | 8 +++++++-
 arch/arm/mach-davinci/dm646x.c        | 8 +++++++-
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 9ae049ae816a..495e9293ed2a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -213,21 +213,29 @@ static struct resource da850_edma1_resources[] = {
 	},
 };
 
+static u64 da8xx_edma0_dmamask = DMA_BIT_MASK(32);
+
 static struct platform_device da8xx_edma0_device = {
 	.name		= "edma",
 	.id		= 0,
 	.dev = {
 		.platform_data = &da8xx_edma0_pdata,
+		.dma_mask = &da8xx_edma0_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(da8xx_edma0_resources),
 	.resource	= da8xx_edma0_resources,
 };
 
+static u64 da850_edma1_dmamask = DMA_BIT_MASK(32);
+
 static struct platform_device da850_edma1_device = {
 	.name		= "edma",
 	.id		= 1,
 	.dev = {
 		.platform_data = &da850_edma1_pdata,
+		.dma_mask = &da850_edma1_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(da850_edma1_resources),
 	.resource	= da850_edma1_resources,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a50bb9c66952..0f8c0ab48872 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -613,10 +613,16 @@ static struct resource edma_resources[] = {
 	/* not using (or muxing) TC*_ERR */
 };
 
+static u64 dm355_edma_dmamask = DMA_BIT_MASK(32);
+
 static struct platform_device dm355_edma_device = {
 	.name			= "edma",
 	.id			= 0,
-	.dev.platform_data	= &dm355_edma_pdata,
+	.dev = {
+		.platform_data	= &dm355_edma_pdata,
+		.dma_mask	= &dm355_edma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
 	.num_resources		= ARRAY_SIZE(edma_resources),
 	.resource		= edma_resources,
 };
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index d759ca8e58e8..fc8950e5a9a0 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -542,10 +542,16 @@ static struct resource edma_resources[] = {
 	/* not using TC*_ERR */
 };
 
+static u64 dm644x_edma_dmamask = DMA_BIT_MASK(32);
+
 static struct platform_device dm644x_edma_device = {
 	.name			= "edma",
 	.id			= 0,
-	.dev.platform_data	= &dm644x_edma_pdata,
+	.dev = {
+		.platform_data	= &dm644x_edma_pdata,
+		.dma_mask	= &dm644x_edma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
 	.num_resources		= ARRAY_SIZE(edma_resources),
 	.resource		= edma_resources,
 };
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 219ebc8f674a..77df905949bc 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -589,10 +589,16 @@ static struct resource edma_resources[] = {
 	/* not using TC*_ERR */
 };
 
+static u64 dm646x_edma_dmamask = DMA_BIT_MASK(32);
+
 static struct platform_device dm646x_edma_device = {
 	.name			= "edma",
 	.id			= 0,
-	.dev.platform_data	= &dm646x_edma_pdata,
+	.dev = {
+		.platform_data	= &dm646x_edma_pdata,
+		.dma_mask	= &dm646x_edma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
 	.num_resources		= ARRAY_SIZE(edma_resources),
 	.resource		= edma_resources,
 };
-- 
2.5.1
