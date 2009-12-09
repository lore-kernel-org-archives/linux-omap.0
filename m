From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v7 2/5] [Resend] OMAP: McBSP: Modify macros/functions API for easy cache access
Date: Wed, 9 Dec 2009 21:40:15 +0100
Message-ID: <200912092140.17244.jkrzyszt@tis.icnet.pl>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl> <200912092129.30422.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:40112 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757841AbZLIUkI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 15:40:08 -0500
In-Reply-To: <200912092129.30422.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

OMAP_MCBSP_READ()/_WRITE() macros and omap_mcbsp_read()/_write() functions
accept McBSP register base address as an argument. In order to support
caching, that must be replaced with an address of the omap_mcbsp structure
that would provide addresses for both register AND cache access.

Since OMAP_ prefix seems obvious in macro names, drop it off in order to
minimize line wrapping throughout the file.

Applies on top of patch 1 from this series:
[PATCH v7 1/5] OMAP: McBSP: Use macros for all register read/write operations

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
Compile-tested with omap_3430sdp_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Line-wrapped again, sorry.

Changes since v3:
- modify API of omap_mcbsp_read()/_write() functions as well, since those will
  actually provide caching operations, not macros like before.

 arch/arm/plat-omap/mcbsp.c |  281 ++++++++++++++++++++-------------------------
 1 file changed, 125 insertions(+), 156 deletions(-)

diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mcbsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-09 15:28:33.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-09 15:29:16.000000000 +0100
@@ -30,26 +30,26 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
 
-void omap_mcbsp_write(void __iomem *io_base, u16 reg, u32 val)
+void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		__raw_writew((u16)val, io_base + reg);
+		__raw_writew((u16)val, mcbsp->io_base + reg);
 	else
-		__raw_writel(val, io_base + reg);
+		__raw_writel(val, mcbsp->io_base + reg);
 }
 
-int omap_mcbsp_read(void __iomem *io_base, u16 reg)
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg)
 {
 	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		return __raw_readw(io_base + reg);
+		return __raw_readw(mcbsp->io_base + reg);
 	else
-		return __raw_readl(io_base + reg);
+		return __raw_readl(mcbsp->io_base + reg);
 }
 
-#define OMAP_MCBSP_READ(base, reg) \
-			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val) \
-			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
+#define MCBSP_READ(mcbsp, reg) \
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg)
+#define MCBSP_WRITE(mcbsp, reg, val) \
+		omap_mcbsp_write(mcbsp, OMAP_MCBSP_REG_##reg, val)
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
@@ -60,31 +60,31 @@ static void omap_mcbsp_dump_reg(u8 id)
 
 	dev_dbg(mcbsp->dev, "**** McBSP%d regs ****\n", mcbsp->id);
 	dev_dbg(mcbsp->dev, "DRR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DRR2));
+			MCBSP_READ(mcbsp, DRR2));
 	dev_dbg(mcbsp->dev, "DRR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DRR1));
+			MCBSP_READ(mcbsp, DRR1));
 	dev_dbg(mcbsp->dev, "DXR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DXR2));
+			MCBSP_READ(mcbsp, DXR2));
 	dev_dbg(mcbsp->dev, "DXR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DXR1));
+			MCBSP_READ(mcbsp, DXR1));
 	dev_dbg(mcbsp->dev, "SPCR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SPCR2));
+			MCBSP_READ(mcbsp, SPCR2));
 	dev_dbg(mcbsp->dev, "SPCR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SPCR1));
+			MCBSP_READ(mcbsp, SPCR1));
 	dev_dbg(mcbsp->dev, "RCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, RCR2));
+			MCBSP_READ(mcbsp, RCR2));
 	dev_dbg(mcbsp->dev, "RCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, RCR1));
+			MCBSP_READ(mcbsp, RCR1));
 	dev_dbg(mcbsp->dev, "XCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, XCR2));
+			MCBSP_READ(mcbsp, XCR2));
 	dev_dbg(mcbsp->dev, "XCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, XCR1));
+			MCBSP_READ(mcbsp, XCR1));
 	dev_dbg(mcbsp->dev, "SRGR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SRGR2));
+			MCBSP_READ(mcbsp, SRGR2));
 	dev_dbg(mcbsp->dev, "SRGR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SRGR1));
+			MCBSP_READ(mcbsp, SRGR1));
 	dev_dbg(mcbsp->dev, "PCR0:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, PCR0));
+			MCBSP_READ(mcbsp, PCR0));
 	dev_dbg(mcbsp->dev, "***********************\n");
 }
 
