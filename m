From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP: Remove __REG access in DMA code
Date: Wed, 30 Apr 2008 10:14:00 -0700
Message-ID: <1209575641-25613-3-git-send-email-tony@atomide.com>
References: omap-dma-2008-04-30
 <1209575641-25613-1-git-send-email-tony@atomide.com>
 <1209575641-25613-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54299 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928AbYD3ROJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 13:14:09 -0400
In-Reply-To: <1209575641-25613-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Remove __REG access in DMA code, use dma_read/write instead:

- dynamically set the omap_dma_base based on the omap type

- omap_read/write becomes dma_read/write
- dma channel registers are read with dma_ch_read/write

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c         |  486 ++++++++++++++++++++++++--------------
 drivers/mtd/nand/omap-hw.c       |    8 -
 drivers/usb/gadget/omap_udc.c    |   43 +---
 include/asm-arm/arch-omap/dma.h  |  200 +++++++++-------
 sound/arm/omap/omap-alsa-dma.c   |    3 +-
 sound/oss/omap-audio-dma-intfc.c |    3 +-
 6 files changed, 428 insertions(+), 315 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index d0cfe2b..5a8e0e0 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -126,6 +126,7 @@ static int dma_chan_count;
 
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
+void __iomem *omap_dma_base;
 
 static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
 	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
@@ -142,6 +143,24 @@ static inline void omap_enable_channel_irq(int lch);
 #define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
 						__func__);
 
+#define dma_read(reg)						\
+({									\
+	u32 __val;							\
+	if (cpu_class_is_omap1())					\
+		__val = __raw_readw(omap_dma_base + OMAP1_DMA_##reg);	\
+	else								\
+		__val = __raw_readl(omap_dma_base + OMAP_DMA4_##reg);	\
+	__val;								\
+})
+
+#define dma_write(val, reg)						\
+({									\
+	if (cpu_class_is_omap1())					\
+		__raw_writew((u16)val, omap_dma_base + OMAP1_DMA_##reg);\
+	else								\
+		__raw_writel((val), omap_dma_base + OMAP_DMA4_##reg);	\
+})
+
 #ifdef CONFIG_ARCH_OMAP15XX
 /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
 int omap_dma_in_1510_mode(void)
@@ -176,13 +195,14 @@ static inline void set_gdma_dev(int req, int dev)
 #define set_gdma_dev(req, dev)	do {} while (0)
 #endif
 
+/* Omap1 only */
 static void clear_lch_regs(int lch)
 {
 	int i;
-	u32 lch_base = OMAP_DMA_BASE + lch * 0x40;
+	void __iomem *lch_base = omap_dma_base + OMAP1_DMA_CH_BASE(lch);
 
 	for (i = 0; i < 0x2c; i += 2)
-		omap_writew(0, lch_base + i);
+		__raw_writew(0, lch_base + i);
 }
 
 void omap_set_dma_priority(int lch, int dst_port, int priority)
@@ -215,10 +235,14 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 	}
 
 	if (cpu_class_is_omap2()) {
+		u32 ccr;
+
+		ccr = dma_read(CCR(lch));
 		if (priority)
-			OMAP_DMA_CCR_REG(lch) |= (1 << 6);
+			ccr |= (1 << 6);
 		else
-			OMAP_DMA_CCR_REG(lch) &= ~(1 << 6);
+			ccr &= ~(1 << 6);
+		dma_write(ccr, CCR(lch));
 	}
 }
 
@@ -226,22 +250,33 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 				  int frame_count, int sync_mode,
 				  int dma_trigger, int src_or_dst_synch)
 {
-	OMAP_DMA_CSDP_REG(lch) &= ~0x03;
-	OMAP_DMA_CSDP_REG(lch) |= data_type;
+	u32 l;
+
+	l = dma_read(CSDP(lch));
+	l &= ~0x03;
+	l |= data_type;
+	dma_write(l, CSDP(lch));
 
 	if (cpu_class_is_omap1()) {
-		OMAP_DMA_CCR_REG(lch) &= ~(1 << 5);
+		u16 ccr;
+
+		ccr = dma_read(CCR(lch));
+		ccr &= ~(1 << 5);
 		if (sync_mode == OMAP_DMA_SYNC_FRAME)
-			OMAP_DMA_CCR_REG(lch) |= 1 << 5;
+			ccr |= 1 << 5;
+		dma_write(ccr, CCR(lch));
 
-		OMAP1_DMA_CCR2_REG(lch) &= ~(1 << 2);
+		ccr = dma_read(CCR2(lch));
+		ccr &= ~(1 << 2);
 		if (sync_mode == OMAP_DMA_SYNC_BLOCK)
-			OMAP1_DMA_CCR2_REG(lch) |= 1 << 2;
+			ccr |= 1 << 2;
+		dma_write(ccr, CCR2(lch));
 	}
 
 	if (cpu_class_is_omap2() && dma_trigger) {
-		u32 val = OMAP_DMA_CCR_REG(lch);
+		u32 val;
 
+		val = dma_read(CCR(lch));
 		val &= ~(3 << 19);
 		if (dma_trigger > 63)
 			val |= 1 << 20;
@@ -266,11 +301,11 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 		else
 			val &= ~(1 << 24);	/* dest synch */
 
-		OMAP_DMA_CCR_REG(lch) = val;
+		dma_write(val, CCR(lch));
 	}
 
-	OMAP_DMA_CEN_REG(lch) = elem_count;
-	OMAP_DMA_CFN_REG(lch) = frame_count;
+	dma_write(elem_count, CEN(lch));
+	dma_write(frame_count, CFN(lch));
 }
 
 void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
@@ -284,7 +319,9 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		return;
 	}
 
-	w = OMAP1_DMA_CCR2_REG(lch) & ~0x03;
+	w = dma_read(CCR2(lch));
+	w &= ~0x03;
+
 	switch (mode) {
 	case OMAP_DMA_CONSTANT_FILL:
 		w |= 0x01;
@@ -297,23 +334,28 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 	default:
 		BUG();
 	}
-	OMAP1_DMA_CCR2_REG(lch) = w;
+	dma_write(w, CCR2(lch));
 
-	w = OMAP1_DMA_LCH_CTRL_REG(lch) & ~0x0f;
+	w = dma_read(LCH_CTRL(lch));
+	w &= ~0x0f;
 	/* Default is channel type 2D */
 	if (mode) {
-		OMAP1_DMA_COLOR_L_REG(lch) = (u16)color;
-		OMAP1_DMA_COLOR_U_REG(lch) = (u16)(color >> 16);
+		dma_write((u16)color, COLOR_L(lch));
+		dma_write((u16)(color >> 16), COLOR_U(lch));
 		w |= 1;		/* Channel type G */
 	}
-	OMAP1_DMA_LCH_CTRL_REG(lch) = w;
+	dma_write(w, LCH_CTRL(lch));
 }
 
 void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 {
 	if (cpu_class_is_omap2()) {
-		OMAP_DMA_CSDP_REG(lch) &= ~(0x3 << 16);
-		OMAP_DMA_CSDP_REG(lch) |= (mode << 16);
+		u32 csdp;
+
+		csdp = dma_read(CSDP(lch));
+		csdp &= ~(0x3 << 16);
+		csdp |= (mode << 16);
+		dma_write(csdp, CSDP(lch));
 	}
 }
 
