From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v4 01/13] OMAP: DMA: Replace read/write macros with functions
Date: Mon,  8 Nov 2010 19:37:40 +0530
Message-ID: <1289225272-9767-2-git-send-email-manjugk@ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48216 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143Ab0KHOH1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 09:07:27 -0500
In-Reply-To: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

The low level read/write macros are replaced with static inline
functions
and register offsets are handled through static register offset tables
mapped through enumeration constants.

The objective of this patch is to prepare for omap dma driver cleanup
and dma hwmod implementation. The code optimization and moving machine
specific code to respective mach-omapx dma file will be handled in the
rest of this patch series.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c              |  741 ++++++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/dma.h |  120 ------
 2 files changed, 498 insertions(+), 363 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2c28265..bb54be3 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -40,6 +40,147 @@
 
 #undef DEBUG
 
+enum {
+	GCR1 = 0,	GSCR,		GRST,		HW_ID,
+	PCH2_ID,	PCH0_ID,	PCH1_ID,	PCHG_ID,
+	PCHD_ID,	CAPS1_0_U,	CAPS1_0_L,	CAPS1_1_U,
+	CAPS1_1_L,	CAPS1_2,	CAPS1_3,	CAPS1_4,
+	PCH2_SR,	PCH0_SR,	PCH1_SR,	PCHD_SR,
+
+	OMAP1_CH_COMMON_START,
+
+	/* Common Registers */
+	CSDP1,		CCR1,		CICR1,		CSR1,
+	CEN1,		CFN1,		CSFI1,		CSEI1,
+	CPC,		CSAC1,		CDAC1,		CDEI1,
+	CDFI1,		CLNK_CTRL1,
+
+	/* Channel specific register offsets */
+	CSSA_L,		CSSA_U,		CDSA_L,		CDSA_U,
+	COLOR_L,	COLOR_U,	CCR1_2,		LCH_CTRL,
+
+	OMAP1_CH_COMMON_END,
+};
+
+static u16 reg_map_omap1[] = {
+	[GCR1]		= 0x400,
+	[GSCR]		= 0x404,
+	[GRST]		= 0x408,
+	[HW_ID]		= 0x442,
+	[PCH2_ID]	= 0x444,
+	[PCH0_ID]	= 0x446,
+	[PCH1_ID]	= 0x448,
+	[PCHG_ID]	= 0x44a,
+	[PCHD_ID]	= 0x44c,
+	[CAPS1_0_U]	= 0x44e,
+	[CAPS1_0_L]	= 0x450,
+	[CAPS1_1_U]	= 0x452,
+	[CAPS1_1_L]	= 0x454,
+	[CAPS1_2]	= 0x456,
+	[CAPS1_3]	= 0x458,
+	[CAPS1_4]	= 0x45a,
+	[PCH2_SR]	= 0x460,
+	[PCH0_SR]	= 0x480,
+	[PCH1_SR]	= 0x482,
+	[PCHD_SR]	= 0x4c0,
+
+	/* Common Registers */
+	[CSDP1]		= 0x00,
+	[CCR1]		= 0x02,
+	[CICR1]		= 0x04,
+	[CSR1]		= 0x06,
+	[CEN1]		= 0x10,
+	[CFN1]		= 0x12,
+	[CSFI1]		= 0x14,
+	[CSEI1]		= 0x16,
+	[CPC]		= 0x18,	/* 15xx only */
+	[CSAC1]		= 0x18,
+	[CDAC1]		= 0x1a,
+	[CDEI1]		= 0x1c,
+	[CDFI1]		= 0x1e,
+	[CLNK_CTRL1]	= 0x28,
+
+	/* Channel specific register offsets */
+	[CSSA_L]	= 0x08,
+	[CSSA_U]	= 0x0a,
+	[CDSA_L]	= 0x0c,
+	[CDSA_U]	= 0x0e,
+	[COLOR_L]	= 0x20,
+	[COLOR_U]	= 0x22,
+	[CCR1_2]	= 0x24,
+	[LCH_CTRL]	= 0x2a,
+};
+
+enum {
+	REVISION = 0,	GCR2,		IRQSTATUS_L0,	IRQSTATUS_L1,
+	IRQSTATUS_L2,	IRQSTATUS_L3,	IRQENABLE_L0,	IRQENABLE_L1,
+	IRQENABLE_L2,	IRQENABLE_L3,	SYSSTATUS,	OCP_SYSCONFIG,
+	CAPS2_0,	CAPS2_2,	CAPS2_3,	CAPS2_4,
+
+	OMAP2_CH_COMMON_START,
+
+	/* Common register offsets */
+	CCR2,		CLNK_CTRL2,	CICR2,		CSR2,
+	CSDP2,		CEN2,		CFN2,		CSEI2,
+	CSFI2,		CDEI2,		CDFI2,		CSAC2,
+	CDAC2,
+
+	/* Channel specific register offsets */
+	CSSA,		CDSA,		CCEN,		CCFN,
+	COLOR,
+
+	/* OMAP4 specific registers */
+	CDP,		CNDP,		CCDN,
+
+	OMAP2_CH_COMMON_END,
+};
+
+static u16 reg_map_omap2[] = {
+	[REVISION]		= 0x00,
+	[GCR2]			= 0x78,
+	[IRQSTATUS_L0]		= 0x08,
+	[IRQSTATUS_L1]		= 0x0c,
+	[IRQSTATUS_L2]		= 0x10,
+	[IRQSTATUS_L3]		= 0x14,
+	[IRQENABLE_L0]		= 0x18,
+	[IRQENABLE_L1]		= 0x1c,
+	[IRQENABLE_L2]		= 0x20,
+	[IRQENABLE_L3]		= 0x24,
+	[SYSSTATUS]		= 0x28,
+	[OCP_SYSCONFIG]		= 0x2c,
+	[CAPS2_0]		= 0x64,
+	[CAPS2_2]		= 0x6c,
+	[CAPS2_3]		= 0x70,
+	[CAPS2_4]		= 0x74,
+
+	/* Common register offsets */
+	[CCR2]			= 0x80,
+	[CLNK_CTRL2]		= 0x84,
+	[CICR2]			= 0x88,
+	[CSR2]			= 0x8c,
+	[CSDP2]			= 0x90,
+	[CEN2]			= 0x94,
+	[CFN2]			= 0x98,
+	[CSEI2]			= 0xa4,
+	[CSFI2]			= 0xa8,
+	[CDEI2]			= 0xac,
+	[CDFI2]			= 0xb0,
+	[CSAC2]			= 0xb4,
+	[CDAC2]			= 0xb8,
+
+	/* Channel specific register offsets */
+	[CSSA]			= 0x9c,
+	[CDSA]			= 0xa0,
+	[CCEN]			= 0xbc,
+	[CCFN]			= 0xc0,
+	[COLOR]			= 0xc4,
+
+	/* OMAP4 specific registers */
+	[CDP]			= 0xd0,
+	[CNDP]			= 0xd4,
+	[CCDN]			= 0xd8,
+};
+
 #ifndef CONFIG_ARCH_OMAP1
 enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
 	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
@@ -137,7 +278,7 @@ static int omap_dma_reserve_channels;
 
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
-static void __iomem *omap_dma_base;
+static void __iomem *dma_base;
 
 static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
 	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