@@ -93,15 +93,14 @@ static irqreturn_t omap_mcbsp_tx_irq_han
 	struct omap_mcbsp *mcbsp_tx = dev_id;
 	u16 irqst_spcr2;
 
-	irqst_spcr2 = OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2);
+	irqst_spcr2 = MCBSP_READ(mcbsp_tx, SPCR2);
 	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n", irqst_spcr2);
 
 	if (irqst_spcr2 & XSYNC_ERR) {
 		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
 			irqst_spcr2);
 		/* Writing zero to XSYNC_ERR clears the IRQ */
-		OMAP_MCBSP_WRITE(mcbsp_tx->io_base, SPCR2,
-			irqst_spcr2 & ~(XSYNC_ERR));
+		MCBSP_WRITE(mcbsp_tx, SPCR2, irqst_spcr2 & ~(XSYNC_ERR));
 	} else {
 		complete(&mcbsp_tx->tx_irq_completion);
 	}
@@ -114,15 +113,14 @@ static irqreturn_t omap_mcbsp_rx_irq_han
 	struct omap_mcbsp *mcbsp_rx = dev_id;
 	u16 irqst_spcr1;
 
-	irqst_spcr1 = OMAP_MCBSP_READ(mcbsp_rx->io_base, SPCR1);
+	irqst_spcr1 = MCBSP_READ(mcbsp_rx, SPCR1);
 	dev_dbg(mcbsp_rx->dev, "RX IRQ callback : 0x%x\n", irqst_spcr1);
 
 	if (irqst_spcr1 & RSYNC_ERR) {
 		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
 			irqst_spcr1);
 		/* Writing zero to RSYNC_ERR clears the IRQ */
-		OMAP_MCBSP_WRITE(mcbsp_rx->io_base, SPCR1,
-			irqst_spcr1 & ~(RSYNC_ERR));
+		MCBSP_WRITE(mcbsp_rx, SPCR1, irqst_spcr1 & ~(RSYNC_ERR));
 	} else {
 		complete(&mcbsp_rx->tx_irq_completion);
 	}
