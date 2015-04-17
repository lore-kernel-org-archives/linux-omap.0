From: <gregkh@linuxfoundation.org>
Subject: Patch "dmaengine: edma: fix memory leak when terminating running transfers" has been added to the 3.19-stable tree
Date: Fri, 17 Apr 2015 14:26:23 +0200
Message-ID: <14292735831329@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: petr@barix.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, vinod.koul@intel.com
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    dmaengine: edma: fix memory leak when terminating running transfers

to the 3.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     dmaengine-edma-fix-memory-leak-when-terminating-running-transfers.patch
and it can be found in the queue-3.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 5ca9e7ce6eebec53362ff779264143860ccf68cd Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <petr@barix.com>
Date: Fri, 27 Mar 2015 13:35:51 +0200
Subject: dmaengine: edma: fix memory leak when terminating running transfers

From: Petr Kulhavy <petr@barix.com>

commit 5ca9e7ce6eebec53362ff779264143860ccf68cd upstream.

If edma_terminate_all() was called while a transfer was running (i.e. after
edma_execute() but before edma_callback()) the echan->edesc was not freed.

This was due to the fact that a running transfer is on none of the
vchan lists: desc_submitted, desc_issued, desc_completed (edma_execute()
removes it from the desc_issued list), so the vchan_dma_desc_free_list()
called at the end of edma_terminate_all() didn't find it and didn't free it.

This bug was found on an AM1808 based hardware (very similar to da850evm,
however using the second MMC/SD controller), where intense operations on the SD
card wasted the device 128MB RAM within a couple of days.

Peter Ujfalusi:
The issue is even more severe since it affects cyclic (audio) transfers as
well. In this case starting/stopping audio will results memory leak.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: <linux-omap@vger.kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/edma.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -258,6 +258,13 @@ static int edma_terminate_all(struct edm
 	 */
 	if (echan->edesc) {
 		int cyclic = echan->edesc->cyclic;
+
+		/*
+		 * free the running request descriptor
+		 * since it is not in any of the vdesc lists
+		 */
+		edma_desc_free(&echan->edesc->vdesc);
+
 		echan->edesc = NULL;
 		edma_stop(echan->ch_num);
 		/* Move the cyclic channel back to default queue */


Patches currently in stable-queue which might be from petr@barix.com are

queue-3.19/dmaengine-edma-fix-memory-leak-when-terminating-running-transfers.patch
