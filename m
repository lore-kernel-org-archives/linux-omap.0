From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/9] dmaengine: omap-dma: port_window support correction for both direction
Date: Fri, 12 May 2017 16:57:44 +0300
Message-ID: <20170512135752.1800-2-peter.ujfalusi@ti.com>
References: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dmaengine@vger.kernel.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

When the port_window support was verified it was done on setup where only
the MEM_TO_DEV direction was enabled. This got un-noticed and thus only
this direction worked.

Now that I have managed to get a setup to verify both direction it turned
out that the setup was incorrect:
omap_desc members are settings for the slave port while the omap_sg members
apply to the memory side of the sDMA setup.

Fixes: 527a27591312 ("dmaengine: omap-dma: Fix the port_window support")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: dmaengine@vger.kernel.org
Cc: dan.j.williams@intel.com
Cc: vinod.koul@intel.com
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/dma/omap-dma.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index daf479cce691..8c1665c8fe33 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -916,12 +916,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		return NULL;
 	}
 
-	/* When the port_window is used, one frame must cover the window */
-	if (port_window) {
-		burst = port_window;
-		port_window_bytes = port_window * es_bytes[es];
-	}
-
 	/* Now allocate and setup the descriptor. */
 	d = kzalloc(sizeof(*d) + sglen * sizeof(d->sg[0]), GFP_ATOMIC);
 	if (!d)
@@ -931,6 +925,21 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	d->dev_addr = dev_addr;
 	d->es = es;
 
+	/* When the port_window is used, one frame must cover the window */
+	if (port_window) {
+		burst = port_window;
+		port_window_bytes = port_window * es_bytes[es];
+
+		d->ei = 1;
+		/*
+		 * One frame covers the port_window and by  configure
+		 * the source frame index to be -1 * (port_window - 1)
+		 * we instruct the sDMA that after a frame is processed
+		 * it should move back to the start of the window.
+		 */
+		d->fi = -(port_window_bytes - 1);
+	}
+
 	d->ccr = c->ccr | CCR_SYNC_FRAME;
 	if (dir == DMA_DEV_TO_MEM) {
 		d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
@@ -955,14 +964,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		d->ccr |= CCR_SRC_AMODE_POSTINC;
 		if (port_window) {
 			d->ccr |= CCR_DST_AMODE_DBLIDX;
-			d->ei = 1;
-			/*
-			 * One frame covers the port_window and by  configure
-			 * the source frame index to be -1 * (port_window - 1)
-			 * we instruct the sDMA that after a frame is processed
-			 * it should move back to the start of the window.
-			 */
-			d->fi = -(port_window_bytes - 1);
 
 			if (port_window_bytes >= 64)
 				d->csdp |= CSDP_DST_BURST_64;
@@ -1018,16 +1019,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		osg->addr = sg_dma_address(sgent);
 		osg->en = en;
 		osg->fn = sg_dma_len(sgent) / frame_bytes;
-		if (port_window && dir == DMA_DEV_TO_MEM) {
-			osg->ei = 1;
-			/*
-			 * One frame covers the port_window and by  configure
-			 * the source frame index to be -1 * (port_window - 1)
-			 * we instruct the sDMA that after a frame is processed
-			 * it should move back to the start of the window.
-			 */
-			osg->fi = -(port_window_bytes - 1);
-		}
 
 		if (d->using_ll) {
 			osg->t2_desc = dma_pool_alloc(od->desc_pool, GFP_ATOMIC,
-- 
2.13.0
