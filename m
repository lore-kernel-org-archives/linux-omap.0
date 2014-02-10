From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/26] dmaengine: omap-dma: move reading of dma position to
 omap-dma.c
Date: Mon, 10 Feb 2014 15:56:23 +0000
Message-ID: <E1WCtDb-0006WQ-Uy@rmk-PC.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60016 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752157AbaBJP40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 10:56:26 -0500
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Read the current DMA position from the hardware directly rather than via
arch/arm/plat-omap/dma.c.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 7aa5ff7ab935..323eae2c9d08 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -427,6 +427,68 @@ static size_t omap_dma_desc_size_pos(struct omap_desc *d, dma_addr_t addr)
 	return size;
 }
 
+static dma_addr_t omap_dma_get_src_pos(struct omap_chan *c)
+{
+	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
+	dma_addr_t addr;
+
+	if (__dma_omap15xx(od->plat->dma_attr))
+		addr = c->plat->dma_read(CPC, c->dma_ch);
+	else
+		addr = c->plat->dma_read(CSAC, c->dma_ch);
+
+	if (od->plat->errata & DMA_ERRATA_3_3 && addr == 0)
+		addr = c->plat->dma_read(CSAC, c->dma_ch);
+
+	if (!__dma_omap15xx(od->plat->dma_attr)) {
+		/*
+		 * CDAC == 0 indicates that the DMA transfer on the channel has
+		 * not been started (no data has been transferred so far).
+		 * Return the programmed source start address in this case.
+		 */
+		if (c->plat->dma_read(CDAC, c->dma_ch))
+			addr = c->plat->dma_read(CSAC, c->dma_ch);
+		else
+			addr = c->plat->dma_read(CSSA, c->dma_ch);
+	}
+
+	if (dma_omap1())
+		addr |= c->plat->dma_read(CSSA, c->dma_ch) & 0xffff0000;
+
+	return addr;
+}
+
+static dma_addr_t omap_dma_get_dst_pos(struct omap_chan *c)
+{
+	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
+	dma_addr_t addr;
+
+	if (__dma_omap15xx(od->plat->dma_attr))
+		addr = c->plat->dma_read(CPC, c->dma_ch);
+	else
+		addr = c->plat->dma_read(CDAC, c->dma_ch);
+
+	/*
+	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
+	 * read before the DMA controller finished disabling the channel.
+	 */
+	if (!__dma_omap15xx(od->plat->dma_attr) && addr == 0) {
+		addr = c->plat->dma_read(CDAC, c->dma_ch);
+		/*
+		 * CDAC == 0 indicates that the DMA transfer on the channel has
+		 * not been started (no data has been transferred so far).
+		 * Return the programmed destination start address in this case.
+		 */
+		if (addr == 0)
+			addr = c->plat->dma_read(CDSA, c->dma_ch);
+	}
+
+	if (dma_omap1())
+		addr |= c->plat->dma_read(CDSA, c->dma_ch) & 0xffff0000;
+
+	return addr;
+}
+
 static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
@@ -448,9 +510,9 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 		dma_addr_t pos;
 
 		if (d->dir == DMA_MEM_TO_DEV)
-			pos = omap_get_dma_src_pos(c->dma_ch);
+			pos = omap_dma_get_src_pos(c);
 		else if (d->dir == DMA_DEV_TO_MEM)
-			pos = omap_get_dma_dst_pos(c->dma_ch);
+			pos = omap_dma_get_dst_pos(c);
 		else
 			pos = 0;
 
-- 
1.8.3.1