@@ -135,7 +133,7 @@ static void omap_mcbsp_tx_dma_callback(i
 	struct omap_mcbsp *mcbsp_dma_tx = data;
 
 	dev_dbg(mcbsp_dma_tx->dev, "TX DMA callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_dma_tx->io_base, SPCR2));
+		MCBSP_READ(mcbsp_dma_tx, SPCR2));
 
 	/* We can free the channels */
 	omap_free_dma(mcbsp_dma_tx->dma_tx_lch);
@@ -149,7 +147,7 @@ static void omap_mcbsp_rx_dma_callback(i
 	struct omap_mcbsp *mcbsp_dma_rx = data;
 
 	dev_dbg(mcbsp_dma_rx->dev, "RX DMA callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_dma_rx->io_base, SPCR2));
+		MCBSP_READ(mcbsp_dma_rx, SPCR2));
 
 	/* We can free the channels */
 	omap_free_dma(mcbsp_dma_rx->dma_rx_lch);
@@ -167,7 +165,6 @@ static void omap_mcbsp_rx_dma_callback(i
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -175,25 +172,24 @@ void omap_mcbsp_config(unsigned int id, 
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	io_base = mcbsp->io_base;
 	dev_dbg(mcbsp->dev, "Configuring McBSP%d  phys_base: 0x%08lx\n",
 			mcbsp->id, mcbsp->phys_base);
 
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
+	MCBSP_WRITE(mcbsp, SPCR2, config->spcr2);
+	MCBSP_WRITE(mcbsp, SPCR1, config->spcr1);
+	MCBSP_WRITE(mcbsp, RCR2, config->rcr2);
+	MCBSP_WRITE(mcbsp, RCR1, config->rcr1);
+	MCBSP_WRITE(mcbsp, XCR2, config->xcr2);
+	MCBSP_WRITE(mcbsp, XCR1, config->xcr1);
+	MCBSP_WRITE(mcbsp, SRGR2, config->srgr2);
+	MCBSP_WRITE(mcbsp, SRGR1, config->srgr1);
+	MCBSP_WRITE(mcbsp, MCR2, config->mcr2);
+	MCBSP_WRITE(mcbsp, MCR1, config->mcr1);
+	MCBSP_WRITE(mcbsp, PCR0, config->pcr0);
 	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
-		OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
+		MCBSP_WRITE(mcbsp, XCCR, config->xccr);
+		MCBSP_WRITE(mcbsp, RCCR, config->rccr);
 	}
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
@@ -207,7 +203,6 @@ EXPORT_SYMBOL(omap_mcbsp_config);
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 
 	if (!cpu_is_omap34xx())
 		return;
@@ -217,9 +212,8 @@ void omap_mcbsp_set_tx_threshold(unsigne
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
-	OMAP_MCBSP_WRITE(io_base, THRSH2, threshold);
+	MCBSP_WRITE(mcbsp, THRSH2, threshold);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
 
@@ -231,7 +225,6 @@ EXPORT_SYMBOL(omap_mcbsp_set_tx_threshol
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 
 	if (!cpu_is_omap34xx())
 		return;
@@ -241,9 +234,8 @@ void omap_mcbsp_set_rx_threshold(unsigne
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
-	OMAP_MCBSP_WRITE(io_base, THRSH1, threshold);
+	MCBSP_WRITE(mcbsp, THRSH1, threshold);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
 
@@ -313,19 +305,18 @@ static inline void omap34xx_mcbsp_reques
 	if (cpu_is_omap34xx()) {
 		u16 syscon;
 
-		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon = MCBSP_READ(mcbsp, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
 					CLOCKACTIVITY(0x02));
-			OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN,
-					XRDYEN | RRDYEN);
+			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 		} else {
 			syscon |= SIDLEMODE(0x01);
 		}
 
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		MCBSP_WRITE(mcbsp, SYSCON, syscon);
 	}
 }
 
@@ -337,7 +328,7 @@ static inline void omap34xx_mcbsp_free(s
 	if (cpu_is_omap34xx()) {
 		u16 syscon;
 
-		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon = MCBSP_READ(mcbsp, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		/*
 		 * HW bug workaround - If no_idle mode is taken, we need to
@@ -345,12 +336,12 @@ static inline void omap34xx_mcbsp_free(s
 		 * device will not hit retention anymore.
 		 */
 		syscon |= SIDLEMODE(0x02);
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		MCBSP_WRITE(mcbsp, SYSCON, syscon);
 
 		syscon &= ~(SIDLEMODE(0x03));
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		MCBSP_WRITE(mcbsp, SYSCON, syscon);
 
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
+		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 	}
 }
 #else
@@ -424,8 +415,8 @@ int omap_mcbsp_request(unsigned int id)
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
 	 */
-	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR1, 0);
-	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR2, 0);
+	MCBSP_WRITE(mcbsp, SPCR1, 0);
+	MCBSP_WRITE(mcbsp, SPCR2, 0);
 
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* We need to get IRQs here */
@@ -501,7 +492,6 @@ EXPORT_SYMBOL(omap_mcbsp_free);
 void omap_mcbsp_start(unsigned int id, int tx, int rx)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	int idle;
 	u16 w;
 
@@ -510,28 +500,26 @@ void omap_mcbsp_start(unsigned int id, i
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
-	mcbsp->rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
-	mcbsp->tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
+	mcbsp->rx_word_length = (MCBSP_READ(mcbsp, RCR1) >> 5) & 0x7;
+	mcbsp->tx_word_length = (MCBSP_READ(mcbsp, XCR1) >> 5) & 0x7;
 
-	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
-		  OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
+	idle = !((MCBSP_READ(mcbsp, SPCR2) | MCBSP_READ(mcbsp, SPCR1)) & 1);
 
 	if (idle) {
 		/* Start the sample generator */
-		w = OMAP_MCBSP_READ(io_base, SPCR2);
-		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 6));
+		w = MCBSP_READ(mcbsp, SPCR2);
+		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 6));
 	}
 
 	/* Enable transmitter and receiver */
 	tx &= 1;
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | tx);
+	w = MCBSP_READ(mcbsp, SPCR2);
+	MCBSP_WRITE(mcbsp, SPCR2, w | tx);
 
 	rx &= 1;
