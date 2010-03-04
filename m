From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: DMA: Fix multi-line comments
Date: Thu,  4 Mar 2010 12:43:14 +0530
Message-ID: <1267686794-22288-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52509 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab0CDGyi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Mar 2010 01:54:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Multi line comments are fixed as per CodingStyle
guidelines.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/plat-omap/dma.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..e5de2bb 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -500,7 +500,8 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 			burst = 0x2;
 			break;
 		}
-		/* not supported by current hardware on OMAP1
+		/*
+		 * not supported by current hardware on OMAP1
 		 * w |= (0x03 << 7);
 		 * fall through
 		 */
@@ -509,7 +510,8 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 			burst = 0x3;
 			break;
 		}
-		/* OMAP1 don't support burst 16
+		/*
+		 * OMAP1 don't support burst 16
 		 * fall through
 		 */
 	default:
@@ -603,7 +605,8 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 			burst = 0x3;
 			break;
 		}
-		/* OMAP1 don't support burst 16
+		/*
+		 * OMAP1 don't support burst 16
 		 * fall through
 		 */
 	default:
@@ -1267,8 +1270,10 @@ int omap_request_dma_chain(int dev_id, const char *dev_name,
 		return -EINVAL;
 	}
 
-	/* Allocate a queue to maintain the status of the channels
-	 * in the chain */
+	/*
+	 * Allocate a queue to maintain the status of the channels
+	 * in the chain
+	 */
 	channels = kmalloc(sizeof(*channels) * no_of_chans, GFP_KERNEL);
 	if (channels == NULL) {
 		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
@@ -1897,7 +1902,8 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO "DMA transaction error with device %d\n",
 		       dma_chan[ch].dev_id);
 		if (cpu_class_is_omap2()) {
-			/* Errata: sDMA Channel is not disabled
+			/*
+			 * Errata: sDMA Channel is not disabled
 			 * after a transaction error. So we explicitely
 			 * disable the channel
 			 */
-- 
1.6.3.3

