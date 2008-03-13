From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] ARM: OMAP: Fix chain_a_transfer return value
Date: Thu, 13 Mar 2008 17:45:17 +0200
Message-ID: <1205423119-22292-5-git-send-email-tony@atomide.com>
References: omap-fixes-2008-03-13
 <1205423119-22292-1-git-send-email-tony@atomide.com>
 <1205423119-22292-2-git-send-email-tony@atomide.com>
 <1205423119-22292-3-git-send-email-tony@atomide.com>
 <1205423119-22292-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59210 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbYCMPpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 11:45:47 -0400
In-Reply-To: <1205423119-22292-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>

From: Anand Gadiyar <gadiyar@ti.com>

This patch changes the return value of omap_dma_chain_a_transfer
to 0 on success instead of the flag 'start_dma', which wasn't really useful
for anything.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 91004a3..06293bf 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1248,7 +1248,7 @@ EXPORT_SYMBOL(omap_dma_chain_status);
  * @param frame_count
  * @param callbk_data - channel callback parameter data.
  *
- * @return  - Success : start_dma status
+ * @return  - Success : 0
  * 	      Failure: -EINVAL/-EBUSY
  */
 int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
@@ -1367,7 +1367,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
 	}
-	return start_dma;
+	return 0;
 }
 EXPORT_SYMBOL(omap_dma_chain_a_transfer);
 
-- 
1.5.3.6