@@ -323,23 +365,37 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 			     int src_ei, int src_fi)
 {
 	if (cpu_class_is_omap1()) {
-		OMAP_DMA_CSDP_REG(lch) &= ~(0x1f << 2);
-		OMAP_DMA_CSDP_REG(lch) |= src_port << 2;
-	}
+		u16 w;
 
-	OMAP_DMA_CCR_REG(lch) &= ~(0x03 << 12);
-	OMAP_DMA_CCR_REG(lch) |= src_amode << 12;
+		w = dma_read(CSDP(lch));
+		w &= ~(0x1f << 2);
+		w |= src_port << 2;
+		dma_write(w, CSDP(lch));
 
-	if (cpu_class_is_omap1()) {
-		OMAP1_DMA_CSSA_U_REG(lch) = src_start >> 16;
-		OMAP1_DMA_CSSA_L_REG(lch) = src_start;
+		w = dma_read(CCR(lch));
+		w &= ~(0x03 << 12);
+		w |= src_amode << 12;
+		dma_write(w, CCR(lch));
+
+		dma_write(src_start >> 16, CSSA_U(lch));
+		dma_write((u16)src_start, CSSA_L(lch));
+
+		dma_write(src_ei, CSEI(lch));
+		dma_write(src_fi, CSFI(lch));
 	}
 
-	if (cpu_class_is_omap2())
-		OMAP2_DMA_CSSA_REG(lch) = src_start;
+	if (cpu_class_is_omap2()) {
+		u32 l;
 
-	OMAP_DMA_CSEI_REG(lch) = src_ei;
-	OMAP_DMA_CSFI_REG(lch) = src_fi;
+		l = dma_read(CCR(lch));
+		l &= ~(0x03 << 12);
+		l |= src_amode << 12;
+		dma_write(l, CCR(lch));
+
+		dma_write(src_start, CSSA(lch));
+		dma_write(src_ei, CSEI(lch));
+		dma_write(src_fi, CSFI(lch));
+	}
 }
 
 void omap_set_dma_params(int lch, struct omap_dma_channel_params * params)
@@ -366,21 +422,28 @@ void omap_set_dma_src_index(int lch, int eidx, int fidx)
 		REVISIT_24XX();
 		return;
 	}
-	OMAP_DMA_CSEI_REG(lch) = eidx;
-	OMAP_DMA_CSFI_REG(lch) = fidx;
+	dma_write(eidx, CSEI(lch));
+	dma_write(fidx, CSFI(lch));
 }
 
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
-	OMAP_DMA_CSDP_REG(lch) &= ~(1 << 6);
+	u32 l;
+
+	l = dma_read(CSDP(lch));
+	l &= ~(1 << 6);
 	if (enable)
-		OMAP_DMA_CSDP_REG(lch) |= (1 << 6);
+		l |= (1 << 6);
+	dma_write(l, CSDP(lch));
 }
 
 void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
 	unsigned int burst = 0;
-	OMAP_DMA_CSDP_REG(lch) &= ~(0x03 << 7);
+	u32 l;
+
+	l = dma_read(CSDP(lch));
+	l &= ~(0x03 << 7);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
@@ -411,7 +474,9 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	default:
 		BUG();
 	}
-	OMAP_DMA_CSDP_REG(lch) |= (burst << 7);
+
+	l |= (burst << 7);
+	dma_write(l, CSDP(lch));
 }
 
 /* Note that dest_port is only for OMAP1 */
@@ -419,24 +484,30 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 			      unsigned long dest_start,
 			      int dst_ei, int dst_fi)
 {
+	u32 l;
+
 	if (cpu_class_is_omap1()) {
-		OMAP_DMA_CSDP_REG(lch) &= ~(0x1f << 9);
-		OMAP_DMA_CSDP_REG(lch) |= dest_port << 9;
+		l = dma_read(CSDP(lch));
+		l &= ~(0x1f << 9);
+		l |= dest_port << 9;
+		dma_write(l, CSDP(lch));
 	}
 
-	OMAP_DMA_CCR_REG(lch) &= ~(0x03 << 14);
-	OMAP_DMA_CCR_REG(lch) |= dest_amode << 14;
+	l = dma_read(CCR(lch));
+	l &= ~(0x03 << 14);
+	l |= dest_amode << 14;
+	dma_write(l, CCR(lch));
 
 	if (cpu_class_is_omap1()) {
-		OMAP1_DMA_CDSA_U_REG(lch) = dest_start >> 16;
-		OMAP1_DMA_CDSA_L_REG(lch) = dest_start;
+		dma_write(dest_start >> 16, CDSA_U(lch));
+		dma_write(dest_start, CDSA_L(lch));
 	}
 
 	if (cpu_class_is_omap2())
-		OMAP2_DMA_CDSA_REG(lch) = dest_start;
+		dma_write(dest_start, CDSA(lch));
 
-	OMAP_DMA_CDEI_REG(lch) = dst_ei;
-	OMAP_DMA_CDFI_REG(lch) = dst_fi;
+	dma_write(dst_ei, CDEI(lch));
+	dma_write(dst_fi, CDFI(lch));
 }
 
 void omap_set_dma_dest_index(int lch, int eidx, int fidx)
@@ -445,21 +516,28 @@ void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 		REVISIT_24XX();
 		return;
 	}
-	OMAP_DMA_CDEI_REG(lch) = eidx;
-	OMAP_DMA_CDFI_REG(lch) = fidx;
+	dma_write(eidx, CDEI(lch));
+	dma_write(fidx, CDFI(lch));
 }
 
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
-	OMAP_DMA_CSDP_REG(lch) &= ~(1 << 13);
+	u32 l;
+
+	l = dma_read(CSDP(lch));
+	l &= ~(1 << 13);
 	if (enable)
-		OMAP_DMA_CSDP_REG(lch) |= 1 << 13;
+		l |= 1 << 13;
+	dma_write(l, CSDP(lch));
 }
 
 void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
 	unsigned int burst = 0;
-	OMAP_DMA_CSDP_REG(lch) &= ~(0x03 << 14);
+	u32 l;
+
+	l = dma_read(CSDP(lch));
+	l &= ~(0x03 << 14);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
@@ -489,7 +567,8 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 		BUG();
 		return;
 	}
-	OMAP_DMA_CSDP_REG(lch) |= (burst << 14);
+	l |= (burst << 14);
+	dma_write(l, CSDP(lch));
 }
 
 static inline void omap_enable_channel_irq(int lch)
@@ -498,12 +577,12 @@ static inline void omap_enable_channel_irq(int lch)
 
 	/* Clear CSR */
 	if (cpu_class_is_omap1())
-		status = OMAP_DMA_CSR_REG(lch);
+		status = dma_read(CSR(lch));
 	else if (cpu_class_is_omap2())
-		OMAP_DMA_CSR_REG(lch) = OMAP2_DMA_CSR_CLEAR_MASK;
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
 
 	/* Enable some nice interrupts. */
-	OMAP_DMA_CICR_REG(lch) = dma_chan[lch].enabled_irqs;
+	dma_write(dma_chan[lch].enabled_irqs, CICR(lch));
 
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
@@ -511,7 +590,7 @@ static inline void omap_enable_channel_irq(int lch)
 static void omap_disable_channel_irq(int lch)
 {
 	if (cpu_class_is_omap2())
-		OMAP_DMA_CICR_REG(lch) = 0;
+		dma_write(0, CICR(lch));
 }
 
 void omap_enable_dma_irq(int lch, u16 bits)
