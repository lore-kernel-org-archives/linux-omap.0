From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] ARM: OMAP2/3: sDMA: Correct omap_request_dma_chain()
Date: Tue, 19 May 2009 16:40:07 -0700
Message-ID: <20090519234007.12760.1967.stgit@localhost>
References: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59539 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbZESXkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:40:07 -0400
In-Reply-To: <20090519232905.12760.15490.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Original OMAP DMA chaining design has chain_id as one of the callback
parameters. Patch 538528de0cb256f65716ab2e9613d9e920f97fe2 broke
the desing.

Change the callback to return the logical channel number and not
chain_id.

More details are on this email thread:

http://marc.info/?l=linux-omap&m=122961071931459&w=2

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c              |    2 +-
 arch/arm/plat-omap/include/mach/dma.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 58d98ad..06e9cbe 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1220,7 +1220,7 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
  * 	     Failure: -EINVAL/-ENOMEM
  */
 int omap_request_dma_chain(int dev_id, const char *dev_name,
-			   void (*callback) (int chain_id, u16 ch_status,
+			   void (*callback) (int lch, u16 ch_status,
 					     void *data),
 			   int *chain_id, int no_of_chans, int chain_mode,
 			   struct omap_dma_channel_params params)
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 35fefdb..19df76f 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -532,7 +532,7 @@ extern int omap_get_dma_index(int lch, int *ei, int *fi);
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-				  void (*callback) (int chain_id, u16 ch_status,
+				  void (*callback) (int lch, u16 ch_status,
 						    void *data),
 				  int *chain_id, int no_of_chans,
 				  int chain_mode,

