From: "Chandra shekhar" <x0044955@ti.com>
Subject: [RFC/PATCH  2/4] McBSP support  for 34XX
Date: Mon, 16 Jun 2008 17:51:03 +0530
Message-ID: <003c01c8cfab$71f09a90$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:55268 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499AbYFPMVL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jun 2008 08:21:11 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5GCL4qR022011
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 07:21:10 -0500
Received: from a0875540 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5GCL3G1023696
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 17:51:03 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: chandra shekhar <x0044955@ti.com>
---
 arch/arm/plat-omap/mcbsp.c        |  171 ++++++++++++++++++++++----------------
 include/asm-arm/arch-omap/mcbsp.h |    3 
 2 files changed, 99 insertions(+), 75 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2008-06-14 17:01:24.170677248 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2008-06-14 17:02:26.871714398 +0530
@@ -30,6 +30,22 @@
 
 struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
 
+void omap_mcbsp_write(u32 io_base, u16 reg, u32 val)
+{
+	if (cpu_class_is_omap1() || cpu_is_omap2420())
+		__raw_writew((u16)val, io_base + reg);
+	else
+		__raw_writel(val, io_base + reg);
+}
+
+int omap_mcbsp_read(u32 io_base, u16 reg)
+{
+	if (cpu_class_is_omap1() || cpu_is_omap2420())
+		return __raw_readw(io_base + reg);
+	else
+		return __raw_readl(io_base + reg);
+}
+
 #define omap_mcbsp_check_valid_id(id)	(mcbsp[id].pdata && \
 					mcbsp[id].pdata->ops && \
 					mcbsp[id].pdata->ops->check && \