@@ -154,23 +295,42 @@ static inline void omap_enable_channel_irq(int lch);
 #define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
 						__func__);
 
-#define dma_read(reg)							\
-({									\
-	u32 __val;							\
-	if (cpu_class_is_omap1())					\
-		__val = __raw_readw(omap_dma_base + OMAP1_DMA_##reg);	\
-	else								\
-		__val = __raw_readl(omap_dma_base + OMAP_DMA4_##reg);	\
-	__val;								\
-})
-
-#define dma_write(val, reg)						\
-({									\
-	if (cpu_class_is_omap1())					\
-		__raw_writew((u16)(val), omap_dma_base + OMAP1_DMA_##reg); \
-	else								\
-		__raw_writel((val), omap_dma_base + OMAP_DMA4_##reg);	\
-})
+static inline void dma_write(u32 val, int reg, int lch)
+{
+	if (cpu_class_is_omap1()) {
+		if (reg > OMAP1_CH_COMMON_START)
+			__raw_writew(val, dma_base +
+				(reg_map_omap1[reg] + 0x40 * lch));
+		else
+			__raw_writew(val, dma_base + reg_map_omap1[reg]);
+	} else {
+		if (reg > OMAP2_CH_COMMON_START)
+			__raw_writel(val, dma_base +
+				(reg_map_omap2[reg] + 0x60 * lch));
+		else
+			__raw_writel(val, dma_base + reg_map_omap2[reg]);
+	}
+}
+
+static inline u32 dma_read(int reg, int lch)
+{
+	u32 val;
+
+	if (cpu_class_is_omap1()) {
+		if (reg > OMAP1_CH_COMMON_START)
+			val = __raw_readw(dma_base +
+					(reg_map_omap1[reg] + 0x40 * lch));
+		else
+			val = __raw_readw(dma_base + reg_map_omap1[reg]);
+	} else {
+		if (reg > OMAP2_CH_COMMON_START)
+			val = __raw_readl(dma_base +
+					(reg_map_omap2[reg] + 0x60 * lch));
+		else
+			val = __raw_readl(dma_base + reg_map_omap2[reg]);
+	}
+	return val;
+}
 
 #ifdef CONFIG_ARCH_OMAP15XX
 /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
@@ -209,11 +369,10 @@ static inline void set_gdma_dev(int req, int dev)
 /* Omap1 only */
 static void clear_lch_regs(int lch)
 {
-	int i;
-	void __iomem *lch_base = omap_dma_base + OMAP1_DMA_CH_BASE(lch);
+	int i = OMAP1_CH_COMMON_START;
 
-	for (i = 0; i < 0x2c; i += 2)
-		__raw_writew(0, lch_base + i);
+	for (; i <= OMAP1_CH_COMMON_END; i += 1)
+		dma_write(0, i, lch);
 }
 
 void omap_set_dma_priority(int lch, int dst_port, int priority)
@@ -248,12 +407,12 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 	if (cpu_class_is_omap2()) {
 		u32 ccr;
 
-		ccr = dma_read(CCR(lch));
+		ccr = dma_read(CCR2, lch);
 		if (priority)
 			ccr |= (1 << 6);
 		else
 			ccr &= ~(1 << 6);
-		dma_write(ccr, CCR(lch));
+		dma_write(ccr, CCR2, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_priority);
@@ -264,31 +423,36 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 {
 	u32 l;
 
-	l = dma_read(CSDP(lch));
-	l &= ~0x03;
-	l |= data_type;
-	dma_write(l, CSDP(lch));
-
 	if (cpu_class_is_omap1()) {
 		u16 ccr;
 
-		ccr = dma_read(CCR(lch));
+		l = dma_read(CSDP1, lch);
+		l &= ~0x03;
+		l |= data_type;
+		dma_write(l, CSDP1, lch);
+
+		ccr = dma_read(CCR1, lch);
 		ccr &= ~(1 << 5);
 		if (sync_mode == OMAP_DMA_SYNC_FRAME)
 			ccr |= 1 << 5;
-		dma_write(ccr, CCR(lch));
+		dma_write(ccr, CCR1, lch);
 
-		ccr = dma_read(CCR2(lch));
+		ccr = dma_read(CCR1_2, lch);
 		ccr &= ~(1 << 2);
 		if (sync_mode == OMAP_DMA_SYNC_BLOCK)
 			ccr |= 1 << 2;
-		dma_write(ccr, CCR2(lch));
+		dma_write(ccr, CCR1_2, lch);
 	}
 
 	if (cpu_class_is_omap2() && dma_trigger) {
 		u32 val;
 
-		val = dma_read(CCR(lch));
+		l = dma_read(CSDP2, lch);
+		l &= ~0x03;
+		l |= data_type;
+		dma_write(l, CSDP2, lch);
+
+		val = dma_read(CCR2, lch);
 
 		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
 		val &= ~((1 << 23) | (3 << 19) | 0x1f);
@@ -313,11 +477,15 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 		} else {
 			val &= ~(1 << 24);	/* dest synch */
 		}
-		dma_write(val, CCR(lch));
+		dma_write(val, CCR2, lch);
+	}
+	if (cpu_class_is_omap1()) {
+		dma_write(elem_count, CEN1, lch);
+		dma_write(frame_count, CFN1, lch);
+	} else {
+		dma_write(elem_count, CEN2, lch);
+		dma_write(frame_count, CFN2, lch);
 	}
-
-	dma_write(elem_count, CEN(lch));
-	dma_write(frame_count, CFN(lch));
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
@@ -328,7 +496,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
-		w = dma_read(CCR2(lch));
+		w = dma_read(CCR1_2, lch);
 		w &= ~0x03;
 
 		switch (mode) {
@@ -343,23 +511,23 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		default:
 			BUG();
 		}
-		dma_write(w, CCR2(lch));
+		dma_write(w, CCR1_2, lch);
 
-		w = dma_read(LCH_CTRL(lch));
+		w = dma_read(LCH_CTRL, lch);
 		w &= ~0x0f;
 		/* Default is channel type 2D */
 		if (mode) {
-			dma_write((u16)color, COLOR_L(lch));
-			dma_write((u16)(color >> 16), COLOR_U(lch));
+			dma_write((u16)color, COLOR_L, lch);
+			dma_write((u16)(color >> 16), COLOR_U, lch);
 			w |= 1;		/* Channel type G */
 		}
-		dma_write(w, LCH_CTRL(lch));
+		dma_write(w, LCH_CTRL, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		u32 val;
 
-		val = dma_read(CCR(lch));
+		val = dma_read(CCR2, lch);
 		val &= ~((1 << 17) | (1 << 16));
 
 		switch (mode) {
@@ -374,10 +542,10 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		default:
 			BUG();
 		}
-		dma_write(val, CCR(lch));
+		dma_write(val, CCR2, lch);
 
 		color &= 0xffffff;
-		dma_write(color, COLOR(lch));
+		dma_write(color, COLOR, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_color_mode);
@@ -387,10 +555,10 @@ void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 	if (cpu_class_is_omap2()) {
 		u32 csdp;
 
-		csdp = dma_read(CSDP(lch));
+		csdp = dma_read(CSDP2, lch);
 		csdp &= ~(0x3 << 16);
 		csdp |= (mode << 16);
-		dma_write(csdp, CSDP(lch));
+		dma_write(csdp, CSDP2, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_write_mode);
@@ -400,10 +568,10 @@ void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
 	if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
 		u32 l;
 
-		l = dma_read(LCH_CTRL(lch));
+		l = dma_read(LCH_CTRL, lch);
 		l &= ~0x7;
 		l |= mode;
-		dma_write(l, LCH_CTRL(lch));
+		dma_write(l, LCH_CTRL, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_channel_mode);
@@ -418,27 +586,38 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
-		w = dma_read(CSDP(lch));
+		w = dma_read(CSDP1, lch);
 		w &= ~(0x1f << 2);
 		w |= src_port << 2;
-		dma_write(w, CSDP(lch));
-	}
+		dma_write(w, CSDP1, lch);
+
+		l = dma_read(CCR1, lch);
+	} else
+		l = dma_read(CCR2, lch);
 
-	l = dma_read(CCR(lch));
 	l &= ~(0x03 << 12);
 	l |= src_amode << 12;
-	dma_write(l, CCR(lch));
+
+	if (cpu_class_is_omap1())
+		dma_write(l, CCR1, lch);
+	else
+		dma_write(l, CCR2, lch);
 
 	if (cpu_class_is_omap1()) {
-		dma_write(src_start >> 16, CSSA_U(lch));
-		dma_write((u16)src_start, CSSA_L(lch));
+		dma_write(src_start >> 16, CSSA_U, lch);
+		dma_write((u16)src_start, CSSA_L, lch);
 	}
 
 	if (cpu_class_is_omap2())
-		dma_write(src_start, CSSA(lch));
+		dma_write(src_start, CSSA, lch);
 
-	dma_write(src_ei, CSEI(lch));
-	dma_write(src_fi, CSFI(lch));
+	if (cpu_class_is_omap1()) {
+		dma_write(src_ei, CSEI1, lch);
+		dma_write(src_fi, CSFI1, lch);
+	} else {
+		dma_write(src_ei, CSEI2, lch);
+		dma_write(src_fi, CSFI2, lch);
+	}
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
 
@@ -466,8 +645,8 @@ void omap_set_dma_src_index(int lch, int eidx, int fidx)
 	if (cpu_class_is_omap2())
 		return;
 
-	dma_write(eidx, CSEI(lch));
-	dma_write(fidx, CSFI(lch));
+	dma_write(eidx, CSEI1, lch);
+	dma_write(fidx, CSFI1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_index);
 
@@ -475,11 +654,19 @@ void omap_set_dma_src_data_pack(int lch, int enable)
 {
 	u32 l;
 
-	l = dma_read(CSDP(lch));
+	if (cpu_class_is_omap1())
+		l = dma_read(CSDP1, lch);
+	else
+		l = dma_read(CSDP2, lch);
+
 	l &= ~(1 << 6);
 	if (enable)
 		l |= (1 << 6);
-	dma_write(l, CSDP(lch));
+
+	if (cpu_class_is_omap1())
+		dma_write(l, CSDP1, lch);
+	else
+		dma_write(l, CSDP2, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_data_pack);
 
@@ -488,7 +675,11 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	unsigned int burst = 0;
 	u32 l;
 
-	l = dma_read(CSDP(lch));
+	if (cpu_class_is_omap2())
+		l = dma_read(CSDP2, lch);
+	else
+		l = dma_read(CSDP1, lch);
+
 	l &= ~(0x03 << 7);
 
 	switch (burst_mode) {
@@ -524,7 +715,11 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	}
 
 	l |= (burst << 7);
-	dma_write(l, CSDP(lch));
+
+	if (cpu_class_is_omap2())
+		dma_write(l, CSDP2, lch);
+	else
+		dma_write(l, CSDP1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
 
@@ -536,27 +731,38 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 	u32 l;
 
 	if (cpu_class_is_omap1()) {
-		l = dma_read(CSDP(lch));
+		l = dma_read(CSDP1, lch);
 		l &= ~(0x1f << 9);
 		l |= dest_port << 9;
-		dma_write(l, CSDP(lch));
-	}
+		dma_write(l, CSDP1, lch);
+
+		l = dma_read(CCR1, lch);
+	} else
+		l = dma_read(CCR2, lch);
 
-	l = dma_read(CCR(lch));
 	l &= ~(0x03 << 14);
 	l |= dest_amode << 14;
-	dma_write(l, CCR(lch));
+
+	if (cpu_class_is_omap1())
+		dma_write(l, CCR1, lch);
+	else
+		dma_write(l, CCR2, lch);
 
 	if (cpu_class_is_omap1()) {
-		dma_write(dest_start >> 16, CDSA_U(lch));
-		dma_write(dest_start, CDSA_L(lch));
+		dma_write(dest_start >> 16, CDSA_U, lch);
+		dma_write(dest_start, CDSA_L, lch);
 	}
 
 	if (cpu_class_is_omap2())
-		dma_write(dest_start, CDSA(lch));
+		dma_write(dest_start, CDSA, lch);
 
-	dma_write(dst_ei, CDEI(lch));
-	dma_write(dst_fi, CDFI(lch));
+	if (cpu_class_is_omap1()) {
+		dma_write(dst_ei, CDEI1, lch);
+		dma_write(dst_fi, CDFI1, lch);
+	} else {
+		dma_write(dst_ei, CDEI2, lch);
+		dma_write(dst_fi, CDFI2, lch);
+	}
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
 
@@ -565,8 +771,8 @@ void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 	if (cpu_class_is_omap2())
 		return;
 
-	dma_write(eidx, CDEI(lch));
-	dma_write(fidx, CDFI(lch));
+	dma_write(eidx, CDEI1, lch);
+	dma_write(fidx, CDFI1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_index);
 
@@ -574,11 +780,19 @@ void omap_set_dma_dest_data_pack(int lch, int enable)
 {
 	u32 l;
 
-	l = dma_read(CSDP(lch));
+	if (cpu_class_is_omap2())
+		l = dma_read(CSDP2, lch);
+	else
+		l = dma_read(CSDP1, lch);
+
 	l &= ~(1 << 13);
 	if (enable)
 		l |= 1 << 13;
-	dma_write(l, CSDP(lch));
+
+	if (cpu_class_is_omap2())
+		dma_write(l, CSDP2, lch);
+	else
+		dma_write(l, CSDP1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
 
@@ -586,8 +800,11 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
 	unsigned int burst = 0;
 	u32 l;
+	if (cpu_class_is_omap2())
+		l = dma_read(CSDP2, lch);
+	else
+		l = dma_read(CSDP1, lch);
 
-	l = dma_read(CSDP(lch));
 	l &= ~(0x03 << 14);
 
 	switch (burst_mode) {
@@ -619,8 +836,13 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 		BUG();
 		return;
 	}
+
 	l |= (burst << 14);
-	dma_write(l, CSDP(lch));
+
+	if (cpu_class_is_omap2())
+		dma_write(l, CSDP2, lch);
+	else
+		dma_write(l, CSDP1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
@@ -629,19 +851,21 @@ static inline void omap_enable_channel_irq(int lch)
 	u32 status;
 
 	/* Clear CSR */
-	if (cpu_class_is_omap1())
-		status = dma_read(CSR(lch));
-	else if (cpu_class_is_omap2())
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
-
-	/* Enable some nice interrupts. */
-	dma_write(dma_chan[lch].enabled_irqs, CICR(lch));
+	if (cpu_class_is_omap1()) {
+		status = dma_read(CSR1, lch);
+		dma_write(dma_chan[lch].enabled_irqs, CICR1, lch);
+	} else if (cpu_class_is_omap2()) {
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
+		dma_write(dma_chan[lch].enabled_irqs, CICR2, lch);
+	}
 }
 
 static void omap_disable_channel_irq(int lch)
 {
 	if (cpu_class_is_omap2())
-		dma_write(0, CICR(lch));
+		dma_write(0, CICR2, lch);
+	else
+		dma_write(0, CICR1, lch);
 }
 
 void omap_enable_dma_irq(int lch, u16 bits)
@@ -660,44 +884,44 @@ static inline void enable_lnk(int lch)
 {
 	u32 l;
 
-	l = dma_read(CLNK_CTRL(lch));
-
-	if (cpu_class_is_omap1())
+	if (cpu_class_is_omap1()) {
+		l = dma_read(CLNK_CTRL1, lch);
 		l &= ~(1 << 14);
+	} else
+		l = dma_read(CLNK_CTRL2, lch);
 
 	/* Set the ENABLE_LNK bits */
 	if (dma_chan[lch].next_lch != -1)
 		l = dma_chan[lch].next_lch | (1 << 15);
 
-#ifndef CONFIG_ARCH_OMAP1
-	if (cpu_class_is_omap2())
+	if (cpu_class_is_omap2()) {
 		if (dma_chan[lch].next_linked_ch != -1)
 			l = dma_chan[lch].next_linked_ch | (1 << 15);
-#endif
-
-	dma_write(l, CLNK_CTRL(lch));
+		dma_write(l, CLNK_CTRL2, lch);
+	} else
+		dma_write(l, CLNK_CTRL1, lch);
 }
 
 static inline void disable_lnk(int lch)
 {
 	u32 l;
 
-	l = dma_read(CLNK_CTRL(lch));
-
 	/* Disable interrupts */
 	if (cpu_class_is_omap1()) {
-		dma_write(0, CICR(lch));
+		l = dma_read(CLNK_CTRL1, lch);
+		dma_write(0, CICR1, lch);
 		/* Set the STOP_LNK bit */
 		l |= 1 << 14;
+		dma_write(l, CLNK_CTRL1, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
+		l = dma_read(CLNK_CTRL2, lch);
 		omap_disable_channel_irq(lch);
 		/* Clear the ENABLE_LNK bit */
 		l &= ~(1 << 15);
+		dma_write(l, CLNK_CTRL2, lch);
 	}
-
-	dma_write(l, CLNK_CTRL(lch));
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 
@@ -710,9 +934,9 @@ static inline void omap2_enable_irq_lch(int lch)
 		return;
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0);
+	val = dma_read(IRQENABLE_L0, 0);
 	val |= 1 << lch;
-	dma_write(val, IRQENABLE_L0);
+	dma_write(val, IRQENABLE_L0, 0);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
@@ -725,9 +949,9 @@ static inline void omap2_disable_irq_lch(int lch)
 		return;
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0);
+	val = dma_read(IRQENABLE_L0, 0);
 	val &= ~(1 << lch);
-	dma_write(val, IRQENABLE_L0);
+	dma_write(val, IRQENABLE_L0, 0);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
@@ -792,17 +1016,17 @@ int omap_request_dma(int dev_id, const char *dev_name,
 		 * Disable the 1510 compatibility mode and set the sync device
 		 * id.
 		 */
-		dma_write(dev_id | (1 << 10), CCR(free_ch));
+		dma_write(dev_id | (1 << 10), CCR1, free_ch);
 	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
-		dma_write(dev_id, CCR(free_ch));
+		dma_write(dev_id, CCR1, free_ch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		omap2_enable_irq_lch(free_ch);
 		omap_enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(free_ch));
-		dma_write(1 << free_ch, IRQSTATUS_L0);
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, free_ch);
+		dma_write(1 << free_ch, IRQSTATUS_L0, 0);
 	}
 
 	*dma_ch_out = free_ch;
@@ -823,23 +1047,23 @@ void omap_free_dma(int lch)
 
 	if (cpu_class_is_omap1()) {
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR(lch));
+		dma_write(0, CICR1, lch);
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR(lch));
+		dma_write(0, CCR1, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		omap2_disable_irq_lch(lch);
 
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
-		dma_write(1 << lch, IRQSTATUS_L0);
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
+		dma_write(1 << lch, IRQSTATUS_L0, 0);
 
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR(lch));
+		dma_write(0, CICR2, lch);
 
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR(lch));
+		dma_write(0, CCR2, lch);
 		omap_clear_dma(lch);
 	}
 
@@ -880,7 +1104,7 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 	reg |= (0x3 & tparams) << 12;
 	reg |= (arb_rate & 0xff) << 16;
 
-	dma_write(reg, GCR);
+	dma_write(reg, GCR2, 0);
 }
 EXPORT_SYMBOL(omap_dma_set_global_params);
 
@@ -903,14 +1127,18 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		printk(KERN_ERR "Invalid channel id\n");
 		return -EINVAL;
 	}
-	l = dma_read(CCR(lch));
-	l &= ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
+
+	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx()) {
+		l = dma_read(CCR2, lch);
+		l &= ~((1 << 6) | (1 << 26));
 		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
-	else
+		dma_write(l, CCR2, lch);
+	} else {
+		l = dma_read(CCR1, lch);
+		l &= ~((1 << 6) | (1 << 26));
 		l |= ((read_prio & 0x1) << 6);
-
-	dma_write(l, CCR(lch));
+		dma_write(l, CCR1, lch);
+	}
 
 	return 0;
 }
