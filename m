From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH v2] OMAP: McBSP: Use register cache
Date: Tue, 24 Nov 2009 12:31:16 +0100
Message-ID: <200911241231.18333.jkrzyszt@tis.icnet.pl>
References: <200908121239.26346.jkrzyszt@tis.icnet.pl> <20091123235355.GJ22923@atomide.com> <20091124095923.4f60044c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:51545 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932668AbZKXLcP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 06:32:15 -0500
In-Reply-To: <20091124095923.4f60044c.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Change the way McBSP registers are updated: use cached values instead of
relying upon those read back from the device.

With this patch, I have finally managed to get rid of all random
playback/recording hangups on my OMAP1510 based Amstrad Delta hardware. Before
that, values read back from McBSP registers to be used for updating them
happened to be errornous.

>From the hardware side, the issue appeared to be caused by a relatively high
power requirements of an external USB adapter connected to the board's printer
dedicated USB port.

I think there is one important point that makes this patch worth of applying,
apart from my hardware quality. With the current code, if it ever happens to
any machine, no matter if OMAP1510 or newer, to read incorrect value from a
McBSP register, this wrong value will get written back without any checking.
That can lead to hardware damage if, for example, an input pin is turned into
output as a result.

Created against linux-omap for-next,
commit 2963c21fab52bfa8227da7f22864db393ebbc858

Tested on Amstrad Delta
Compile tested with omap_generic_2420_defconfig

Signed-off-by: Janusz Krzysztofik

---

Tuesday 24 November 2009 08:59:23 Jarkko Nikula wrote:
>
> > > > > +	OMAP_MCBSP_WRITE(io_base, SPCR2, reg_cache->spcr2 =
> > > > > config->spcr2); +	OMAP_MCBSP_WRITE(io_base, SPCR1, reg_cache->spcr1
> > > > > = config->spcr1);
>
> ...
>
> > > > > -	mcbsp->rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) &
> > > > > 0x7; -	mcbsp->tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >>
> > > > > 5) & 0x7; +	mcbsp->rx_word_length = (reg_cache->rcr1 >> 5) & 0x7;
> > > > > +	mcbsp->tx_word_length = (reg_cache->xcr1 >> 5) & 0x7;
>
> IMO these would be cleaner if you embed cache handling into read and
> write functions only. Probably reading could have explicit _read and
> read_cache functions when code is dealing with the status bits and when
> just updating some cached bits.

Hi Jarkko,

Could you please have a look at this modified version? It seems to address
your comment above more or less closely.

Thanks,
Janusz

