From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/13] omap: dma: Support for prefetch in destination
	synchronizedtransfer
Date: Thu, 08 Jul 2010 16:54:58 +0300
Message-ID: <20100708135458.26276.67951.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60371 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757859Ab0GHNzB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:55:01 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, linux-omap@vger.kernel.org

From: Samu Onkalo <samu.p.onkalo@nokia.com>

Omap DMA controller can prefetch data in advance in case of
destination synchronized data transfer. This may increase
performance when target HW block doesn't have fifo.
Data is waiting for transfer request in DMA fifo instead of read from memory.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c              |   11 +++++++----
 arch/arm/plat-omap/include/plat/dma.h |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index f7f571e..ec7eddf 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -290,7 +290,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 		val = dma_read(CCR(lch));
 
 		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
-		val &= ~((3 << 19) | 0x1f);
+		val &= ~((1 << 23) | (3 << 19) | 0x1f);
 		val |= (dma_trigger & ~0x1f) << 14;
 		val |= dma_trigger & 0x1f;
 
@@ -304,11 +304,14 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 		else
 			val &= ~(1 << 18);
 
-		if (src_or_dst_synch)
+		if (src_or_dst_synch == OMAP_DMA_DST_SYNC_PREFETCH) {
+			val &= ~(1 << 24);	/* dest synch */
+			val |= (1 << 23);	/* Prefetch */
+		} else if (src_or_dst_synch) {
 			val |= 1 << 24;		/* source synch */
-		else
+		} else {
 			val &= ~(1 << 24);	/* dest synch */
-
+		}
 		dma_write(val, CCR(lch));
 	}
 
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 02232ca..af3a039 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -345,6 +345,7 @@
 #define OMAP_DMA_SYNC_BLOCK		0x02
 #define OMAP_DMA_SYNC_PACKET		0x03
 
+#define OMAP_DMA_DST_SYNC_PREFETCH	0x02
 #define OMAP_DMA_SRC_SYNC		0x01
 #define OMAP_DMA_DST_SYNC		0x00
 