@@ -526,36 +605,45 @@ void omap_disable_dma_irq(int lch, u16 bits)
 
 static inline void enable_lnk(int lch)
 {
+	u32 l;
+
+	l = dma_read(CLNK_CTRL(lch));
+
 	if (cpu_class_is_omap1())
-		OMAP_DMA_CLNK_CTRL_REG(lch) &= ~(1 << 14);
+		l &= ~(1 << 14);
 
 	/* Set the ENABLE_LNK bits */
 	if (dma_chan[lch].next_lch != -1)
-		OMAP_DMA_CLNK_CTRL_REG(lch) =
-			dma_chan[lch].next_lch | (1 << 15);
+		l = dma_chan[lch].next_lch | (1 << 15);
 
 #ifndef CONFIG_ARCH_OMAP1
 	if (dma_chan[lch].next_linked_ch != -1)
-		OMAP_DMA_CLNK_CTRL_REG(lch) =
-			dma_chan[lch].next_linked_ch | (1 << 15);
+		l = dma_chan[lch].next_linked_ch | (1 << 15);
 #endif
+
+	dma_write(l, CLNK_CTRL(lch));
 }
 
 static inline void disable_lnk(int lch)
 {
+	u32 l;
+
+	l = dma_read(CLNK_CTRL(lch));
+
 	/* Disable interrupts */
 	if (cpu_class_is_omap1()) {
-		OMAP_DMA_CICR_REG(lch) = 0;
+		dma_write(0, CICR(lch));
 		/* Set the STOP_LNK bit */
-		OMAP_DMA_CLNK_CTRL_REG(lch) |= 1 << 14;
+		l |= 1 << 14;
 	}
 
 	if (cpu_class_is_omap2()) {
 		omap_disable_channel_irq(lch);
 		/* Clear the ENABLE_LNK bit */
-		OMAP_DMA_CLNK_CTRL_REG(lch) &= ~(1 << 15);
+		l &= ~(1 << 15);
 	}
 
+	dma_write(l, CLNK_CTRL(lch));
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 
@@ -566,9 +654,9 @@ static inline void omap2_enable_irq_lch(int lch)
 	if (!cpu_class_is_omap2())
 		return;
 
-	val = omap_readl(OMAP_DMA4_IRQENABLE_L0);
+	val = dma_read(IRQENABLE_L0);
 	val |= 1 << lch;
-	omap_writel(val, OMAP_DMA4_IRQENABLE_L0);
+	dma_write(val, IRQENABLE_L0);
 }
 
 int omap_request_dma(int dev_id, const char *dev_name,
@@ -625,9 +713,9 @@ int omap_request_dma(int dev_id, const char *dev_name,
 		}
 		/* Disable the 1510 compatibility mode and set the sync device
 		 * id. */
-		OMAP_DMA_CCR_REG(free_ch) = dev_id | (1 << 10);
+		dma_write(dev_id | (1 << 10), CCR(free_ch));
 	} else if (cpu_is_omap730() || cpu_is_omap15xx()) {
-		OMAP_DMA_CCR_REG(free_ch) = dev_id;
+		dma_write(dev_id, CCR(free_ch));
 	}
 
 	if (cpu_class_is_omap2()) {
@@ -635,8 +723,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
 
 		omap_enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
-		OMAP_DMA_CSR_REG(free_ch) = OMAP2_DMA_CSR_CLEAR_MASK;
-		omap_writel(1 << free_ch, OMAP_DMA4_IRQSTATUS_L0);
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(free_ch));
+		dma_write(1 << free_ch, IRQSTATUS_L0);
 	}
 
 	*dma_ch_out = free_ch;
@@ -662,27 +750,27 @@ void omap_free_dma(int lch)
 
 	if (cpu_class_is_omap1()) {
 		/* Disable all DMA interrupts for the channel. */
-		OMAP_DMA_CICR_REG(lch) = 0;
+		dma_write(0, CICR(lch));
 		/* Make sure the DMA transfer is stopped. */
-		OMAP_DMA_CCR_REG(lch) = 0;
+		dma_write(0, CCR(lch));
 	}
 
 	if (cpu_class_is_omap2()) {
 		u32 val;
 		/* Disable interrupts */
-		val = omap_readl(OMAP_DMA4_IRQENABLE_L0);
+		val = dma_read(IRQENABLE_L0);
 		val &= ~(1 << lch);
-		omap_writel(val, OMAP_DMA4_IRQENABLE_L0);
+		dma_write(val, IRQENABLE_L0);
 
 		/* Clear the CSR register and IRQ status register */
-		OMAP_DMA_CSR_REG(lch) = OMAP2_DMA_CSR_CLEAR_MASK;
-		omap_writel(1 << lch, OMAP_DMA4_IRQSTATUS_L0);
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
+		dma_write(1 << lch, IRQSTATUS_L0);
 
 		/* Disable all DMA interrupts for the channel. */
-		OMAP_DMA_CICR_REG(lch) = 0;
+		dma_write(0, CICR(lch));
 
 		/* Make sure the DMA transfer is stopped. */
-		OMAP_DMA_CCR_REG(lch) = 0;
+		dma_write(0, CCR(lch));
 		omap_clear_dma(lch);
 	}
 }
@@ -713,7 +801,7 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 	reg = (arb_rate & 0xff) << 16;
 	reg |= (0xff & max_fifo_depth);
 
-	omap_writel(reg, OMAP_DMA4_GCR_REG);
+	dma_write(reg, GCR);
 }
 EXPORT_SYMBOL(omap_dma_set_global_params);
 
@@ -730,20 +818,21 @@ int
 omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		      unsigned char write_prio)
 {
-	u32 w;
+	u32 l;
 
 	if (unlikely((lch < 0 || lch >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid channel id\n");
 		return -EINVAL;
 	}
-	w = OMAP_DMA_CCR_REG(lch);
-	w &= ~((1 << 6) | (1 << 26));
+	l = dma_read(CCR(lch));
+	l &= ~((1 << 6) | (1 << 26));
 	if (cpu_is_omap2430() || cpu_is_omap34xx())
-		w |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
+		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
 	else
-		w |= ((read_prio & 0x1) << 6);
+		l |= ((read_prio & 0x1) << 6);
+
+	dma_write(l, CCR(lch));
 
-	OMAP_DMA_CCR_REG(lch) = w;
 	return 0;
 }
 EXPORT_SYMBOL(omap_dma_set_prio_lch);
@@ -759,18 +848,21 @@ void omap_clear_dma(int lch)
 	local_irq_save(flags);
 
 	if (cpu_class_is_omap1()) {
-		int status;
-		OMAP_DMA_CCR_REG(lch) &= ~OMAP_DMA_CCR_EN;
+		u32 l;
+
+		l = dma_read(CCR(lch));
+		l &= ~OMAP_DMA_CCR_EN;
+		dma_write(l, CCR(lch));
 
 		/* Clear pending interrupts */
-		status = OMAP_DMA_CSR_REG(lch);
+		l = dma_read(CSR(lch));
 	}
 
 	if (cpu_class_is_omap2()) {
 		int i;
-		u32 lch_base = OMAP_DMA4_BASE + lch * 0x60 + 0x80;
+		void __iomem *lch_base = omap_dma_base + OMAP_DMA4_CH_BASE(lch);
 		for (i = 0; i < 0x44; i += 4)
-			omap_writel(0, lch_base + i);
+			__raw_writel(0, lch_base + i);
 	}
 
 	local_irq_restore(flags);
@@ -778,6 +870,8 @@ void omap_clear_dma(int lch)
 
 void omap_start_dma(int lch)
 {
+	u32 l;
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
@@ -804,24 +898,28 @@ void omap_start_dma(int lch)
 		} while (next_lch != -1);
 	} else if (cpu_class_is_omap2()) {
 		/* Errata: Need to write lch even if not using chaining */
-		OMAP_DMA_CLNK_CTRL_REG(lch) = lch;
+		dma_write(lch, CLNK_CTRL(lch));
 	}
 
 	omap_enable_channel_irq(lch);
 
+	l = dma_read(CCR(lch));
+
 	/* Errata: On ES2.0 BUFFERING disable must be set.
 	 * This will always fail on ES1.0 */
-	if (cpu_is_omap24xx()) {
-		OMAP_DMA_CCR_REG(lch) |= OMAP_DMA_CCR_EN;
-	}
+	if (cpu_is_omap24xx())
+		l |= OMAP_DMA_CCR_EN;
 
-	OMAP_DMA_CCR_REG(lch) |= OMAP_DMA_CCR_EN;
+	l |= OMAP_DMA_CCR_EN;
+	dma_write(l, CCR(lch));
 
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
 
 void omap_stop_dma(int lch)
 {
+	u32 l;
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
@@ -845,9 +943,12 @@ void omap_stop_dma(int lch)
 
 	/* Disable all interrupts on the channel */
 	if (cpu_class_is_omap1())
-		OMAP_DMA_CICR_REG(lch) = 0;
+		dma_write(0, CICR(lch));
+
+	l = dma_read(CCR(lch));
+	l &= ~OMAP_DMA_CCR_EN;
+	dma_write(l, CCR(lch));
 
-	OMAP_DMA_CCR_REG(lch) &= ~OMAP_DMA_CCR_EN;
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 
@@ -890,11 +991,19 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_class_is_omap1())
-		offset = (dma_addr_t) (OMAP1_DMA_CSSA_L_REG(lch) |
-				       (OMAP1_DMA_CSSA_U_REG(lch) << 16));
+		offset = (dma_addr_t)(dma_read(CSSA_L(lch)) |
+					(dma_read(CSSA_U(lch)) << 16));
 
-	if (cpu_class_is_omap2())
-		offset = OMAP_DMA_CSAC_REG(lch);
+	if (cpu_class_is_omap2()) {
+		offset = dma_read(CSAC(lch));
+
+		/*
+		 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
+		 * read before the DMA controller finished disabling the channel.
+		 */
+		if (offset == 0)
+			offset = dma_read(CSAC(lch));
+	}
 
 	return offset;
 }
