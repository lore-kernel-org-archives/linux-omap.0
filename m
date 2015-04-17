From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.19 062/101] dmaengine: edma: fix memory leak when terminating running transfers
Date: Fri, 17 Apr 2015 15:28:50 +0200
Message-ID: <20150417132517.081653392@linuxfoundation.org>
References: <20150417132514.379828774@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150417132514.379828774@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Petr Kulhavy <petr@barix.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-omap@vger.kernel.org

3.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
