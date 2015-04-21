From: Luis Henriques <luis.henriques@canonical.com>
Subject: [3.16.y-ckt stable] Patch "dmaengine: edma: fix memory leak when terminating running transfers" has been added to staging queue
Date: Tue, 21 Apr 2015 16:23:59 +0100
Message-ID: <1429629839-20265-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56884 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbbDUPYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2015 11:24:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Luis Henriques <luis.henriques@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    dmaengine: edma: fix memory leak when terminating running transfers

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt10.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 14a39537780a5a78fd5ca7f5866b1aaf27223437 Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <petr@barix.com>
Date: Fri, 27 Mar 2015 13:35:51 +0200
Subject: dmaengine: edma: fix memory leak when terminating running transfers

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
[ luis: backported to 3.16: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/dma/edma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d08c4dedef35..3c58df963e06 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -256,6 +256,12 @@ static int edma_terminate_all(struct edma_chan *echan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
+		/*
+		 * free the running request descriptor
+		 * since it is not in any of the vdesc lists
+		 */
+		edma_desc_free(&echan->edesc->vdesc);
+
 		echan->edesc = NULL;
 		edma_stop(echan->ch_num);
 	}