@@ -39,31 +55,31 @@ static void omap_mcbsp_dump_reg(u8 id)
 {
 	dev_dbg(mcbsp[id].dev, "**** McBSP%d regs ****\n", mcbsp[id].id);
 	dev_dbg(mcbsp[id].dev, "DRR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DRR2));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_DRR2));
 	dev_dbg(mcbsp[id].dev, "DRR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DRR1));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_DRR1));
 	dev_dbg(mcbsp[id].dev, "DXR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DXR2));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_DXR2));
 	dev_dbg(mcbsp[id].dev, "DXR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DXR1));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_DXR1));
 	dev_dbg(mcbsp[id].dev, "SPCR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SPCR2));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_SPCR2));
 	dev_dbg(mcbsp[id].dev, "SPCR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SPCR1));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_SPCR1));
 	dev_dbg(mcbsp[id].dev, "RCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, RCR2));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_RCR2));
 	dev_dbg(mcbsp[id].dev, "RCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, RCR1));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_RCR1));
 	dev_dbg(mcbsp[id].dev, "XCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, XCR2));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_XCR2));
 	dev_dbg(mcbsp[id].dev, "XCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, XCR1));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_XCR1));
 	dev_dbg(mcbsp[id].dev, "SRGR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SRGR2));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_SRGR2));
 	dev_dbg(mcbsp[id].dev, "SRGR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SRGR1));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_SRGR1));
 	dev_dbg(mcbsp[id].dev, "PCR0:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, PCR0));
+		omap_mcbsp_read(mcbsp[id].io_base, OMAP_MCBSP_REG_PCR0));
 	dev_dbg(mcbsp[id].dev, "***********************\n");
 }
 
@@ -72,7 +88,7 @@ static irqreturn_t omap_mcbsp_tx_irq_han
 	struct omap_mcbsp *mcbsp_tx = dev_id;
 
 	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2));
+		omap_mcbsp_read(mcbsp_tx->io_base, OMAP_MCBSP_REG_SPCR2));
 
 	complete(&mcbsp_tx->tx_irq_completion);
 
@@ -84,7 +100,7 @@ static irqreturn_t omap_mcbsp_rx_irq_han
 	struct omap_mcbsp *mcbsp_rx = dev_id;
 
 	dev_dbg(mcbsp_rx->dev, "RX IRQ callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_rx->io_base, SPCR2));
+		omap_mcbsp_read(mcbsp_rx->io_base, OMAP_MCBSP_REG_SPCR2));
 
 	complete(&mcbsp_rx->rx_irq_completion);
 
@@ -96,7 +112,7 @@ static void omap_mcbsp_tx_dma_callback(i
 	struct omap_mcbsp *mcbsp_dma_tx = data;
 
 	dev_dbg(mcbsp_dma_tx->dev, "TX DMA callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_dma_tx->io_base, SPCR2));
+		omap_mcbsp_read(mcbsp_dma_tx->io_base, OMAP_MCBSP_REG_SPCR2));
 
 	/* We can free the channels */
 	omap_free_dma(mcbsp_dma_tx->dma_tx_lch);
@@ -110,7 +126,7 @@ static void omap_mcbsp_rx_dma_callback(i
 	struct omap_mcbsp *mcbsp_dma_rx = data;
 
 	dev_dbg(mcbsp_dma_rx->dev, "RX DMA callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_dma_rx->io_base, SPCR2));
+		omap_mcbsp_read(mcbsp_dma_rx->io_base, OMAP_MCBSP_REG_SPCR2));
 
 	/* We can free the channels */
 	omap_free_dma(mcbsp_dma_rx->dma_rx_lch);
@@ -139,17 +155,17 @@ void omap_mcbsp_config(unsigned int id, 
 			mcbsp[id].id, io_base);
 
 	/* We write the given config */
-	OMAP_MCBSP_WRITE(io_base, SPCR2, config->spcr2);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, config->spcr1);
-	OMAP_MCBSP_WRITE(io_base, RCR2, config->rcr2);
-	OMAP_MCBSP_WRITE(io_base, RCR1, config->rcr1);
-	OMAP_MCBSP_WRITE(io_base, XCR2, config->xcr2);
-	OMAP_MCBSP_WRITE(io_base, XCR1, config->xcr1);
-	OMAP_MCBSP_WRITE(io_base, SRGR2, config->srgr2);
-	OMAP_MCBSP_WRITE(io_base, SRGR1, config->srgr1);
-	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
-	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
-	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2, config->spcr2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1, config->spcr1);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_RCR2, config->rcr2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_RCR1, config->rcr1);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_XCR2, config->xcr2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_XCR1, config->xcr1);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SRGR2, config->srgr2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SRGR1, config->srgr1);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_MCR2, config->mcr2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_MCR1, config->mcr1);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_PCR0, config->pcr0);
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
@@ -284,25 +300,27 @@ void omap_mcbsp_start(unsigned int id)
 
 	io_base = mcbsp[id].io_base;
 
-	mcbsp[id].rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
-	mcbsp[id].tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
+	mcbsp[id].rx_word_length = (omap_mcbsp_read(io_base,
+					OMAP_MCBSP_REG_RCR1) >> 5) & 0x7;
+	mcbsp[id].tx_word_length = (omap_mcbsp_read(io_base,
+					OMAP_MCBSP_REG_XCR1) >> 5) & 0x7;
 
 	/* Start the sample generator */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 6));
+	w = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2, w | (1 << 6));
 
 	/* Enable transmitter and receiver */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | 1);
+	w = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2, w | 1);
 
-	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
+	w = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1, w | 1);
 
 	udelay(100);
 
 	/* Start frame sync */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 7));
+	w = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2, w | (1 << 7));
 
 	/* Dump McBSP Regs */
 	omap_mcbsp_dump_reg(id);
@@ -322,16 +340,16 @@ void omap_mcbsp_stop(unsigned int id)
 	io_base = mcbsp[id].io_base;
 
 	/* Reset transmitter */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1));
+	w = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2, w & ~(1));
 
 	/* Reset receiver */
-	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~(1));
+	w = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1, w & ~(1));
 
 	/* Reset the sample rate generator */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
