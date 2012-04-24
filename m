From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: OMAP1: Pass dma request lines in platform data to
 MMC driver
Date: Mon, 23 Apr 2012 17:08:39 -0700
Message-ID: <20120424000839.17783.70410.stgit@muffinssi.local>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40234 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab2DXAIk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:40 -0400
In-Reply-To: <20120424000607.17783.81686.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Pass dma request lines in platform data to MMC driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 2192676..fa1fa4d 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -22,6 +22,7 @@
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mux.h>
+#include <plat/dma.h>
 #include <plat/mmc.h>
 #include <plat/omap7xx.h>
 
@@ -144,13 +145,14 @@ static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
-#define OMAP_MMC_NR_RES		2
+#define OMAP_MMC_NR_RES		4
 
 /*
  * Register MMC devices.
  */
 static int __init omap_mmc_add(const char *name, int id, unsigned long base,
 				unsigned long size, unsigned int irq,
+				unsigned rx_req, unsigned tx_req,
 				struct omap_mmc_platform_data *data)
 {
 	struct platform_device *pdev;
@@ -167,6 +169,12 @@ static int __init omap_mmc_add(const char *name, int id, unsigned long base,
 	res[0].flags = IORESOURCE_MEM;
 	res[1].start = res[1].end = irq;
 	res[1].flags = IORESOURCE_IRQ;
+	res[2].start = rx_req;
+	res[2].name = "rx";
+	res[2].flags = IORESOURCE_DMA;
+	res[3].start = tx_req;
+	res[3].name = "tx";
+	res[3].flags = IORESOURCE_DMA;
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret == 0)
@@ -194,6 +202,7 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 
 	for (i = 0; i < nr_controllers; i++) {
 		unsigned long base, size;
+		unsigned rx_req, tx_req;
 		unsigned int irq = 0;
 
 		if (!mmc_data[i])
@@ -205,19 +214,24 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		case 0:
 			base = OMAP1_MMC1_BASE;
 			irq = INT_MMC;
+			rx_req = OMAP_DMA_MMC_RX;
+			tx_req = OMAP_DMA_MMC_TX;
 			break;
 		case 1:
 			if (!cpu_is_omap16xx())
 				return;
 			base = OMAP1_MMC2_BASE;
 			irq = INT_1610_MMC2;
+			rx_req = OMAP_DMA_MMC2_RX;
+			tx_req = OMAP_DMA_MMC2_TX;
 			break;
 		default:
 			continue;
 		}
 		size = OMAP1_MMC_SIZE;
 
-		omap_mmc_add("mmci-omap", i, base, size, irq, mmc_data[i]);
+		omap_mmc_add("mmci-omap", i, base, size, irq,
+				rx_req, tx_req, mmc_data[i]);
 	};
 }
 

