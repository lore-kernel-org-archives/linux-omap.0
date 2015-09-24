From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 17/25] dmaengine: edma: Use the edma_write_slot instead open coded memcpy_toio
Date: Thu, 24 Sep 2015 13:02:04 +0300
Message-ID: <1443088932-21731-18-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

edma_write_slot() is for writing an entire paRAM slot.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index fe8cde21b497..d759abc80bef 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -949,8 +949,7 @@ static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
 	edma_setup_interrupt(ecc, channel, NULL, NULL);
 	/* REVISIT should probably take out of shadow region 0 */
 
-	memcpy_toio(ecc->base + PARM_OFFSET(channel), &dummy_paramset,
-		    PARM_SIZE);
+	edma_write_slot(ecc, channel, &dummy_paramset);
 	clear_bit(channel, ecc->edma_inuse);
 }
 
-- 
2.5.2
