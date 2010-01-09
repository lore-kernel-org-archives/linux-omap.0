From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP: dma_chan[lch_head].flag & OMAP_DMA_ACTIVE tested twice
 in omap_dma_unlink_lch()
Date: Sat, 09 Jan 2010 14:55:11 +0100
Message-ID: <4B488ABF.4070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754611Ab0AINvN@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The same flag and bits were tested twice.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Is this what was intended? please review.

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 09d82b3..728c642 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1183,7 +1183,7 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 	}
 
 	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
-	    (dma_chan[lch_head].flags & OMAP_DMA_ACTIVE)) {
+	    (dma_chan[lch_queue].flags & OMAP_DMA_ACTIVE)) {
 		printk(KERN_ERR "omap_dma: You need to stop the DMA channels "
 		       "before unlinking\n");
 		dump_stack();