@@ -912,11 +1021,19 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_class_is_omap1())
-		offset = (dma_addr_t) (OMAP1_DMA_CDSA_L_REG(lch) |
-				       (OMAP1_DMA_CDSA_U_REG(lch) << 16));
+		offset = (dma_addr_t)(dma_read(CDSA_L(lch)) |
+					(dma_read(CDSA_U(lch)) << 16));
 
-	if (cpu_class_is_omap2())
-		offset = OMAP_DMA_CDAC_REG(lch);
+	if (cpu_class_is_omap2()) {
+		offset = dma_read(CDAC(lch));
+
+		/*
+		 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
+		 * read before the DMA controller finished disabling the channel.
+		 */
+		if (offset == 0)
+			offset = dma_read(CDAC(lch));
+	}
 
 	return offset;
 }
@@ -928,8 +1045,14 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
  */
 int omap_get_dma_src_addr_counter(int lch)
 {
-	return (dma_addr_t) OMAP_DMA_CSAC_REG(lch);
+	return (dma_addr_t)dma_read(CSAC(lch));
+}
+
+int omap_get_dma_active_status(int lch)
+{
+	return (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN) != 0;
 }
+EXPORT_SYMBOL(omap_get_dma_active_status);
 
 int omap_dma_running(void)
 {
@@ -941,7 +1064,7 @@ int omap_dma_running(void)
 			return 1;
 
 	for (lch = 0; lch < dma_chan_count; lch++)
-		if (OMAP_DMA_CCR_REG(lch) & OMAP_DMA_CCR_EN)
+		if (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN)
 			return 1;
 
 	return 0;
@@ -1003,7 +1126,7 @@ void omap_dma_unlink_lch (int lch_head, int lch_queue)
 /* Create chain of DMA channesls */
 static void create_dma_lch_chain(int lch_head, int lch_queue)
 {
-	u32 w;
+	u32 l;
 
 	/* Check if this is the first link in chain */
 	if (dma_chan[lch_head].next_linked_ch == -1) {
@@ -1023,15 +1146,15 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 					lch_queue;
 	}
 
-	w = OMAP_DMA_CLNK_CTRL_REG(lch_head);
-	w &= ~(0x1f);
-	w |= lch_queue;
-	OMAP_DMA_CLNK_CTRL_REG(lch_head) = w;
+	l = dma_read(CLNK_CTRL(lch_head));
+	l &= ~(0x1f);
+	l |= lch_queue;
+	dma_write(l, CLNK_CTRL(lch_head));
 
-	w = OMAP_DMA_CLNK_CTRL_REG(lch_queue);
-	w &= ~(0x1f);
-	w |= (dma_chan[lch_queue].next_linked_ch);
-	OMAP_DMA_CLNK_CTRL_REG(lch_queue) = w;
+	l = dma_read(CLNK_CTRL(lch_queue));
+	l &= ~(0x1f);
+	l |= (dma_chan[lch_queue].next_linked_ch);
+	dma_write(l, CLNK_CTRL(lch_queue));
 }
 
 /**
@@ -1258,7 +1381,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			int elem_count, int frame_count, void *callbk_data)
 {
 	int *channels;
-	u32 w, lch;
+	u32 l, lch;
 	int start_dma = 0;
 
 	/* if buffer size is less than 1 then there is
@@ -1299,13 +1422,13 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 
 	/* Set the params to the free channel */
 	if (src_start != 0)
-		OMAP2_DMA_CSSA_REG(lch) = src_start;
+		dma_write(src_start, CSSA(lch));
 	if (dest_start != 0)
-		OMAP2_DMA_CDSA_REG(lch) = dest_start;
+		dma_write(dest_start, CDSA(lch));
 
 	/* Write the buffer size */
-	OMAP_DMA_CEN_REG(lch) = elem_count;
-	OMAP_DMA_CFN_REG(lch) = frame_count;
+	dma_write(elem_count, CEN(lch));
+	dma_write(frame_count, CFN(lch));
 
 	/* If the chain is dynamically linked,
 	 * then we may have to start the chain if its not active */
@@ -1332,8 +1455,8 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 				enable_lnk(dma_chan[lch].prev_linked_ch);
 				dma_chan[lch].state = DMA_CH_QUEUED;
 				start_dma = 0;
-				if (0 == ((1 << 7) & (OMAP_DMA_CCR_REG
-					(dma_chan[lch].prev_linked_ch)))) {
+				if (0 == ((1 << 7) & dma_read(
+					CCR(dma_chan[lch].prev_linked_ch)))) {
 					disable_lnk(dma_chan[lch].
 						    prev_linked_ch);
 					pr_debug("\n prev ch is stopped\n");
@@ -1349,23 +1472,23 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			}
 			omap_enable_channel_irq(lch);
 
-			w = OMAP_DMA_CCR_REG(lch);
+			l = dma_read(CCR(lch));
 
-			if ((0 == (w & (1 << 24))))
-				w &= ~(1 << 25);
+			if ((0 == (l & (1 << 24))))
+				l &= ~(1 << 25);
 			else
-				w |= (1 << 25);
+				l |= (1 << 25);
 			if (start_dma == 1) {
-				if (0 == (w & (1 << 7))) {
-					w |= (1 << 7);
+				if (0 == (l & (1 << 7))) {
+					l |= (1 << 7);
 					dma_chan[lch].state = DMA_CH_STARTED;
 					pr_debug("starting %d\n", lch);
-					OMAP_DMA_CCR_REG(lch) = w;
+					dma_write(l, CCR(lch));
 				} else
 					start_dma = 0;
 			} else {
-				if (0 == (w & (1 << 7)))
-					OMAP_DMA_CCR_REG(lch) = w;
+				if (0 == (l & (1 << 7)))
+					dma_write(l, CCR(lch));
 			}
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
@@ -1385,7 +1508,7 @@ EXPORT_SYMBOL(omap_dma_chain_a_transfer);
 int omap_start_dma_chain_transfers(int chain_id)
 {
 	int *channels;
-	u32 w, i;
+	u32 l, i;
 
 	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
@@ -1409,16 +1532,16 @@ int omap_start_dma_chain_transfers(int chain_id)
 		omap_enable_channel_irq(channels[0]);
 	}
 
-	w = OMAP_DMA_CCR_REG(channels[0]);
-	w |= (1 << 7);
+	l = dma_read(CCR(channels[0]));
+	l |= (1 << 7);
 	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
 	dma_chan[channels[0]].state = DMA_CH_STARTED;
 
-	if ((0 == (w & (1 << 24))))
-		w &= ~(1 << 25);
+	if ((0 == (l & (1 << 24))))
+		l &= ~(1 << 25);
 	else
-		w |= (1 << 25);
-	OMAP_DMA_CCR_REG(channels[0]) = w;
+		l |= (1 << 25);
+	dma_write(l, CCR(channels[0]));
 
 	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
 	return 0;
@@ -1436,7 +1559,7 @@ EXPORT_SYMBOL(omap_start_dma_chain_transfers);
 int omap_stop_dma_chain_transfers(int chain_id)
 {
 	int *channels;
-	u32 w, i;
+	u32 l, i;
 	u32 sys_cf;
 
 	/* Check for input params */
@@ -1455,18 +1578,18 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	/* DMA Errata:
 	 * Special programming model needed to disable DMA before end of block
 	 */
-	sys_cf = omap_readl(OMAP_DMA4_OCP_SYSCONFIG);
-	w = sys_cf;
+	sys_cf = dma_read(OCP_SYSCONFIG);
+	l = sys_cf;
 	/* Middle mode reg set no Standby */
-	w &= ~((1 << 12)|(1 << 13));
-	omap_writel(w, OMAP_DMA4_OCP_SYSCONFIG);
+	l &= ~((1 << 12)|(1 << 13));
+	dma_write(l, OCP_SYSCONFIG);
 
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
 
 		/* Stop the Channel transmission */
-		w = OMAP_DMA_CCR_REG(channels[i]);
-		w &= ~(1 << 7);
-		OMAP_DMA_CCR_REG(channels[i]) = w;
+		l = dma_read(CCR(channels[i]));
+		l &= ~(1 << 7);
+		dma_write(l, CCR(channels[i]));
 
 		/* Disable the link in all the channels */
 		disable_lnk(channels[i]);
@@ -1479,7 +1602,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
 	/* Errata - put in the old value */
-	omap_writel(sys_cf, OMAP_DMA4_OCP_SYSCONFIG);
+	dma_write(sys_cf, OCP_SYSCONFIG);
 	return 0;
 }
 EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
@@ -1520,8 +1643,8 @@ int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	*ei = OMAP2_DMA_CCEN_REG(lch);
-	*fi = OMAP2_DMA_CCFN_REG(lch);
+	*ei = dma_read(CCEN(lch));
+	*fi = dma_read(CCFN(lch));
 
 	return 0;
 }
@@ -1558,7 +1681,7 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return (OMAP_DMA_CDAC_REG(lch));
+	return dma_read(CDAC(lch));
 }
 EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
 
@@ -1592,7 +1715,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return (OMAP_DMA_CSAC_REG(lch));
+	return dma_read(CSAC(lch));
 }
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif
@@ -1603,13 +1726,13 @@ EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 
 static int omap1_dma_handle_ch(int ch)
 {
-	u16 csr;
+	u32 csr;
 
 	if (enable_1510_mode && ch >= 6) {
 		csr = dma_chan[ch].saved_csr;
 		dma_chan[ch].saved_csr = 0;
 	} else
-		csr = OMAP_DMA_CSR_REG(ch);
+		csr = dma_read(CSR(ch));
 	if (enable_1510_mode && ch <= 2 && (csr >> 7) != 0) {
 		dma_chan[ch + 6].saved_csr = csr >> 7;
 		csr &= 0x7f;
@@ -1661,12 +1784,12 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 
 static int omap2_dma_handle_ch(int ch)
 {
-	u32 status = OMAP_DMA_CSR_REG(ch);
+	u32 status = dma_read(CSR(ch));
 
 	if (!status) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n", ch);
-		omap_writel(1 << ch, OMAP_DMA4_IRQSTATUS_L0);
+		dma_write(1 << ch, IRQSTATUS_L0);
 		return 0;
 	}
 	if (unlikely(dma_chan[ch].dev_id == -1)) {
@@ -1689,14 +1812,14 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO "DMA misaligned error with device %d\n",
 		       dma_chan[ch].dev_id);
 
-	OMAP_DMA_CSR_REG(ch) = OMAP2_DMA_CSR_CLEAR_MASK;
-	omap_writel(1 << ch, OMAP_DMA4_IRQSTATUS_L0);
+	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
+	dma_write(1 << ch, IRQSTATUS_L0);
 
 	/* If the ch is not chained then chain_id will be -1 */
 	if (dma_chan[ch].chain_id != -1) {
 		int chain_id = dma_chan[ch].chain_id;
 		dma_chan[ch].state = DMA_CH_NOTSTARTED;
-		if (OMAP_DMA_CLNK_CTRL_REG(ch) & (1 << 15))
+		if (dma_read(CLNK_CTRL(ch)) & (1 << 15))
 			dma_chan[dma_chan[ch].next_linked_ch].state =
 							DMA_CH_STARTED;
 		if (dma_linked_lch[chain_id].chain_mode ==
@@ -1706,13 +1829,13 @@ static int omap2_dma_handle_ch(int ch)
 		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
 			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
 
-		status = OMAP_DMA_CSR_REG(ch);
+		status = dma_read(CSR(ch));
 	}
 
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
 
-	OMAP_DMA_CSR_REG(ch) = status;
+	dma_write(status, CSR(ch));
 
 	return 0;
 }
@@ -1723,7 +1846,7 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 	u32 val;
 	int i;
 
-	val = omap_readl(OMAP_DMA4_IRQSTATUS_L0);
+	val = dma_read(IRQSTATUS_L0);
 	if (val == 0) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
@@ -2111,10 +2234,19 @@ static int __init omap_init_dma(void)
 {
 	int ch, r;
 
-	if (cpu_class_is_omap1())
+	if (cpu_class_is_omap1()) {
+		omap_dma_base = (void __iomem *)IO_ADDRESS(OMAP1_DMA_BASE);
 		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
-	else
+	} else if (cpu_is_omap24xx()) {
+		omap_dma_base = (void __iomem *)IO_ADDRESS(OMAP24XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+	} else if (cpu_is_omap34xx()) {
+		omap_dma_base = (void __iomem *)IO_ADDRESS(OMAP34XX_DMA4_BASE);
+		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+	} else {
+		pr_err("DMA init failed for unsupported omap\n");
+		return -ENODEV;
+	}
 
 	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
 				GFP_KERNEL);
@@ -2136,21 +2268,21 @@ static int __init omap_init_dma(void)
 		enable_1510_mode = 1;
 	} else if (cpu_is_omap16xx() || cpu_is_omap730()) {
 		printk(KERN_INFO "OMAP DMA hardware version %d\n",
-		       omap_readw(OMAP_DMA_HW_ID));
+		       dma_read(HW_ID));
 		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
-		       (omap_readw(OMAP_DMA_CAPS_0_U) << 16) |
-		       omap_readw(OMAP_DMA_CAPS_0_L),
-		       (omap_readw(OMAP_DMA_CAPS_1_U) << 16) |
-		       omap_readw(OMAP_DMA_CAPS_1_L),
-		       omap_readw(OMAP_DMA_CAPS_2), omap_readw(OMAP_DMA_CAPS_3),
-		       omap_readw(OMAP_DMA_CAPS_4));
+		       (dma_read(CAPS_0_U) << 16) |
+		       dma_read(CAPS_0_L),
+		       (dma_read(CAPS_1_U) << 16) |
+		       dma_read(CAPS_1_L),
+		       dma_read(CAPS_2), dma_read(CAPS_3),
+		       dma_read(CAPS_4));
 		if (!enable_1510_mode) {
 			u16 w;
 
 			/* Disable OMAP 3.0/3.1 compatibility mode. */
-			w = omap_readw(OMAP_DMA_GSCR);
+			w = dma_read(GSCR);
 			w |= 1 << 3;
-			omap_writew(w, OMAP_DMA_GSCR);
+			dma_write(w, GSCR);
 			dma_chan_count = 16;
 		} else
 			dma_chan_count = 9;
