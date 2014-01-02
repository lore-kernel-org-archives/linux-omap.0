From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 16/26] dmaengine: omap-dma: provide register read/write
 functions
Date: Thu, 02 Jan 2014 15:11:31 +0000
Message-ID: <E1Vyjvn-0005F0-DB@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54168 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752105AbaABPPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:09 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Provide a pair of channel register accessors, and a pair of global
accessors for non-channel specific registers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |  102 ++++++++++++++++++++++++++++-------------------
 1 files changed, 61 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 98e77adeaeb3..a1aefe9fe3fe 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -169,12 +169,32 @@ static void omap_dma_desc_free(struct virt_dma_desc *vd)
 	kfree(container_of(vd, struct omap_desc, vd));
 }
 
+static void omap_dma_glbl_write(struct omap_dmadev *od, unsigned reg, unsigned val)
+{
+	od->plat->dma_write(val, reg, 0);
+}
+
+static unsigned omap_dma_glbl_read(struct omap_dmadev *od, unsigned reg)
+{
+	return od->plat->dma_read(reg, 0);
+}
+
+static void omap_dma_chan_write(struct omap_chan *c, unsigned reg, unsigned val)
+{
+	c->plat->dma_write(val, reg, c->dma_ch);
+}
+
+static unsigned omap_dma_chan_read(struct omap_chan *c, unsigned reg)
+{
+	return c->plat->dma_read(reg, c->dma_ch);
+}
+
 static void omap_dma_clear_csr(struct omap_chan *c)
 {
 	if (dma_omap1())
-		c->plat->dma_read(CSR, c->dma_ch);
+		omap_dma_chan_read(c, CSR);
 	else
-		c->plat->dma_write(~0, CSR, c->dma_ch);
+		omap_dma_chan_write(c, CSR, ~0);
 }
 
 static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
@@ -182,17 +202,17 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
 
 	if (__dma_omap15xx(od->plat->dma_attr))
-		c->plat->dma_write(0, CPC, c->dma_ch);
+		omap_dma_chan_write(c, CPC, 0);
 	else
-		c->plat->dma_write(0, CDAC, c->dma_ch);
+		omap_dma_chan_write(c, CDAC, 0);
 
 	omap_dma_clear_csr(c);
 
 	/* Enable interrupts */
-	c->plat->dma_write(d->cicr, CICR, c->dma_ch);
+	omap_dma_chan_write(c, CICR, d->cicr);
 
 	/* Enable channel */
-	c->plat->dma_write(d->ccr | CCR_ENABLE, CCR, c->dma_ch);
+	omap_dma_chan_write(c, CCR, d->ccr | CCR_ENABLE);
 }
 
 static void omap_dma_stop(struct omap_chan *c)
@@ -201,27 +221,27 @@ static void omap_dma_stop(struct omap_chan *c)
 	uint32_t val;
 
 	/* disable irq */
-	c->plat->dma_write(0, CICR, c->dma_ch);
+	omap_dma_chan_write(c, CICR, 0);
 
 	omap_dma_clear_csr(c);
 
-	val = c->plat->dma_read(CCR, c->dma_ch);
+	val = omap_dma_chan_read(c, CCR);
 	if (od->plat->errata & DMA_ERRATA_i541 && val & CCR_TRIGGER_SRC) {
 		uint32_t sysconfig;
 		unsigned i;
 
-		sysconfig = c->plat->dma_read(OCP_SYSCONFIG, c->dma_ch);
+		sysconfig = omap_dma_glbl_read(od, OCP_SYSCONFIG);
 		val = sysconfig & ~DMA_SYSCONFIG_MIDLEMODE_MASK;
 		val |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		c->plat->dma_write(val, OCP_SYSCONFIG, c->dma_ch);
+		omap_dma_glbl_write(od, OCP_SYSCONFIG, val);
 
-		val = c->plat->dma_read(CCR, c->dma_ch);
+		val = omap_dma_chan_read(c, CCR);
 		val &= ~CCR_ENABLE;
-		c->plat->dma_write(val, CCR, c->dma_ch);
+		omap_dma_chan_write(c, CCR, val);
 
 		/* Wait for sDMA FIFO to drain */
 		for (i = 0; ; i++) {
-			val = c->plat->dma_read(CCR, c->dma_ch);
+			val = omap_dma_chan_read(c, CCR);
 			if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
 				break;
 
@@ -236,16 +256,16 @@ static void omap_dma_stop(struct omap_chan *c)
 				"DMA drain did not complete on lch %d\n",
 			        c->dma_ch);
 
-		c->plat->dma_write(sysconfig, OCP_SYSCONFIG, c->dma_ch);
+		omap_dma_glbl_write(od, OCP_SYSCONFIG, sysconfig);
 	} else {
 		val &= ~CCR_ENABLE;
-		c->plat->dma_write(val, CCR, c->dma_ch);
+		omap_dma_chan_write(c, CCR, val);
 	}
 
 	mb();
 
 	if (!__dma_omap15xx(od->plat->dma_attr) && c->cyclic) {
-		val = c->plat->dma_read(CLNK_CTRL, c->dma_ch);
+		val = omap_dma_chan_read(c, CLNK_CTRL);
 
 		if (dma_omap1())
 			val |= 1 << 14; /* set the STOP_LNK bit */
@@ -253,7 +273,7 @@ static void omap_dma_stop(struct omap_chan *c)
 		if (dma_omap2plus())
 			val &= ~CLNK_CTRL_ENABLE_LNK;
 
-		c->plat->dma_write(val, CLNK_CTRL, c->dma_ch);
+		omap_dma_chan_write(c, CLNK_CTRL, val);
 	}
 }
 
