From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH 2/2] EDMA: TI: fixed wrongly initialized data parameter to the edma callback
Date: Mon, 23 Mar 2015 21:35:01 +0100
Message-ID: <1427142901-16391-1-git-send-email-petr@barix.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36763 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbCWUff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 16:35:35 -0400
Received: by wibg7 with SMTP id g7so57724876wib.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2015 13:35:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vinod.koul@intel.com
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, trivial@kernel.org, Petr Kulhavy <petr@barix.com>

The "data" parameter passed indirectly to the edma_callback() should be
edma_chan and not the dma_chan.

This bug was so far harmless since the offset of struct dma_chan within struct
edma_chan is 0. However as soon as someone changes struct edma_chan this would
cause troubles.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 drivers/dma/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 1465610..4c8208b 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -813,7 +813,7 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	LIST_HEAD(descs);
 
 	a_ch_num = edma_alloc_channel(echan->ch_num, edma_callback,
-					chan, EVENTQ_DEFAULT);
+					echan, EVENTQ_DEFAULT);
 
 	if (a_ch_num < 0) {
 		ret = -ENODEV;
-- 
1.9.1

