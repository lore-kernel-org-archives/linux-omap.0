From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH] EDMA: TI: fixed memory leak when terminating running transfers
Date: Mon, 23 Mar 2015 16:00:12 +0100
Message-ID: <1427122812-22657-1-git-send-email-petr@barix.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, trivial@kernel.org, Petr Kulhavy <petr@barix.com>
List-Id: linux-omap@vger.kernel.org

If edma_terminate_all() was called while a transfer was running (i.e. after
edma_execute() but before edma_callback()) the echan->edesc was not freed.

This was due to the fact that a running transfer is on none of the
vchan lists: desc_submitted, desc_issued, desc_completed (edma_execute()
removes it from the desc_issued list), so the vchan_dma_desc_free_list()
called at the end of edma_terminate_all() didn't find it and didn't free it.

This bug was found on an AM1808 based hardware (very similar to da850evm,
however using the second MMC/SD controller), where intense operations on the SD
card wasted the device 128MB RAM within a couple of days.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 drivers/dma/edma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 276157f..1465610 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -260,6 +260,14 @@ static int edma_terminate_all(struct dma_chan *chan)
 	 */
 	if (echan->edesc) {
 		int cyclic = echan->edesc->cyclic;
+
+		/*
+		 * free the running request descriptor
+		 * since it is on none of the vchan lists
+		 * desc_submitted, desc_issued, desc_completed
+		 */
+		kfree(echan->edesc);
+
 		echan->edesc = NULL;
 		edma_stop(echan->ch_num);
 		/* Move the cyclic channel back to default queue */
-- 
1.9.1