-	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w | rx);
+	w = MCBSP_READ(mcbsp, SPCR1);
+	MCBSP_WRITE(mcbsp, SPCR1, w | rx);
 
 	/*
 	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
@@ -543,18 +531,18 @@ void omap_mcbsp_start(unsigned int id, i
 
 	if (idle) {
 		/* Start frame sync */
-		w = OMAP_MCBSP_READ(io_base, SPCR2);
-		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 7));
+		w = MCBSP_READ(mcbsp, SPCR2);
+		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7));
 	}
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		/* Release the transmitter and receiver */
-		w = OMAP_MCBSP_READ(io_base, XCCR);
+		w = MCBSP_READ(mcbsp, XCCR);
 		w &= ~(tx ? XDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, XCCR, w);
-		w = OMAP_MCBSP_READ(io_base, RCCR);
+		MCBSP_WRITE(mcbsp, XCCR, w);
+		w = MCBSP_READ(mcbsp, RCCR);
 		w &= ~(rx ? RDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, RCCR, w);
+		MCBSP_WRITE(mcbsp, RCCR, w);
 	}
 
 	/* Dump McBSP Regs */
@@ -565,7 +553,6 @@ EXPORT_SYMBOL(omap_mcbsp_start);
 void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	int idle;
 	u16 w;
 
@@ -575,35 +562,33 @@ void omap_mcbsp_stop(unsigned int id, in
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
 	/* Reset transmitter */
 	tx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		w = OMAP_MCBSP_READ(io_base, XCCR);
+		w = MCBSP_READ(mcbsp, XCCR);
 		w |= (tx ? XDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, XCCR, w);
+		MCBSP_WRITE(mcbsp, XCCR, w);
 	}
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~tx);
+	w = MCBSP_READ(mcbsp, SPCR2);
+	MCBSP_WRITE(mcbsp, SPCR2, w & ~tx);
 
 	/* Reset receiver */
 	rx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		w = OMAP_MCBSP_READ(io_base, RCCR);
+		w = MCBSP_READ(mcbsp, RCCR);
 		w |= (rx ? RDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, RCCR, w);
+		MCBSP_WRITE(mcbsp, RCCR, w);
 	}
-	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~rx);
+	w = MCBSP_READ(mcbsp, SPCR1);
+	MCBSP_WRITE(mcbsp, SPCR1, w & ~rx);
 
