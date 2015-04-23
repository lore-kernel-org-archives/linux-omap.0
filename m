From: Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] dmaengine: omap-dma: Fix memory leak when terminating running transfer
Date: Thu, 23 Apr 2015 09:21:11 +0200
Message-ID: <1429773689-26866-33-git-send-email-jslaby@suse.cz>
References: <1429773689-26866-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:38993 "EHLO
	ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756075AbbDWHVd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Apr 2015 03:21:33 -0400
In-Reply-To: <1429773689-26866-1-git-send-email-jslaby@suse.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Jiri Slaby <jslaby@suse.cz>

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 02d88b735f5a60f04dbf6d051b76e1877a0d0844 upstream.

In omap_dma_start_desc the vdesc->node is removed from the virt-dma
framework managed lists (to be precise from the desc_issued list).
If a terminate_all comes before the transfer finishes the omap_desc will
not be freed up because it is not in any of the lists and we stopped the
DMA channel so the transfer will not going to complete.
There is no special sequence for leaking memory when using cyclic (audio)
transfer: with every start and stop of a cyclic transfer the driver leaks
struct omap_desc worth of memory.

Free up the allocated memory directly in omap_dma_terminate_all() since the
framework will not going to do that for us.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: <linux-omap@vger.kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/dma/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ec3fc4fd9160..b94a37630e36 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -487,6 +487,7 @@ static int omap_dma_terminate_all(struct omap_chan *c)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		omap_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)
-- 
2.3.5