@@ -273,11 +293,11 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 		cxfi = CSFI;
 	}
 
-	c->plat->dma_write(sg->addr, cxsa, c->dma_ch);
-	c->plat->dma_write(0, cxei, c->dma_ch);
-	c->plat->dma_write(0, cxfi, c->dma_ch);
-	c->plat->dma_write(sg->en, CEN, c->dma_ch);
-	c->plat->dma_write(sg->fn, CFN, c->dma_ch);
+	omap_dma_chan_write(c, cxsa, sg->addr);
+	omap_dma_chan_write(c, cxei, 0);
+	omap_dma_chan_write(c, cxfi, 0);
+	omap_dma_chan_write(c, CEN, sg->en);
+	omap_dma_chan_write(c, CFN, sg->fn);
 
 	omap_dma_start(c, d);
 }
@@ -305,9 +325,9 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	 */
 	mb();
 
-	c->plat->dma_write(d->ccr, CCR, c->dma_ch);
+	omap_dma_chan_write(c, CCR, d->ccr);
 	if (dma_omap1())
-		c->plat->dma_write(d->ccr >> 16, CCR2, c->dma_ch);
+		omap_dma_chan_write(c, CCR2, d->ccr >> 16);
 
 	if (d->dir == DMA_DEV_TO_MEM) {
 		cxsa = CSSA;
@@ -319,11 +339,11 @@ static void omap_dma_start_desc(struct omap_chan *c)
 		cxfi = CDFI;
 	}
 
-	c->plat->dma_write(d->dev_addr, cxsa, c->dma_ch);
-	c->plat->dma_write(0, cxei, c->dma_ch);
-	c->plat->dma_write(d->fi, cxfi, c->dma_ch);
-	c->plat->dma_write(d->csdp, CSDP, c->dma_ch);
-	c->plat->dma_write(d->clnk_ctrl, CLNK_CTRL, c->dma_ch);
+	omap_dma_chan_write(c, cxsa, d->dev_addr);
+	omap_dma_chan_write(c, cxei, 0);
+	omap_dma_chan_write(c, cxfi, d->fi);
+	omap_dma_chan_write(c, CSDP, d->csdp);
+	omap_dma_chan_write(c, CLNK_CTRL, d->clnk_ctrl);
 
 	omap_dma_start_sg(c, d, 0);
 }
@@ -437,12 +457,12 @@ static dma_addr_t omap_dma_get_src_pos(struct omap_chan *c)
 	dma_addr_t addr;
 
 	if (__dma_omap15xx(od->plat->dma_attr))
-		addr = c->plat->dma_read(CPC, c->dma_ch);
+		addr = omap_dma_chan_read(c, CPC);
 	else
-		addr = c->plat->dma_read(CSAC, c->dma_ch);
+		addr = omap_dma_chan_read(c, CSAC);
 
 	if (od->plat->errata & DMA_ERRATA_3_3 && addr == 0)
-		addr = c->plat->dma_read(CSAC, c->dma_ch);
+		addr = omap_dma_chan_read(c, CSAC);
 
 	if (!__dma_omap15xx(od->plat->dma_attr)) {
 		/*
@@ -450,14 +470,14 @@ static dma_addr_t omap_dma_get_src_pos(struct omap_chan *c)
 		 * not been started (no data has been transferred so far).
 		 * Return the programmed source start address in this case.
 		 */
-		if (c->plat->dma_read(CDAC, c->dma_ch))
-			addr = c->plat->dma_read(CSAC, c->dma_ch);
+		if (omap_dma_chan_read(c, CDAC))
+			addr = omap_dma_chan_read(c, CSAC);
 		else
-			addr = c->plat->dma_read(CSSA, c->dma_ch);
+			addr = omap_dma_chan_read(c, CSSA);
 	}
 
 	if (dma_omap1())
-		addr |= c->plat->dma_read(CSSA, c->dma_ch) & 0xffff0000;
+		addr |= omap_dma_chan_read(c, CSSA) & 0xffff0000;
 
 	return addr;
 }
@@ -468,27 +488,27 @@ static dma_addr_t omap_dma_get_dst_pos(struct omap_chan *c)
 	dma_addr_t addr;
 
 	if (__dma_omap15xx(od->plat->dma_attr))
-		addr = c->plat->dma_read(CPC, c->dma_ch);
+		addr = omap_dma_chan_read(c, CPC);
 	else
-		addr = c->plat->dma_read(CDAC, c->dma_ch);
+		addr = omap_dma_chan_read(c, CDAC);
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
 	 * read before the DMA controller finished disabling the channel.
 	 */
 	if (!__dma_omap15xx(od->plat->dma_attr) && addr == 0) {
-		addr = c->plat->dma_read(CDAC, c->dma_ch);
+		addr = omap_dma_chan_read(c, CDAC);
 		/*
 		 * CDAC == 0 indicates that the DMA transfer on the channel has
 		 * not been started (no data has been transferred so far).
 		 * Return the programmed destination start address in this case.
 		 */
 		if (addr == 0)
-			addr = c->plat->dma_read(CDSA, c->dma_ch);
+			addr = omap_dma_chan_read(c, CDSA);
 	}
 
 	if (dma_omap1())
-		addr |= c->plat->dma_read(CDSA, c->dma_ch) & 0xffff0000;
+		addr |= omap_dma_chan_read(c, CDSA) & 0xffff0000;
 
 	return addr;
 }
-- 
1.7.4.4

