From: Fabrice Goucem <f-goucem@ti.com>
Subject: [PATCH] Add support for packet synchronised sDMA transfers.
Date: Wed,  3 Mar 2010 11:20:58 +0100
Message-ID: <1267611658-18946-1-git-send-email-f-goucem@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60630 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab0CCKUh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 05:20:37 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o23AKalM019713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 04:20:36 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Fabrice Goucem <f-goucem@ti.com>

System DMA packet synchronisation is currently not supported in the
Linux Kernel.
This patch provides necessary modifications to support packet
synchronisation:
Function omap_set_dma_transfer_params() handles value OMAP_DMA_SYNC_PACKET
to program FS and BS bits of register CCR.
Users can give the packet size to the DMA driver by using parameters
src_fi / dst_fi in functions omap_set_dma_src_params() /
omap_set_dma_dest_params().

Patch has been validated using OMAP's McSPI (on Zoom2, OMAP3430):
McSPI is configured to use DMA transfer.
FIFO are activated with a threshold of 16 bytes (i.e. DMA requests will be
triggered as soon as more than 16 bytes are free in the FIFO).
A frame of 132 elements (bytes) has been transfered, by packets of 16
elements. Resulting transfer was 8 packets of 16 elements plus a last packet
of 4 elements.

Modifications tested building on OMAP2, OMAP3 and OMAP4 configurations.

Signed-off-by: Fabrice Goucem <f-goucem@ti.com>
Acked-by: Venkatraman S <svenkatr@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Shilpa Maddi <s-maddi@ti.com>
---
 arch/arm/plat-omap/dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..48f9355 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -293,12 +293,14 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 		val |= (dma_trigger & ~0x1f) << 14;
 		val |= dma_trigger & 0x1f;
 
-		if (sync_mode & OMAP_DMA_SYNC_FRAME)
+		if ((sync_mode == OMAP_DMA_SYNC_FRAME) ||
+		    (sync_mode == OMAP_DMA_SYNC_PACKET))
 			val |= 1 << 5;
 		else
 			val &= ~(1 << 5);
 
-		if (sync_mode & OMAP_DMA_SYNC_BLOCK)
+		if ((sync_mode == OMAP_DMA_SYNC_BLOCK) ||
+		    (sync_mode == OMAP_DMA_SYNC_PACKET))
 			val |= 1 << 18;
 		else
 			val &= ~(1 << 18);
-- 
1.6.0.4

