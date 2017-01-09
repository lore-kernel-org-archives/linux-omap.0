From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: omap-dma: Fix the port_window support
Date: Mon, 9 Jan 2017 16:50:52 +0200
Message-ID: <20170109145052.26837-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

We do not yet have users of port_window. The following errors were found
when converting the tusb6010_omap.c musb driver:

- The peripheral side must have SRC_/DST_PACKED disabled
- when configuring the burst for the peripheral side the memory side
  configuration were overwritten: d->csdp = ... -> d->csdp |= ...
- The EI and FI were configured for the wrong sides of the transfers.

With these changes and the converted tus6010_omap.c I was able to verify
that things are working as they expected to work.

Fixes: 201ac4861c19 ("dmaengine: omap-dma: Support for slave devices with data port window")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Vinod,

finaly I got one n810 from Tony and managed to boot it up so I could verify the
port_window support in omap-dma. Well, it almost worked for the first try ;)

This patch is fixing the port_window initial support in omap-dma.

It is intentional that it is done in one patch as these changes need to be done
in order to get this mode working, we would not gain anything with separate
patches regarding to bisect. But I can split it up if needed.

AFAIK the port_window support is introduced in 4.10. Would it be possible to
send this patch also so for 4.11 I can start sending the tub6010_omap conversion
to DMAengine?

Regards,
Peter

 drivers/dma/omap-dma.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 4ad101a47e0a..daf479cce691 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -938,21 +938,14 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		d->ccr |= CCR_DST_AMODE_POSTINC;
 		if (port_window) {
 			d->ccr |= CCR_SRC_AMODE_DBLIDX;
-			d->ei = 1;
-			/*
-			 * One frame covers the port_window and by  configure
-			 * the source frame index to be -1 * (port_window - 1)
-			 * we instruct the sDMA that after a frame is processed
-			 * it should move back to the start of the window.
-			 */
-			d->fi = -(port_window_bytes - 1);
 
 			if (port_window_bytes >= 64)
-				d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
+				d->csdp |= CSDP_SRC_BURST_64;
 			else if (port_window_bytes >= 32)
-				d->csdp = CSDP_SRC_BURST_32 | CSDP_SRC_PACKED;
+				d->csdp |= CSDP_SRC_BURST_32;
 			else if (port_window_bytes >= 16)
-				d->csdp = CSDP_SRC_BURST_16 | CSDP_SRC_PACKED;
+				d->csdp |= CSDP_SRC_BURST_16;
+
 		} else {
 			d->ccr |= CCR_SRC_AMODE_CONSTANT;
 		}
@@ -962,13 +955,21 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		d->ccr |= CCR_SRC_AMODE_POSTINC;
 		if (port_window) {
 			d->ccr |= CCR_DST_AMODE_DBLIDX;
+			d->ei = 1;
+			/*
+			 * One frame covers the port_window and by  configure
+			 * the source frame index to be -1 * (port_window - 1)
+			 * we instruct the sDMA that after a frame is processed
+			 * it should move back to the start of the window.
+			 */
+			d->fi = -(port_window_bytes - 1);
 
 			if (port_window_bytes >= 64)
-				d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
+				d->csdp |= CSDP_DST_BURST_64;
 			else if (port_window_bytes >= 32)
-				d->csdp = CSDP_DST_BURST_32 | CSDP_DST_PACKED;
+				d->csdp |= CSDP_DST_BURST_32;
 			else if (port_window_bytes >= 16)
-				d->csdp = CSDP_DST_BURST_16 | CSDP_DST_PACKED;
+				d->csdp |= CSDP_DST_BURST_16;
 		} else {
 			d->ccr |= CCR_DST_AMODE_CONSTANT;
 		}
@@ -1017,7 +1018,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		osg->addr = sg_dma_address(sgent);
 		osg->en = en;
 		osg->fn = sg_dma_len(sgent) / frame_bytes;
-		if (port_window && dir == DMA_MEM_TO_DEV) {
+		if (port_window && dir == DMA_DEV_TO_MEM) {
 			osg->ei = 1;
 			/*
 			 * One frame covers the port_window and by  configure
-- 
2.11.0
