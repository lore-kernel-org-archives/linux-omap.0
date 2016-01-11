From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Fix paRAM slot allocation for entry channel 0
Date: Mon, 11 Jan 2016 10:38:01 +0200
Message-ID: <1452501481-5543-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

edma_alloc_slot was not checking the channel mapping support existence when
slot 0 has been requested (used as entry slot for channel/event 0).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 50584015e046..d92d65549406 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -484,7 +484,7 @@ static void edma_read_slot(struct edma_cc *ecc, unsigned slot,
  */
 static int edma_alloc_slot(struct edma_cc *ecc, int slot)
 {
-	if (slot > 0) {
+	if (slot >= 0) {
 		slot = EDMA_CHAN_SLOT(slot);
 		/* Requesting entry paRAM slot for a HW triggered channel. */
 		if (ecc->chmap_exist && slot < ecc->num_channels)
-- 
2.6.4