@@ -929,19 +1157,19 @@ void omap_clear_dma(int lch)
 	if (cpu_class_is_omap1()) {
 		u32 l;
 
-		l = dma_read(CCR(lch));
+		l = dma_read(CCR1, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR(lch));
+		dma_write(l, CCR1, lch);
 
 		/* Clear pending interrupts */
-		l = dma_read(CSR(lch));
+		l = dma_read(CSR1, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
-		int i;
-		void __iomem *lch_base = omap_dma_base + OMAP_DMA4_CH_BASE(lch);
-		for (i = 0; i < 0x44; i += 4)
-			__raw_writel(0, lch_base + i);
+		int i = OMAP2_CH_COMMON_START;
+
+		for (; i <= OMAP2_CH_COMMON_END; i++)
+			dma_write(0, i, lch);
 	}
 
 	local_irq_restore(flags);
@@ -957,9 +1185,12 @@ void omap_start_dma(int lch)
 	 * before starting dma transfer.
 	 */
 	if (cpu_is_omap15xx())
-		dma_write(0, CPC(lch));
+		dma_write(0, CPC, lch);
+	else if (cpu_class_is_omap1())
+		dma_write(0, CDAC1, lch);
 	else
-		dma_write(0, CDAC(lch));
+		dma_write(0, CDAC2, lch);
+
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
@@ -989,29 +1220,33 @@ void omap_start_dma(int lch)
 		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
 
 		/* Errata: Need to write lch even if not using chaining */
-		dma_write(lch, CLNK_CTRL(lch));
+		dma_write(lch, CLNK_CTRL2, lch);
 	}
 
 	omap_enable_channel_irq(lch);
 
