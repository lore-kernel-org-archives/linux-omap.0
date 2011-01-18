From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 5/6] OMAP: devices: Modify McSPI device to adapt to hwmod framework
Date: Tue, 18 Jan 2011 19:22:38 +0530
Message-ID: <1295358759-11731-6-git-send-email-govindraj.raja@ti.com>
References: <1295358759-11731-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657Ab1ARNh6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 08:37:58 -0500
In-Reply-To: <1295358759-11731-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Cc: grant.likely@secretlab.ca, charu@ti.com, b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, tony@atomide.com, "Govindraj.R" <govindraj.raja@ti.com>

From: Charulatha V <charu@ti.com>

Cleans up all base address definitions for omap_mcspi
and adapts the device registration and driver to hwmod framework.
Changes involves:
1) Removing all base address macro defines.
2) Using omap-device layer to register device and utilizing data from
   hwmod data file for base address, dma channel number, Irq_number,
   device attribute(number of chipselect).
3) Appending base address with pdata reg_offset for omap4 boards.
   For omap4 all regs used in driver deviate with reg_offset_macros
   defined with an value of 0x100. So pass this offset through pdata
   and append the same to base address retrieved from hwmod data file
   and we are not mapping *_HL_* regs which are not used in driver.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Reviewed-by: Partha Basak <p-basak2@ti.com>
---
 arch/arm/mach-omap2/devices.c           |  187 +++++++------------------------
 arch/arm/plat-omap/include/plat/mcspi.h |    3 +
 drivers/spi/omap2_mcspi.c               |  110 +++++--------------
 3 files changed, 71 insertions(+), 229 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 381f4eb..8cfc654 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -279,163 +280,55 @@ static inline void omap_init_audio(void) {}
 
 #include <plat/mcspi.h>
 