diff -upr git.orig/arch/arm/plat-omap/include/plat/mcbsp.h git/arch/arm/plat-omap/include/plat/mcbsp.h
--- git.orig/arch/arm/plat-omap/include/plat/mcbsp.h	2009-11-21 00:38:46.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-11-24 02:38:32.000000000 +0100
@@ -415,6 +415,11 @@ struct omap_mcbsp {
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
+#ifdef CONFIG_ARCH_OMAP1
+	u16 reg_cache[OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1];
+#else
+	u32 reg_cache[OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1];
+#endif
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
Only in git/arch/arm/plat-omap/include/plat: mcbsp.h.orig
diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mcbsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-11-21 00:38:46.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-11-24 12:22:42.000000000 +0100
@@ -46,10 +46,21 @@ int omap_mcbsp_read(void __iomem *io_bas
 		return __raw_readl(io_base + reg);
 }
 
-#define OMAP_MCBSP_READ(base, reg) \
-			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val) \
-			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
+#define OMAP_MCBSP_READ(mcbsp, reg) \
+		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(mcbsp, reg, val) \
+		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
+
+#define OMAP_MCBSP_CREAD(mcbsp, reg) \
+		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1])
+#define OMAP_MCBSP_CWRITE(mcbsp, reg, val) \
+		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
+		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
+			= val)
+
+#define OMAP_MCBSP_BREAD(mcbsp, reg) \
+		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
+			= OMAP_MCBSP_READ(mcbsp->io_base, reg))
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
@@ -60,31 +71,31 @@ static void omap_mcbsp_dump_reg(u8 id)
 
 	dev_dbg(mcbsp->dev, "**** McBSP%d regs ****\n", mcbsp->id);
 	dev_dbg(mcbsp->dev, "DRR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DRR2));
+			OMAP_MCBSP_READ(mcbsp, DRR2));
 	dev_dbg(mcbsp->dev, "DRR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DRR1));
+			OMAP_MCBSP_READ(mcbsp, DRR1));
 	dev_dbg(mcbsp->dev, "DXR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DXR2));
+			OMAP_MCBSP_READ(mcbsp, DXR2));
 	dev_dbg(mcbsp->dev, "DXR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, DXR1));
+			OMAP_MCBSP_READ(mcbsp, DXR1));
 	dev_dbg(mcbsp->dev, "SPCR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SPCR2));
+			OMAP_MCBSP_READ(mcbsp, SPCR2));
 	dev_dbg(mcbsp->dev, "SPCR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SPCR1));
+			OMAP_MCBSP_READ(mcbsp, SPCR1));
 	dev_dbg(mcbsp->dev, "RCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, RCR2));
+			OMAP_MCBSP_READ(mcbsp, RCR2));
 	dev_dbg(mcbsp->dev, "RCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, RCR1));
+			OMAP_MCBSP_READ(mcbsp, RCR1));
 	dev_dbg(mcbsp->dev, "XCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, XCR2));
+			OMAP_MCBSP_READ(mcbsp, XCR2));
 	dev_dbg(mcbsp->dev, "XCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, XCR1));
+			OMAP_MCBSP_READ(mcbsp, XCR1));
 	dev_dbg(mcbsp->dev, "SRGR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SRGR2));
+			OMAP_MCBSP_READ(mcbsp, SRGR2));
 	dev_dbg(mcbsp->dev, "SRGR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, SRGR1));
+			OMAP_MCBSP_READ(mcbsp, SRGR1));
 	dev_dbg(mcbsp->dev, "PCR0:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp->io_base, PCR0));
+			OMAP_MCBSP_READ(mcbsp, PCR0));
 	dev_dbg(mcbsp->dev, "***********************\n");
 }
 
@@ -93,15 +104,15 @@ static irqreturn_t omap_mcbsp_tx_irq_han
 	struct omap_mcbsp *mcbsp_tx = dev_id;
 	u16 irqst_spcr2;
 
-	irqst_spcr2 = OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2);
+	irqst_spcr2 = OMAP_MCBSP_READ(mcbsp_tx, SPCR2);
 	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n", irqst_spcr2);
 
 	if (irqst_spcr2 & XSYNC_ERR) {
 		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
 			irqst_spcr2);
 		/* Writing zero to XSYNC_ERR clears the IRQ */
-		OMAP_MCBSP_WRITE(mcbsp_tx->io_base, SPCR2,
-			irqst_spcr2 & ~(XSYNC_ERR));
+		OMAP_MCBSP_CWRITE(mcbsp_tx, SPCR2,
+			OMAP_MCBSP_CREAD(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
 	} else {
 		complete(&mcbsp_tx->tx_irq_completion);
 	}
@@ -114,15 +125,15 @@ static irqreturn_t omap_mcbsp_rx_irq_han
 	struct omap_mcbsp *mcbsp_rx = dev_id;
 	u16 irqst_spcr1;
 
-	irqst_spcr1 = OMAP_MCBSP_READ(mcbsp_rx->io_base, SPCR1);
+	irqst_spcr1 = OMAP_MCBSP_READ(mcbsp_rx, SPCR1);
 	dev_dbg(mcbsp_rx->dev, "RX IRQ callback : 0x%x\n", irqst_spcr1);
 
 	if (irqst_spcr1 & RSYNC_ERR) {
 		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
 			irqst_spcr1);
 		/* Writing zero to RSYNC_ERR clears the IRQ */
-		OMAP_MCBSP_WRITE(mcbsp_rx->io_base, SPCR1,
-			irqst_spcr1 & ~(RSYNC_ERR));
+		OMAP_MCBSP_CWRITE(mcbsp_rx, SPCR1,
+			OMAP_MCBSP_CREAD(mcbsp_rx, SPCR1) & ~(RSYNC_ERR));
 	} else {
 		complete(&mcbsp_rx->tx_irq_completion);
 	}
