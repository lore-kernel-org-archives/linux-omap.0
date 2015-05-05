From: Kamal Mostafa <kamal@canonical.com>
Subject: [3.13.y-ckt stable] Patch "dmaengine: omap-dma: Fix memory leak when terminating running transfer" has been added to staging queue
Date: Tue,  5 May 2015 13:33:24 -0700
Message-ID: <1430858004-3446-1-git-send-email-kamal@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35954 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559AbbEEUd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 16:33:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Kamal Mostafa <kamal@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    dmaengine: omap-dma: Fix memory leak when terminating running transfer

to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11-ckt20.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From 11890cda33ea837608f666e62598438c0471635f Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 27 Mar 2015 13:35:52 +0200
Subject: dmaengine: omap-dma: Fix memory leak when terminating running
 transfer

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/dma/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 2f66cf4..d1cb93d 100644
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
1.9.1

