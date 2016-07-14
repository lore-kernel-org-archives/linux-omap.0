From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/7] dmaengine: omap-dma: Use pointer to omap_sg in slave_sg setup's loop
Date: Thu, 14 Jul 2016 15:42:41 +0300
Message-ID: <20160714124242.7579-7-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Instead of accessing the array via index, take the pointer first and use
it to set up the omap_sg struct.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bbad82985083..8497750fa44a 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -819,9 +819,11 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	en = burst;
 	frame_bytes = es_bytes[es] * en;
 	for_each_sg(sgl, sgent, sglen, i) {
-		d->sg[i].addr = sg_dma_address(sgent);
-		d->sg[i].en = en;
-		d->sg[i].fn = sg_dma_len(sgent) / frame_bytes;
+		struct omap_sg *osg = &d->sg[i];
+
+		osg->addr = sg_dma_address(sgent);
+		osg->en = en;
+		osg->fn = sg_dma_len(sgent) / frame_bytes;
 	}
 
 	d->sglen = sglen;
-- 
2.9.1
