From: Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] dmaengine: edma: fix memory leak when terminating running transfers
Date: Thu, 23 Apr 2015 15:00:31 -0400
Message-ID: <1429815663-25702-55-git-send-email-sasha.levin@oracle.com>
References: <1429815663-25702-1-git-send-email-sasha.levin@oracle.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42415 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030922AbbDWTCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2015 15:02:19 -0400
In-Reply-To: <1429815663-25702-1-git-send-email-sasha.levin@oracle.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Petr Kulhavy <petr@barix.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Sasha Levin <sasha.levin@oracle.com>

From: Petr Kulhavy <petr@barix.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 5ca9e7ce6eebec53362ff779264143860ccf68cd ]

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
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/dma/edma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 4cfaaa5..abff66c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -258,6 +258,13 @@ static int edma_terminate_all(struct edma_chan *echan)
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
2.1.0