@@ -135,7 +146,7 @@ static void omap_mcbsp_tx_dma_callback(i
 	struct omap_mcbsp *mcbsp_dma_tx = data;
 
 	dev_dbg(mcbsp_dma_tx->dev, "TX DMA callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_dma_tx->io_base, SPCR2));
+		OMAP_MCBSP_READ(mcbsp_dma_tx, SPCR2));
 
 	/* We can free the channels */
 	omap_free_dma(mcbsp_dma_tx->dma_tx_lch);
@@ -149,7 +160,7 @@ static void omap_mcbsp_rx_dma_callback(i
 	struct omap_mcbsp *mcbsp_dma_rx = data;
 
 	dev_dbg(mcbsp_dma_rx->dev, "RX DMA callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_dma_rx->io_base, SPCR2));
+		OMAP_MCBSP_READ(mcbsp_dma_rx, SPCR2));
 
 	/* We can free the channels */
 	omap_free_dma(mcbsp_dma_rx->dma_rx_lch);
@@ -167,7 +178,6 @@ static void omap_mcbsp_rx_dma_callback(i
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -175,25 +185,24 @@ void omap_mcbsp_config(unsigned int id, 
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
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR2, config->spcr2);
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR1, config->spcr1);
+	OMAP_MCBSP_CWRITE(mcbsp, RCR2, config->rcr2);
+	OMAP_MCBSP_CWRITE(mcbsp, RCR1, config->rcr1);
+	OMAP_MCBSP_CWRITE(mcbsp, XCR2, config->xcr2);
+	OMAP_MCBSP_CWRITE(mcbsp, XCR1, config->xcr1);
+	OMAP_MCBSP_CWRITE(mcbsp, SRGR2, config->srgr2);
+	OMAP_MCBSP_CWRITE(mcbsp, SRGR1, config->srgr1);
+	OMAP_MCBSP_CWRITE(mcbsp, MCR2, config->mcr2);
+	OMAP_MCBSP_CWRITE(mcbsp, MCR1, config->mcr1);
+	OMAP_MCBSP_CWRITE(mcbsp, PCR0, config->pcr0);
 	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
-		OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
+		OMAP_MCBSP_CWRITE(mcbsp, XCCR, config->xccr);
+		OMAP_MCBSP_CWRITE(mcbsp, RCCR, config->rccr);
 	}
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
@@ -207,7 +216,6 @@ EXPORT_SYMBOL(omap_mcbsp_config);
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 
 	if (!cpu_is_omap34xx())
 		return;
@@ -217,9 +225,8 @@ void omap_mcbsp_set_tx_threshold(unsigne
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
-	OMAP_MCBSP_WRITE(io_base, THRSH2, threshold);
+	OMAP_MCBSP_CWRITE(mcbsp, THRSH2, threshold);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
 
@@ -231,7 +238,6 @@ EXPORT_SYMBOL(omap_mcbsp_set_tx_threshol
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 
 	if (!cpu_is_omap34xx())
 		return;
@@ -241,9 +247,8 @@ void omap_mcbsp_set_rx_threshold(unsigne
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
-	OMAP_MCBSP_WRITE(io_base, THRSH1, threshold);
+	OMAP_MCBSP_CWRITE(mcbsp, THRSH1, threshold);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
 
@@ -313,19 +318,18 @@ static inline void omap34xx_mcbsp_reques
 	if (cpu_is_omap34xx()) {
 		u16 syscon;
 
-		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon = OMAP_MCBSP_READ(mcbsp, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
 					CLOCKACTIVITY(0x02));
-			OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN,
-					XRDYEN | RRDYEN);
+			OMAP_MCBSP_CWRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 		} else {
 			syscon |= SIDLEMODE(0x01);
 		}
 
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		OMAP_MCBSP_CWRITE(mcbsp, SYSCON, syscon);
 	}
 }
 
@@ -337,7 +341,7 @@ static inline void omap34xx_mcbsp_free(s
 	if (cpu_is_omap34xx()) {
 		u16 syscon;
 
-		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon = OMAP_MCBSP_READ(mcbsp, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		/*
 		 * HW bug workaround - If no_idle mode is taken, we need to
@@ -345,12 +349,12 @@ static inline void omap34xx_mcbsp_free(s
 		 * device will not hit retention anymore.
 		 */
 		syscon |= SIDLEMODE(0x02);
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		OMAP_MCBSP_CWRITE(mcbsp, SYSCON, syscon);
 
 		syscon &= ~(SIDLEMODE(0x03));
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		OMAP_MCBSP_CWRITE(mcbsp, SYSCON, syscon);
 
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
+		OMAP_MCBSP_CWRITE(mcbsp, WAKEUPEN, 0);
 	}
 }
 #else
@@ -424,8 +428,8 @@ int omap_mcbsp_request(unsigned int id)
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
 	 */
-	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR1, 0);
-	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR2, 0);
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR1, 0);
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR2, 0);
 
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* We need to get IRQs here */
@@ -501,7 +505,6 @@ EXPORT_SYMBOL(omap_mcbsp_free);
 void omap_mcbsp_start(unsigned int id, int tx, int rx)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	int idle;
 	u16 w;
 