-	l = dma_read(CCR(lch));
-
-	/*
-	 * Errata: Inter Frame DMA buffering issue (All OMAP2420 and
-	 * OMAP2430ES1.0): DMA will wrongly buffer elements if packing and
-	 * bursting is enabled. This might result in data gets stalled in
-	 * FIFO at the end of the block.
-	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
-	 * guarantee no data will stay in the DMA FIFO in case inter frame
-	 * buffering occurs.
-	 */
-	if (cpu_is_omap2420() ||
-	    (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
-		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
-
-	l |= OMAP_DMA_CCR_EN;
-	dma_write(l, CCR(lch));
+	if (cpu_class_is_omap1()) {
+		l = dma_read(CCR1, lch);
+		l |= OMAP_DMA_CCR_EN;
+		dma_write(l, CCR1, lch);
+	} else {
+		l = dma_read(CCR2, lch);
+		/*
+		 * Errata: Inter Frame DMA buffering issue (All OMAP2420 and
+		 * OMAP2430ES1.0): DMA will wrongly buffer elements if packing
+		 * and bursting is enabled. This might result in data gets
+		 * stalled in FIFO at the end of the block.
+		 * Workaround: DMA channels must have BUFFERING_DISABLED bit
+		 * set to guarantee no data will stay in the DMA FIFO in case
+		 * inter frame buffering occurs.
+		 */
+		if (cpu_is_omap2420() || (cpu_is_omap2430() &&
+				(omap_type() == OMAP2430_REV_ES1_0)))
+			l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 
+		l |= OMAP_DMA_CCR_EN;
+		dma_write(l, CCR2, lch);
+	}
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
 EXPORT_SYMBOL(omap_start_dma);
@@ -1022,41 +1257,45 @@ void omap_stop_dma(int lch)
 
 	/* Disable all interrupts on the channel */
 	if (cpu_class_is_omap1())
-		dma_write(0, CICR(lch));
+		dma_write(0, CICR1, lch);
 
-	l = dma_read(CCR(lch));
 	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
 	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
 		u32 sys_cf;
 
 		/* Configure No-Standby */
-		l = dma_read(OCP_SYSCONFIG);
+		l = dma_read(OCP_SYSCONFIG, 0);
 		sys_cf = l;
 		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
 		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		dma_write(l , OCP_SYSCONFIG);
+		dma_write(l , OCP_SYSCONFIG, 0);
 
-		l = dma_read(CCR(lch));
+		l = dma_read(CCR2, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR(lch));
+		dma_write(l, CCR2, lch);
 
 		/* Wait for sDMA FIFO drain */
-		l = dma_read(CCR(lch));
+		l = dma_read(CCR2, lch);
 		while (i < 100 && (l & (OMAP_DMA_CCR_RD_ACTIVE |
 					OMAP_DMA_CCR_WR_ACTIVE))) {
 			udelay(5);
 			i++;
-			l = dma_read(CCR(lch));
+			l = dma_read(CCR2, lch);
 		}
 		if (i >= 100)
 			printk(KERN_ERR "DMA drain did not complete on "
 					"lch %d\n", lch);
 		/* Restore OCP_SYSCONFIG */
-		dma_write(sys_cf, OCP_SYSCONFIG);
+		dma_write(sys_cf, OCP_SYSCONFIG, 0);
+	} else if (cpu_class_is_omap1()) {
+		l = dma_read(CCR1, lch);
+		l &= ~OMAP_DMA_CCR_EN;
+		dma_write(l, CCR1, lch);
 	} else {
+		l = dma_read(CCR2, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR(lch));
+		dma_write(l, CCR2, lch);
 	}
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
@@ -1122,19 +1361,25 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_is_omap15xx())
-		offset = dma_read(CPC(lch));
+		offset = dma_read(CPC, lch);
+	else if (cpu_class_is_omap1())
+		offset = dma_read(CSAC1, lch);
 	else
