From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/1] dma: edma: fix incorrect SG list handling
Date: Wed, 19 Mar 2014 11:25:50 +0530
Message-ID: <1395208550-1603-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57239 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaCSF4M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2014 01:56:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: DMA Engine Mailing List <dmaengine@vger.kernel.org>, Linux DaVinci Mailing List <davinci-linux-open-source@linux.davincidsp.com>, Jon Ringle <jringle@gridpoint.com>, Alexander Holler <holler@ahsoftware.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Joel Fernandes <joelf@ti.com>

The code to handle any length SG lists calls edma_resume()
even before edma_start() is called. This is incorrect
because edma_resume() enables edma events on the channel
after which CPU (in edma_start) cannot clear posted
events by writing to ECR (per the EDMA user's guide).

Because of this EDMA transfers fail to start if due
to some reason there is a pending EDMA event registered
even before EDMA transfers are started. This can happen if
an EDMA event is a byproduct of device initialization.

Fix this by calling edma_resume() only if it is not the
first batch of MAX_NR_SG elements.

Without this patch, MMC/SD fails to function on DA850 EVM
with DMA. The behaviour is triggered by specific IP and
this can explain why the issue was not reported before
(example with MMC/SD on AM335x).

Tested on DA850 EVM and AM335x EVM-SK using MMC/SD card.

Cc: stable@vger.kernel.org # v3.12.x+
Cc: Joel Fernandes <joelf@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
Tested-by: Jon Ringle <jringle@gridpoint.com>
Tested-by: Alexander Holler <holler@ahsoftware.de>
Reported-by: Jon Ringle <jringle@gridpoint.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Same as the version send previously (which did not make
into all mailing lists). Commit message updates with
tested-by and acks received.

 drivers/dma/edma.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index cd8da45..bf5ad0f 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -182,11 +182,13 @@ static void edma_execute(struct edma_chan *echan)
 				  echan->ecc->dummy_slot);
 	}
 
-	edma_resume(echan->ch_num);
-
 	if (edesc->processed <= MAX_NR_SG) {
 		dev_dbg(dev, "first transfer starting %d\n", echan->ch_num);
 		edma_start(echan->ch_num);
+	} else {
+		dev_dbg(dev, "chan: %d: completed %d elements, resuming\n",
+			echan->ch_num, edesc->processed);
+		edma_resume(echan->ch_num);
 	}
 
 	/*
-- 
1.7.10.1