-#define OMAP2_MCSPI1_BASE		0x48098000
-#define OMAP2_MCSPI2_BASE		0x4809a000
-#define OMAP2_MCSPI3_BASE		0x480b8000
-#define OMAP2_MCSPI4_BASE		0x480ba000
-
-#define OMAP4_MCSPI1_BASE		0x48098100
-#define OMAP4_MCSPI2_BASE		0x4809a100
-#define OMAP4_MCSPI3_BASE		0x480b8100
-#define OMAP4_MCSPI4_BASE		0x480ba100
-
-static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
-	.num_cs		= 4,
-};
-
-static struct resource omap2_mcspi1_resources[] = {
-	{
-		.start		= OMAP2_MCSPI1_BASE,
-		.end		= OMAP2_MCSPI1_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi1 = {
-	.name		= "omap2_mcspi",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi1_resources),
-	.resource	= omap2_mcspi1_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi1_config,
-	},
-};
-
-static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
-	.num_cs		= 2,
-};
-
-static struct resource omap2_mcspi2_resources[] = {
-	{
-		.start		= OMAP2_MCSPI2_BASE,
-		.end		= OMAP2_MCSPI2_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi2 = {
-	.name		= "omap2_mcspi",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi2_resources),
-	.resource	= omap2_mcspi2_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi2_config,
-	},
-};
-
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
-	defined(CONFIG_ARCH_OMAP4)
-static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
-	.num_cs		= 2,
-};
-
-static struct resource omap2_mcspi3_resources[] = {
-	{
-	.start		= OMAP2_MCSPI3_BASE,
-	.end		= OMAP2_MCSPI3_BASE + 0xff,
-	.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi3 = {
-	.name		= "omap2_mcspi",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi3_resources),
-	.resource	= omap2_mcspi3_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi3_config,
-	},
-};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
-	.num_cs		= 1,
-};
-
-static struct resource omap2_mcspi4_resources[] = {
-	{
-		.start		= OMAP2_MCSPI4_BASE,
-		.end		= OMAP2_MCSPI4_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi4 = {
-	.name		= "omap2_mcspi",
-	.id		= 4,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi4_resources),
-	.resource	= omap2_mcspi4_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi4_config,
+struct omap_device_pm_latency omap_mcspi_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
 };
-#endif
 
-#ifdef CONFIG_ARCH_OMAP4
-static inline void omap4_mcspi_fixup(void)
+static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 {
-	omap2_mcspi1_resources[0].start	= OMAP4_MCSPI1_BASE;
-	omap2_mcspi1_resources[0].end	= OMAP4_MCSPI1_BASE + 0xff;
-	omap2_mcspi2_resources[0].start	= OMAP4_MCSPI2_BASE;
-	omap2_mcspi2_resources[0].end	= OMAP4_MCSPI2_BASE + 0xff;
-	omap2_mcspi3_resources[0].start	= OMAP4_MCSPI3_BASE;
-	omap2_mcspi3_resources[0].end	= OMAP4_MCSPI3_BASE + 0xff;
-	omap2_mcspi4_resources[0].start	= OMAP4_MCSPI4_BASE;
-	omap2_mcspi4_resources[0].end	= OMAP4_MCSPI4_BASE + 0xff;
-}
-#else
-static inline void omap4_mcspi_fixup(void)
-{
-}
-#endif
+	struct omap_device *od;
+	char *name = "omap2_mcspi";
+	struct omap2_mcspi_platform_config *pdata;
+	static int spi_num;
+	struct omap2_mcspi_dev_attr *mcspi_attrib = oh->dev_attr;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("Memory allocation for McSPI device failed\n");
+		return -ENOMEM;
+	}
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
-	defined(CONFIG_ARCH_OMAP4)
-static inline void omap2_mcspi3_init(void)
-{
-	platform_device_register(&omap2_mcspi3);
-}
-#else
-static inline void omap2_mcspi3_init(void)
-{
-}
-#endif
+	pdata->num_cs = mcspi_attrib->num_chipselect;
+	switch (oh->class->rev) {
+	case OMAP2_MCSPI_REV:
+	case OMAP3_MCSPI_REV:
+			pdata->regs_offset = 0;
+			break;
+	case OMAP4_MCSPI_REV:
+			pdata->regs_offset = OMAP4_MCSPI_REG_OFFSET;
+			break;
+	default:
+			pr_err("Invalid McSPI Revision value\n");
+			return -EINVAL;
+	}
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-static inline void omap2_mcspi4_init(void)
-{
-	platform_device_register(&omap2_mcspi4);
-}
-#else
-static inline void omap2_mcspi4_init(void)
-{
+	spi_num++;
+	od = omap_device_build(name, spi_num, oh, pdata,
+				sizeof(*pdata),	omap_mcspi_latency,
+				ARRAY_SIZE(omap_mcspi_latency), 0);
+	WARN(IS_ERR(od), "Cant build omap_device for %s:%s\n",
+				name, oh->name);
+	kfree(pdata);
+	return 0;
 }
-#endif
 
 static void omap_init_mcspi(void)
 {
-	if (cpu_is_omap44xx())
-		omap4_mcspi_fixup();
-
-	platform_device_register(&omap2_mcspi1);
-	platform_device_register(&omap2_mcspi2);
-
-	if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
-		omap2_mcspi3_init();
-
-	if (cpu_is_omap343x() || cpu_is_omap44xx())
-		omap2_mcspi4_init();
+	omap_hwmod_for_each_by_class("mcspi", omap_mcspi_init, NULL);
 }
 
 #else
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 560e266..3d51b18 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -5,8 +5,11 @@
 #define OMAP3_MCSPI_REV 1
 #define OMAP4_MCSPI_REV 2
 
+#define OMAP4_MCSPI_REG_OFFSET 0x100
+
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
+	unsigned int regs_offset;
 };
 
 struct omap2_mcspi_dev_attr {
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 2a651e6..6018fe4 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1092,91 +1092,14 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 	return 0;
 }
 