-		offset = dma_read(CSAC(lch));
+		offset = dma_read(CSAC2, lch);
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
 	 * read before the DMA controller finished disabling the channel.
 	 */
-	if (!cpu_is_omap15xx() && offset == 0)
-		offset = dma_read(CSAC(lch));
+	if (!cpu_is_omap15xx() && offset == 0) {
+		if (cpu_class_is_omap1())
+			offset = dma_read(CSAC1, lch);
+		else
+			offset = dma_read(CSAC2, lch);
+	}
 
 	if (cpu_class_is_omap1())
-		offset |= (dma_read(CSSA_U(lch)) << 16);
+		offset |= (dma_read(CSSA_U, lch) << 16);
 
 	return offset;
 }
@@ -1153,19 +1398,25 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_is_omap15xx())
-		offset = dma_read(CPC(lch));
+		offset = dma_read(CPC, lch);
+	else if (cpu_class_is_omap1())
+		offset = dma_read(CDAC1, lch);
 	else
-		offset = dma_read(CDAC(lch));
+		offset = dma_read(CDAC2, lch);
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
 	 * read before the DMA controller finished disabling the channel.
 	 */
-	if (!cpu_is_omap15xx() && offset == 0)
-		offset = dma_read(CDAC(lch));
+	if (!cpu_is_omap15xx() && offset == 0) {
+		if (cpu_class_is_omap1())
+			offset = dma_read(CDAC1, lch);
+		else
+			offset = dma_read(CDAC2, lch);
+	}
 
 	if (cpu_class_is_omap1())
-		offset |= (dma_read(CDSA_U(lch)) << 16);
+		offset |= (dma_read(CDSA_U, lch) << 16);
 
 	return offset;
 }
@@ -1173,7 +1424,10 @@ EXPORT_SYMBOL(omap_get_dma_dst_pos);
 
 int omap_get_dma_active_status(int lch)
 {
-	return (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN) != 0;
+	if (cpu_class_is_omap1())
+		return (dma_read(CCR1, lch) & OMAP_DMA_CCR_EN) != 0;
+	else
+		return (dma_read(CCR2, lch) & OMAP_DMA_CCR_EN) != 0;
 }
 EXPORT_SYMBOL(omap_get_dma_active_status);
 
@@ -1181,14 +1435,15 @@ int omap_dma_running(void)
 {
 	int lch;
 
-	if (cpu_class_is_omap1())
-		if (omap_lcd_dma_running())
-			return 1;
-
-	for (lch = 0; lch < dma_chan_count; lch++)
-		if (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN)
-			return 1;
-
+	for (lch = 0; lch < dma_chan_count; lch++) {
+		if (cpu_class_is_omap1()) {
+			if (dma_read(CCR1, lch) & OMAP_DMA_CCR_EN)
+				return 1;
+		} else {
+			if (dma_read(CCR2, lch) & OMAP_DMA_CCR_EN)
+				return 1;
+		}
+	}
 	return 0;
 }
 
@@ -1201,8 +1456,8 @@ void omap_dma_link_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR(lch_head)) | (3 << 8),
-								CCR(lch_head));
+			dma_write(dma_read(CCR1, lch_head) | (3 << 8),
+							CCR1, lch_head);
 			return;
 		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1228,8 +1483,8 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR(lch_head)) & ~(3 << 8),