-	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
-		  OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
+	idle = !((MCBSP_READ(mcbsp, SPCR2) | MCBSP_READ(mcbsp, SPCR1)) & 1);
 
 	if (idle) {
 		/* Reset the sample rate generator */
-		w = OMAP_MCBSP_READ(io_base, SPCR2);
-		OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
+		w = MCBSP_READ(mcbsp, SPCR2);
+		MCBSP_WRITE(mcbsp, SPCR2, w & ~(1 << 6));
 	}
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
@@ -612,7 +597,6 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -620,28 +604,25 @@ int omap_mcbsp_pollwrite(unsigned int id
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	base = mcbsp->io_base;
 
-	OMAP_MCBSP_WRITE(base, DXR1, buf);
+	MCBSP_WRITE(mcbsp, DXR1, buf);
 	/* if frame sync error - clear the error */
-	if (OMAP_MCBSP_READ(base, SPCR2) & XSYNC_ERR) {
+	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
 		/* clear error */
-		OMAP_MCBSP_WRITE(base, SPCR2,
-				OMAP_MCBSP_READ(base, SPCR2) & (~XSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR2,
+				MCBSP_READ(mcbsp, SPCR2) & (~XSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
 		/* wait for transmit confirmation */
 		int attemps = 0;
-		while (!(OMAP_MCBSP_READ(base, SPCR2) & XRDY)) {
+		while (!(MCBSP_READ(mcbsp, SPCR2) & XRDY)) {
 			if (attemps++ > 1000) {
-				OMAP_MCBSP_WRITE(base, SPCR2,
-						OMAP_MCBSP_READ(base, SPCR2) &
-						(~XRST));
+				MCBSP_WRITE(mcbsp, SPCR2,
+					    MCBSP_READ(mcbsp, SPCR2) & (~XRST));
 				udelay(10);
-				OMAP_MCBSP_WRITE(base, SPCR2,
-						OMAP_MCBSP_READ(base, SPCR2) |
-						(XRST));
+				MCBSP_WRITE(mcbsp, SPCR2,
+					    MCBSP_READ(mcbsp, SPCR2) | (XRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not write to"
 					" McBSP%d Register\n", mcbsp->id);
@@ -657,7 +638,6 @@ EXPORT_SYMBOL(omap_mcbsp_pollwrite);
 int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -665,26 +645,23 @@ int omap_mcbsp_pollread(unsigned int id,
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	base = mcbsp->io_base;
 	/* if frame sync error - clear the error */
-	if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
+	if (MCBSP_READ(mcbsp, SPCR1) & RSYNC_ERR) {
 		/* clear error */
-		OMAP_MCBSP_WRITE(base, SPCR1,
-				OMAP_MCBSP_READ(base, SPCR1) & (~RSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR1,
+				MCBSP_READ(mcbsp, SPCR1) & (~RSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
 		/* wait for recieve confirmation */
 		int attemps = 0;
-		while (!(OMAP_MCBSP_READ(base, SPCR1) & RRDY)) {
+		while (!(MCBSP_READ(mcbsp, SPCR1) & RRDY)) {
 			if (attemps++ > 1000) {
-				OMAP_MCBSP_WRITE(base, SPCR1,
-						OMAP_MCBSP_READ(base, SPCR1) &
-						(~RRST));
+				MCBSP_WRITE(mcbsp, SPCR1,
+					    MCBSP_READ(mcbsp, SPCR1) & (~RRST));
 				udelay(10);
-				OMAP_MCBSP_WRITE(base, SPCR1,
-						OMAP_MCBSP_READ(base, SPCR1) |
-						(RRST));
+				MCBSP_WRITE(mcbsp, SPCR1,
+					    MCBSP_READ(mcbsp, SPCR1) | (RRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not read from"
 					" McBSP%d Register\n", mcbsp->id);
@@ -692,7 +669,7 @@ int omap_mcbsp_pollread(unsigned int id,
 			}
 		}
 	}
-	*buf = OMAP_MCBSP_READ(base, DRR1);
+	*buf = MCBSP_READ(mcbsp, DRR1);
 
 	return 0;
 }
@@ -704,7 +681,6 @@ EXPORT_SYMBOL(omap_mcbsp_pollread);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	omap_mcbsp_word_length word_length;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -713,21 +689,19 @@ void omap_mcbsp_xmit_word(unsigned int i
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 	word_length = mcbsp->tx_word_length;
 
 	wait_for_completion(&mcbsp->tx_irq_completion);
 
 	if (word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, word & 0xffff);
+		MCBSP_WRITE(mcbsp, DXR2, word >> 16);
+	MCBSP_WRITE(mcbsp, DXR1, word & 0xffff);
 }
 EXPORT_SYMBOL(omap_mcbsp_xmit_word);
 
 u32 omap_mcbsp_recv_word(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	u16 word_lsb, word_msb = 0;
 	omap_mcbsp_word_length word_length;
 
@@ -738,13 +712,12 @@ u32 omap_mcbsp_recv_word(unsigned int id
 	mcbsp = id_to_mcbsp_ptr(id);
 
 	word_length = mcbsp->rx_word_length;
-	io_base = mcbsp->io_base;
 
 	wait_for_completion(&mcbsp->rx_irq_completion);
 
 	if (word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = MCBSP_READ(mcbsp, DRR2);
+	word_lsb = MCBSP_READ(mcbsp, DRR1);
 
 	return (word_lsb | (word_msb << 16));
 }
@@ -753,7 +726,6 @@ EXPORT_SYMBOL(omap_mcbsp_recv_word);
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
 	omap_mcbsp_word_length rx_word_length;
 	u16 spcr2, spcr1, attempts = 0, word_lsb, word_msb = 0;
@@ -763,7 +735,6 @@ int omap_mcbsp_spi_master_xmit_word_poll
 		return -ENODEV;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 	tx_word_length = mcbsp->tx_word_length;
 	rx_word_length = mcbsp->rx_word_length;
 
@@ -771,14 +742,14 @@ int omap_mcbsp_spi_master_xmit_word_poll
 		return -EINVAL;
 
 	/* First we wait for the transmitter to be ready */
-	spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+	spcr2 = MCBSP_READ(mcbsp, SPCR2);
 	while (!(spcr2 & XRDY)) {
-		spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+		spcr2 = MCBSP_READ(mcbsp, SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 & (~XRST));
+			MCBSP_WRITE(mcbsp, SPCR2, spcr2 & (~XRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
+			MCBSP_WRITE(mcbsp, SPCR2, spcr2 | XRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp->id);
@@ -788,18 +759,18 @@ int omap_mcbsp_spi_master_xmit_word_poll
 
 	/* Now we can push the data */
 	if (tx_word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, word & 0xffff);
+		MCBSP_WRITE(mcbsp, DXR2, word >> 16);
+	MCBSP_WRITE(mcbsp, DXR1, word & 0xffff);
 
 	/* We wait for the receiver to be ready */
-	spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+	spcr1 = MCBSP_READ(mcbsp, SPCR1);
 	while (!(spcr1 & RRDY)) {
-		spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+		spcr1 = MCBSP_READ(mcbsp, SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 & (~RRST));
+			MCBSP_WRITE(mcbsp, SPCR1, spcr1 & (~RRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
+			MCBSP_WRITE(mcbsp, SPCR1, spcr1 | RRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d receiver not "
 				"ready\n", mcbsp->id);
@@ -809,8 +780,8 @@ int omap_mcbsp_spi_master_xmit_word_poll
 
 	/* Receiver is ready, let's read the dummy data */
 	if (rx_word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = MCBSP_READ(mcbsp, DRR2);
+	word_lsb = MCBSP_READ(mcbsp, DRR1);
 
 	return 0;
 }
@@ -820,7 +791,6 @@ int omap_mcbsp_spi_master_recv_word_poll
 {
 	struct omap_mcbsp *mcbsp;
 	u32 clock_word = 0;
-	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
 	omap_mcbsp_word_length rx_word_length;
 	u16 spcr2, spcr1, attempts = 0, word_lsb, word_msb = 0;
@@ -831,7 +801,6 @@ int omap_mcbsp_spi_master_recv_word_poll
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
 	tx_word_length = mcbsp->tx_word_length;
 	rx_word_length = mcbsp->rx_word_length;
@@ -840,14 +809,14 @@ int omap_mcbsp_spi_master_recv_word_poll
 		return -EINVAL;
 
 	/* First we wait for the transmitter to be ready */
-	spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+	spcr2 = MCBSP_READ(mcbsp, SPCR2);
 	while (!(spcr2 & XRDY)) {
-		spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+		spcr2 = MCBSP_READ(mcbsp, SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 & (~XRST));
+			MCBSP_WRITE(mcbsp, SPCR2, spcr2 & (~XRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
+			MCBSP_WRITE(mcbsp, SPCR2, spcr2 | XRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp->id);
@@ -857,18 +826,18 @@ int omap_mcbsp_spi_master_recv_word_poll
 
 	/* We first need to enable the bus clock */
 	if (tx_word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, clock_word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, clock_word & 0xffff);
+		MCBSP_WRITE(mcbsp, DXR2, clock_word >> 16);
+	MCBSP_WRITE(mcbsp, DXR1, clock_word & 0xffff);
 
 	/* We wait for the receiver to be ready */
-	spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+	spcr1 = MCBSP_READ(mcbsp, SPCR1);
 	while (!(spcr1 & RRDY)) {
-		spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+		spcr1 = MCBSP_READ(mcbsp, SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 & (~RRST));
+			MCBSP_WRITE(mcbsp, SPCR1, spcr1 & (~RRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
+			MCBSP_WRITE(mcbsp, SPCR1, spcr1 | RRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d receiver not "
 				"ready\n", mcbsp->id);
@@ -878,8 +847,8 @@ int omap_mcbsp_spi_master_recv_word_poll
 
 	/* Receiver is ready, there is something for us */
 	if (rx_word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = MCBSP_READ(mcbsp, DRR2);
+	word_lsb = MCBSP_READ(mcbsp, DRR1);
 
 	word[0] = (word_lsb | (word_msb << 16));
 