+	w = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2, w & ~(1 << 6));
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
@@ -439,8 +457,8 @@ void omap_mcbsp_xmit_word(unsigned int i
 	wait_for_completion(&(mcbsp[id].tx_irq_completion));
 
 	if (word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, word & 0xffff);
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_DXR2, word >> 16);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_DXR1, word & 0xffff);
 }
 EXPORT_SYMBOL(omap_mcbsp_xmit_word);
 
@@ -461,8 +479,8 @@ u32 omap_mcbsp_recv_word(unsigned int id
 	wait_for_completion(&(mcbsp[id].rx_irq_completion));
 
 	if (word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_DRR2);
+	word_lsb = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_DRR1);
 
 	return (word_lsb | (word_msb << 16));
 }
@@ -488,14 +506,16 @@ int omap_mcbsp_spi_master_xmit_word_poll
 		return -EINVAL;
 
 	/* First we wait for the transmitter to be ready */
-	spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+	spcr2 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
 	while (!(spcr2 & XRDY)) {
-		spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+		spcr2 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 & (~XRST));
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+							 spcr2 & (~XRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+							 spcr2 | XRST);
 			udelay(10);
 			dev_err(mcbsp[id].dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp[id].id);
@@ -505,18 +525,20 @@ int omap_mcbsp_spi_master_xmit_word_poll
 
 	/* Now we can push the data */
 	if (tx_word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, word & 0xffff);
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_DXR2, word >> 16);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_DXR1, word & 0xffff);
 
 	/* We wait for the receiver to be ready */
-	spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+	spcr1 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1);
 	while (!(spcr1 & RRDY)) {
-		spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+		spcr1 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 & (~RRST));
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+							 spcr1 & (~RRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+							 spcr1 | RRST);
 			udelay(10);
 			dev_err(mcbsp[id].dev, "McBSP%d receiver not "
 				"ready\n", mcbsp[id].id);
@@ -526,8 +548,8 @@ int omap_mcbsp_spi_master_xmit_word_poll
 
 	/* Receiver is ready, let's read the dummy data */
 	if (rx_word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_DRR2);
+	word_lsb = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_DRR1);
 
 	return 0;
 }
@@ -553,14 +575,16 @@ int omap_mcbsp_spi_master_recv_word_poll
 		return -EINVAL;
 
 	/* First we wait for the transmitter to be ready */
-	spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+	spcr2 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
 	while (!(spcr2 & XRDY)) {
-		spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+		spcr2 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 & (~XRST));
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+							spcr2 & (~XRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+							 spcr2 | XRST);
 			udelay(10);
 			dev_err(mcbsp[id].dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp[id].id);
@@ -570,18 +594,21 @@ int omap_mcbsp_spi_master_recv_word_poll
 
 	/* We first need to enable the bus clock */
 	if (tx_word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, clock_word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, clock_word & 0xffff);
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_DXR2,
+						 clock_word >> 16);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_DXR1, clock_word & 0xffff);
 
 	/* We wait for the receiver to be ready */
-	spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+	spcr1 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1);
 	while (!(spcr1 & RRDY)) {
-		spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+		spcr1 = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 & (~RRST));
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+							 spcr1 & (~RRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
+			omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+							 spcr1 | RRST);
 			udelay(10);
 			dev_err(mcbsp[id].dev, "McBSP%d receiver not "
 				"ready\n", mcbsp[id].id);
@@ -591,8 +618,8 @@ int omap_mcbsp_spi_master_recv_word_poll
 
 	/* Receiver is ready, there is something for us */
 	if (rx_word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_DRR2);
+	word_lsb = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_DRR1);
 
 	word[0] = (word_lsb | (word_msb << 16));
 
Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-06-14 17:01:24.169677279 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-06-14 17:02:26.872714367 +0530
@@ -150,9 +150,6 @@
 
 #endif
 
-#define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) + OMAP_MCBSP_REG_##reg)
-
 #define OMAP_MCBSP_BIT(ARG)	((0x01)<<(ARG))
 
 /************************** McBSP SPCR1 bit definitions ***********************/