@@ -510,28 +513,27 @@ void omap_mcbsp_start(unsigned int id, i
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
-	mcbsp->rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
-	mcbsp->tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
+	mcbsp->rx_word_length = (OMAP_MCBSP_CREAD(mcbsp, RCR1) >> 5) & 0x7;
+	mcbsp->tx_word_length = (OMAP_MCBSP_CREAD(mcbsp, XCR1) >> 5) & 0x7;
 
-	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
-		  OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
+	idle = !((OMAP_MCBSP_CREAD(mcbsp, SPCR2) |
+		  OMAP_MCBSP_CREAD(mcbsp, SPCR1)) & 1);
 
 	if (idle) {
 		/* Start the sample generator */
-		w = OMAP_MCBSP_READ(io_base, SPCR2);
-		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 6));
+		w = OMAP_MCBSP_CREAD(mcbsp, SPCR2);
+		OMAP_MCBSP_CWRITE(mcbsp, SPCR2, w | (1 << 6));
 	}
 
 	/* Enable transmitter and receiver */
 	tx &= 1;
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | tx);
+	w = OMAP_MCBSP_CREAD(mcbsp, SPCR2);
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR2, w | tx);
 
 	rx &= 1;
-	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w | rx);
+	w = OMAP_MCBSP_CREAD(mcbsp, SPCR1);
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR1, w | rx);
 
 	/*
 	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
@@ -543,18 +545,18 @@ void omap_mcbsp_start(unsigned int id, i
 
 	if (idle) {
 		/* Start frame sync */
-		w = OMAP_MCBSP_READ(io_base, SPCR2);
-		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 7));
+		w = OMAP_MCBSP_CREAD(mcbsp, SPCR2);
+		OMAP_MCBSP_CWRITE(mcbsp, SPCR2, w | (1 << 7));
 	}
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		/* Release the transmitter and receiver */
-		w = OMAP_MCBSP_READ(io_base, XCCR);
+		w = OMAP_MCBSP_CREAD(mcbsp, XCCR);
 		w &= ~(tx ? XDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, XCCR, w);
-		w = OMAP_MCBSP_READ(io_base, RCCR);
+		OMAP_MCBSP_CWRITE(mcbsp, XCCR, w);
+		w = OMAP_MCBSP_CREAD(mcbsp, RCCR);
 		w &= ~(rx ? RDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, RCCR, w);
+		OMAP_MCBSP_CWRITE(mcbsp, RCCR, w);
 	}
 
 	/* Dump McBSP Regs */
@@ -565,7 +567,6 @@ EXPORT_SYMBOL(omap_mcbsp_start);
 void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	int idle;
 	u16 w;
 
