From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] dmaengine: edma: fix memory leak when terminating running transfers
Date: Fri, 27 Mar 2015 13:35:51 +0200
Message-ID: <1427456155-28990-2-git-send-email-peter.ujfalusi@ti.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
Sender: stable-owner@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Petr Kulhavy <petr@barix.com>, stable@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Petr Kulhavy <petr@barix.com>

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
CC: <stable@vger.kernel.org>
CC: <linux-omap@vger.kernel.org>
---
 drivers/dma/edma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 741baa68365c..984c2b12dae3 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -268,6 +268,13 @@ static int edma_terminate_all(struct dma_chan *chan)
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
-- 
2.3.3