@@ -2163,7 +2295,7 @@ static int __init omap_init_dma(void)
 			omap_writew(w, OMAP1610_DMA_LCD_CTRL);
 		}
 	} else if (cpu_class_is_omap2()) {
-		u8 revision = omap_readb(OMAP_DMA4_REVISION);
+		u8 revision = dma_read(REVISION) & 0xff;
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
 		dma_chan_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
diff --git a/drivers/mtd/nand/omap-hw.c b/drivers/mtd/nand/omap-hw.c
index 77817eb..1602977 100644
--- a/drivers/mtd/nand/omap-hw.c
+++ b/drivers/mtd/nand/omap-hw.c
@@ -269,14 +269,6 @@ static void omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 		printk(KERN_WARNING "omap-hw-nand: DMA timeout after %u ms, max. seen latency %u ms\n",
 		       jiffies_to_msecs(jiffies_spent),
 		       jiffies_to_msecs(max_jiffies));
-		if (OMAP_DMA_CCR_REG(dma_ch) & (1 << 7)) {
-			/* If the DMA transfer is still running, something
-			 * is really wrong. */
-			printk(KERN_ERR "omap-hw-nand: DMA transfer still running. Not good.\n");
-			printk(KERN_INFO "DMA ch %d: CCR %04x, CSR %04x, CCDEN_L %04x\n",
-			       dma_ch, omap_readw(OMAP_DMA_CCR_REG(dma_ch)), omap_readw(OMAP_DMA_CSR_REG(dma_ch)),
-			       omap_readw(OMAP_DMA_BASE + 0x40 * (dma_ch) + 0x34));
-		}
 	}
 	if (!is_write)
 		dma_cache_maint(addr, len, DMA_FROM_DEVICE);
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 699ff42..c76ba46 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -492,32 +492,6 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
 
 /*-------------------------------------------------------------------------*/
 