@@ -575,35 +576,34 @@ void omap_mcbsp_stop(unsigned int id, in
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
 	/* Reset transmitter */
 	tx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		w = OMAP_MCBSP_READ(io_base, XCCR);
+		w = OMAP_MCBSP_CREAD(mcbsp, XCCR);
 		w |= (tx ? XDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, XCCR, w);
+		OMAP_MCBSP_CWRITE(mcbsp, XCCR, w);
 	}
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~tx);
+	w = OMAP_MCBSP_CREAD(mcbsp, SPCR2);
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR2, w & ~tx);
 
 	/* Reset receiver */
 	rx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		w = OMAP_MCBSP_READ(io_base, RCCR);
+		w = OMAP_MCBSP_CREAD(mcbsp, RCCR);
 		w |= (rx ? RDISABLE : 0);
-		OMAP_MCBSP_WRITE(io_base, RCCR, w);
+		OMAP_MCBSP_CWRITE(mcbsp, RCCR, w);
 	}
-	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~rx);
+	w = OMAP_MCBSP_CREAD(mcbsp, SPCR1);
+	OMAP_MCBSP_CWRITE(mcbsp, SPCR1, w & ~rx);
 
-	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
-		  OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
+	idle = !((OMAP_MCBSP_CREAD(mcbsp, SPCR2) |
+		  OMAP_MCBSP_CREAD(mcbsp, SPCR1)) & 1);
 
 	if (idle) {
 		/* Reset the sample rate generator */
-		w = OMAP_MCBSP_READ(io_base, SPCR2);
-		OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
+		w = OMAP_MCBSP_CREAD(mcbsp, SPCR2);
+		OMAP_MCBSP_CWRITE(mcbsp, SPCR2, w & ~(1 << 6));
 	}
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
@@ -612,7 +612,6 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -620,28 +619,27 @@ int omap_mcbsp_pollwrite(unsigned int id
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	base = mcbsp->io_base;
 
-	writew(buf, base + OMAP_MCBSP_REG_DXR1);
+	OMAP_MCBSP_WRITE(mcbsp, DXR1, buf);
 	/* if frame sync error - clear the error */
-	if (readw(base + OMAP_MCBSP_REG_SPCR2) & XSYNC_ERR) {
+	if (OMAP_MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
 		/* clear error */
-		writew(readw(base + OMAP_MCBSP_REG_SPCR2) & (~XSYNC_ERR),
-		       base + OMAP_MCBSP_REG_SPCR2);
+		OMAP_MCBSP_CWRITE(mcbsp, SPCR2,
+				OMAP_MCBSP_CREAD(mcbsp, SPCR2) & (~XSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
 		/* wait for transmit confirmation */
 		int attemps = 0;
-		while (!(readw(base + OMAP_MCBSP_REG_SPCR2) & XRDY)) {
+		while (!(OMAP_MCBSP_READ(mcbsp, SPCR2) & XRDY)) {
 			if (attemps++ > 1000) {
-				writew(readw(base + OMAP_MCBSP_REG_SPCR2) &
-				       (~XRST),
-				       base + OMAP_MCBSP_REG_SPCR2);
+				OMAP_MCBSP_CWRITE(mcbsp, SPCR2,
+						OMAP_MCBSP_CREAD(mcbsp, SPCR2) &
+						(~XRST));
 				udelay(10);
-				writew(readw(base + OMAP_MCBSP_REG_SPCR2) |
-				       (XRST),
-				       base + OMAP_MCBSP_REG_SPCR2);
+				OMAP_MCBSP_CWRITE(mcbsp, SPCR2,
+						OMAP_MCBSP_CREAD(mcbsp, SPCR2) |
+						(XRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not write to"
 					" McBSP%d Register\n", mcbsp->id);
@@ -657,7 +655,6 @@ EXPORT_SYMBOL(omap_mcbsp_pollwrite);
 int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -665,26 +662,25 @@ int omap_mcbsp_pollread(unsigned int id,
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	base = mcbsp->io_base;
 	/* if frame sync error - clear the error */
-	if (readw(base + OMAP_MCBSP_REG_SPCR1) & RSYNC_ERR) {
+	if (OMAP_MCBSP_READ(mcbsp, SPCR1) & RSYNC_ERR) {
 		/* clear error */
-		writew(readw(base + OMAP_MCBSP_REG_SPCR1) & (~RSYNC_ERR),
-		       base + OMAP_MCBSP_REG_SPCR1);
+		OMAP_MCBSP_CWRITE(mcbsp, SPCR1,
+				OMAP_MCBSP_CREAD(mcbsp, SPCR1) & (~RSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
 		/* wait for recieve confirmation */
 		int attemps = 0;
-		while (!(readw(base + OMAP_MCBSP_REG_SPCR1) & RRDY)) {
+		while (!(OMAP_MCBSP_READ(mcbsp, SPCR1) & RRDY)) {
 			if (attemps++ > 1000) {
-				writew(readw(base + OMAP_MCBSP_REG_SPCR1) &
-				       (~RRST),
-				       base + OMAP_MCBSP_REG_SPCR1);
+				OMAP_MCBSP_CWRITE(mcbsp, SPCR1,
+						OMAP_MCBSP_CREAD(mcbsp, SPCR1) &
+						(~RRST));
 				udelay(10);
-				writew(readw(base + OMAP_MCBSP_REG_SPCR1) |
-				       (RRST),
-				       base + OMAP_MCBSP_REG_SPCR1);
+				OMAP_MCBSP_CWRITE(mcbsp, SPCR1,
+						OMAP_MCBSP_CREAD(mcbsp, SPCR1) |
+						(RRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not read from"
 					" McBSP%d Register\n", mcbsp->id);
@@ -692,7 +688,7 @@ int omap_mcbsp_pollread(unsigned int id,
 			}
 		}
 	}
-	*buf = readw(base + OMAP_MCBSP_REG_DRR1);
+	*buf = OMAP_MCBSP_READ(mcbsp, DRR1);
 
 	return 0;
 }
@@ -704,7 +700,6 @@ EXPORT_SYMBOL(omap_mcbsp_pollread);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	omap_mcbsp_word_length word_length;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -713,21 +708,19 @@ void omap_mcbsp_xmit_word(unsigned int i
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 	word_length = mcbsp->tx_word_length;
 
 	wait_for_completion(&mcbsp->tx_irq_completion);
 
 	if (word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, word & 0xffff);
+		OMAP_MCBSP_WRITE(mcbsp, DXR2, word >> 16);
+	OMAP_MCBSP_WRITE(mcbsp, DXR1, word & 0xffff);
 }
 EXPORT_SYMBOL(omap_mcbsp_xmit_word);
 
 u32 omap_mcbsp_recv_word(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	u16 word_lsb, word_msb = 0;
 	omap_mcbsp_word_length word_length;
 
@@ -738,13 +731,12 @@ u32 omap_mcbsp_recv_word(unsigned int id
 	mcbsp = id_to_mcbsp_ptr(id);
 
 	word_length = mcbsp->rx_word_length;
-	io_base = mcbsp->io_base;
 
 	wait_for_completion(&mcbsp->rx_irq_completion);
 
 	if (word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = OMAP_MCBSP_READ(mcbsp, DRR2);
+	word_lsb = OMAP_MCBSP_READ(mcbsp, DRR1);
 
 	return (word_lsb | (word_msb << 16));
 }
@@ -753,7 +745,6 @@ EXPORT_SYMBOL(omap_mcbsp_recv_word);
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 {
 	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
 	omap_mcbsp_word_length rx_word_length;
 	u16 spcr2, spcr1, attempts = 0, word_lsb, word_msb = 0;
@@ -763,7 +754,6 @@ int omap_mcbsp_spi_master_xmit_word_poll
 		return -ENODEV;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 	tx_word_length = mcbsp->tx_word_length;
 	rx_word_length = mcbsp->rx_word_length;
 
@@ -771,14 +761,16 @@ int omap_mcbsp_spi_master_xmit_word_poll
 		return -EINVAL;
 
 	/* First we wait for the transmitter to be ready */
-	spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+	spcr2 = OMAP_MCBSP_READ(mcbsp, SPCR2);
 	while (!(spcr2 & XRDY)) {
-		spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+		spcr2 = OMAP_MCBSP_READ(mcbsp, SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 & (~XRST));
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR2,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR2) & (~XRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR2,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR2) | XRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp->id);
@@ -788,18 +780,20 @@ int omap_mcbsp_spi_master_xmit_word_poll
 
 	/* Now we can push the data */
 	if (tx_word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, word & 0xffff);
+		OMAP_MCBSP_WRITE(mcbsp, DXR2, word >> 16);
+	OMAP_MCBSP_WRITE(mcbsp, DXR1, word & 0xffff);
 
 	/* We wait for the receiver to be ready */
-	spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+	spcr1 = OMAP_MCBSP_READ(mcbsp, SPCR1);
 	while (!(spcr1 & RRDY)) {
-		spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+		spcr1 = OMAP_MCBSP_READ(mcbsp, SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 & (~RRST));
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR1,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR1) & (~RRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR1,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR1) | RRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d receiver not "
 				"ready\n", mcbsp->id);
@@ -809,8 +803,8 @@ int omap_mcbsp_spi_master_xmit_word_poll
 
 	/* Receiver is ready, let's read the dummy data */
 	if (rx_word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = OMAP_MCBSP_READ(mcbsp, DRR2);
+	word_lsb = OMAP_MCBSP_READ(mcbsp, DRR1);
 
 	return 0;
 }
@@ -820,7 +814,6 @@ int omap_mcbsp_spi_master_recv_word_poll
 {
 	struct omap_mcbsp *mcbsp;
 	u32 clock_word = 0;
-	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
 	omap_mcbsp_word_length rx_word_length;
 	u16 spcr2, spcr1, attempts = 0, word_lsb, word_msb = 0;
@@ -831,7 +824,6 @@ int omap_mcbsp_spi_master_recv_word_poll
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
 
 	tx_word_length = mcbsp->tx_word_length;
 	rx_word_length = mcbsp->rx_word_length;
@@ -840,14 +832,16 @@ int omap_mcbsp_spi_master_recv_word_poll
 		return -EINVAL;
 
 	/* First we wait for the transmitter to be ready */
-	spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+	spcr2 = OMAP_MCBSP_READ(mcbsp, SPCR2);
 	while (!(spcr2 & XRDY)) {
-		spcr2 = OMAP_MCBSP_READ(io_base, SPCR2);
+		spcr2 = OMAP_MCBSP_READ(mcbsp, SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 & (~XRST));
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR2,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR2) & (~XRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR2,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR2) | XRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp->id);
@@ -857,18 +851,20 @@ int omap_mcbsp_spi_master_recv_word_poll
 
 	/* We first need to enable the bus clock */
 	if (tx_word_length > OMAP_MCBSP_WORD_16)
-		OMAP_MCBSP_WRITE(io_base, DXR2, clock_word >> 16);
-	OMAP_MCBSP_WRITE(io_base, DXR1, clock_word & 0xffff);
+		OMAP_MCBSP_WRITE(mcbsp, DXR2, clock_word >> 16);
+	OMAP_MCBSP_WRITE(mcbsp, DXR1, clock_word & 0xffff);
 
 	/* We wait for the receiver to be ready */
-	spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+	spcr1 = OMAP_MCBSP_READ(mcbsp, SPCR1);
 	while (!(spcr1 & RRDY)) {
-		spcr1 = OMAP_MCBSP_READ(io_base, SPCR1);
+		spcr1 = OMAP_MCBSP_READ(mcbsp, SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 & (~RRST));
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR1,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR1) & (~RRST));
 			udelay(10);
-			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
+			OMAP_MCBSP_CWRITE(mcbsp, SPCR1,
+				    OMAP_MCBSP_CREAD(mcbsp, SPCR1) | RRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d receiver not "
 				"ready\n", mcbsp->id);
@@ -878,8 +874,8 @@ int omap_mcbsp_spi_master_recv_word_poll
 
 	/* Receiver is ready, there is something for us */
 	if (rx_word_length > OMAP_MCBSP_WORD_16)
-		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
-	word_lsb = OMAP_MCBSP_READ(io_base, DRR1);
+		word_msb = OMAP_MCBSP_READ(mcbsp, DRR2);
+	word_lsb = OMAP_MCBSP_READ(mcbsp, DRR1);
 
 	word[0] = (word_lsb | (word_msb << 16));
 
