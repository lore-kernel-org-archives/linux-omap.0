From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 12/26] dmaengine: omap-dma: improve efficiency loading
 C.SA/C.EI/C.FI registers
Date: Thu, 02 Jan 2014 15:10:50 +0000
Message-ID: <E1Vyjv8-0005Ej-VN@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54169 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751987AbaABPPM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:12 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 574f38e3fead..b4700e1f7c57 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -275,17 +275,21 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 	unsigned idx)
 {
 	struct omap_sg *sg = d->sg + idx;
+	unsigned cxsa, cxei, cxfi;
 
 	if (d->dir == DMA_DEV_TO_MEM) {
-		c->plat->dma_write(sg->addr, CDSA, c->dma_ch);
-		c->plat->dma_write(0, CDEI, c->dma_ch);
-		c->plat->dma_write(0, CDFI, c->dma_ch);
+		cxsa = CDSA;
+		cxei = CDEI;
+		cxfi = CDFI;
 	} else {
-		c->plat->dma_write(sg->addr, CSSA, c->dma_ch);
-		c->plat->dma_write(0, CSEI, c->dma_ch);
-		c->plat->dma_write(0, CSFI, c->dma_ch);
+		cxsa = CSSA;
+		cxei = CSEI;
+		cxfi = CSFI;
 	}
 
+	c->plat->dma_write(sg->addr, cxsa, c->dma_ch);
+	c->plat->dma_write(0, cxei, c->dma_ch);
+	c->plat->dma_write(0, cxfi, c->dma_ch);
 	c->plat->dma_write(sg->en, CEN, c->dma_ch);
 	c->plat->dma_write(sg->fn, CFN, c->dma_ch);
 
@@ -296,6 +300,7 @@ static void omap_dma_start_desc(struct omap_chan *c)
 {
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
 	struct omap_desc *d;
+	unsigned cxsa, cxei, cxfi;
 
 	if (!vd) {
 		c->desc = NULL;
@@ -312,15 +317,18 @@ static void omap_dma_start_desc(struct omap_chan *c)
 		c->plat->dma_write(d->ccr >> 16, CCR2, c->dma_ch);
 
 	if (d->dir == DMA_DEV_TO_MEM) {
-		c->plat->dma_write(d->dev_addr, CSSA, c->dma_ch);
-		c->plat->dma_write(0, CSEI, c->dma_ch);
-		c->plat->dma_write(d->fi, CSFI, c->dma_ch);
+		cxsa = CSSA;
+		cxei = CSEI;
+		cxfi = CSFI;
 	} else {
-		c->plat->dma_write(d->dev_addr, CDSA, c->dma_ch);
-		c->plat->dma_write(0, CDEI, c->dma_ch);
-		c->plat->dma_write(d->fi, CDFI, c->dma_ch);
+		cxsa = CDSA;
+		cxei = CDEI;
+		cxfi = CDFI;
 	}
 
+	c->plat->dma_write(d->dev_addr, cxsa, c->dma_ch);
+	c->plat->dma_write(0, cxei, c->dma_ch);
+	c->plat->dma_write(d->fi, cxfi, c->dma_ch);
 	c->plat->dma_write(d->csdp, CSDP, c->dma_ch);
 
 	omap_dma_start_sg(c, d, 0);
-- 
1.7.4.4

