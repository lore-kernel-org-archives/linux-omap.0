From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain() signature
Date: Wed, 29 Apr 2009 17:39:16 +0530
Message-ID: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57489 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758057AbZD2MJZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Apr 2009 08:09:25 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3TC9IP4021560
	for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 07:09:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Original OMAP DMA chaining design has chain_id as one of the callback
parameters. The below patch broke the desing.
http://git.omapzoom.org/?p=repo/omapkernel.git;a=commitdiff;h=538528de0cb256f65716ab2e9613d9e920f97fe2
Now callback returns logical channel number and not chain_id. 
Hence the signature of the omap_request_dma_chain() functions needs to be
corrected to avoid any confusion.

More details are on this email thread :
http://marc.info/?l=linux-omap&m=122961071931459&w=2

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c              |    2 +-
 arch/arm/plat-omap/include/mach/dma.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 6093018..fcc6f69 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1199,7 +1199,7 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
  * 	     Failure: -EINVAL/-ENOMEM
  */
 int omap_request_dma_chain(int dev_id, const char *dev_name,
-			   void (*callback) (int chain_id, u16 ch_status,
+			   void (*callback) (int lch, u16 ch_status,
 					     void *data),
 			   int *chain_id, int no_of_chans, int chain_mode,
 			   struct omap_dma_channel_params params)
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 224b077..2d5af41 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -546,7 +546,7 @@ extern int omap_get_dma_index(int lch, int *ei, int *fi);
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-				  void (*callback) (int chain_id, u16 ch_status,
+				  void (*callback) (int lch, u16 ch_status,
 						    void *data),
 				  int *chain_id, int no_of_chans,
 				  int chain_mode,
-- 
1.5.4.7

