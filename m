From: <gregkh@linuxfoundation.org>
Subject: Patch "dmaengine: omap-dma: Fix memory leak when terminating running transfer" has been added to the 3.19-stable tree
Date: Fri, 17 Apr 2015 14:26:23 +0200
Message-ID: <1429273583206212@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60259 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbbDQM1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2015 08:27:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@ti.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, vinod.koul@intel.com
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    dmaengine: omap-dma: Fix memory leak when terminating running transfer

to the 3.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     dmaengine-omap-dma-fix-memory-leak-when-terminating-running-transfer.patch
and it can be found in the queue-3.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 02d88b735f5a60f04dbf6d051b76e1877a0d0844 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 27 Mar 2015 13:35:52 +0200
Subject: dmaengine: omap-dma: Fix memory leak when terminating running transfer

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/omap-dma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -978,6 +978,7 @@ static int omap_dma_terminate_all(struct
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		omap_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)


Patches currently in stable-queue which might be from peter.ujfalusi@ti.com are

queue-3.19/dmaengine-edma-fix-memory-leak-when-terminating-running-transfers.patch
queue-3.19/dmaengine-omap-dma-fix-memory-leak-when-terminating-running-transfer.patch
