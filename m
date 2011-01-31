From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 02/13] OMAP: McBSP: Convert McBSP to platform device model
Date: Mon, 31 Jan 2011 20:20:26 +0530
Message-ID: <1296485437-12806-3-git-send-email-kishon@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab1AaOzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 09:55:21 -0500
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Implement McBSP as platform device and add support for
registering through platform device layer using resource
structures.

Later in this patch series, OMAP2+ McBSP driver would be modified to
use hwmod framework after populating the omap2+ hwmod database.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap1/mcbsp.c             |  383 ++++++++++++++---
 arch/arm/mach-omap2/mcbsp.c             |  704 +++++++++++++++++++++++++-----
 arch/arm/plat-omap/devices.c            |   10 +-
 arch/arm/plat-omap/include/plat/mcbsp.h |   14 +-
 arch/arm/plat-omap/mcbsp.c              |   60 +++-
 5 files changed, 966 insertions(+), 205 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 8209736..2b89ebd 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -10,6 +10,7 @@
  *
  * Multichannel mode not supported.
  */
+#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/clk.h>
@@ -78,100 +79,344 @@ static struct omap_mcbsp_ops omap1_mcbsp_ops = {
 };
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+struct resource omap7xx_mcbsp_res[][6] = {
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP7XX_MCBSP1_BASE,
+			.end   = OMAP7XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP7XX_MCBSP1_BASE,
+			.end   = OMAP7XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_7XX_McBSP1RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_7XX_McBSP1TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP1_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP1_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP7XX_MCBSP2_BASE,
+			.end   = OMAP7XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP7XX_MCBSP2_BASE,
+			.end   = OMAP7XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_7XX_McBSP2RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_7XX_McBSP2TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP3_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP3_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+};
+
 static struct omap_mcbsp_platform_data omap7xx_mcbsp_pdata[] = {
 	{
-		.phys_base	= OMAP7XX_MCBSP1_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
-		.rx_irq		= INT_7XX_McBSP1RX,
-		.tx_irq		= INT_7XX_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.phys_base	= OMAP7XX_MCBSP2_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
-		.rx_irq		= INT_7XX_McBSP2RX,
-		.tx_irq		= INT_7XX_McBSP2TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 };
-#define OMAP7XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap7xx_mcbsp_pdata)
-#define OMAP7XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
+#define OMAP7XX_MCBSP_RES_SZ		ARRAY_SIZE(omap7xx_mcbsp_res[1])
+#define OMAP7XX_MCBSP_COUNT		ARRAY_SIZE(omap7xx_mcbsp_res)
 #else
+#define omap7xx_mcbsp_res		NULL
 #define omap7xx_mcbsp_pdata		NULL
-#define OMAP7XX_MCBSP_PDATA_SZ		0
-#define OMAP7XX_MCBSP_REG_NUM		0
+#define OMAP7XX_MCBSP_RES_SZ		0
+#define OMAP7XX_MCBSP_COUNT		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP15XX
+struct resource omap15xx_mcbsp_res[][6] = {
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP1510_MCBSP1_BASE,
+			.end   = OMAP1510_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP1510_MCBSP1_BASE,
+			.end   = OMAP1510_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_McBSP1RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_McBSP1TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP1_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP1_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP1510_MCBSP2_BASE,
+			.end   = OMAP1510_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP1510_MCBSP2_BASE,
+			.end   = OMAP1510_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_1510_SPI_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_1510_SPI_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP2_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP2_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP1510_MCBSP3_BASE,
+			.end   = OMAP1510_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP1510_MCBSP3_BASE,
+			.end   = OMAP1510_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_McBSP3RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_McBSP3TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP3_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP3_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+};
+
 static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 	{
-		.phys_base	= OMAP1510_MCBSP1_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
-		.rx_irq		= INT_McBSP1RX,
-		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.phys_base	= OMAP1510_MCBSP2_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP2_TX,
-		.rx_irq		= INT_1510_SPI_RX,
-		.tx_irq		= INT_1510_SPI_TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.phys_base	= OMAP1510_MCBSP3_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
-		.rx_irq		= INT_McBSP3RX,
-		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 };
-#define OMAP15XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap15xx_mcbsp_pdata)
-#define OMAP15XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
+#define OMAP15XX_MCBSP_RES_SZ		ARRAY_SIZE(omap15xx_mcbsp_res[1])
+#define OMAP15XX_MCBSP_COUNT		ARRAY_SIZE(omap15xx_mcbsp_res)
 #else
+#define omap15xx_mcbsp_res		NULL
 #define omap15xx_mcbsp_pdata		NULL
-#define OMAP15XX_MCBSP_PDATA_SZ		0
-#define OMAP15XX_MCBSP_REG_NUM		0
+#define OMAP15XX_MCBSP_RES_SZ		0
+#define OMAP15XX_MCBSP_COUNT		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP16XX
+struct resource omap16xx_mcbsp_res[][6] = {
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP1610_MCBSP1_BASE,
+			.end   = OMAP1610_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP1610_MCBSP1_BASE,
+			.end   = OMAP1610_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_McBSP1RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_McBSP1TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP1_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP1_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP1610_MCBSP2_BASE,
+			.end   = OMAP1610_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP1610_MCBSP2_BASE,
+			.end   = OMAP1610_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_1610_McBSP2_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_1610_McBSP2_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP2_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP2_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP1610_MCBSP3_BASE,
+			.end   = OMAP1610_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP1610_MCBSP3_BASE,
+			.end   = OMAP1610_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_McBSP3RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_McBSP3TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP_DMA_MCBSP3_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP_DMA_MCBSP3_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+};
+
 static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 	{
-		.phys_base	= OMAP1610_MCBSP1_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
-		.rx_irq		= INT_McBSP1RX,
-		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.phys_base	= OMAP1610_MCBSP2_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP2_TX,
-		.rx_irq		= INT_1610_McBSP2_RX,
-		.tx_irq		= INT_1610_McBSP2_TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.phys_base	= OMAP1610_MCBSP3_BASE,
-		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
-		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
-		.rx_irq		= INT_McBSP3RX,
-		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 };
-#define OMAP16XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap16xx_mcbsp_pdata)
-#define OMAP16XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
+#define OMAP16XX_MCBSP_RES_SZ		ARRAY_SIZE(omap16xx_mcbsp_res[1])
+#define OMAP16XX_MCBSP_COUNT		ARRAY_SIZE(omap16xx_mcbsp_res)
 #else
+#define omap16xx_mcbsp_res		NULL
 #define omap16xx_mcbsp_pdata		NULL
-#define OMAP16XX_MCBSP_PDATA_SZ		0
-#define OMAP16XX_MCBSP_REG_NUM		0
+#define OMAP16XX_MCBSP_RES_SZ		0
+#define OMAP16XX_MCBSP_COUNT		0
 #endif
 
 static int __init omap1_mcbsp_init(void)
@@ -179,16 +424,12 @@ static int __init omap1_mcbsp_init(void)
 	if (!cpu_class_is_omap1())
 		return -ENODEV;
 
-	if (cpu_is_omap7xx()) {
-		omap_mcbsp_count = OMAP7XX_MCBSP_PDATA_SZ;
-		omap_mcbsp_cache_size = OMAP7XX_MCBSP_REG_NUM * sizeof(u16);
-	} else if (cpu_is_omap15xx()) {
-		omap_mcbsp_count = OMAP15XX_MCBSP_PDATA_SZ;
-		omap_mcbsp_cache_size = OMAP15XX_MCBSP_REG_NUM * sizeof(u16);
-	} else if (cpu_is_omap16xx()) {
-		omap_mcbsp_count = OMAP16XX_MCBSP_PDATA_SZ;
-		omap_mcbsp_cache_size = OMAP16XX_MCBSP_REG_NUM * sizeof(u16);
-	}
+	if (cpu_is_omap7xx())
+		omap_mcbsp_count = OMAP7XX_MCBSP_COUNT;
+	else if (cpu_is_omap15xx())
+		omap_mcbsp_count = OMAP15XX_MCBSP_COUNT;
+	else if (cpu_is_omap16xx())
+		omap_mcbsp_count = OMAP16XX_MCBSP_COUNT;
 
 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
@@ -196,16 +437,22 @@ static int __init omap1_mcbsp_init(void)
 		return -ENOMEM;
 
 	if (cpu_is_omap7xx())
-		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_pdata,
-						OMAP7XX_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res[0],
+					OMAP7XX_MCBSP_RES_SZ,
+					omap7xx_mcbsp_pdata,
+					OMAP7XX_MCBSP_COUNT);
 
 	if (cpu_is_omap15xx())