-								CCR(lch_head));
+			dma_write(dma_read(CCR1, lch_head) & ~(3 << 8),
+								CCR1, lch_head);
 			return;
 		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1281,15 +1536,15 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 					lch_queue;
 	}
 
-	l = dma_read(CLNK_CTRL(lch_head));
+	l = dma_read(CLNK_CTRL2, lch_head);
 	l &= ~(0x1f);
 	l |= lch_queue;
-	dma_write(l, CLNK_CTRL(lch_head));
+	dma_write(l, CLNK_CTRL2, lch_head);
 
-	l = dma_read(CLNK_CTRL(lch_queue));
+	l = dma_read(CLNK_CTRL2, lch_queue);
 	l &= ~(0x1f);
 	l |= (dma_chan[lch_queue].next_linked_ch);
-	dma_write(l, CLNK_CTRL(lch_queue));
+	dma_write(l, CLNK_CTRL2, lch_queue);
 }
 
 /**
@@ -1565,13 +1820,13 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 
 	/* Set the params to the free channel */
 	if (src_start != 0)
-		dma_write(src_start, CSSA(lch));
+		dma_write(src_start, CSSA, lch);
 	if (dest_start != 0)
-		dma_write(dest_start, CDSA(lch));
+		dma_write(dest_start, CDSA, lch);
 
 	/* Write the buffer size */
-	dma_write(elem_count, CEN(lch));
-	dma_write(frame_count, CFN(lch));
+	dma_write(elem_count, CEN2, lch);
+	dma_write(frame_count, CFN2, lch);
 
 	/*
 	 * If the chain is dynamically linked,
@@ -1605,7 +1860,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 				dma_chan[lch].state = DMA_CH_QUEUED;
 				start_dma = 0;
 				if (0 == ((1 << 7) & dma_read(
-					CCR(dma_chan[lch].prev_linked_ch)))) {
+					CCR2, dma_chan[lch].prev_linked_ch))) {
 					disable_lnk(dma_chan[lch].
 						    prev_linked_ch);
 					pr_debug("\n prev ch is stopped\n");
@@ -1621,7 +1876,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			}
 			omap_enable_channel_irq(lch);
 
-			l = dma_read(CCR(lch));
+			l = dma_read(CCR2, lch);
 
 			if ((0 == (l & (1 << 24))))
 				l &= ~(1 << 25);
@@ -1632,12 +1887,12 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 					l |= (1 << 7);
 					dma_chan[lch].state = DMA_CH_STARTED;
 					pr_debug("starting %d\n", lch);
-					dma_write(l, CCR(lch));
+					dma_write(l, CCR2, lch);
 				} else
 					start_dma = 0;
 			} else {
 				if (0 == (l & (1 << 7)))
-					dma_write(l, CCR(lch));
+					dma_write(l, CCR2, lch);
 			}
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
@@ -1682,7 +1937,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 		omap_enable_channel_irq(channels[0]);
 	}
 
-	l = dma_read(CCR(channels[0]));
+	l = dma_read(CCR2, channels[0]);
 	l |= (1 << 7);
 	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
 	dma_chan[channels[0]].state = DMA_CH_STARTED;
@@ -1691,7 +1946,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 		l &= ~(1 << 25);
 	else
 		l |= (1 << 25);
-	dma_write(l, CCR(channels[0]));
+	dma_write(l, CCR2, channels[0]);
 
 	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
 
@@ -1730,18 +1985,18 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	 * DMA Errata:
 	 * Special programming model needed to disable DMA before end of block
 	 */
-	sys_cf = dma_read(OCP_SYSCONFIG);
+	sys_cf = dma_read(OCP_SYSCONFIG, 0);
 	l = sys_cf;
 	/* Middle mode reg set no Standby */
 	l &= ~((1 << 12)|(1 << 13));
-	dma_write(l, OCP_SYSCONFIG);
+	dma_write(l, OCP_SYSCONFIG, 0);
 
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
 
 		/* Stop the Channel transmission */
-		l = dma_read(CCR(channels[i]));
+		l = dma_read(CCR2, channels[i]);
 		l &= ~(1 << 7);
-		dma_write(l, CCR(channels[i]));
+		dma_write(l, CCR2, channels[i]);
 
 		/* Disable the link in all the channels */
 		disable_lnk(channels[i]);
@@ -1754,7 +2009,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
 	/* Errata - put in the old value */
-	dma_write(sys_cf, OCP_SYSCONFIG);
+	dma_write(sys_cf, OCP_SYSCONFIG, 0);
 
 	return 0;
 }
@@ -1796,8 +2051,8 @@ int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	*ei = dma_read(CCEN(lch));
-	*fi = dma_read(CCFN(lch));
+	*ei = dma_read(CCEN, lch);
+	*fi = dma_read(CCFN, lch);
 
 	return 0;
 }
@@ -1834,7 +2089,7 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return dma_read(CDAC(lch));
+	return dma_read(CDAC2, lch);
 }
 EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
 
@@ -1868,7 +2123,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return dma_read(CSAC(lch));
+	return dma_read(CSAC2, lch);
 }
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */
@@ -1885,7 +2140,7 @@ static int omap1_dma_handle_ch(int ch)
 		csr = dma_chan[ch].saved_csr;
 		dma_chan[ch].saved_csr = 0;
 	} else
-		csr = dma_read(CSR(ch));
+		csr = dma_read(CSR1, ch);
 	if (enable_1510_mode && ch <= 2 && (csr >> 7) != 0) {
 		dma_chan[ch + 6].saved_csr = csr >> 7;
 		csr &= 0x7f;
@@ -1938,13 +2193,13 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 
 static int omap2_dma_handle_ch(int ch)
 {
-	u32 status = dma_read(CSR(ch));
+	u32 status = dma_read(CSR2, ch);
 
 	if (!status) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
 				ch);
-		dma_write(1 << ch, IRQSTATUS_L0);
+		dma_write(1 << ch, IRQSTATUS_L0, 0);
 		return 0;
 	}
 	if (unlikely(dma_chan[ch].dev_id == -1)) {
@@ -1968,9 +2223,9 @@ static int omap2_dma_handle_ch(int ch)
 			 */
 			u32 ccr;
 
-			ccr = dma_read(CCR(ch));
+			ccr = dma_read(CCR2, ch);
 			ccr &= ~OMAP_DMA_CCR_EN;
-			dma_write(ccr, CCR(ch));
+			dma_write(ccr, CCR2, ch);
 			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
 		}
 	}
@@ -1981,16 +2236,16 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO "DMA misaligned error with device %d\n",
 		       dma_chan[ch].dev_id);
 
-	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
-	dma_write(1 << ch, IRQSTATUS_L0);
+	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, ch);
+	dma_write(1 << ch, IRQSTATUS_L0, ch);
 	/* read back the register to flush the write */
