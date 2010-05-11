From: Madhvapathi Sriram <sriram.m@ti.com>
Subject: [PATCH 1/1] omap-hsmmc.c: re-organize dma line population
Date: Tue, 11 May 2010 14:02:13 +0530
Message-ID: <1273566733-22572-1-git-send-email-sriram.m@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36816 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab0EKJbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 May 2010 05:31:41 -0400
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4B9VePc018186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 04:31:40 -0500
Received: from tidmzi-ftp.india.ext.ti.com (localhost [127.0.0.1])
	by dflp53.itg.ti.com (8.13.8/8.13.8) with SMTP id o4B9VcE1001848
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 04:31:39 -0500 (CDT)
Received: from symphonyindia.ti.com (symphony-ftp [192.168.247.11])
	by tidmzi-ftp.india.ext.ti.com (Postfix) with SMTP id 3D87638872
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 14:58:04 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com, Madhvapathi Sriram <sriram.m@ti.com>

 - This moves the dma line population from omap_hsmmc.c to plat-omap/devices.c
 - This is done to keep platform specific code inside the platform directory
   rather than the host driver
 - This makes the porting work across OMAP platforms easier

Signed-off-by: Madhvapathi Sriram <sriram.m@ti.com>
---
 arch/arm/plat-omap/devices.c  |   49 ++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/omap_hsmmc.c |   35 +++++++---------------------
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 95677d1..a62b148 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -30,6 +30,7 @@
 #include <plat/mcbsp.h>
 #include <plat/dsp_common.h>
 #include <plat/omap44xx.h>
+#include <plat/dma.h>
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
@@ -232,7 +233,7 @@ static inline void omap_init_mcpdm(void) {}
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-#define OMAP_MMC_NR_RES		2
+#define OMAP_MMC_NR_RES		4
 
 /*
  * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
@@ -255,6 +256,52 @@ int __init omap_mmc_add(const char *name, int id, unsigned long base,
 	res[0].flags = IORESOURCE_MEM;
 	res[1].start = res[1].end = irq;
 	res[1].flags = IORESOURCE_IRQ;
+	/* Populate DMA lines based on the instance used. Rx first,Tx next*/
+	switch (id) {
+	case 0:
+		res[2].start = OMAP24XX_DMA_MMC1_RX;
+		res[2].end = OMAP24XX_DMA_MMC1_RX;
+		res[2].flags = IORESOURCE_DMA;
+		res[3].start = OMAP24XX_DMA_MMC1_TX;
+		res[3].end = OMAP24XX_DMA_MMC1_TX;
+		res[3].flags = IORESOURCE_DMA;
+		break;
+	case 1:
+		res[2].start = OMAP24XX_DMA_MMC2_RX;
+		res[2].end = OMAP24XX_DMA_MMC2_RX;
+		res[2].flags = IORESOURCE_DMA;
+		res[3].start = OMAP24XX_DMA_MMC2_TX;
+		res[3].end = OMAP24XX_DMA_MMC2_TX;
+		res[3].flags = IORESOURCE_DMA;
+		break;
+	case 2:
+		res[2].start = OMAP34XX_DMA_MMC3_RX;
+		res[2].end = OMAP34XX_DMA_MMC3_RX;
+		res[2].flags = IORESOURCE_DMA;
+		res[3].start = OMAP34XX_DMA_MMC3_TX;
+		res[3].end = OMAP34XX_DMA_MMC3_TX;
+		res[3].flags = IORESOURCE_DMA;
+		break;
+	case 3:
+		res[2].start = OMAP44XX_DMA_MMC4_RX;
+		res[2].end = OMAP44XX_DMA_MMC4_RX;
+		res[2].flags = IORESOURCE_DMA;
+		res[3].start = OMAP44XX_DMA_MMC4_TX;
+		res[3].end = OMAP44XX_DMA_MMC4_TX;
+		res[3].flags = IORESOURCE_DMA;
+		break;
+	case 4:
+		res[2].start = OMAP44XX_DMA_MMC5_RX;
+		res[2].end = OMAP44XX_DMA_MMC5_RX;
+		res[2].flags = IORESOURCE_DMA;
+		res[3].start = OMAP44XX_DMA_MMC5_TX;
+		res[3].end = OMAP44XX_DMA_MMC5_TX;
+		res[3].flags = IORESOURCE_DMA;
+		break;
+	default:
+		ret = -ENODEV;
+		goto fail;
+	}
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret == 0)
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e9caf69..61d30ab 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2096,32 +2096,15 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_conf_bus_power(host);
 
-	/* Select DMA lines */
-	switch (host->id) {
-	case OMAP_MMC1_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC1_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC1_RX;
-		break;
-	case OMAP_MMC2_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC2_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC2_RX;
-		break;
-	case OMAP_MMC3_DEVID:
-		host->dma_line_tx = OMAP34XX_DMA_MMC3_TX;
-		host->dma_line_rx = OMAP34XX_DMA_MMC3_RX;
-		break;
-	case OMAP_MMC4_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC4_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC4_RX;
-		break;
-	case OMAP_MMC5_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC5_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC5_RX;
-		break;
-	default:
-		dev_err(mmc_dev(host->mmc), "Invalid MMC id\n");
-		goto err_irq;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res)
+		goto err1;
+	host->dma_line_rx = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res)
+		goto err1;
+	host->dma_line_tx = res->start;
 
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, IRQF_DISABLED,
-- 
1.5.6