-static inline dma_addr_t dma_csac(unsigned lch)
-{
-	dma_addr_t	csac;
-
-	/* omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	csac = OMAP_DMA_CSAC_REG(lch);
-	if (csac == 0)
-		csac = OMAP_DMA_CSAC_REG(lch);
-	return csac;
-}
-
-static inline dma_addr_t dma_cdac(unsigned lch)
-{
-	dma_addr_t	cdac;
-
-	/* omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	cdac = OMAP_DMA_CDAC_REG(lch);
-	if (cdac == 0)
-		cdac = OMAP_DMA_CDAC_REG(lch);
-	return cdac;
-}
-
 static u16 dma_src_len(struct omap_ep *ep, dma_addr_t start)
 {
 	dma_addr_t	end;
@@ -528,7 +502,7 @@ static u16 dma_src_len(struct omap_ep *ep, dma_addr_t start)
 	if (cpu_is_omap15xx())
 		return 0;
 
-	end = dma_csac(ep->lch);
+	end = omap_get_dma_src_pos(ep->lch);
 	if (end == ep->dma_counter)
 		return 0;
 
@@ -538,15 +512,11 @@ static u16 dma_src_len(struct omap_ep *ep, dma_addr_t start)
 	return end - start;
 }
 
-#define DMA_DEST_LAST(x) (cpu_is_omap15xx() \
-		? OMAP_DMA_CSAC_REG(x) /* really: CPC */ \
-		: dma_cdac(x))
-
 static u16 dma_dest_len(struct omap_ep *ep, dma_addr_t start)
 {
 	dma_addr_t	end;
 
-	end = DMA_DEST_LAST(ep->lch);
+	end = omap_get_dma_dst_pos(ep->lch);
 	if (end == ep->dma_counter)
 		return 0;
 
@@ -597,7 +567,7 @@ static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
 		0, 0);
 
 	omap_start_dma(ep->lch);
-	ep->dma_counter = dma_csac(ep->lch);
+	ep->dma_counter = omap_get_dma_src_pos(ep->lch);
 	UDC_DMA_IRQ_EN_REG |= UDC_TX_DONE_IE(ep->dma_channel);
 	UDC_TXDMA_REG(ep->dma_channel) = UDC_TXN_START | txdma_ctrl;
 	req->dma_bytes = length;
@@ -655,7 +625,7 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
 		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
 		0, 0);
-	ep->dma_counter = DMA_DEST_LAST(ep->lch);
+	ep->dma_counter = omap_get_dma_dst_pos(ep->lch);
 
 	UDC_RXDMA_REG(ep->dma_channel) = UDC_RXN_STOP | (packets - 1);
 	UDC_DMA_IRQ_EN_REG |= UDC_RX_EOT_IE(ep->dma_channel);
@@ -835,7 +805,8 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 
 		/* channel type P: hw synch (fifo) */
 		if (cpu_class_is_omap1() && !cpu_is_omap15xx())
-			OMAP1_DMA_LCH_CTRL_REG(ep->lch) = 2;
+			omap_set_dma_color_mode(ep->lch,
+					OMAP_DMA_TRANSPARENT_COPY, 0);
 	}
 
 just_restart:
@@ -882,7 +853,7 @@ static void dma_channel_release(struct omap_ep *ep)
 	else
 		req = NULL;
 