-		omap_mcbsp_register_board_cfg(omap15xx_mcbsp_pdata,
-						OMAP15XX_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap15xx_mcbsp_res[0],
+					OMAP15XX_MCBSP_RES_SZ,
+					omap15xx_mcbsp_pdata,
+					OMAP15XX_MCBSP_COUNT);
 
 	if (cpu_is_omap16xx())
-		omap_mcbsp_register_board_cfg(omap16xx_mcbsp_pdata,
-						OMAP16XX_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap16xx_mcbsp_res[0],
+					OMAP16XX_MCBSP_RES_SZ,
+					omap16xx_mcbsp_pdata,
+					OMAP16XX_MCBSP_COUNT);
 
 	return omap_mcbsp_init();
 }
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 0526b75..bc004be 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -105,173 +105,633 @@ EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 /* Platform data */
 
 #ifdef CONFIG_SOC_OMAP2420
-static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
+struct resource omap2420_mcbsp_res[][6] = {
 	{
-		.phys_base	= OMAP24XX_MCBSP1_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
-		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
+		{
+			.name  = "mpu",
+			.start = OMAP24XX_MCBSP1_BASE,
+			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP24XX_MCBSP1_BASE,
+			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP1_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP1_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP1_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP1_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base	= OMAP24XX_MCBSP2_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
-		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		{
+			.name  = "mpu",
+			.start = OMAP24XX_MCBSP2_BASE,
+			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP24XX_MCBSP2_BASE,
+			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP2_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP2_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP2_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP2_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 };
-#define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
-#define OMAP2420_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
+#define OMAP2420_MCBSP_RES_SZ		ARRAY_SIZE(omap2420_mcbsp_res[1])
+#define OMAP2420_MCBSP_COUNT		ARRAY_SIZE(omap2420_mcbsp_res)
 #else
-#define omap2420_mcbsp_pdata		NULL
-#define OMAP2420_MCBSP_PDATA_SZ		0
-#define OMAP2420_MCBSP_REG_NUM		0
+#define omap2420_mcbsp_res		NULL
+#define OMAP2420_MCBSP_RES_SZ		0
+#define OMAP2420_MCBSP_COUNT		0
 #endif
 
+#define omap2420_mcbsp_pdata		NULL
+
 #ifdef CONFIG_SOC_OMAP2430
-static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
+struct resource omap2430_mcbsp_res[][6] = {
 	{
-		.phys_base	= OMAP24XX_MCBSP1_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
-		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
+		{
+			.name  = "mpu",
+			.start = OMAP24XX_MCBSP1_BASE,
+			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP24XX_MCBSP1_BASE,
+			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP1_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP1_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP1_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP1_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base	= OMAP24XX_MCBSP2_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
-		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		{
+			.name  = "mpu",
+			.start = OMAP24XX_MCBSP2_BASE,
+			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP24XX_MCBSP2_BASE,
+			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP2_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP2_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP2_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP2_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base	= OMAP2430_MCBSP3_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
-		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
+		{
+			.name  = "mpu",
+			.start = OMAP2430_MCBSP3_BASE,
+			.end   = OMAP2430_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP2430_MCBSP3_BASE,
+			.end   = OMAP2430_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP3_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP3_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP3_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP3_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base	= OMAP2430_MCBSP4_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
-		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
+		{
+			.name  = "mpu",
+			.start = OMAP2430_MCBSP4_BASE,
+			.end   = OMAP2430_MCBSP4_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP2430_MCBSP4_BASE,
+			.end   = OMAP2430_MCBSP4_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP4_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP4_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP4_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP4_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base	= OMAP2430_MCBSP5_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
-		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
+		{
+			.name  = "mpu",
+			.start = OMAP2430_MCBSP5_BASE,
+			.end   = OMAP2430_MCBSP5_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP2430_MCBSP5_BASE,
+			.end   = OMAP2430_MCBSP5_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP5_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP5_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP5_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP5_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 };
-#define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
-#define OMAP2430_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
+#define OMAP2430_MCBSP_RES_SZ		ARRAY_SIZE(omap2430_mcbsp_res[1])
+#define OMAP2430_MCBSP_COUNT		ARRAY_SIZE(omap2430_mcbsp_res)
 #else
-#define omap2430_mcbsp_pdata		NULL
-#define OMAP2430_MCBSP_PDATA_SZ		0
-#define OMAP2430_MCBSP_REG_NUM		0
+#define omap2430_mcbsp_res		NULL
+#define OMAP2430_MCBSP_RES_SZ		0
+#define OMAP2430_MCBSP_COUNT		0
 #endif
 
+#define omap2430_mcbsp_pdata		NULL
+
 #ifdef CONFIG_ARCH_OMAP3
+struct resource omap34xx_mcbsp_res[][7] = {
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP34XX_MCBSP1_BASE,
+			.end   = OMAP34XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP34XX_MCBSP1_BASE,
+			.end   = OMAP34XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP1_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP1_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP1_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP1_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP34XX_MCBSP2_BASE,
+			.end   = OMAP34XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP34XX_MCBSP2_BASE,
+			.end   = OMAP34XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "sidetone",
+			.start = OMAP34XX_MCBSP2_ST_BASE,
+			.end   = OMAP34XX_MCBSP2_ST_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP2_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP2_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP2_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP2_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP34XX_MCBSP3_BASE,
+			.end   = OMAP34XX_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP34XX_MCBSP3_BASE,
+			.end   = OMAP34XX_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "sidetone",
+			.start = OMAP34XX_MCBSP3_ST_BASE,
+			.end   = OMAP34XX_MCBSP3_ST_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP3_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP3_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP3_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP3_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP34XX_MCBSP4_BASE,
+			.end   = OMAP34XX_MCBSP4_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP34XX_MCBSP4_BASE,
+			.end   = OMAP34XX_MCBSP4_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP4_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP4_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP4_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP4_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+	{
+		{
+			.name  = "mpu",
+			.start = OMAP34XX_MCBSP5_BASE,
+			.end   = OMAP34XX_MCBSP5_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP34XX_MCBSP5_BASE,
+			.end   = OMAP34XX_MCBSP5_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = INT_24XX_MCBSP5_IRQ_RX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = INT_24XX_MCBSP5_IRQ_TX,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP24XX_DMA_MCBSP5_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP24XX_DMA_MCBSP5_TX,
+			.flags = IORESOURCE_DMA,
+		},
+	},
+};
+
 static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	{
-		.phys_base	= OMAP34XX_MCBSP1_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
-		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
 	},
 	{
-		.phys_base	= OMAP34XX_MCBSP2_BASE,
-		.phys_base_st	= OMAP34XX_MCBSP2_ST_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
-		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.buffer_size	= 0x500, /* The FIFO has 1024 + 256 locations */
 	},
 	{
-		.phys_base	= OMAP34XX_MCBSP3_BASE,
-		.phys_base_st	= OMAP34XX_MCBSP3_ST_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
-		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
 	},
 	{
-		.phys_base	= OMAP34XX_MCBSP4_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
-		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
 	},
 	{
-		.phys_base	= OMAP34XX_MCBSP5_BASE,
-		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
-		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
-		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
-		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
 	},
 };
-#define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
-#define OMAP34XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
+#define OMAP34XX_MCBSP_RES_SZ		ARRAY_SIZE(omap34xx_mcbsp_res[1])
+#define OMAP34XX_MCBSP_COUNT		ARRAY_SIZE(omap34xx_mcbsp_res)
 #else
 #define omap34xx_mcbsp_pdata		NULL
-#define OMAP34XX_MCBSP_PDATA_SZ		0
-#define OMAP34XX_MCBSP_REG_NUM		0
+#define omap34XX_mcbsp_res		NULL
+#define OMAP34XX_MCBSP_RES_SZ		0
+#define OMAP34XX_MCBSP_COUNT		0
 #endif
 
-static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
+struct resource omap44xx_mcbsp_res[][6] = {
 	{
-		.phys_base      = OMAP44XX_MCBSP1_BASE,
-		.dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
-		.dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
-		.tx_irq         = OMAP44XX_IRQ_MCBSP1,
+		{
+			.name  = "mpu",
+			.start = OMAP44XX_MCBSP1_BASE,
+			.end   = OMAP44XX_MCBSP1_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP44XX_MCBSP1_DMA_BASE,
+			.end   = OMAP44XX_MCBSP1_DMA_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = 0,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_IRQ_MCBSP1,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP44XX_DMA_MCBSP1_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_DMA_MCBSP1_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base      = OMAP44XX_MCBSP2_BASE,
-		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
-		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
-		.tx_irq         = OMAP44XX_IRQ_MCBSP2,
+		{
+			.name  = "mpu",
+			.start = OMAP44XX_MCBSP2_BASE,
+			.end   = OMAP44XX_MCBSP2_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP44XX_MCBSP2_DMA_BASE,
+			.end   = OMAP44XX_MCBSP2_DMA_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = 0,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_IRQ_MCBSP2,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP44XX_DMA_MCBSP2_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_DMA_MCBSP2_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base      = OMAP44XX_MCBSP3_BASE,
-		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
-		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
-		.tx_irq         = OMAP44XX_IRQ_MCBSP3,
+		{
+			.name  = "mpu",
+			.start = OMAP44XX_MCBSP3_BASE,
+			.end   = OMAP44XX_MCBSP3_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP44XX_MCBSP3_DMA_BASE,
+			.end   = OMAP44XX_MCBSP3_DMA_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = 0,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_IRQ_MCBSP3,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP44XX_DMA_MCBSP3_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_DMA_MCBSP3_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 	{
-		.phys_base      = OMAP44XX_MCBSP4_BASE,
-		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
-		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
-		.tx_irq         = OMAP44XX_IRQ_MCBSP4,
+		{
+			.name  = "mpu",
+			.start = OMAP44XX_MCBSP4_BASE,
+			.end   = OMAP44XX_MCBSP4_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "dma",
+			.start = OMAP44XX_MCBSP4_BASE,
+			.end   = OMAP44XX_MCBSP4_BASE + SZ_256,
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.name  = "rx",
+			.start = 0,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_IRQ_MCBSP4,
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.name  = "rx",
+			.start = OMAP44XX_DMA_MCBSP4_RX,
+			.flags = IORESOURCE_DMA,
+		},
+		{
+			.name  = "tx",
+			.start = OMAP44XX_DMA_MCBSP4_TX,
+			.flags = IORESOURCE_DMA,
+		},
 	},
 };
-#define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
-#define OMAP44XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
+#define omap44xx_mcbsp_pdata		NULL
+#define OMAP44XX_MCBSP_RES_SZ		ARRAY_SIZE(omap44xx_mcbsp_res[1])
+#define OMAP44XX_MCBSP_COUNT		ARRAY_SIZE(omap44xx_mcbsp_res)
 
 static int __init omap2_mcbsp_init(void)
 {
-	if (cpu_is_omap2420()) {
-		omap_mcbsp_count = OMAP2420_MCBSP_PDATA_SZ;
-		omap_mcbsp_cache_size = OMAP2420_MCBSP_REG_NUM * sizeof(u16);
-	} else if (cpu_is_omap2430()) {
-		omap_mcbsp_count = OMAP2430_MCBSP_PDATA_SZ;
-		omap_mcbsp_cache_size = OMAP2430_MCBSP_REG_NUM * sizeof(u32);
-	} else if (cpu_is_omap34xx()) {
-		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
-		omap_mcbsp_cache_size = OMAP34XX_MCBSP_REG_NUM * sizeof(u32);
-	} else if (cpu_is_omap44xx()) {
-		omap_mcbsp_count = OMAP44XX_MCBSP_PDATA_SZ;
-		omap_mcbsp_cache_size = OMAP44XX_MCBSP_REG_NUM * sizeof(u32);
-	}
+	if (cpu_is_omap2420())
+		omap_mcbsp_count = OMAP2420_MCBSP_COUNT;
+	else if (cpu_is_omap2430())
+		omap_mcbsp_count = OMAP2430_MCBSP_COUNT;
+	else if (cpu_is_omap34xx())
+		omap_mcbsp_count = OMAP34XX_MCBSP_COUNT;
+	else if (cpu_is_omap44xx())
+		omap_mcbsp_count = OMAP44XX_MCBSP_COUNT;
 
 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
@@ -279,17 +739,25 @@ static int __init omap2_mcbsp_init(void)
 		return -ENOMEM;
 
 	if (cpu_is_omap2420())
-		omap_mcbsp_register_board_cfg(omap2420_mcbsp_pdata,
-						OMAP2420_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap2420_mcbsp_res[0],
+					OMAP2420_MCBSP_RES_SZ,
+					omap2420_mcbsp_pdata,
+					OMAP2420_MCBSP_COUNT);
 	if (cpu_is_omap2430())
-		omap_mcbsp_register_board_cfg(omap2430_mcbsp_pdata,
-						OMAP2430_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap2430_mcbsp_res[0],
+					OMAP2420_MCBSP_RES_SZ,
+					omap2430_mcbsp_pdata,
+					OMAP2430_MCBSP_COUNT);
 	if (cpu_is_omap34xx())
-		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
-						OMAP34XX_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_res[0],
+					OMAP34XX_MCBSP_RES_SZ,
+					omap34xx_mcbsp_pdata,
+					OMAP34XX_MCBSP_COUNT);
 	if (cpu_is_omap44xx())
-		omap_mcbsp_register_board_cfg(omap44xx_mcbsp_pdata,
-						OMAP44XX_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap44xx_mcbsp_res[0],
+					OMAP44XX_MCBSP_RES_SZ,
+					omap44xx_mcbsp_pdata,
+					OMAP44XX_MCBSP_COUNT);
 
 	return omap_mcbsp_init();
 }
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 10245b8..7d9f815 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -35,8 +35,8 @@
 
 static struct platform_device **omap_mcbsp_devices;
 
-void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
-					int size)
+void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
+			struct omap_mcbsp_platform_data *config, int size)
 {
 	int i;
 
@@ -54,6 +54,8 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 		new_mcbsp = platform_device_alloc("omap-mcbsp", i + 1);
 		if (!new_mcbsp)
 			continue;
+		platform_device_add_resources(new_mcbsp, &res[i * res_count],
+					res_count);
 		new_mcbsp->dev.platform_data = &config[i];
 		ret = platform_device_add(new_mcbsp);
 		if (ret) {
@@ -65,8 +67,8 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 }
 
 #else
-void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
-					int size)
+void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
+			struct omap_mcbsp_platform_data *config, int size)
 {  }
 #endif
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index b87d83c..e9bde6e 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -63,9 +63,12 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP34XX_MCBSP4_BASE	0x49026000
 #define OMAP34XX_MCBSP5_BASE	0x48096000
 
-#define OMAP44XX_MCBSP1_BASE	0x49022000
-#define OMAP44XX_MCBSP2_BASE	0x49024000
-#define OMAP44XX_MCBSP3_BASE	0x49026000
+#define OMAP44XX_MCBSP1_BASE	0x40122000
+#define OMAP44XX_MCBSP1_DMA_BASE	0x49022000
+#define OMAP44XX_MCBSP2_BASE	0x40124000
+#define OMAP44XX_MCBSP2_DMA_BASE	0x49024000
+#define OMAP44XX_MCBSP3_BASE	0x40126000
+#define OMAP44XX_MCBSP3_DMA_BASE	0x49026000
 #define OMAP44XX_MCBSP4_BASE	0x48096000
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
@@ -445,6 +448,7 @@ struct omap_mcbsp_st_data {
 struct omap_mcbsp {
 	struct device *dev;
 	unsigned long phys_base;
+	unsigned long phys_dma_base;
 	void __iomem *io_base;
 	u8 id;
 	u8 free;
@@ -488,8 +492,8 @@ extern int omap_mcbsp_count, omap_mcbsp_cache_size;
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
 
 int omap_mcbsp_init(void);
-void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
-					int size);
+void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
+			struct omap_mcbsp_platform_data *config, int size);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
 #ifdef CONFIG_ARCH_OMAP3
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 473edab..275a37a 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1676,7 +1676,8 @@ static const struct attribute_group sidetone_attr_group = {
 
 static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp_platform_data *pdata = mcbsp->pdata;
+	struct platform_device *pdev;
+	struct resource *res;
 	struct omap_mcbsp_st_data *st_data;
 	int err;
 
@@ -1686,7 +1687,10 @@ static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
 		goto err1;
 	}
 
-	st_data->io_base_st = ioremap(pdata->phys_base_st, SZ_4K);
+	pdev = container_of(mcbsp->dev, struct platform_device, dev);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sidetone");
+	st_data->io_base_st = ioremap(res->start, resource_size(res));
 	if (!st_data->io_base_st) {
 		err = -ENOMEM;
 		goto err2;
@@ -1775,6 +1779,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
 	struct omap_mcbsp *mcbsp;
 	int id = pdev->id - 1;
+	struct resource *res;
 	int ret = 0;
 
 	if (!pdata) {
@@ -1804,25 +1809,60 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dma_tx_lch = -1;
 	mcbsp->dma_rx_lch = -1;
 
-	mcbsp->phys_base = pdata->phys_base;
-	mcbsp->io_base = ioremap(pdata->phys_base, SZ_4K);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
+	if (!res) {
+		dev_err(&pdev->dev, "%s:mcbsp%d has invalid memory resource\n",
+					__func__, pdev->id);
+		ret = -ENOMEM;
+		goto exit;
+	}
+	mcbsp->phys_base = res->start;
+	mcbsp->io_base = ioremap(res->start, resource_size(res));
 	if (!mcbsp->io_base) {
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
+	if (!res) {
+		dev_err(&pdev->dev, "%s:mcbsp%d has invalid memory resource\n",
+					__func__, pdev->id);
+		ret = -ENOMEM;
+		goto exit;
+	}
+	mcbsp->phys_dma_base = res->start;
+
+	omap_mcbsp_cache_size = resource_size(res);
+
 	/* Default I/O is IRQ based */
 	mcbsp->io_type = OMAP_MCBSP_IRQ_IO;
-	mcbsp->tx_irq = pdata->tx_irq;
-	mcbsp->rx_irq = pdata->rx_irq;
-	mcbsp->dma_rx_sync = pdata->dma_rx_sync;
-	mcbsp->dma_tx_sync = pdata->dma_tx_sync;
+
+	mcbsp->tx_irq = platform_get_irq_byname(pdev, "tx");
+	mcbsp->rx_irq = platform_get_irq_byname(pdev, "rx");
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (!res) {
+		dev_err(&pdev->dev, "%s:mcbsp%d has invalid rx DMA channel\n",
+					__func__, pdev->id);
+		ret = -ENODEV;
+		goto err_res;
+	}
+	mcbsp->dma_rx_sync = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (!res) {
+		dev_err(&pdev->dev, "%s:mcbsp%d has invalid tx DMA channel\n",
+					__func__, pdev->id);
+		ret = -ENODEV;
+		goto err_res;
+	}
+	mcbsp->dma_tx_sync = res->start;
 
 	mcbsp->iclk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(mcbsp->iclk)) {
 		ret = PTR_ERR(mcbsp->iclk);
 		dev_err(&pdev->dev, "unable to get ick: %d\n", ret);
-		goto err_iclk;
+		goto err_res;
 	}
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
@@ -1844,7 +1884,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 err_fclk:
 	clk_put(mcbsp->iclk);
-err_iclk:
+err_res:
 	iounmap(mcbsp->io_base);
 err_ioremap:
 	kfree(mcbsp);
-- 
1.7.0.4