-static u8 __initdata spi1_rxdma_id [] = {
-	OMAP24XX_DMA_SPI1_RX0,
-	OMAP24XX_DMA_SPI1_RX1,
-	OMAP24XX_DMA_SPI1_RX2,
-	OMAP24XX_DMA_SPI1_RX3,
-};
-
-static u8 __initdata spi1_txdma_id [] = {
-	OMAP24XX_DMA_SPI1_TX0,
-	OMAP24XX_DMA_SPI1_TX1,
-	OMAP24XX_DMA_SPI1_TX2,
-	OMAP24XX_DMA_SPI1_TX3,
-};
-
-static u8 __initdata spi2_rxdma_id[] = {
-	OMAP24XX_DMA_SPI2_RX0,
-	OMAP24XX_DMA_SPI2_RX1,
-};
-
-static u8 __initdata spi2_txdma_id[] = {
-	OMAP24XX_DMA_SPI2_TX0,
-	OMAP24XX_DMA_SPI2_TX1,
-};
-
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
-	|| defined(CONFIG_ARCH_OMAP4)
-static u8 __initdata spi3_rxdma_id[] = {
-	OMAP24XX_DMA_SPI3_RX0,
-	OMAP24XX_DMA_SPI3_RX1,
-};
-
-static u8 __initdata spi3_txdma_id[] = {
-	OMAP24XX_DMA_SPI3_TX0,
-	OMAP24XX_DMA_SPI3_TX1,
-};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-static u8 __initdata spi4_rxdma_id[] = {
-	OMAP34XX_DMA_SPI4_RX0,
-};
-
-static u8 __initdata spi4_txdma_id[] = {
-	OMAP34XX_DMA_SPI4_TX0,
-};
-#endif
 
 static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
+	struct omap2_mcspi_platform_config *pdata = pdev->dev.platform_data;
 	struct omap2_mcspi	*mcspi;
 	struct resource		*r;
 	int			status = 0, i;
-	const u8		*rxdma_id, *txdma_id;
-	unsigned		num_chipselect;
-
-	switch (pdev->id) {
-	case 1:
-		rxdma_id = spi1_rxdma_id;
-		txdma_id = spi1_txdma_id;
-		num_chipselect = 4;
-		break;
-	case 2:
-		rxdma_id = spi2_rxdma_id;
-		txdma_id = spi2_txdma_id;
-		num_chipselect = 2;
-		break;
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
-	|| defined(CONFIG_ARCH_OMAP4)
-	case 3:
-		rxdma_id = spi3_rxdma_id;
-		txdma_id = spi3_txdma_id;
-		num_chipselect = 2;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	case 4:
-		rxdma_id = spi4_rxdma_id;
-		txdma_id = spi4_txdma_id;
-		num_chipselect = 1;
-		break;
-#endif
-	default:
-		return -EINVAL;
-	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
 	if (master == NULL) {
@@ -1193,7 +1116,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	master->setup = omap2_mcspi_setup;
 	master->transfer = omap2_mcspi_transfer;
 	master->cleanup = omap2_mcspi_cleanup;
-	master->num_chipselect = num_chipselect;
+	master->num_chipselect = pdata->num_cs;
 
 	dev_set_drvdata(&pdev->dev, master);
 
@@ -1211,6 +1134,8 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	r->start += pdata->regs_offset;
+	r->end += pdata->regs_offset;
 	mcspi->phys = r->start;
 	mcspi->base = ioremap(r->start, r->end - r->start + 1);
 	if (!mcspi->base) {
@@ -1245,11 +1170,32 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	if (mcspi->dma_channels == NULL)
 		goto err3;
 
-	for (i = 0; i < num_chipselect; i++) {
+	for (i = 0; i < master->num_chipselect; i++) {
+		char dma_ch_name[14];
+		struct resource *dma_res;
+
+		sprintf(dma_ch_name, "rx%d", i);
+		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+							dma_ch_name);
+		if (!dma_res) {
+			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
+			status = -ENODEV;
+			break;
+		}
+
 		mcspi->dma_channels[i].dma_rx_channel = -1;
-		mcspi->dma_channels[i].dma_rx_sync_dev = rxdma_id[i];
+		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
+		sprintf(dma_ch_name, "tx%d", i);
+		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+							dma_ch_name);
+		if (!dma_res) {
+			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
+			status = -ENODEV;
+			break;
+		}
+
 		mcspi->dma_channels[i].dma_tx_channel = -1;
-		mcspi->dma_channels[i].dma_tx_sync_dev = txdma_id[i];
+		mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
 	}
 
 	if (omap2_mcspi_reset(mcspi) < 0)
-- 
1.7.1