-	active = ((1 << 7) & OMAP_DMA_CCR_REG(ep->lch)) != 0;
+	active = omap_get_dma_active_status(ep->lch);
 
 	DBG("%s release %s %cxdma%d %p\n", ep->ep.name,
 			active ? "active" : "idle",
diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-omap/dma.h
index 28492c3..e62eb6e 100644
--- a/include/asm-arm/arch-omap/dma.h
+++ b/include/asm-arm/arch-omap/dma.h
@@ -22,107 +22,126 @@
 #define __ASM_ARCH_DMA_H
 
 /* Hardware registers for omap1 */
-#define OMAP_DMA_BASE			(0xfffed800)
-#define OMAP_DMA_GCR			(OMAP_DMA_BASE + 0x400)
-#define OMAP_DMA_GSCR			(OMAP_DMA_BASE + 0x404)
-#define OMAP_DMA_GRST			(OMAP_DMA_BASE + 0x408)
-#define OMAP_DMA_HW_ID			(OMAP_DMA_BASE + 0x442)
-#define OMAP_DMA_PCH2_ID		(OMAP_DMA_BASE + 0x444)
-#define OMAP_DMA_PCH0_ID		(OMAP_DMA_BASE + 0x446)
-#define OMAP_DMA_PCH1_ID		(OMAP_DMA_BASE + 0x448)
-#define OMAP_DMA_PCHG_ID		(OMAP_DMA_BASE + 0x44a)
-#define OMAP_DMA_PCHD_ID		(OMAP_DMA_BASE + 0x44c)
-#define OMAP_DMA_CAPS_0_U		(OMAP_DMA_BASE + 0x44e)
-#define OMAP_DMA_CAPS_0_L		(OMAP_DMA_BASE + 0x450)
-#define OMAP_DMA_CAPS_1_U		(OMAP_DMA_BASE + 0x452)
-#define OMAP_DMA_CAPS_1_L		(OMAP_DMA_BASE + 0x454)
-#define OMAP_DMA_CAPS_2			(OMAP_DMA_BASE + 0x456)
-#define OMAP_DMA_CAPS_3			(OMAP_DMA_BASE + 0x458)
-#define OMAP_DMA_CAPS_4			(OMAP_DMA_BASE + 0x45a)
-#define OMAP_DMA_PCH2_SR		(OMAP_DMA_BASE + 0x460)
-#define OMAP_DMA_PCH0_SR		(OMAP_DMA_BASE + 0x480)
-#define OMAP_DMA_PCH1_SR		(OMAP_DMA_BASE + 0x482)
-#define OMAP_DMA_PCHD_SR		(OMAP_DMA_BASE + 0x4c0)
-
-/* Hardware registers for omap2 */
-#if defined(CONFIG_ARCH_OMAP3)
-#define OMAP_DMA4_BASE			(L4_34XX_BASE + 0x56000)
-#else	/* CONFIG_ARCH_OMAP2 */
-#define OMAP_DMA4_BASE			(L4_24XX_BASE + 0x56000)
-#endif
-
-#define OMAP_DMA4_REVISION		(OMAP_DMA4_BASE + 0x00)
-#define OMAP_DMA4_GCR_REG		(OMAP_DMA4_BASE + 0x78)
-#define OMAP_DMA4_IRQSTATUS_L0		(OMAP_DMA4_BASE + 0x08)
-#define OMAP_DMA4_IRQSTATUS_L1		(OMAP_DMA4_BASE + 0x0c)
-#define OMAP_DMA4_IRQSTATUS_L2		(OMAP_DMA4_BASE + 0x10)
-#define OMAP_DMA4_IRQSTATUS_L3		(OMAP_DMA4_BASE + 0x14)
-#define OMAP_DMA4_IRQENABLE_L0		(OMAP_DMA4_BASE + 0x18)
-#define OMAP_DMA4_IRQENABLE_L1		(OMAP_DMA4_BASE + 0x1c)
-#define OMAP_DMA4_IRQENABLE_L2		(OMAP_DMA4_BASE + 0x20)
-#define OMAP_DMA4_IRQENABLE_L3		(OMAP_DMA4_BASE + 0x24)
-#define OMAP_DMA4_SYSSTATUS		(OMAP_DMA4_BASE + 0x28)
-#define OMAP_DMA4_OCP_SYSCONFIG		(OMAP_DMA4_BASE + 0x2c)
-#define OMAP_DMA4_CAPS_0		(OMAP_DMA4_BASE + 0x64)
-#define OMAP_DMA4_CAPS_2		(OMAP_DMA4_BASE + 0x6c)
-#define OMAP_DMA4_CAPS_3		(OMAP_DMA4_BASE + 0x70)
-#define OMAP_DMA4_CAPS_4		(OMAP_DMA4_BASE + 0x74)
+#define OMAP1_DMA_BASE			(0xfffed800)
+
+#define OMAP1_DMA_GCR			0x400
+#define OMAP1_DMA_GSCR			0x404
+#define OMAP1_DMA_GRST			0x408
+#define OMAP1_DMA_HW_ID			0x442
+#define OMAP1_DMA_PCH2_ID		0x444
+#define OMAP1_DMA_PCH0_ID		0x446
+#define OMAP1_DMA_PCH1_ID		0x448
+#define OMAP1_DMA_PCHG_ID		0x44a
+#define OMAP1_DMA_PCHD_ID		0x44c
+#define OMAP1_DMA_CAPS_0_U		0x44e
+#define OMAP1_DMA_CAPS_0_L		0x450
+#define OMAP1_DMA_CAPS_1_U		0x452
+#define OMAP1_DMA_CAPS_1_L		0x454
+#define OMAP1_DMA_CAPS_2		0x456
+#define OMAP1_DMA_CAPS_3		0x458
+#define OMAP1_DMA_CAPS_4		0x45a
+#define OMAP1_DMA_PCH2_SR		0x460
+#define OMAP1_DMA_PCH0_SR		0x480
+#define OMAP1_DMA_PCH1_SR		0x482
+#define OMAP1_DMA_PCHD_SR		0x4c0
+
+/* Hardware registers for omap2 and omap3 */
+#define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
+#define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
+
+#define OMAP_DMA4_REVISION		0x00
+#define OMAP_DMA4_GCR			0x78
+#define OMAP_DMA4_IRQSTATUS_L0		0x08
+#define OMAP_DMA4_IRQSTATUS_L1		0x0c
+#define OMAP_DMA4_IRQSTATUS_L2		0x10
+#define OMAP_DMA4_IRQSTATUS_L3		0x14
+#define OMAP_DMA4_IRQENABLE_L0		0x18
+#define OMAP_DMA4_IRQENABLE_L1		0x1c
+#define OMAP_DMA4_IRQENABLE_L2		0x20
+#define OMAP_DMA4_IRQENABLE_L3		0x24
+#define OMAP_DMA4_SYSSTATUS		0x28
+#define OMAP_DMA4_OCP_SYSCONFIG		0x2c
+#define OMAP_DMA4_CAPS_0		0x64
+#define OMAP_DMA4_CAPS_2		0x6c
+#define OMAP_DMA4_CAPS_3		0x70
+#define OMAP_DMA4_CAPS_4		0x74
 
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
 #define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
 
-#ifdef CONFIG_ARCH_OMAP1
-
 /* Common channel specific registers for omap1 */
-#define OMAP_DMA_CSDP_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x00)
-#define OMAP_DMA_CCR_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x02)
-#define OMAP_DMA_CICR_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x04)
-#define OMAP_DMA_CSR_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x06)
-#define OMAP_DMA_CEN_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x10)
-#define OMAP_DMA_CFN_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x12)
-#define OMAP_DMA_CSFI_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x14)
-#define OMAP_DMA_CSEI_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x16)
-#define OMAP_DMA_CSAC_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x18)
-#define OMAP_DMA_CDAC_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x1a)
-#define OMAP_DMA_CDEI_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x1c)
-#define OMAP_DMA_CDFI_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x1e)
-#define OMAP_DMA_CLNK_CTRL_REG(n)	__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x28)
-
-#else
+#define OMAP1_DMA_CH_BASE(n)		(0x40 * (n) + 0x00)
+#define OMAP1_DMA_CSDP(n)		(0x40 * (n) + 0x00)
+#define OMAP1_DMA_CCR(n)		(0x40 * (n) + 0x02)
+#define OMAP1_DMA_CICR(n)		(0x40 * (n) + 0x04)
+#define OMAP1_DMA_CSR(n)		(0x40 * (n) + 0x06)
+#define OMAP1_DMA_CEN(n)		(0x40 * (n) + 0x10)
+#define OMAP1_DMA_CFN(n)		(0x40 * (n) + 0x12)
+#define OMAP1_DMA_CSFI(n)		(0x40 * (n) + 0x14)
+#define OMAP1_DMA_CSEI(n)		(0x40 * (n) + 0x16)
+#define OMAP1_DMA_CSAC(n)		(0x40 * (n) + 0x18)
+#define OMAP1_DMA_CDAC(n)		(0x40 * (n) + 0x1a)
+#define OMAP1_DMA_CDEI(n)		(0x40 * (n) + 0x1c)
+#define OMAP1_DMA_CDFI(n)		(0x40 * (n) + 0x1e)
+#define OMAP1_DMA_CLNK_CTRL(n)		(0x40 * (n) + 0x28)
 
 /* Common channel specific registers for omap2 */
-#define OMAP_DMA_CCR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x80)
-#define OMAP_DMA_CLNK_CTRL_REG(n)	__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x84)
-#define OMAP_DMA_CICR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x88)
-#define OMAP_DMA_CSR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x8c)
-#define OMAP_DMA_CSDP_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x90)
-#define OMAP_DMA_CEN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x94)
-#define OMAP_DMA_CFN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x98)
-#define OMAP_DMA_CSEI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xa4)
-#define OMAP_DMA_CSFI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xa8)
-#define OMAP_DMA_CDEI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xac)
-#define OMAP_DMA_CDFI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xb0)
-#define OMAP_DMA_CSAC_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xb4)
-#define OMAP_DMA_CDAC_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xb8)
-
-#endif
+#define OMAP_DMA4_CH_BASE(n)		(0x60 * (n) + 0x80)
+#define OMAP_DMA4_CCR(n)		(0x60 * (n) + 0x80)
+#define OMAP_DMA4_CLNK_CTRL(n)		(0x60 * (n) + 0x84)
+#define OMAP_DMA4_CICR(n)		(0x60 * (n) + 0x88)
+#define OMAP_DMA4_CSR(n)		(0x60 * (n) + 0x8c)
+#define OMAP_DMA4_CSDP(n)		(0x60 * (n) + 0x90)
+#define OMAP_DMA4_CEN(n)		(0x60 * (n) + 0x94)
+#define OMAP_DMA4_CFN(n)		(0x60 * (n) + 0x98)
+#define OMAP_DMA4_CSEI(n)		(0x60 * (n) + 0xa4)
+#define OMAP_DMA4_CSFI(n)		(0x60 * (n) + 0xa8)
+#define OMAP_DMA4_CDEI(n)		(0x60 * (n) + 0xac)
+#define OMAP_DMA4_CDFI(n)		(0x60 * (n) + 0xb0)
+#define OMAP_DMA4_CSAC(n)		(0x60 * (n) + 0xb4)
+#define OMAP_DMA4_CDAC(n)		(0x60 * (n) + 0xb8)
 
 /* Channel specific registers only on omap1 */
-#define OMAP1_DMA_CSSA_L_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x08)
-#define OMAP1_DMA_CSSA_U_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x0a)
-#define OMAP1_DMA_CDSA_L_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x0c)
-#define OMAP1_DMA_CDSA_U_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x0e)
-#define OMAP1_DMA_COLOR_L_REG(n)	__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x20)
-#define OMAP1_DMA_CCR2_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x24)
-#define OMAP1_DMA_COLOR_U_REG(n)	__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x22)
-#define OMAP1_DMA_LCH_CTRL_REG(n)	__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x2a)
+#define OMAP1_DMA_CSSA_L(n)		(0x40 * (n) + 0x08)
+#define OMAP1_DMA_CSSA_U(n)		(0x40 * (n) + 0x0a)
+#define OMAP1_DMA_CDSA_L(n)		(0x40 * (n) + 0x0c)
+#define OMAP1_DMA_CDSA_U(n)		(0x40 * (n) + 0x0e)
+#define OMAP1_DMA_COLOR_L(n)		(0x40 * (n) + 0x20)
+#define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
+#define OMAP1_DMA_COLOR_U(n)		(0x40 * (n) + 0x22)
+#define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)
+#define OMAP1_DMA_CCEN(n)		0
+#define OMAP1_DMA_CCFN(n)		0
 
 /* Channel specific registers only on omap2 */
-#define OMAP2_DMA_CSSA_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x9c)
-#define OMAP2_DMA_CDSA_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xa0)
-#define OMAP2_DMA_CCEN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xbc)
-#define OMAP2_DMA_CCFN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xc0)
-#define OMAP2_DMA_COLOR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xc4)
+#define OMAP_DMA4_CSSA(n)		(0x60 * (n) + 0x9c)
+#define OMAP_DMA4_CDSA(n)		(0x60 * (n) + 0xa0)
+#define OMAP_DMA4_CCEN(n)		(0x60 * (n) + 0xbc)
+#define OMAP_DMA4_CCFN(n)		(0x60 * (n) + 0xc0)
+#define OMAP_DMA4_COLOR(n)		(0x60 * (n) + 0xc4)
+
+/* Dummy defines to keep multi-omap compiles happy */
+#define OMAP1_DMA_REVISION		0
+#define OMAP1_DMA_IRQSTATUS_L0		0
+#define OMAP1_DMA_IRQENABLE_L0		0
+#define OMAP1_DMA_OCP_SYSCONFIG		0
+#define OMAP_DMA4_HW_ID			0
+#define OMAP_DMA4_CAPS_0_L		0
+#define OMAP_DMA4_CAPS_0_U		0
+#define OMAP_DMA4_CAPS_1_L		0
+#define OMAP_DMA4_CAPS_1_U		0
+#define OMAP_DMA4_GSCR			0
+
+#define OMAP_DMA4_LCH_CTRL(n)		0
+#define OMAP_DMA4_COLOR_L(n)		0
+#define OMAP_DMA4_COLOR_U(n)		0
+#define OMAP_DMA4_CCR2(n)		0
+#define OMAP1_DMA_CSSA(n)		0
+#define OMAP1_DMA_CDSA(n)		0
+#define OMAP_DMA4_CSSA_L(n)		0
+#define OMAP_DMA4_CSSA_U(n)		0
+#define OMAP_DMA4_CDSA_L(n)		0
+#define OMAP_DMA4_CDSA_U(n)		0
 
 /*----------------------------------------------------------------------------*/
 
@@ -488,6 +507,7 @@ extern dma_addr_t omap_get_dma_src_pos(int lch);
 extern dma_addr_t omap_get_dma_dst_pos(int lch);
 extern int omap_get_dma_src_addr_counter(int lch);
 extern void omap_clear_dma(int lch);
+extern int omap_get_dma_active_status(int lch);
 extern int omap_dma_running(void);
 extern void omap_dma_set_global_params(int arb_rate, int max_fifo_depth,
 				       int tparams);
diff --git a/sound/arm/omap/omap-alsa-dma.c b/sound/arm/omap/omap-alsa-dma.c
index 3f9ff68..d263933 100644
--- a/sound/arm/omap/omap-alsa-dma.c
+++ b/sound/arm/omap/omap-alsa-dma.c
@@ -108,7 +108,6 @@
 
 #define DCCR_FS              (1 << 5)
 #define DCCR_PRIO            (1 << 6)
-#define DCCR_EN              (1 << 7)
 #define DCCR_AI              (1 << 8)
 #define DCCR_REPEAT          (1 << 9)
 /* if 0 the channel works in 3.1 compatible mode */
@@ -420,7 +419,7 @@ static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
 		sound_curr_lch, ch_status, dma_status, data);
 
 	if (dma_status & (DCSR_ERROR)) {
-		OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
+		omap_stop_dma(sound_curr_lch);
 		ERR("DCSR_ERROR!\n");
 		FN_OUT(-1);
 		return;
diff --git a/sound/oss/omap-audio-dma-intfc.c b/sound/oss/omap-audio-dma-intfc.c
index 146e288..d568582 100644
--- a/sound/oss/omap-audio-dma-intfc.c
+++ b/sound/oss/omap-audio-dma-intfc.c
@@ -108,7 +108,6 @@
 
 #define DCCR_FS              (1 << 5)
 #define DCCR_PRIO            (1 << 6)
-#define DCCR_EN              (1 << 7)
 #define DCCR_AI              (1 << 8)
 #define DCCR_REPEAT          (1 << 9)
 /* if 0 the channel works in 3.1 compatible mode*/
@@ -872,7 +871,7 @@ static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status, void *data)
 
 	if (dma_status & (DCSR_ERROR)) {
 		if (cpu_is_omap15xx() || cpu_is_omap16xx())
-			OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
+			omap_stop_dma(sound_curr_lch);
 		ERR("DCSR_ERROR!\n");
 		FN_OUT(-1);
 		return;
-- 
1.5.3.6