-	dma_read(IRQSTATUS_L0);
+	dma_read(IRQSTATUS_L0, ch);
 
 	/* If the ch is not chained then chain_id will be -1 */
 	if (dma_chan[ch].chain_id != -1) {
 		int chain_id = dma_chan[ch].chain_id;
 		dma_chan[ch].state = DMA_CH_NOTSTARTED;
-		if (dma_read(CLNK_CTRL(ch)) & (1 << 15))
+		if (dma_read(CLNK_CTRL2, ch) & (1 << 15))
 			dma_chan[dma_chan[ch].next_linked_ch].state =
 							DMA_CH_STARTED;
 		if (dma_linked_lch[chain_id].chain_mode ==
@@ -2000,10 +2255,10 @@ static int omap2_dma_handle_ch(int ch)
 		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
 			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
 
-		status = dma_read(CSR(ch));
+		status = dma_read(CSR2, ch);
 	}
 
-	dma_write(status, CSR(ch));
+	dma_write(status, CSR2, ch);
 
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
@@ -2017,13 +2272,13 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 	u32 val, enable_reg;
 	int i;
 
-	val = dma_read(IRQSTATUS_L0);
+	val = dma_read(IRQSTATUS_L0, 0);
 	if (val == 0) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
 		return IRQ_HANDLED;
 	}
-	enable_reg = dma_read(IRQENABLE_L0);
+	enable_reg = dma_read(IRQENABLE_L0, 0);
 	val &= enable_reg; /* Dispatch only relevant interrupts */
 	for (i = 0; i < dma_lch_count && val != 0; i++) {
 		if (val & 1)
@@ -2049,21 +2304,21 @@ static struct irqaction omap24xx_dma_irq;
 void omap_dma_global_context_save(void)
 {
 	omap_dma_global_context.dma_irqenable_l0 =
-		dma_read(IRQENABLE_L0);
+		dma_read(IRQENABLE_L0, 0);
 	omap_dma_global_context.dma_ocp_sysconfig =
-		dma_read(OCP_SYSCONFIG);
-	omap_dma_global_context.dma_gcr = dma_read(GCR);
+		dma_read(OCP_SYSCONFIG, 0);
+	omap_dma_global_context.dma_gcr = dma_read(GCR2, 0);
 }
 
 void omap_dma_global_context_restore(void)
 {
 	int ch;
 
-	dma_write(omap_dma_global_context.dma_gcr, GCR);
+	dma_write(omap_dma_global_context.dma_gcr, GCR2, 0);
 	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
-		OCP_SYSCONFIG);
+		OCP_SYSCONFIG, 0);
 	dma_write(omap_dma_global_context.dma_irqenable_l0,
-		IRQENABLE_L0);
+		IRQENABLE_L0, 0);
 
 	/*
 	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
@@ -2072,7 +2327,7 @@ void omap_dma_global_context_restore(void)
 	 * affects only secure devices.
 	 */
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
-		dma_write(0x3 , IRQSTATUS_L0);
+		dma_write(0x3 , IRQSTATUS_L0, 0);
 
 	for (ch = 0; ch < dma_chan_count; ch++)
 		if (dma_chan[ch].dev_id != -1)
@@ -2103,8 +2358,8 @@ static int __init omap_init_dma(void)
 		return -ENODEV;
 	}
 
-	omap_dma_base = ioremap(base, SZ_4K);
-	BUG_ON(!omap_dma_base);
+	dma_base = ioremap(base, SZ_4K);
+	BUG_ON(!dma_base);
 
 	if (cpu_class_is_omap2() && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
@@ -2132,26 +2387,26 @@ static int __init omap_init_dma(void)
 		enable_1510_mode = 1;
 	} else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
 		printk(KERN_INFO "OMAP DMA hardware version %d\n",
-		       dma_read(HW_ID));
+		       dma_read(HW_ID, 0));
 		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
-		       (dma_read(CAPS_0_U) << 16) |
-		       dma_read(CAPS_0_L),
-		       (dma_read(CAPS_1_U) << 16) |
-		       dma_read(CAPS_1_L),
-		       dma_read(CAPS_2), dma_read(CAPS_3),
-		       dma_read(CAPS_4));
+		       (dma_read(CAPS1_0_U, 0) << 16) |
+		       dma_read(CAPS1_0_L, 0),
+		       (dma_read(CAPS1_1_U, 0) << 16) |
+		       dma_read(CAPS1_1_L, 0),
+		       dma_read(CAPS1_2, 0), dma_read(CAPS1_3, 0),
+		       dma_read(CAPS1_4, 0));
 		if (!enable_1510_mode) {
 			u16 w;
 
 			/* Disable OMAP 3.0/3.1 compatibility mode. */
-			w = dma_read(GSCR);
+			w = dma_read(GSCR, 0);
 			w |= 1 << 3;
-			dma_write(w, GSCR);
+			dma_write(w, GSCR, 0);
 			dma_chan_count = 16;
 		} else
 			dma_chan_count = 9;
 	} else if (cpu_class_is_omap2()) {
-		u8 revision = dma_read(REVISION) & 0xff;
+		u8 revision = dma_read(REVISION, 0) & 0xff;
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
 		dma_chan_count = dma_lch_count;
@@ -2210,14 +2465,14 @@ static int __init omap_init_dma(void)
 
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		/* Enable smartidle idlemodes and autoidle */
-		u32 v = dma_read(OCP_SYSCONFIG);
+		u32 v = dma_read(OCP_SYSCONFIG, 0);
 		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
 				DMA_SYSCONFIG_SIDLEMODE_MASK |
 				DMA_SYSCONFIG_AUTOIDLE);
 		v |= (DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
 			DMA_SYSCONFIG_SIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
 			DMA_SYSCONFIG_AUTOIDLE);
