From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 02/31] dmaengine: PL08x: fix missed dma_transfer_direction
 fixup
Date: Thu, 07 Jun 2012 11:46:21 +0100
Message-ID: <E1ScaEP-0003jp-VE@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54157 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab2FGKq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:46:26 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

db8196df4 (dmaengine: move drivers to dma_transfer_direction) missed
fixing up the "DMA_NONE" case.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 5586d9a..f3ab004 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1287,7 +1287,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	}
 	list_add_tail(&dsg->node, &txd->dsg_list);
 
-	txd->direction = DMA_NONE;
+	txd->direction = DMA_MEM_TO_MEM;
 	dsg->src_addr = src;
 	dsg->dst_addr = dest;
 	dsg->len = len;
-- 
1.7.4.4

