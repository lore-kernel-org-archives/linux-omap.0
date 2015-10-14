From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 17/24] dmaengine: edma: Print warning when linking slots from different eDMA
Date: Wed, 14 Oct 2015 14:42:59 +0300
Message-ID: <1444822986-20562-18-git-send-email-peter.ujfalusi@ti.com>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Warning message in case of linking between paRAM slots in different eDMA
controllers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index f6653da0ee16..d33ae0b43925 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -619,6 +619,9 @@ static void edma_free_slot(struct edma_cc *ecc, unsigned slot)
  */
 static void edma_link(struct edma_cc *ecc, unsigned from, unsigned to)
 {
+	if (unlikely(EDMA_CTLR(from) != EDMA_CTLR(to)))
+		dev_warn(ecc->dev, "Ignoring eDMA instance for linking\n");
+
 	from = EDMA_CHAN_SLOT(from);
 	to = EDMA_CHAN_SLOT(to);
 	if (from >= ecc->num_slots || to >= ecc->num_slots)
-- 
2.6.1