-		dma_write(v , OCP_SYSCONFIG);
+		dma_write(v , OCP_SYSCONFIG, 0);
 		/* reserve dma channels 0 and 1 in high security devices */
 		if (cpu_is_omap34xx() &&
 			(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
@@ -2234,7 +2489,7 @@ out_free:
 	kfree(dma_chan);
 
 out_unmap:
-	iounmap(omap_dma_base);
+	iounmap(dma_base);
 
 	return r;
 }
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 0cce4ca..27578f3 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -27,134 +27,14 @@
 /* Hardware registers for omap1 */
 #define OMAP1_DMA_BASE			(0xfffed800)
 
-#define OMAP1_DMA_GCR			0x400
-#define OMAP1_DMA_GSCR			0x404
-#define OMAP1_DMA_GRST			0x408
-#define OMAP1_DMA_HW_ID			0x442
-#define OMAP1_DMA_PCH2_ID		0x444
-#define OMAP1_DMA_PCH0_ID		0x446
-#define OMAP1_DMA_PCH1_ID		0x448
-#define OMAP1_DMA_PCHG_ID		0x44a
-#define OMAP1_DMA_PCHD_ID		0x44c
-#define OMAP1_DMA_CAPS_0_U		0x44e
-#define OMAP1_DMA_CAPS_0_L		0x450
-#define OMAP1_DMA_CAPS_1_U		0x452
-#define OMAP1_DMA_CAPS_1_L		0x454
-#define OMAP1_DMA_CAPS_2		0x456
-#define OMAP1_DMA_CAPS_3		0x458
-#define OMAP1_DMA_CAPS_4		0x45a
-#define OMAP1_DMA_PCH2_SR		0x460
-#define OMAP1_DMA_PCH0_SR		0x480
-#define OMAP1_DMA_PCH1_SR		0x482
-#define OMAP1_DMA_PCHD_SR		0x4c0
-
 /* Hardware registers for omap2 and omap3 */
 #define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
 #define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
 #define OMAP44XX_DMA4_BASE		(L4_44XX_BASE + 0x56000)
 
-#define OMAP_DMA4_REVISION		0x00
-#define OMAP_DMA4_GCR			0x78
-#define OMAP_DMA4_IRQSTATUS_L0		0x08
-#define OMAP_DMA4_IRQSTATUS_L1		0x0c
-#define OMAP_DMA4_IRQSTATUS_L2		0x10
-#define OMAP_DMA4_IRQSTATUS_L3		0x14
-#define OMAP_DMA4_IRQENABLE_L0		0x18
-#define OMAP_DMA4_IRQENABLE_L1		0x1c
-#define OMAP_DMA4_IRQENABLE_L2		0x20
-#define OMAP_DMA4_IRQENABLE_L3		0x24
-#define OMAP_DMA4_SYSSTATUS		0x28
-#define OMAP_DMA4_OCP_SYSCONFIG		0x2c
-#define OMAP_DMA4_CAPS_0		0x64
-#define OMAP_DMA4_CAPS_2		0x6c
-#define OMAP_DMA4_CAPS_3		0x70
-#define OMAP_DMA4_CAPS_4		0x74
-
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
 #define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
 
-/* Common channel specific registers for omap1 */
-#define OMAP1_DMA_CH_BASE(n)		(0x40 * (n) + 0x00)
-#define OMAP1_DMA_CSDP(n)		(0x40 * (n) + 0x00)
-#define OMAP1_DMA_CCR(n)		(0x40 * (n) + 0x02)
-#define OMAP1_DMA_CICR(n)		(0x40 * (n) + 0x04)
-#define OMAP1_DMA_CSR(n)		(0x40 * (n) + 0x06)
-#define OMAP1_DMA_CEN(n)		(0x40 * (n) + 0x10)
-#define OMAP1_DMA_CFN(n)		(0x40 * (n) + 0x12)
-#define OMAP1_DMA_CSFI(n)		(0x40 * (n) + 0x14)
-#define OMAP1_DMA_CSEI(n)		(0x40 * (n) + 0x16)
-#define OMAP1_DMA_CPC(n)		(0x40 * (n) + 0x18)	/* 15xx only */
-#define OMAP1_DMA_CSAC(n)		(0x40 * (n) + 0x18)
-#define OMAP1_DMA_CDAC(n)		(0x40 * (n) + 0x1a)
-#define OMAP1_DMA_CDEI(n)		(0x40 * (n) + 0x1c)
-#define OMAP1_DMA_CDFI(n)		(0x40 * (n) + 0x1e)
-#define OMAP1_DMA_CLNK_CTRL(n)		(0x40 * (n) + 0x28)
-
-/* Common channel specific registers for omap2 */
-#define OMAP_DMA4_CH_BASE(n)		(0x60 * (n) + 0x80)
-#define OMAP_DMA4_CCR(n)		(0x60 * (n) + 0x80)
-#define OMAP_DMA4_CLNK_CTRL(n)		(0x60 * (n) + 0x84)
-#define OMAP_DMA4_CICR(n)		(0x60 * (n) + 0x88)
-#define OMAP_DMA4_CSR(n)		(0x60 * (n) + 0x8c)
-#define OMAP_DMA4_CSDP(n)		(0x60 * (n) + 0x90)
-#define OMAP_DMA4_CEN(n)		(0x60 * (n) + 0x94)
-#define OMAP_DMA4_CFN(n)		(0x60 * (n) + 0x98)
-#define OMAP_DMA4_CSEI(n)		(0x60 * (n) + 0xa4)
-#define OMAP_DMA4_CSFI(n)		(0x60 * (n) + 0xa8)
-#define OMAP_DMA4_CDEI(n)		(0x60 * (n) + 0xac)
-#define OMAP_DMA4_CDFI(n)		(0x60 * (n) + 0xb0)
-#define OMAP_DMA4_CSAC(n)		(0x60 * (n) + 0xb4)
-#define OMAP_DMA4_CDAC(n)		(0x60 * (n) + 0xb8)
-
-/* Channel specific registers only on omap1 */
-#define OMAP1_DMA_CSSA_L(n)		(0x40 * (n) + 0x08)
-#define OMAP1_DMA_CSSA_U(n)		(0x40 * (n) + 0x0a)
-#define OMAP1_DMA_CDSA_L(n)		(0x40 * (n) + 0x0c)
-#define OMAP1_DMA_CDSA_U(n)		(0x40 * (n) + 0x0e)
-#define OMAP1_DMA_COLOR_L(n)		(0x40 * (n) + 0x20)
-#define OMAP1_DMA_COLOR_U(n)		(0x40 * (n) + 0x22)
-#define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
-#define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)	/* not on 15xx */
-#define OMAP1_DMA_CCEN(n)		0
-#define OMAP1_DMA_CCFN(n)		0
-
-/* Channel specific registers only on omap2 */
-#define OMAP_DMA4_CSSA(n)		(0x60 * (n) + 0x9c)
-#define OMAP_DMA4_CDSA(n)		(0x60 * (n) + 0xa0)
-#define OMAP_DMA4_CCEN(n)		(0x60 * (n) + 0xbc)
-#define OMAP_DMA4_CCFN(n)		(0x60 * (n) + 0xc0)
-#define OMAP_DMA4_COLOR(n)		(0x60 * (n) + 0xc4)
-
-/* Additional registers available on OMAP4 */
-#define OMAP_DMA4_CDP(n)		(0x60 * (n) + 0xd0)
-#define OMAP_DMA4_CNDP(n)		(0x60 * (n) + 0xd4)
-#define OMAP_DMA4_CCDN(n)		(0x60 * (n) + 0xd8)
-
-/* Dummy defines to keep multi-omap compiles happy */
-#define OMAP1_DMA_REVISION		0
-#define OMAP1_DMA_IRQSTATUS_L0		0
-#define OMAP1_DMA_IRQENABLE_L0		0
-#define OMAP1_DMA_OCP_SYSCONFIG		0
-#define OMAP_DMA4_HW_ID			0
-#define OMAP_DMA4_CAPS_0_L		0
-#define OMAP_DMA4_CAPS_0_U		0
-#define OMAP_DMA4_CAPS_1_L		0
-#define OMAP_DMA4_CAPS_1_U		0
-#define OMAP_DMA4_GSCR			0
-#define OMAP_DMA4_CPC(n)		0
-
-#define OMAP_DMA4_LCH_CTRL(n)		0
-#define OMAP_DMA4_COLOR_L(n)		0
-#define OMAP_DMA4_COLOR_U(n)		0
-#define OMAP_DMA4_CCR2(n)		0
-#define OMAP1_DMA_CSSA(n)		0
-#define OMAP1_DMA_CDSA(n)		0
-#define OMAP_DMA4_CSSA_L(n)		0
-#define OMAP_DMA4_CSSA_U(n)		0
-#define OMAP_DMA4_CDSA_L(n)		0
-#define OMAP_DMA4_CDSA_U(n)		0
-#define OMAP1_DMA_COLOR(n)		0
-
 /*----------------------------------------------------------------------------*/
 
 /* DMA channels for omap1 */
-- 
1.7.1

