From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] omap: DMA: Fix multi-line comments
Date: Fri, 14 May 2010 14:27:52 -0700
Message-ID: <20100514212752.25599.69904.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56257 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab0ENV1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:27:54 -0400
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Manjunatha GK <manjugk@ti.com>, linux-omap@vger.kernel.org

From: manjugk manjugk <manjugk@ti.com>

Multi line comments are fixed as per CodingStyle
guidelines.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ad42ec3..f7f571e 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -501,7 +501,8 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 			burst = 0x2;
 			break;
 		}
-		/* not supported by current hardware on OMAP1
+		/*
+		 * not supported by current hardware on OMAP1
 		 * w |= (0x03 << 7);
 		 * fall through
 		 */
@@ -510,7 +511,8 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 			burst = 0x3;
 			break;
 		}
-		/* OMAP1 don't support burst 16
+		/*
+		 * OMAP1 don't support burst 16
 		 * fall through
 		 */
 	default:
@@ -604,7 +606,8 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 			burst = 0x3;
 			break;
 		}
-		/* OMAP1 don't support burst 16
+		/*
+		 * OMAP1 don't support burst 16
 		 * fall through
 		 */
 	default:
@@ -1285,8 +1288,10 @@ int omap_request_dma_chain(int dev_id, const char *dev_name,
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
@@ -1915,7 +1920,8 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO "DMA transaction error with device %d\n",
 		       dma_chan[ch].dev_id);
 		if (cpu_class_is_omap2()) {
-			/* Errata: sDMA Channel is not disabled
+			/*
+			 * Errata: sDMA Channel is not disabled
 			 * after a transaction error. So we explicitely
 			 * disable the channel
 			 */

