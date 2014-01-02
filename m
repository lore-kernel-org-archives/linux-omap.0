From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 17/26] dmaengine: omap-dma: cleanup errata 3.3 handling
Date: Thu, 02 Jan 2014 15:11:41 +0000
Message-ID: <E1Vyjvx-0005F4-Gd@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54127 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751136AbaABPMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:12:10 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   52 ++++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index a1aefe9fe3fe..04631e6732c4 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -451,28 +451,39 @@ static size_t omap_dma_desc_size_pos(struct omap_desc *d, dma_addr_t addr)
 	return size;
 }
 
+/*
+ * OMAP 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
+ * read before the DMA controller finished disabling the channel.
+ */
+static uint32_t omap_dma_chan_read_3_3(struct omap_chan *c, unsigned reg)
+{
+	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
+	uint32_t val;
+
+	val = omap_dma_chan_read(c, reg);
+	if (val == 0 && od->plat->errata & DMA_ERRATA_3_3)
+		val = omap_dma_chan_read(c, reg);
+
+	return val;
+}
+
 static dma_addr_t omap_dma_get_src_pos(struct omap_chan *c)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
-	dma_addr_t addr;
+	dma_addr_t addr, cdac;
 
-	if (__dma_omap15xx(od->plat->dma_attr))
+	if (__dma_omap15xx(od->plat->dma_attr)) {
 		addr = omap_dma_chan_read(c, CPC);
-	else
-		addr = omap_dma_chan_read(c, CSAC);
-
-	if (od->plat->errata & DMA_ERRATA_3_3 && addr == 0)
-		addr = omap_dma_chan_read(c, CSAC);
+	} else {
+		addr = omap_dma_chan_read_3_3(c, CSAC);
+		cdac = omap_dma_chan_read_3_3(c, CDAC);
 
-	if (!__dma_omap15xx(od->plat->dma_attr)) {
 		/*
 		 * CDAC == 0 indicates that the DMA transfer on the channel has
 		 * not been started (no data has been transferred so far).
 		 * Return the programmed source start address in this case.
 		 */
-		if (omap_dma_chan_read(c, CDAC))
-			addr = omap_dma_chan_read(c, CSAC);
-		else
+		if (cdac == 0)
 			addr = omap_dma_chan_read(c, CSSA);
 	}
 
@@ -487,21 +498,16 @@ static dma_addr_t omap_dma_get_dst_pos(struct omap_chan *c)
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
 	dma_addr_t addr;
 
-	if (__dma_omap15xx(od->plat->dma_attr))
+	if (__dma_omap15xx(od->plat->dma_attr)) {
 		addr = omap_dma_chan_read(c, CPC);
-	else
-		addr = omap_dma_chan_read(c, CDAC);
+	} else {
+		addr = omap_dma_chan_read_3_3(c, CDAC);
 
-	/*
-	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	if (!__dma_omap15xx(od->plat->dma_attr) && addr == 0) {
-		addr = omap_dma_chan_read(c, CDAC);
 		/*
-		 * CDAC == 0 indicates that the DMA transfer on the channel has
-		 * not been started (no data has been transferred so far).
-		 * Return the programmed destination start address in this case.
+		 * CDAC == 0 indicates that the DMA transfer on the channel
+		 * has not been started (no data has been transferred so
+		 * far).  Return the programmed destination start address in
+		 * this case.
 		 */
 		if (addr == 0)
 			addr = omap_dma_chan_read(c, CDSA);
-- 
1.7.4.4

