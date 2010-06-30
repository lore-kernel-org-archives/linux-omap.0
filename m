From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 1/1] omap: dma: Support for prefetch in destination synchronized transfer
Date: Wed, 30 Jun 2010 11:47:06 +0300
Message-ID: <1277887626-11917-2-git-send-email-samu.p.onkalo@nokia.com>
References: <1277887626-11917-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40563 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0F3Irn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 04:47:43 -0400
In-Reply-To: <1277887626-11917-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Omap DMA controller can prefetch data in advance in case of
destination synchronized data transfer. This may increase
performance when target HW block doesn't have fifo.
Data is waiting for transfer request in DMA fifo instead of read from memory.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
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
 
-- 
1.6.0.4

