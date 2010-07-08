From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 10/10] OMAP: DMA: Cleanup DMA library and enable DMA platform driver
Date: Fri,  9 Jul 2010 04:21:22 +0530
Message-ID: <1278629482-32501-11-git-send-email-manjugk@ti.com>
References: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39652 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758716Ab0GHWyL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 18:54:11 -0400
In-Reply-To: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

This patch will cleanup DMA library in plat-omap and converts the
the same into platform driver and makes use of hwmod database and
structures for DMA configuration. As a part of platform driver
conversion and hwmod support, the API's are cleaned up so that
cpu_is_xxxx checks are eliminated and corresponding API/source code
is moved to machine specific directories.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/Makefile          |    2 +-
 arch/arm/mach-omap2/Makefile          |    2 +-
 arch/arm/plat-omap/dma.c              | 1968 +++++++--------------------------
 arch/arm/plat-omap/include/plat/dma.h |  320 ++----
 4 files changed, 465 insertions(+), 1827 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index fd4df71..a159af4 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
+obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o dma.o
 obj-y += clock.o clock_data.o opp_data.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ae5f36f..3c5557a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o dma.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index f7f571e..418187a 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -39,402 +39,77 @@
 
 #undef DEBUG
 
-#ifndef CONFIG_ARCH_OMAP1
-enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
-	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
-};
-
-enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
-#endif
-
-#define OMAP_DMA_ACTIVE			0x01
-#define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
-
-#define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
-
-static int enable_1510_mode;
-
-static struct omap_dma_global_context_registers {
-	u32 dma_irqenable_l0;
-	u32 dma_ocp_sysconfig;
-	u32 dma_gcr;
-} omap_dma_global_context;
-
-struct omap_dma_lch {
-	int next_lch;
-	int dev_id;
-	u16 saved_csr;
-	u16 enabled_irqs;
-	const char *dev_name;
-	void (*callback)(int lch, u16 ch_status, void *data);
-	void *data;
-
-#ifndef CONFIG_ARCH_OMAP1
-	/* required for Dynamic chaining */
-	int prev_linked_ch;
-	int next_linked_ch;
-	int state;
-	int chain_id;
-
-	int status;
-#endif
-	long flags;
-};
-
-struct dma_link_info {
-	int *linked_dmach_q;
-	int no_of_lchs_linked;
-
-	int q_count;
-	int q_tail;
-	int q_head;
-
-	int chain_state;
-	int chain_mode;
-
-};
-
-static struct dma_link_info *dma_linked_lch;
-
-#ifndef CONFIG_ARCH_OMAP1
-
-/* Chain handling macros */
-#define OMAP_DMA_CHAIN_QINIT(chain_id)					\
-	do {								\
-		dma_linked_lch[chain_id].q_head =			\
-		dma_linked_lch[chain_id].q_tail =			\
-		dma_linked_lch[chain_id].q_count = 0;			\
-	} while (0)
-#define OMAP_DMA_CHAIN_QFULL(chain_id)					\
-		(dma_linked_lch[chain_id].no_of_lchs_linked ==		\
-		dma_linked_lch[chain_id].q_count)
-#define OMAP_DMA_CHAIN_QLAST(chain_id)					\
-	do {								\
-		((dma_linked_lch[chain_id].no_of_lchs_linked-1) ==	\
-		dma_linked_lch[chain_id].q_count)			\
-	} while (0)
-#define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
-		(0 == dma_linked_lch[chain_id].q_count)
-#define __OMAP_DMA_CHAIN_INCQ(end)					\
-	((end) = ((end)+1) % dma_linked_lch[chain_id].no_of_lchs_linked)
-#define OMAP_DMA_CHAIN_INCQHEAD(chain_id)				\
-	do {								\
-		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_head);	\
-		dma_linked_lch[chain_id].q_count--;			\
-	} while (0)
-
-#define OMAP_DMA_CHAIN_INCQTAIL(chain_id)				\
-	do {								\
-		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_tail);	\
-		dma_linked_lch[chain_id].q_count++; \
-	} while (0)
-#endif
-
-static int dma_lch_count;
 static int dma_chan_count;
 static int omap_dma_reserve_channels;
 
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
-static void __iomem *omap_dma_base;
-
-static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
-	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
-	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
-	INT_1610_DMA_CH8, INT_1610_DMA_CH9, INT_1610_DMA_CH10,
-	INT_1610_DMA_CH11, INT_1610_DMA_CH12, INT_1610_DMA_CH13,
-	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
-};
 
-static inline void disable_lnk(int lch);
-static void omap_disable_channel_irq(int lch);
-static inline void omap_enable_channel_irq(int lch);
+/*
+ * TODO : clean up usage of below variables since it contains
+ * device instance information.
+ */
+static void __iomem *omap_dma_base;
+struct omap_system_dma_plat_info *p;
+static struct omap_dma_reg_offset *r;
+static struct omap_dma_dev_attr *d;
 
-#define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
-						__func__);
 
-#define dma_read(reg)							\
+#define dma_read(reg)						\
 ({									\
 	u32 __val;							\
-	if (cpu_class_is_omap1())					\
-		__val = __raw_readw(omap_dma_base + OMAP1_DMA_##reg);	\
+									\
+	if (d->dma_dev_attr & IS_WORD_16)				\
+		__val = __raw_readw(omap_dma_base + reg);		\
 	else								\
-		__val = __raw_readl(omap_dma_base + OMAP_DMA4_##reg);	\
-	__val;								\
+		__val = __raw_readl(omap_dma_base + reg);		\
+		__val;							\
 })
 
 #define dma_write(val, reg)						\
 ({									\
-	if (cpu_class_is_omap1())					\
-		__raw_writew((u16)(val), omap_dma_base + OMAP1_DMA_##reg); \
+	if (d->dma_dev_attr & IS_WORD_16)				\
+		__raw_writew((u16)(val), omap_dma_base + reg);		\
 	else								\
-		__raw_writel((val), omap_dma_base + OMAP_DMA4_##reg);	\
+		__raw_writel((val), omap_dma_base + reg);		\
 })
 
-#ifdef CONFIG_ARCH_OMAP15XX
-/* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
-int omap_dma_in_1510_mode(void)
-{
-	return enable_1510_mode;
-}
-#else
-#define omap_dma_in_1510_mode()		0
-#endif
-
-#ifdef CONFIG_ARCH_OMAP1
-static inline int get_gdma_dev(int req)
-{
-	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
-	int shift = ((req - 1) % 5) * 6;
-
-	return ((omap_readl(reg) >> shift) & 0x3f) + 1;
-}
-
-static inline void set_gdma_dev(int req, int dev)
-{
-	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
-	int shift = ((req - 1) % 5) * 6;
-	u32 l;
-
-	l = omap_readl(reg);
-	l &= ~(0x3f << shift);
-	l |= (dev - 1) << shift;
-	omap_writel(l, reg);
-}
-#else
-#define set_gdma_dev(req, dev)	do {} while (0)
-#endif
-
-/* Omap1 only */
-static void clear_lch_regs(int lch)
-{
-	int i;
-	void __iomem *lch_base = omap_dma_base + OMAP1_DMA_CH_BASE(lch);
-
-	for (i = 0; i < 0x2c; i += 2)
-		__raw_writew(0, lch_base + i);
-}
-
-void omap_set_dma_priority(int lch, int dst_port, int priority)
-{
-	unsigned long reg;
-	u32 l;
-
-	if (cpu_class_is_omap1()) {
-		switch (dst_port) {
-		case OMAP_DMA_PORT_OCP_T1:	/* FFFECC00 */
-			reg = OMAP_TC_OCPT1_PRIOR;
-			break;
-		case OMAP_DMA_PORT_OCP_T2:	/* FFFECCD0 */
-			reg = OMAP_TC_OCPT2_PRIOR;
-			break;
-		case OMAP_DMA_PORT_EMIFF:	/* FFFECC08 */
-			reg = OMAP_TC_EMIFF_PRIOR;
-			break;
-		case OMAP_DMA_PORT_EMIFS:	/* FFFECC04 */
-			reg = OMAP_TC_EMIFS_PRIOR;
-			break;
-		default:
-			BUG();
-			return;
-		}
-		l = omap_readl(reg);
-		l &= ~(0xf << 8);
-		l |= (priority & 0xf) << 8;
-		omap_writel(l, reg);
-	}
-
-	if (cpu_class_is_omap2()) {
-		u32 ccr;
-
-		ccr = dma_read(CCR(lch));
-		if (priority)
-			ccr |= (1 << 6);
-		else
-			ccr &= ~(1 << 6);
-		dma_write(ccr, CCR(lch));
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_priority);
-
-void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
-				  int frame_count, int sync_mode,
-				  int dma_trigger, int src_or_dst_synch)
-{
-	u32 l;
-
-	l = dma_read(CSDP(lch));
-	l &= ~0x03;
-	l |= data_type;
-	dma_write(l, CSDP(lch));
-
-	if (cpu_class_is_omap1()) {
-		u16 ccr;
-
-		ccr = dma_read(CCR(lch));
-		ccr &= ~(1 << 5);
-		if (sync_mode == OMAP_DMA_SYNC_FRAME)
-			ccr |= 1 << 5;
-		dma_write(ccr, CCR(lch));
-
-		ccr = dma_read(CCR2(lch));
-		ccr &= ~(1 << 2);
-		if (sync_mode == OMAP_DMA_SYNC_BLOCK)
-			ccr |= 1 << 2;
-		dma_write(ccr, CCR2(lch));
-	}
-
-	if (cpu_class_is_omap2() && dma_trigger) {
-		u32 val;
-
-		val = dma_read(CCR(lch));
-
-		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
-		val &= ~((3 << 19) | 0x1f);
-		val |= (dma_trigger & ~0x1f) << 14;
-		val |= dma_trigger & 0x1f;
-
-		if (sync_mode & OMAP_DMA_SYNC_FRAME)
-			val |= 1 << 5;
-		else
-			val &= ~(1 << 5);
-
-		if (sync_mode & OMAP_DMA_SYNC_BLOCK)
-			val |= 1 << 18;
-		else
-			val &= ~(1 << 18);
-
-		if (src_or_dst_synch)
-			val |= 1 << 24;		/* source synch */
-		else
-			val &= ~(1 << 24);	/* dest synch */
-
-		dma_write(val, CCR(lch));
-	}
-
-	dma_write(elem_count, CEN(lch));
-	dma_write(frame_count, CFN(lch));
-}
-EXPORT_SYMBOL(omap_set_dma_transfer_params);
-
-void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
-{
-	BUG_ON(omap_dma_in_1510_mode());
-
-	if (cpu_class_is_omap1()) {
-		u16 w;
-
-		w = dma_read(CCR2(lch));
-		w &= ~0x03;
-
-		switch (mode) {
-		case OMAP_DMA_CONSTANT_FILL:
-			w |= 0x01;
-			break;
-		case OMAP_DMA_TRANSPARENT_COPY:
-			w |= 0x02;
-			break;
-		case OMAP_DMA_COLOR_DIS:
-			break;
-		default:
-			BUG();
-		}
-		dma_write(w, CCR2(lch));
-
-		w = dma_read(LCH_CTRL(lch));
-		w &= ~0x0f;
-		/* Default is channel type 2D */
-		if (mode) {
-			dma_write((u16)color, COLOR_L(lch));
-			dma_write((u16)(color >> 16), COLOR_U(lch));
-			w |= 1;		/* Channel type G */
-		}
-		dma_write(w, LCH_CTRL(lch));
-	}
-
-	if (cpu_class_is_omap2()) {
-		u32 val;
-
-		val = dma_read(CCR(lch));
-		val &= ~((1 << 17) | (1 << 16));
-
-		switch (mode) {
-		case OMAP_DMA_CONSTANT_FILL:
-			val |= 1 << 16;
-			break;
-		case OMAP_DMA_TRANSPARENT_COPY:
-			val |= 1 << 17;
-			break;
-		case OMAP_DMA_COLOR_DIS:
-			break;
-		default:
-			BUG();
-		}
-		dma_write(val, CCR(lch));
-
-		color &= 0xffffff;
-		dma_write(color, COLOR(lch));
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_color_mode);
-
-void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
-{
-	if (cpu_class_is_omap2()) {
-		u32 csdp;
-
-		csdp = dma_read(CSDP(lch));
-		csdp &= ~(0x3 << 16);
-		csdp |= (mode << 16);
-		dma_write(csdp, CSDP(lch));
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_write_mode);
-
-void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
-{
-	if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
-		u32 l;
-
-		l = dma_read(LCH_CTRL(lch));
-		l &= ~0x7;
-		l |= mode;
-		dma_write(l, LCH_CTRL(lch));
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_channel_mode);
-
-/* Note that src_port is only for omap1 */
 void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 			     unsigned long src_start,
 			     int src_ei, int src_fi)
 {
-	u32 l;
+	u32 l, reg = 0;
 
-	if (cpu_class_is_omap1()) {
+	if (d->dma_dev_attr & SRC_PORT) {
 		u16 w;
-
-		w = dma_read(CSDP(lch));
+		reg = (r->lch_base * lch) + r->common_ch.csdp;
+		w = dma_read(reg);
 		w &= ~(0x1f << 2);
 		w |= src_port << 2;
-		dma_write(w, CSDP(lch));
+		dma_write(w, reg);
 	}
 
-	l = dma_read(CCR(lch));
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	l = dma_read(reg);
 	l &= ~(0x03 << 12);
 	l |= src_amode << 12;
-	dma_write(l, CCR(lch));
+	dma_write(l, reg);
 
-	if (cpu_class_is_omap1()) {
-		dma_write(src_start >> 16, CSSA_U(lch));
-		dma_write((u16)src_start, CSSA_L(lch));
+	if (!(d->dma_dev_attr & IS_CSSA_32)) {
+		reg = (r->lch_base * lch) + r->ch_specific.cssa_u;
+		dma_write(src_start >> 16, reg);
+		reg = (r->lch_base * lch) + r->ch_specific.cssa_l;
+		dma_write((u16)src_start, reg);
+	} else {
+		reg = (r->lch_base * lch) + r->ch_specific.cssa;
+		dma_write(src_start, reg);
+		l = dma_read(reg);
 	}
 
-	if (cpu_class_is_omap2())
-		dma_write(src_start, CSSA(lch));
-
-	dma_write(src_ei, CSEI(lch));
-	dma_write(src_fi, CSFI(lch));
+	reg = (r->lch_base * lch) + r->common_ch.csei;
+	dma_write(src_ei, reg);
+	reg = (r->lch_base * lch) + r->common_ch.csfi;
+	dma_write(src_fi, reg);
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
 
@@ -459,187 +134,171 @@ EXPORT_SYMBOL(omap_set_dma_params);
 
 void omap_set_dma_src_index(int lch, int eidx, int fidx)
 {
-	if (cpu_class_is_omap2())
-		return;
+	u32 reg;
 
-	dma_write(eidx, CSEI(lch));
-	dma_write(fidx, CSFI(lch));
+	if (d->dma_dev_attr & SRC_INDEX) {
+		reg = (r->lch_base * lch) + r->common_ch.csei;
+		dma_write(eidx, reg);
+		reg = (r->lch_base * lch) + r->common_ch.csfi;
+		dma_write(fidx, reg);
+	}
+	return;
 }
 EXPORT_SYMBOL(omap_set_dma_src_index);
 
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
-	u32 l;
+	u32 l, reg;
 
-	l = dma_read(CSDP(lch));
+	reg = (r->lch_base * lch) + r->common_ch.csdp;
+	l = dma_read(reg);
 	l &= ~(1 << 6);
 	if (enable)
 		l |= (1 << 6);
-	dma_write(l, CSDP(lch));
+	dma_write(l, reg);
 }
 EXPORT_SYMBOL(omap_set_dma_src_data_pack);
 
 void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
 	unsigned int burst = 0;
-	u32 l;
+	u32 l, reg;
 
-	l = dma_read(CSDP(lch));
+	reg = (r->lch_base * lch) + r->common_ch.csdp;
+	l = dma_read(reg);
 	l &= ~(0x03 << 7);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_class_is_omap2())
-			burst = 0x1;
-		else
+		if (d->dma_dev_attr & IS_BURST_ONLY4)
 			burst = 0x2;
+		else
+			burst = 0x1;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dma_dev_attr & IS_BURST_ONLY4)) {
 			burst = 0x2;
 			break;
 		}
-		/*
-		 * not supported by current hardware on OMAP1
-		 * w |= (0x03 << 7);
-		 * fall through
-		 */
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_class_is_omap2()) {
-			burst = 0x3;
+		if (!(d->dma_dev_attr & IS_BURST_ONLY4)) {
+			burst = 0x2;
 			break;
 		}
-		/*
-		 * OMAP1 don't support burst 16
-		 * fall through
-		 */
 	default:
 		BUG();
 	}
 
 	l |= (burst << 7);
-	dma_write(l, CSDP(lch));
+	dma_write(l, reg);
 }
 EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
 
-/* Note that dest_port is only for OMAP1 */
 void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 			      unsigned long dest_start,
 			      int dst_ei, int dst_fi)
 {
-	u32 l;
+	u32 l, reg;
 
-	if (cpu_class_is_omap1()) {
-		l = dma_read(CSDP(lch));
+	reg = (r->lch_base * lch) + r->common_ch.csdp;
+	if (d->dma_dev_attr & DST_PORT) {
+		l = dma_read(reg);
 		l &= ~(0x1f << 9);
 		l |= dest_port << 9;
-		dma_write(l, CSDP(lch));
+		dma_write(l, reg);
 	}
 
-	l = dma_read(CCR(lch));
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	l = dma_read(reg);
 	l &= ~(0x03 << 14);
 	l |= dest_amode << 14;
-	dma_write(l, CCR(lch));
+	dma_write(l, reg);
 
-	if (cpu_class_is_omap1()) {
-		dma_write(dest_start >> 16, CDSA_U(lch));
-		dma_write(dest_start, CDSA_L(lch));
+	if (!(d->dma_dev_attr & IS_CDSA_32)) {
+		reg = (r->lch_base * lch) + r->ch_specific.cdsa_u;
+		dma_write(dest_start >> 16, reg);
+		reg = (r->lch_base * lch) + r->ch_specific.cdsa_l;
+		dma_write(dest_start, reg);
+	} else {
+		reg = (r->lch_base * lch) + r->ch_specific.cdsa;
+		dma_write(dest_start, reg);
 	}
 
-	if (cpu_class_is_omap2())
-		dma_write(dest_start, CDSA(lch));
-
-	dma_write(dst_ei, CDEI(lch));
-	dma_write(dst_fi, CDFI(lch));
+	reg = (r->lch_base * lch) + r->common_ch.cdei;
+	dma_write(dst_ei, reg);
+	reg = (r->lch_base * lch) + r->common_ch.cdfi;
+	dma_write(dst_fi, reg);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
 
 void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 {
-	if (cpu_class_is_omap2())
-		return;
+	u32 reg;
 
-	dma_write(eidx, CDEI(lch));
-	dma_write(fidx, CDFI(lch));
+	if (d->dma_dev_attr & SRC_INDEX) {
+		reg = (r->lch_base * lch) + r->common_ch.cdei;
+		dma_write(eidx, reg);
+		reg = (r->lch_base * lch) + r->common_ch.cdfi;
+		dma_write(fidx, reg);
+	}
+	return;
 }
 EXPORT_SYMBOL(omap_set_dma_dest_index);
 
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
-	u32 l;
+	u32 l, reg;
 
-	l = dma_read(CSDP(lch));
+	reg = (r->lch_base * lch) + r->common_ch.csdp;
+	l = dma_read(reg);
 	l &= ~(1 << 13);
 	if (enable)
 		l |= 1 << 13;
-	dma_write(l, CSDP(lch));
+	dma_write(l, reg);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
 
 void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
 	unsigned int burst = 0;
-	u32 l;
+	u32 l, reg;
 
-	l = dma_read(CSDP(lch));
+	reg = (r->lch_base * lch) + r->common_ch.csdp;
+	l = dma_read(reg);
 	l &= ~(0x03 << 14);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_class_is_omap2())
-			burst = 0x1;
-		else
+		if (d->dma_dev_attr & IS_BURST_ONLY4)
 			burst = 0x2;
+		else
+			burst = 0x1;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_class_is_omap2())
-			burst = 0x2;
-		else
+		if (d->dma_dev_attr & IS_BURST_ONLY4)
 			burst = 0x3;
+		else
+			burst = 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dma_dev_attr & IS_BURST_ONLY4)) {
 			burst = 0x3;
 			break;
 		}
-		/*
-		 * OMAP1 don't support burst 16
-		 * fall through
-		 */
 	default:
 		printk(KERN_ERR "Invalid DMA burst mode\n");
 		BUG();
 		return;
 	}
 	l |= (burst << 14);
-	dma_write(l, CSDP(lch));
+	dma_write(l, reg);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
-static inline void omap_enable_channel_irq(int lch)
-{
-	u32 status;
-
-	/* Clear CSR */
-	if (cpu_class_is_omap1())
-		status = dma_read(CSR(lch));
-	else if (cpu_class_is_omap2())
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
-
-	/* Enable some nice interrupts. */
-	dma_write(dma_chan[lch].enabled_irqs, CICR(lch));
-}
-
-static void omap_disable_channel_irq(int lch)
-{
-	if (cpu_class_is_omap2())
-		dma_write(0, CICR(lch));
-}
-
 void omap_enable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs |= bits;
@@ -652,88 +311,14 @@ void omap_disable_dma_irq(int lch, u16 bits)
 }
 EXPORT_SYMBOL(omap_disable_dma_irq);
 
-static inline void enable_lnk(int lch)
-{
-	u32 l;
-
-	l = dma_read(CLNK_CTRL(lch));
-
-	if (cpu_class_is_omap1())
-		l &= ~(1 << 14);
-
-	/* Set the ENABLE_LNK bits */
-	if (dma_chan[lch].next_lch != -1)
-		l = dma_chan[lch].next_lch | (1 << 15);
-
-#ifndef CONFIG_ARCH_OMAP1
-	if (cpu_class_is_omap2())
-		if (dma_chan[lch].next_linked_ch != -1)
-			l = dma_chan[lch].next_linked_ch | (1 << 15);
-#endif
-
-	dma_write(l, CLNK_CTRL(lch));
-}
-
-static inline void disable_lnk(int lch)
-{
-	u32 l;
-
-	l = dma_read(CLNK_CTRL(lch));
-
-	/* Disable interrupts */
-	if (cpu_class_is_omap1()) {
-		dma_write(0, CICR(lch));
-		/* Set the STOP_LNK bit */
-		l |= 1 << 14;
-	}
-
-	if (cpu_class_is_omap2()) {
-		omap_disable_channel_irq(lch);
-		/* Clear the ENABLE_LNK bit */
-		l &= ~(1 << 15);
-	}
-
-	dma_write(l, CLNK_CTRL(lch));
-	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
-}
-
-static inline void omap2_enable_irq_lch(int lch)
-{
-	u32 val;
-	unsigned long flags;
-
-	if (!cpu_class_is_omap2())
-		return;
-
-	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0);
-	val |= 1 << lch;
-	dma_write(val, IRQENABLE_L0);
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-}
-
-static inline void omap2_disable_irq_lch(int lch)
-{
-	u32 val;
-	unsigned long flags;
-
-	if (!cpu_class_is_omap2())
-		return;
-
-	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0);
-	val &= ~(1 << lch);
-	dma_write(val, IRQENABLE_L0);
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-}
-
 int omap_request_dma(int dev_id, const char *dev_name,
 		     void (*callback)(int lch, u16 ch_status, void *data),
 		     void *data, int *dma_ch_out)
 {
-	int ch, free_ch = -1;
 	unsigned long flags;
 	struct omap_dma_lch *chan;
+	int ch, free_ch = -1;
+	u32 reg;
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	for (ch = 0; ch < dma_chan_count; ch++) {
@@ -750,10 +335,9 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan = dma_chan + free_ch;
 	chan->dev_id = dev_id;
 
-	if (cpu_class_is_omap1())
-		clear_lch_regs(free_ch);
-
-	if (cpu_class_is_omap2())
+	if (!d->dma_dev_attr & DMA_LINKED_LCH)
+		p->clear_lch_regs(free_ch);
+	else
 		omap_clear_dma(free_ch);
 
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
@@ -763,46 +347,34 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan->data = data;
 	chan->flags = 0;
 
-#ifndef CONFIG_ARCH_OMAP1
-	if (cpu_class_is_omap2()) {
+	if (d->dma_dev_attr & DMA_LINKED_LCH) {
 		chan->chain_id = -1;
 		chan->next_linked_ch = -1;
 	}
-#endif
-
 	chan->enabled_irqs = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
 
-	if (cpu_class_is_omap1())
-		chan->enabled_irqs |= OMAP1_DMA_TOUT_IRQ;
-	else if (cpu_class_is_omap2())
+	if (p->enable_irq_lch)
 		chan->enabled_irqs |= OMAP2_DMA_MISALIGNED_ERR_IRQ |
 			OMAP2_DMA_TRANS_ERR_IRQ;
+	else
+		chan->enabled_irqs |= OMAP1_DMA_TOUT_IRQ;
 
-	if (cpu_is_omap16xx()) {
-		/* If the sync device is set, configure it dynamically. */
-		if (dev_id != 0) {
-			set_gdma_dev(free_ch + 1, dev_id);
-			dev_id = free_ch + 1;
-		}
-		/*
-		 * Disable the 1510 compatibility mode and set the sync device
-		 * id.
-		 */
-		dma_write(dev_id | (1 << 10), CCR(free_ch));
-	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
-		dma_write(dev_id, CCR(free_ch));
-	}
+	if (p->sync_device_set)
+		p->sync_device_set(dev_id, free_ch);
+
+	if (p->enable_irq_lch) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->enable_irq_lch(free_ch);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
 
-	if (cpu_class_is_omap2()) {
-		omap2_enable_irq_lch(free_ch);
-		omap_enable_channel_irq(free_ch);
+		p->enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(free_ch));
-		dma_write(1 << free_ch, IRQSTATUS_L0);
+		reg = (r->lch_base * free_ch) + r->common_ch.csr;
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, reg);
+		dma_write(1 << free_ch, r->irqreg.irq_status_l0);
 	}
 
 	*dma_ch_out = free_ch;
-
 	return 0;
 }
 EXPORT_SYMBOL(omap_request_dma);
@@ -810,6 +382,7 @@ EXPORT_SYMBOL(omap_request_dma);
 void omap_free_dma(int lch)
 {
 	unsigned long flags;
+	u32 reg;
 
 	if (dma_chan[lch].dev_id == -1) {
 		pr_err("omap_dma: trying to free unallocated DMA channel %d\n",
@@ -817,26 +390,32 @@ void omap_free_dma(int lch)
 		return;
 	}
 
-	if (cpu_class_is_omap1()) {
-		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR(lch));
-		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR(lch));
-	}
-
-	if (cpu_class_is_omap2()) {
-		omap2_disable_irq_lch(lch);
+	if (p->disable_irq_lch) {
+		unsigned long flags;
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->disable_irq_lch(lch);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
 
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
-		dma_write(1 << lch, IRQSTATUS_L0);
+		reg = (r->lch_base * lch) + r->common_ch.csr;
+		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, reg);
+		dma_write(1 << lch, r->irqreg.irq_status_l0);
 
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR(lch));
+		reg = (r->lch_base * lch) + r->common_ch.cicr;
+		dma_write(0, reg);
 
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR(lch));
+		reg = (r->lch_base * lch) + r->common_ch.ccr;
+		dma_write(0, reg);
 		omap_clear_dma(lch);
+	} else {
+		/* Disable all DMA interrupts for the channel. */
+		reg = (r->lch_base * lch) + r->common_ch.cicr;
+		dma_write(0, reg);
+		/* Make sure the DMA transfer is stopped. */
+		reg = (r->lch_base * lch) + r->common_ch.ccr;
+		dma_write(0, reg);
 	}
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
@@ -861,8 +440,7 @@ void
 omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 {
 	u32 reg;
-
-	if (!cpu_class_is_omap2()) {
+	if (!d->dma_dev_attr & GLOBAL_PRIORITY) {
 		printk(KERN_ERR "FIXME: no %s on 15xx/16xx\n", __func__);
 		return;
 	}
@@ -876,7 +454,7 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 	reg |= (0x3 & tparams) << 12;
 	reg |= (arb_rate & 0xff) << 16;
 
-	dma_write(reg, GCR);
+	dma_write(reg, r->gcr);
 }
 EXPORT_SYMBOL(omap_dma_set_global_params);
 
@@ -893,21 +471,20 @@ int
 omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		      unsigned char write_prio)
 {
-	u32 l;
+	u32 l, reg;
 
-	if (unlikely((lch < 0 || lch >= dma_lch_count))) {
+	if (unlikely((lch < 0 || lch >= d->dma_lch_count))) {
 		printk(KERN_ERR "Invalid channel id\n");
 		return -EINVAL;
 	}
-	l = dma_read(CCR(lch));
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	l = dma_read(reg);
 	l &= ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
-		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
-	else
-		l |= ((read_prio & 0x1) << 6);
 
-	dma_write(l, CCR(lch));
+	if (p->set_prio_lch)
+		l = p->set_prio_lch(l, read_prio, write_prio);
 
+	dma_write(l, reg);
 	return 0;
 }
 EXPORT_SYMBOL(omap_dma_set_prio_lch);
@@ -922,22 +499,19 @@ void omap_clear_dma(int lch)
 
 	local_irq_save(flags);
 
-	if (cpu_class_is_omap1()) {
-		u32 l;
-
-		l = dma_read(CCR(lch));
-		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR(lch));
+	/* OMAP1 only */
+	if (!(d->dma_dev_attr & DMA_LINKED_LCH) && p->clear_ccr_csr)
+		p->clear_ccr_csr(lch);
 
-		/* Clear pending interrupts */
-		l = dma_read(CSR(lch));
-	}
-
-	if (cpu_class_is_omap2()) {
+	/* OMAP2 only */
+	if (d->dma_dev_attr & DMA_LINKED_LCH) {
+		u32 reg;
 		int i;
-		void __iomem *lch_base = omap_dma_base + OMAP_DMA4_CH_BASE(lch);
-		for (i = 0; i < 0x44; i += 4)
-			__raw_writel(0, lch_base + i);
+		reg = (r->lch_base * lch) + 0x80;
+		for (i = 0; i < 0x44; i += 4) {
+			reg = reg + i;
+			dma_write(0, reg);
+		}
 	}
 
 	local_irq_restore(flags);
@@ -946,24 +520,28 @@ EXPORT_SYMBOL(omap_clear_dma);
 
 void omap_start_dma(int lch)
 {
-	u32 l;
+	u32 l, reg;
 
 	/*
 	 * The CPC/CDAC register needs to be initialized to zero
 	 * before starting dma transfer.
 	 */
-	if (cpu_is_omap15xx())
-		dma_write(0, CPC(lch));
-	else
-		dma_write(0, CDAC(lch));
+	if (d->dma_dev_attr & ENABLE_1510_MODE) {
+		reg = (r->lch_base * lch) + r->common_ch.cpc;
+		dma_write(0, reg);
+	} else {
+		reg = (r->lch_base * lch) + r->common_ch.cdac;
+		dma_write(0, reg);
+	}
 
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
+	if ((!d->dma_dev_attr & ENABLE_1510_MODE) &&
+			dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[d->dma_lch_count];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
-		enable_lnk(lch);
+		p->enable_lnk(lch);
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		cur_lch = dma_chan[lch].next_lch;
@@ -976,31 +554,28 @@ void omap_start_dma(int lch)
 			/* Mark the current channel */
 			dma_chan_link_map[cur_lch] = 1;
 
-			enable_lnk(cur_lch);
-			omap_enable_channel_irq(cur_lch);
+			p->enable_lnk(cur_lch);
+			p->enable_channel_irq(cur_lch);
 
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-	} else if (cpu_is_omap242x() ||
-		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
+	}
 
-		/* Errata: Need to write lch even if not using chaining */
-		dma_write(lch, CLNK_CTRL(lch));
+	if (p->errata & DMA_CHAINING_ERRATA) {
+		reg = (r->lch_base * lch) + r->common_ch.clnk_ctrl;
+		dma_write(lch, reg);
 	}
 
-	omap_enable_channel_irq(lch);
+	p->enable_channel_irq(lch);
 
-	l = dma_read(CCR(lch));
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	l = dma_read(reg);
 
-	/*
-	 * Errata: On ES2.0 BUFFERING disable must be set.
-	 * This will always fail on ES1.0
-	 */
-	if (cpu_is_omap24xx())
+	if (p->errata & DMA_BUFF_DISABLE_ERRATA)
 		l |= OMAP_DMA_CCR_EN;
 
 	l |= OMAP_DMA_CCR_EN;
-	dma_write(l, CCR(lch));
+	dma_write(l, reg);
 
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
@@ -1008,19 +583,22 @@ EXPORT_SYMBOL(omap_start_dma);
 
 void omap_stop_dma(int lch)
 {
-	u32 l;
+	u32 l, reg;
 
 	/* Disable all interrupts on the channel */
-	if (cpu_class_is_omap1())
-		dma_write(0, CICR(lch));
+	reg = (r->lch_base * lch) + r->common_ch.cicr;
+	if (!p->disable_irq_lch)
+		dma_write(0, reg);
 
-	l = dma_read(CCR(lch));
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	l = dma_read(reg);
 	l &= ~OMAP_DMA_CCR_EN;
-	dma_write(l, CCR(lch));
+	dma_write(l, reg);
 
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
+	if (!(d->dma_dev_attr & ENABLE_1510_MODE) &&
+			dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[d->dma_lch_count];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {
@@ -1030,7 +608,7 @@ void omap_stop_dma(int lch)
 			/* Mark the current channel */
 			dma_chan_link_map[cur_lch] = 1;
 
-			disable_lnk(cur_lch);
+			p->disable_lnk(cur_lch);
 
 			next_lch = dma_chan[cur_lch].next_lch;
 			cur_lch = next_lch;
@@ -1079,21 +657,30 @@ EXPORT_SYMBOL(omap_set_dma_callback);
 dma_addr_t omap_get_dma_src_pos(int lch)
 {
 	dma_addr_t offset = 0;
+	u32 reg;
 
-	if (cpu_is_omap15xx())
-		offset = dma_read(CPC(lch));
-	else
-		offset = dma_read(CSAC(lch));
+	if (d->dma_dev_attr & ENABLE_1510_MODE) {
+		reg = (r->lch_base * lch) + r->common_ch.cpc;
+		offset = dma_read(reg);
+	} else {
+		reg = (r->lch_base * lch) + r->common_ch.csac;
+		offset = dma_read(reg);
+	}
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
 	 * read before the DMA controller finished disabling the channel.
 	 */
-	if (!cpu_is_omap15xx() && offset == 0)
-		offset = dma_read(CSAC(lch));
-
-	if (cpu_class_is_omap1())
-		offset |= (dma_read(CSSA_U(lch)) << 16);
+	if ((p->errata & OMAP3_3_ERRATUM) && !(d->dma_dev_attr & IS_WORD_16)
+				&& (offset == 0)) {
+		reg = (r->lch_base * lch) + r->common_ch.csac;
+		offset = dma_read(reg);
+	}
+	if ((p->errata & OMAP3_3_ERRATUM) && (d->dma_dev_attr & IS_WORD_16)
+				&& (offset == 0)) {
+		reg = (r->lch_base * lch) + r->ch_specific.cssa_u;
+		offset |= dma_read(reg) << 16;
+	}
 
 	return offset;
 }
@@ -1110,21 +697,30 @@ EXPORT_SYMBOL(omap_get_dma_src_pos);
 dma_addr_t omap_get_dma_dst_pos(int lch)
 {
 	dma_addr_t offset = 0;
+	u32 reg;
 
-	if (cpu_is_omap15xx())
-		offset = dma_read(CPC(lch));
-	else
-		offset = dma_read(CDAC(lch));
+	if (d->dma_dev_attr & ENABLE_1510_MODE) {
+		reg = (r->lch_base * lch) + r->common_ch.cpc;
+		offset = dma_read(reg);
+	} else {
+		reg = (r->lch_base * lch) + r->common_ch.cdac;
+		offset = dma_read(reg);
+	}
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
 	 * read before the DMA controller finished disabling the channel.
 	 */
-	if (!cpu_is_omap15xx() && offset == 0)
-		offset = dma_read(CDAC(lch));
-
-	if (cpu_class_is_omap1())
-		offset |= (dma_read(CDSA_U(lch)) << 16);
+	if ((p->errata & OMAP3_3_ERRATUM) && !(d->dma_dev_attr & IS_WORD_16)
+				&& (offset == 0)) {
+		reg = (r->lch_base * lch) + r->common_ch.cdac;
+		offset = dma_read(reg);
+	}
+	if ((p->errata & OMAP3_3_ERRATUM) && (d->dma_dev_attr & IS_WORD_16)
+				&& (offset == 0)) {
+		reg = (r->lch_base * lch) + r->ch_specific.cdsa_u;
+		offset |= dma_read(reg) << 16;
+	}
 
 	return offset;
 }
@@ -1132,23 +728,18 @@ EXPORT_SYMBOL(omap_get_dma_dst_pos);
 
 int omap_get_dma_active_status(int lch)
 {
-	return (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN) != 0;
+	u32 reg;
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	return (dma_read(reg) & OMAP_DMA_CCR_EN) != 0;
 }
 EXPORT_SYMBOL(omap_get_dma_active_status);
 
 int omap_dma_running(void)
 {
-	int lch;
-
-	if (cpu_class_is_omap1())
-		if (omap_lcd_dma_running())
-			return 1;
+	if (p->dma_running)
+		return p->dma_running(dma_chan_count);
 
-	for (lch = 0; lch < dma_chan_count; lch++)
-		if (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN)
-			return 1;
-
-	return 0;
+	return -EPERM;
 }
 
 /*
@@ -1158,10 +749,12 @@ int omap_dma_running(void)
  */
 void omap_dma_link_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	u32 reg;
+
+	reg = (r->lch_base * lch_head) + r->common_ch.ccr;
+	if (d->dma_dev_attr & ENABLE_1510_MODE) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR(lch_head)) | (3 << 8),
-								CCR(lch_head));
+			dma_write((dma_read(reg) | (3 << 8)), reg);
 			return;
 		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1172,7 +765,7 @@ void omap_dma_link_lch(int lch_head, int lch_queue)
 	if ((dma_chan[lch_head].dev_id == -1) ||
 	    (dma_chan[lch_queue].dev_id == -1)) {
 		printk(KERN_ERR "omap_dma: trying to link "
-		       "non requested channels\n");
+		"non requested channels\n");
 		dump_stack();
 	}
 
@@ -1185,10 +778,12 @@ EXPORT_SYMBOL(omap_dma_link_lch);
  */
 void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	u32 reg;
+
+	reg = (r->lch_base * lch_head) + r->common_ch.ccr;
+	if (d->dma_dev_attr & ENABLE_1510_MODE) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR(lch_head)) & ~(3 << 8),
-								CCR(lch_head));
+			dma_write((dma_read(reg) & ~(3 << 8)), reg);
 			return;
 		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1199,1004 +794,199 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 	if (dma_chan[lch_head].next_lch != lch_queue ||
 	    dma_chan[lch_head].next_lch == -1) {
 		printk(KERN_ERR "omap_dma: trying to unlink "
-		       "non linked channels\n");
+		"non linked channels\n");
 		dump_stack();
 	}
 
 	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
 	    (dma_chan[lch_queue].flags & OMAP_DMA_ACTIVE)) {
 		printk(KERN_ERR "omap_dma: You need to stop the DMA channels "
-		       "before unlinking\n");
+					"before unlinking\n");
 		dump_stack();
 	}
-
 	dma_chan[lch_head].next_lch = -1;
 }
 EXPORT_SYMBOL(omap_dma_unlink_lch);
 
-/*----------------------------------------------------------------------------*/
-
-#ifndef CONFIG_ARCH_OMAP1
-/* Create chain of DMA channesls */
-static void create_dma_lch_chain(int lch_head, int lch_queue)
+static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 {
-	u32 l;
-
-	/* Check if this is the first link in chain */
-	if (dma_chan[lch_head].next_linked_ch == -1) {
-		dma_chan[lch_head].next_linked_ch = lch_queue;
-		dma_chan[lch_head].prev_linked_ch = lch_queue;
-		dma_chan[lch_queue].next_linked_ch = lch_head;
-		dma_chan[lch_queue].prev_linked_ch = lch_head;
-	}
-
-	/* a link exists, link the new channel in circular chain */
-	else {
-		dma_chan[lch_queue].next_linked_ch =
-					dma_chan[lch_head].next_linked_ch;
-		dma_chan[lch_queue].prev_linked_ch = lch_head;
-		dma_chan[lch_head].next_linked_ch = lch_queue;
-		dma_chan[dma_chan[lch_queue].next_linked_ch].prev_linked_ch =
-					lch_queue;
-	}
-
-	l = dma_read(CLNK_CTRL(lch_head));
-	l &= ~(0x1f);
-	l |= lch_queue;
-	dma_write(l, CLNK_CTRL(lch_head));
+	struct omap_system_dma_plat_info *pdata = pdev->dev.platform_data;
+	struct resource *mem;
+	int irq_count, ret = 0;
+	int dma_irq;
+	char irq_name[14];
 
-	l = dma_read(CLNK_CTRL(lch_queue));
-	l &= ~(0x1f);
-	l |= (dma_chan[lch_queue].next_linked_ch);
-	dma_write(l, CLNK_CTRL(lch_queue));
-}
-
-/**
- * @brief omap_request_dma_chain : Request a chain of DMA channels
- *
- * @param dev_id - Device id using the dma channel
- * @param dev_name - Device name
- * @param callback - Call back function
- * @chain_id -
- * @no_of_chans - Number of channels requested
- * @chain_mode - Dynamic or static chaining : OMAP_DMA_STATIC_CHAIN
- * 					      OMAP_DMA_DYNAMIC_CHAIN
- * @params - Channel parameters
- *
- * @return - Success : 0
- * 	     Failure: -EINVAL/-ENOMEM
- */
-int omap_request_dma_chain(int dev_id, const char *dev_name,
-			   void (*callback) (int lch, u16 ch_status,
-					     void *data),
-			   int *chain_id, int no_of_chans, int chain_mode,
-			   struct omap_dma_channel_params params)
-{
-	int *channels;
-	int i, err;
-
-	/* Is the chain mode valid ? */
-	if (chain_mode != OMAP_DMA_STATIC_CHAIN
-			&& chain_mode != OMAP_DMA_DYNAMIC_CHAIN) {
-		printk(KERN_ERR "Invalid chain mode requested\n");
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: System DMA initialized without"
+			"platform data\n", __func__);
 		return -EINVAL;
 	}
 
-	if (unlikely((no_of_chans < 1
-			|| no_of_chans > dma_lch_count))) {
-		printk(KERN_ERR "Invalid Number of channels requested\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Allocate a queue to maintain the status of the channels
-	 * in the chain
-	 */
-	channels = kmalloc(sizeof(*channels) * no_of_chans, GFP_KERNEL);
-	if (channels == NULL) {
-		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
-		return -ENOMEM;
-	}
-
-	/* request and reserve DMA channels for the chain */
-	for (i = 0; i < no_of_chans; i++) {
-		err = omap_request_dma(dev_id, dev_name,
-					callback, NULL, &channels[i]);
-		if (err < 0) {
-			int j;
-			for (j = 0; j < i; j++)
-				omap_free_dma(channels[j]);
-			kfree(channels);
-			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
-			return err;
-		}
-		dma_chan[channels[i]].prev_linked_ch = -1;
-		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
-
-		/*
-		 * Allowing client drivers to set common parameters now,
-		 * so that later only relevant (src_start, dest_start
-		 * and element count) can be set
-		 */
-		omap_set_dma_params(channels[i], &params);
-	}
-
-	*chain_id = channels[0];
-	dma_linked_lch[*chain_id].linked_dmach_q = channels;
-	dma_linked_lch[*chain_id].chain_mode = chain_mode;
-	dma_linked_lch[*chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
-	dma_linked_lch[*chain_id].no_of_lchs_linked = no_of_chans;
-
-	for (i = 0; i < no_of_chans; i++)
-		dma_chan[channels[i]].chain_id = *chain_id;
-
-	/* Reset the Queue pointers */
-	OMAP_DMA_CHAIN_QINIT(*chain_id);
-
-	/* Set up the chain */
-	if (no_of_chans == 1)
-		create_dma_lch_chain(channels[0], channels[0]);
-	else {
-		for (i = 0; i < (no_of_chans - 1); i++)
-			create_dma_lch_chain(channels[i], channels[i + 1]);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_request_dma_chain);
-
-/**
- * @brief omap_modify_dma_chain_param : Modify the chain's params - Modify the
- * params after setting it. Dont do this while dma is running!!
- *
- * @param chain_id - Chained logical channel id.
- * @param params
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL
- */
-int omap_modify_dma_chain_params(int chain_id,
-				struct omap_dma_channel_params params)
-{
-	int *channels;
-	u32 i;
+	p = pdata;
+	r = p->dma_reg_offset;
+	d = p->dma_attr;
 
-	/* Check for input params */
-	if (unlikely((chain_id < 0
-			|| chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
 		return -EINVAL;
 	}
 
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-		/*
-		 * Allowing client drivers to set common parameters now,
-		 * so that later only relevant (src_start, dest_start
-		 * and element count) can be set
-		 */
-		omap_set_dma_params(channels[i], &params);
+	omap_dma_base = ioremap(mem->start, resource_size(mem));
+	if (!omap_dma_base) {
+		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
+		ret = -ENOMEM;
+		goto exit_release_region;
 	}
 
-	return 0;
-}
-EXPORT_SYMBOL(omap_modify_dma_chain_params);
+	if ((d->dma_dev_attr & RESERVE_CHANNEL) && omap_dma_reserve_channels
+		&& (omap_dma_reserve_channels <= (d->dma_lch_count)))
+		d->dma_lch_count = omap_dma_reserve_channels;
 
-/**
- * @brief omap_free_dma_chain - Free all the logical channels in a chain.
- *
- * @param chain_id
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL
- */
-int omap_free_dma_chain(int chain_id)
-{
-	int *channels;
-	u32 i;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-		dma_chan[channels[i]].next_linked_ch = -1;
-		dma_chan[channels[i]].prev_linked_ch = -1;
-		dma_chan[channels[i]].chain_id = -1;
-		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
-		omap_free_dma(channels[i]);
-	}
-
-	kfree(channels);
-
-	dma_linked_lch[chain_id].linked_dmach_q = NULL;
-	dma_linked_lch[chain_id].chain_mode = -1;
-	dma_linked_lch[chain_id].chain_state = -1;
-
-	return (0);
-}
-EXPORT_SYMBOL(omap_free_dma_chain);
-
-/**
- * @brief omap_dma_chain_status - Check if the chain is in
- * active / inactive state.
- * @param chain_id
- *
- * @return - Success : OMAP_DMA_CHAIN_ACTIVE/OMAP_DMA_CHAIN_INACTIVE
- * 	     Failure : -EINVAL
- */
-int omap_dma_chain_status(int chain_id)
-{
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	pr_debug("CHAINID=%d, qcnt=%d\n", chain_id,
-			dma_linked_lch[chain_id].q_count);
-
-	if (OMAP_DMA_CHAIN_QEMPTY(chain_id))
-		return OMAP_DMA_CHAIN_INACTIVE;
-
-	return OMAP_DMA_CHAIN_ACTIVE;
-}
-EXPORT_SYMBOL(omap_dma_chain_status);
-
-/**
- * @brief omap_dma_chain_a_transfer - Get a free channel from a chain,
- * set the params and start the transfer.
- *
- * @param chain_id
- * @param src_start - buffer start address
- * @param dest_start - Dest address
- * @param elem_count
- * @param frame_count
- * @param callbk_data - channel callback parameter data.
- *
- * @return  - Success : 0
- * 	      Failure: -EINVAL/-EBUSY
- */
-int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
-			int elem_count, int frame_count, void *callbk_data)
-{
-	int *channels;
-	u32 l, lch;
-	int start_dma = 0;
-
-	/*
-	 * if buffer size is less than 1 then there is
-	 * no use of starting the chain
-	 */
-	if (elem_count < 1) {
-		printk(KERN_ERR "Invalid buffer size\n");
-		return -EINVAL;
-	}
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0
-			|| chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exist\n");
-		return -EINVAL;
-	}
-
-	/* Check if all the channels in chain are in use */
-	if (OMAP_DMA_CHAIN_QFULL(chain_id))
-		return -EBUSY;
-
-	/* Frame count may be negative in case of indexed transfers */
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get a free channel */
-	lch = channels[dma_linked_lch[chain_id].q_tail];
-
-	/* Store the callback data */
-	dma_chan[lch].data = callbk_data;
-
-	/* Increment the q_tail */
-	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
-
-	/* Set the params to the free channel */
-	if (src_start != 0)
-		dma_write(src_start, CSSA(lch));
-	if (dest_start != 0)
-		dma_write(dest_start, CDSA(lch));
-
-	/* Write the buffer size */
-	dma_write(elem_count, CEN(lch));
-	dma_write(frame_count, CFN(lch));
-
-	/*
-	 * If the chain is dynamically linked,
-	 * then we may have to start the chain if its not active
-	 */
-	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_DYNAMIC_CHAIN) {
-
-		/*
-		 * In Dynamic chain, if the chain is not started,
-		 * queue the channel
-		 */
-		if (dma_linked_lch[chain_id].chain_state ==
-						DMA_CHAIN_NOTSTARTED) {
-			/* Enable the link in previous channel */
-			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
-								DMA_CH_QUEUED)
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-			dma_chan[lch].state = DMA_CH_QUEUED;
-		}
-
-		/*
-		 * Chain is already started, make sure its active,
-		 * if not then start the chain
-		 */
-		else {
-			start_dma = 1;
-
-			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
-							DMA_CH_STARTED) {
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-				dma_chan[lch].state = DMA_CH_QUEUED;
-				start_dma = 0;
-				if (0 == ((1 << 7) & dma_read(
-					CCR(dma_chan[lch].prev_linked_ch)))) {
-					disable_lnk(dma_chan[lch].
-						    prev_linked_ch);
-					pr_debug("\n prev ch is stopped\n");
-					start_dma = 1;
-				}
-			}
-
-			else if (dma_chan[dma_chan[lch].prev_linked_ch].state
-							== DMA_CH_QUEUED) {
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-				dma_chan[lch].state = DMA_CH_QUEUED;
-				start_dma = 0;
-			}
-			omap_enable_channel_irq(lch);
-
-			l = dma_read(CCR(lch));
-
-			if ((0 == (l & (1 << 24))))
-				l &= ~(1 << 25);
-			else
-				l |= (1 << 25);
-			if (start_dma == 1) {
-				if (0 == (l & (1 << 7))) {
-					l |= (1 << 7);
-					dma_chan[lch].state = DMA_CH_STARTED;
-					pr_debug("starting %d\n", lch);
-					dma_write(l, CCR(lch));
-				} else
-					start_dma = 0;
-			} else {
-				if (0 == (l & (1 << 7)))
-					dma_write(l, CCR(lch));
-			}
-			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
-		}
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_dma_chain_a_transfer);
-
-/**
- * @brief omap_start_dma_chain_transfers - Start the chain
- *
- * @param chain_id
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL/-EBUSY
- */
-int omap_start_dma_chain_transfers(int chain_id)
-{
-	int *channels;
-	u32 l, i;
-
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	if (dma_linked_lch[channels[0]].chain_state == DMA_CHAIN_STARTED) {
-		printk(KERN_ERR "Chain is already started\n");
-		return -EBUSY;
-	}
-
-	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_STATIC_CHAIN) {
-		for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked;
-									i++) {
-			enable_lnk(channels[i]);
-			omap_enable_channel_irq(channels[i]);
-		}
-	} else {
-		omap_enable_channel_irq(channels[0]);
-	}
-
-	l = dma_read(CCR(channels[0]));
-	l |= (1 << 7);
-	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
-	dma_chan[channels[0]].state = DMA_CH_STARTED;
-
-	if ((0 == (l & (1 << 24))))
-		l &= ~(1 << 25);
-	else
-		l |= (1 << 25);
-	dma_write(l, CCR(channels[0]));
-
-	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_start_dma_chain_transfers);
-
-/**
- * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a chain.
- *
- * @param chain_id
- *
- * @return - Success : 0
- * 	     Failure : EINVAL
- */
-int omap_stop_dma_chain_transfers(int chain_id)
-{
-	int *channels;
-	u32 l, i;
-	u32 sys_cf;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/*
-	 * DMA Errata:
-	 * Special programming model needed to disable DMA before end of block
-	 */
-	sys_cf = dma_read(OCP_SYSCONFIG);
-	l = sys_cf;
-	/* Middle mode reg set no Standby */
-	l &= ~((1 << 12)|(1 << 13));
-	dma_write(l, OCP_SYSCONFIG);
-
-	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-
-		/* Stop the Channel transmission */
-		l = dma_read(CCR(channels[i]));
-		l &= ~(1 << 7);
-		dma_write(l, CCR(channels[i]));
-
-		/* Disable the link in all the channels */
-		disable_lnk(channels[i]);
-		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
-
-	}
-	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
-
-	/* Reset the Queue pointers */
-	OMAP_DMA_CHAIN_QINIT(chain_id);
-
-	/* Errata - put in the old value */
-	dma_write(sys_cf, OCP_SYSCONFIG);
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
-
-/* Get the index of the ongoing DMA in chain */
-/**
- * @brief omap_get_dma_chain_index - Get the element and frame index
- * of the ongoing DMA in chain
- *
- * @param chain_id
- * @param ei - Element index
- * @param fi - Frame index
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL
- */
-int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
-{
-	int lch;
-	int *channels;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	if ((!ei) || (!fi))
-		return -EINVAL;
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch = channels[dma_linked_lch[chain_id].q_head];
-
-	*ei = dma_read(CCEN(lch));
-	*fi = dma_read(CCFN(lch));
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_get_dma_chain_index);
-
-/**
- * @brief omap_get_dma_chain_dst_pos - Get the destination position of the
- * ongoing DMA in chain
- *
- * @param chain_id
- *
- * @return - Success : Destination position
- * 	     Failure : -EINVAL
- */
-int omap_get_dma_chain_dst_pos(int chain_id)
-{
-	int lch;
-	int *channels;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch = channels[dma_linked_lch[chain_id].q_head];
-
-	return dma_read(CDAC(lch));
-}
-EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
-
-/**
- * @brief omap_get_dma_chain_src_pos - Get the source position
- * of the ongoing DMA in chain
- * @param chain_id
- *
- * @return - Success : Destination position
- * 	     Failure : -EINVAL
- */
-int omap_get_dma_chain_src_pos(int chain_id)
-{
-	int lch;
-	int *channels;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch = channels[dma_linked_lch[chain_id].q_head];
-
-	return dma_read(CSAC(lch));
-}
-EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
-#endif	/* ifndef CONFIG_ARCH_OMAP1 */
-
-/*----------------------------------------------------------------------------*/
-
-#ifdef CONFIG_ARCH_OMAP1
-
-static int omap1_dma_handle_ch(int ch)
-{
-	u32 csr;
-
-	if (enable_1510_mode && ch >= 6) {
-		csr = dma_chan[ch].saved_csr;
-		dma_chan[ch].saved_csr = 0;
-	} else
-		csr = dma_read(CSR(ch));
-	if (enable_1510_mode && ch <= 2 && (csr >> 7) != 0) {
-		dma_chan[ch + 6].saved_csr = csr >> 7;
-		csr &= 0x7f;
-	}
-	if ((csr & 0x3f) == 0)
-		return 0;
-	if (unlikely(dma_chan[ch].dev_id == -1)) {
-		printk(KERN_WARNING "Spurious interrupt from DMA channel "
-		       "%d (CSR %04x)\n", ch, csr);
-		return 0;
-	}
-	if (unlikely(csr & OMAP1_DMA_TOUT_IRQ))
-		printk(KERN_WARNING "DMA timeout with device %d\n",
-		       dma_chan[ch].dev_id);
-	if (unlikely(csr & OMAP_DMA_DROP_IRQ))
-		printk(KERN_WARNING "DMA synchronization event drop occurred "
-		       "with device %d\n", dma_chan[ch].dev_id);
-	if (likely(csr & OMAP_DMA_BLOCK_IRQ))
-		dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
-	if (likely(dma_chan[ch].callback != NULL))
-		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
-
-	return 1;
-}
-
-static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
-{
-	int ch = ((int) dev_id) - 1;
-	int handled = 0;
-
-	for (;;) {
-		int handled_now = 0;
-
-		handled_now += omap1_dma_handle_ch(ch);
-		if (enable_1510_mode && dma_chan[ch + 6].saved_csr)
-			handled_now += omap1_dma_handle_ch(ch + 6);
-		if (!handled_now)
-			break;
-		handled += handled_now;
-	}
-
-	return handled ? IRQ_HANDLED : IRQ_NONE;
-}
-
-#else
-#define omap1_dma_irq_handler	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
-static int omap2_dma_handle_ch(int ch)
-{
-	u32 status = dma_read(CSR(ch));
-
-	if (!status) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
-				ch);
-		dma_write(1 << ch, IRQSTATUS_L0);
-		return 0;
-	}
-	if (unlikely(dma_chan[ch].dev_id == -1)) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "IRQ %04x for non-allocated DMA"
-					"channel %d\n", status, ch);
-		return 0;
-	}
-	if (unlikely(status & OMAP_DMA_DROP_IRQ))
-		printk(KERN_INFO
-		       "DMA synchronization event drop occurred with device "
-		       "%d\n", dma_chan[ch].dev_id);
-	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
-		printk(KERN_INFO "DMA transaction error with device %d\n",
-		       dma_chan[ch].dev_id);
-		if (cpu_class_is_omap2()) {
-			/*
-			 * Errata: sDMA Channel is not disabled
-			 * after a transaction error. So we explicitely
-			 * disable the channel
-			 */
-			u32 ccr;
-
-			ccr = dma_read(CCR(ch));
-			ccr &= ~OMAP_DMA_CCR_EN;
-			dma_write(ccr, CCR(ch));
-			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
-		}
-	}
-	if (unlikely(status & OMAP2_DMA_SECURE_ERR_IRQ))
-		printk(KERN_INFO "DMA secure error with device %d\n",
-		       dma_chan[ch].dev_id);
-	if (unlikely(status & OMAP2_DMA_MISALIGNED_ERR_IRQ))
-		printk(KERN_INFO "DMA misaligned error with device %d\n",
-		       dma_chan[ch].dev_id);
-
-	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
-	dma_write(1 << ch, IRQSTATUS_L0);
-
-	/* If the ch is not chained then chain_id will be -1 */
-	if (dma_chan[ch].chain_id != -1) {
-		int chain_id = dma_chan[ch].chain_id;
-		dma_chan[ch].state = DMA_CH_NOTSTARTED;
-		if (dma_read(CLNK_CTRL(ch)) & (1 << 15))
-			dma_chan[dma_chan[ch].next_linked_ch].state =
-							DMA_CH_STARTED;
-		if (dma_linked_lch[chain_id].chain_mode ==
-						OMAP_DMA_DYNAMIC_CHAIN)
-			disable_lnk(ch);
-
-		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
-			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
-
-		status = dma_read(CSR(ch));
-	}
-
-	dma_write(status, CSR(ch));
-
-	if (likely(dma_chan[ch].callback != NULL))
-		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
-
-	return 0;
-}
-
-/* STATUS register count is from 1-32 while our is 0-31 */
-static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
-{
-	u32 val, enable_reg;
-	int i;
-
-	val = dma_read(IRQSTATUS_L0);
-	if (val == 0) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ\n");
-		return IRQ_HANDLED;
-	}
-	enable_reg = dma_read(IRQENABLE_L0);
-	val &= enable_reg; /* Dispatch only relevant interrupts */
-	for (i = 0; i < dma_lch_count && val != 0; i++) {
-		if (val & 1)
-			omap2_dma_handle_ch(i);
-		val >>= 1;
-	}
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction omap24xx_dma_irq = {
-	.name = "DMA",
-	.handler = omap2_dma_irq_handler,
-	.flags = IRQF_DISABLED
-};
-
-#else
-static struct irqaction omap24xx_dma_irq;
-#endif
-
-/*----------------------------------------------------------------------------*/
-
-void omap_dma_global_context_save(void)
-{
-	omap_dma_global_context.dma_irqenable_l0 =
-		dma_read(IRQENABLE_L0);
-	omap_dma_global_context.dma_ocp_sysconfig =
-		dma_read(OCP_SYSCONFIG);
-	omap_dma_global_context.dma_gcr = dma_read(GCR);
-}
-
-void omap_dma_global_context_restore(void)
-{
-	int ch;
-
-	dma_write(omap_dma_global_context.dma_gcr, GCR);
-	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
-		OCP_SYSCONFIG);
-	dma_write(omap_dma_global_context.dma_irqenable_l0,
-		IRQENABLE_L0);
-
-	/*
-	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
-	 * after secure sram context save and restore. Hence we need to
-	 * manually clear those IRQs to avoid spurious interrupts. This
-	 * affects only secure devices.
-	 */
-	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
-		dma_write(0x3 , IRQSTATUS_L0);
-
-	for (ch = 0; ch < dma_chan_count; ch++)
-		if (dma_chan[ch].dev_id != -1)
-			omap_clear_dma(ch);
-}
-
-/*----------------------------------------------------------------------------*/
-
-static int __init omap_init_dma(void)
-{
-	unsigned long base;
-	int ch, r;
-
-	if (cpu_class_is_omap1()) {
-		base = OMAP1_DMA_BASE;
-		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
-	} else if (cpu_is_omap24xx()) {
-		base = OMAP24XX_DMA4_BASE;
-		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
-	} else if (cpu_is_omap34xx()) {
-		base = OMAP34XX_DMA4_BASE;
-		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
-	} else if (cpu_is_omap44xx()) {
-		base = OMAP44XX_DMA4_BASE;
-		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
-	} else {
-		pr_err("DMA init failed for unsupported omap\n");
-		return -ENODEV;
-	}
-
-	omap_dma_base = ioremap(base, SZ_4K);
-	BUG_ON(!omap_dma_base);
-
-	if (cpu_class_is_omap2() && omap_dma_reserve_channels
-			&& (omap_dma_reserve_channels <= dma_lch_count))
-		dma_lch_count = omap_dma_reserve_channels;
-
-	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
+	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * (d->dma_lch_count),
 				GFP_KERNEL);
-	if (!dma_chan) {
-		r = -ENOMEM;
-		goto out_unmap;
-	}
 
-	if (cpu_class_is_omap2()) {
-		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
-						dma_lch_count, GFP_KERNEL);
-		if (!dma_linked_lch) {
-			r = -ENOMEM;
-			goto out_free;
-		}
+	if (!dma_chan) {
+		ret = -ENOMEM;
+		goto exit_unmap;
 	}
 
-	if (cpu_is_omap15xx()) {
+	if (d->dma_dev_attr & ENABLE_1510_MODE) {
 		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
 		dma_chan_count = 9;
-		enable_1510_mode = 1;
-	} else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
+	} else if (!(d->dma_dev_attr & ENABLE_1510_MODE) &&
+			!(d->dma_dev_attr & DMA_LINKED_LCH)) {
+		u16 w;
 		printk(KERN_INFO "OMAP DMA hardware version %d\n",
-		       dma_read(HW_ID));
+		       dma_read(r->hw_id));
 		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
-		       (dma_read(CAPS_0_U) << 16) |
-		       dma_read(CAPS_0_L),
-		       (dma_read(CAPS_1_U) << 16) |
-		       dma_read(CAPS_1_L),
-		       dma_read(CAPS_2), dma_read(CAPS_3),
-		       dma_read(CAPS_4));
-		if (!enable_1510_mode) {
-			u16 w;
+			(dma_read(r->reg_caps.caps_0u) << 16) |
+			dma_read(r->reg_caps.caps_0l),
+			(dma_read(r->reg_caps.caps_1u) << 16) |
+			dma_read(r->reg_caps.caps_1l),
+			dma_read(r->reg_caps.caps_2),
+			dma_read(r->reg_caps.caps_3),
+			dma_read(r->reg_caps.caps_4));
 
 			/* Disable OMAP 3.0/3.1 compatibility mode. */
-			w = dma_read(GSCR);
+			w = dma_read(r->gscr);
 			w |= 1 << 3;
-			dma_write(w, GSCR);
+			dma_write(w, r->gscr);
 			dma_chan_count = 16;
-		} else
-			dma_chan_count = 9;
-	} else if (cpu_class_is_omap2()) {
-		u8 revision = dma_read(REVISION) & 0xff;
+	} else if (d->dma_dev_attr & DMA_LINKED_LCH) {
+		u8 revision = dma_read(r->rev) & 0xff;
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
-		dma_chan_count = dma_lch_count;
+		dma_chan_count = d->dma_lch_count;
 	} else {
 		dma_chan_count = 0;
-		return 0;
 	}
-
 	spin_lock_init(&dma_chan_lock);
 
-	for (ch = 0; ch < dma_chan_count; ch++) {
-		omap_clear_dma(ch);
-		if (cpu_class_is_omap2())
-			omap2_disable_irq_lch(ch);
+	for (irq_count = 0; irq_count < dma_chan_count ; irq_count++) {
+		omap_clear_dma(irq_count);
+		if (p->disable_irq_lch) {
+			unsigned long flags;
+			spin_lock_irqsave(&dma_chan_lock, flags);
+			p->disable_irq_lch(irq_count);
+			spin_unlock_irqrestore(&dma_chan_lock, flags);
+		}
+
+		dma_chan[irq_count].dev_id	= -1;
+		dma_chan[irq_count].next_lch	= -1;
 
-		dma_chan[ch].dev_id = -1;
-		dma_chan[ch].next_lch = -1;
+		dma_irq = platform_get_irq_byname(pdev, irq_name);
 
-		if (ch >= 6 && enable_1510_mode)
+		if (((irq_count >= 7) && (d->dma_dev_attr & ENABLE_1510_MODE))
+					|| (d->dma_dev_attr & DMA_LINKED_LCH))
 			continue;
 
-		if (cpu_class_is_omap1()) {
-			/*
-			 * request_irq() doesn't like dev_id (ie. ch) being
-			 * zero, so we have to kludge around this.
-			 */
-			r = request_irq(omap1_dma_irq[ch],
-					omap1_dma_irq_handler, 0, "DMA",
-					(void *) (ch + 1));
-			if (r != 0) {
-				int i;
-
-				printk(KERN_ERR "unable to request IRQ %d "
-				       "for DMA (error %d)\n",
-				       omap1_dma_irq[ch], r);
-				for (i = 0; i < ch; i++)
-					free_irq(omap1_dma_irq[i],
-						 (void *) (i + 1));
-				goto out_free;
+		if (dma_irq < 0) {
+			dev_err(&pdev->dev, "%s:unable to get irq\n", __func__);
+			ret = dma_irq;
+			goto exit_unmap;
+		}
+
+		if (p->dma_irq_register)
+			ret = p->dma_irq_register(dma_irq, irq_count, dma_chan);
+
+		if (ret != 0) {
+			int irq_rel;
+
+			printk(KERN_ERR "unable to request IRQ %d"
+				"for DMA (error %d)\n", dma_irq, ret);
+			for (irq_rel = 0; irq_rel < irq_count; irq_rel++) {
+				dma_irq = platform_get_irq(pdev, irq_rel);
+				free_irq(dma_irq, (void *) (irq_rel + 1));
+				goto exit_dma_chan;
 			}
 		}
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
+	if ((d->dma_dev_attr & DMA_LINKED_LCH) &&
+				p->dma_irq_register) {
+		strcpy(irq_name, "dma_0");
+		dma_irq = platform_get_irq_byname(pdev, irq_name);
+		p->dma_irq_register(dma_irq, 0, dma_chan);
+	}
+
+	if (d->dma_dev_attr & GLOBAL_PRIORITY)
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
 
-	if (cpu_class_is_omap2()) {
-		int irq;
-		if (cpu_is_omap44xx())
-			irq = OMAP44XX_IRQ_SDMA_0;
-		else
-			irq = INT_24XX_SDMA_IRQ0;
-		setup_irq(irq, &omap24xx_dma_irq);
-	}
-
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		/* Enable smartidle idlemodes and autoidle */
-		u32 v = dma_read(OCP_SYSCONFIG);
-		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
-				DMA_SYSCONFIG_SIDLEMODE_MASK |
-				DMA_SYSCONFIG_AUTOIDLE);
-		v |= (DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
-			DMA_SYSCONFIG_SIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
-			DMA_SYSCONFIG_AUTOIDLE);
-		dma_write(v , OCP_SYSCONFIG);
-		/* reserve dma channels 0 and 1 in high security devices */
-		if (cpu_is_omap34xx() &&
-			(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
-			printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
-					"HS ROM code\n");
-			dma_chan[0].dev_id = 0;
-			dma_chan[1].dev_id = 1;
-		}
+	/* reserve dma channels 0 and 1 in high security devices */
+	if (d->dma_dev_attr & RESERVE_CHANNEL) {
+		printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
+				"HS ROM code\n");
+		dma_chan[0].dev_id = 0;
+		dma_chan[1].dev_id = 1;
 	}
 
+	dev_info(&pdev->dev, "System DMA registered\n");
 	return 0;
 
-out_free:
+exit_dma_chan:
 	kfree(dma_chan);
+exit_unmap:
+	iounmap(omap_dma_base);
+exit_release_region:
+	release_mem_region(mem->start, resource_size(mem));
+	return ret;
+}
 
-out_unmap:
+static int __devexit omap_system_dma_remove(struct platform_device *pdev)
+{
+	struct resource *mem;
 	iounmap(omap_dma_base);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	return 0;
+}
+
+static struct platform_driver omap_system_dma_driver = {
+	.probe		= omap_system_dma_probe,
+	.remove		= omap_system_dma_remove,
+	.driver		= {
+		.name	= "dma"
+	},
+};
+
+static int __init omap_system_dma_init(void)
+{
+	return platform_driver_register(&omap_system_dma_driver);
+}
 
-	return r;
+arch_initcall(omap_system_dma_init);
+
+static void __exit omap_system_dma_exit(void)
+{
+	platform_driver_unregister(&omap_system_dma_driver);
 }
 
-arch_initcall(omap_init_dma);
+MODULE_DESCRIPTION("OMAP SYSTEM DMA DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
 
 /*
  * Reserve the omap SDMA channels using cmdline bootarg
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index fcc7d6e..ae372cb 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -26,139 +26,91 @@
 /* Move omap4 specific defines to dma-44xx.h */
 #include "dma-44xx.h"
 
-/* Hardware registers for omap1 */
-#define OMAP1_DMA_BASE			(0xfffed800)
-
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
-/* Hardware registers for omap2 and omap3 */
-#define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
-#define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
-#define OMAP44XX_DMA4_BASE		(L4_44XX_BASE + 0x56000)
-
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
-#define OMAP1_LOGICAL_DMA_CH_COUNT	17
-#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
-
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
-/*----------------------------------------------------------------------------*/
+#define OMAP1_DMA_TOUT_IRQ		(1 << 0)
+#define OMAP_DMA_DROP_IRQ		(1 << 1)
+#define OMAP_DMA_HALF_IRQ		(1 << 2)
+#define OMAP_DMA_FRAME_IRQ		(1 << 3)
+#define OMAP_DMA_LAST_IRQ		(1 << 4)
+#define OMAP_DMA_BLOCK_IRQ		(1 << 5)
+#define OMAP1_DMA_SYNC_IRQ		(1 << 6)
+#define OMAP2_DMA_PKT_IRQ		(1 << 7)
+#define OMAP2_DMA_TRANS_ERR_IRQ		(1 << 8)
+#define OMAP2_DMA_SECURE_ERR_IRQ	(1 << 9)
+#define OMAP2_DMA_SUPERVISOR_ERR_IRQ	(1 << 10)
+#define OMAP2_DMA_MISALIGNED_ERR_IRQ	(1 << 11)
+
+#define OMAP_DMA_CCR_EN			(1 << 7)
+
+#define OMAP_DMA_DATA_TYPE_S8		0x00
+#define OMAP_DMA_DATA_TYPE_S16		0x01
+#define OMAP_DMA_DATA_TYPE_S32		0x02
+
+#define OMAP_DMA_SYNC_ELEMENT		0x00
+#define OMAP_DMA_SYNC_FRAME		0x01
+#define OMAP_DMA_SYNC_BLOCK		0x02
+#define OMAP_DMA_SYNC_PACKET		0x03
+
+#define OMAP_DMA_SRC_SYNC		0x01
+#define OMAP_DMA_DST_SYNC		0x00
+
+#define OMAP_DMA_PORT_EMIFF		0x00
+#define OMAP_DMA_PORT_EMIFS		0x01
+#define OMAP_DMA_PORT_OCP_T1		0x02
+#define OMAP_DMA_PORT_TIPB		0x03
+#define OMAP_DMA_PORT_OCP_T2		0x04
+#define OMAP_DMA_PORT_MPUI		0x05
 
+#define OMAP_DMA_AMODE_CONSTANT		0x00
+#define OMAP_DMA_AMODE_POST_INC		0x01
+#define OMAP_DMA_AMODE_SINGLE_IDX	0x02
+#define OMAP_DMA_AMODE_DOUBLE_IDX	0x03
+
+#define DMA_DEFAULT_FIFO_DEPTH		0x10
+#define DMA_DEFAULT_ARB_RATE		0x01
+/* Pass THREAD_RESERVE ORed with THREAD_FIFO for tparams */
+#define DMA_THREAD_RESERVE_NORM		(0x00 << 12) /* Def */
+#define DMA_THREAD_RESERVE_ONET		(0x01 << 12)
+#define DMA_THREAD_RESERVE_TWOT		(0x02 << 12)
+#define DMA_THREAD_RESERVE_THREET	(0x03 << 12)
+#define DMA_THREAD_FIFO_NONE		(0x00 << 14) /* Def */
+#define DMA_THREAD_FIFO_75		(0x01 << 14)
+#define DMA_THREAD_FIFO_25		(0x02 << 14)
+#define DMA_THREAD_FIFO_50		(0x03 << 14)
+
+#define DMA_CH_PRIO_HIGH		0x1
+#define DMA_CH_PRIO_LOW			0x0 /* Def */
+
+/* Attributes for OMAP DMA Contrllers */
+#define	ENABLE_1510_MODE	(1 << 0)
+#define	DMA_LINKED_LCH		(1 << 1)
+#define	GLOBAL_PRIORITY		(1 << 2)
+#define	RESERVE_CHANNEL		(1 << 3)
+#define	SRC_PORT		(2 << 3)
+#define	DST_PORT		(2 << 4)
+#define	IS_CSSA_32		(2 << 5)
+#define	IS_CDSA_32		(2 << 6)
+#define	SRC_INDEX		(4 << 6)
+#define	DST_INDEX		(4 << 7)
+#define	IS_BURST_ONLY4		(4 << 8)
+#define	CLEAR_CSR_ON_READ	(4 << 9)
+#define	IS_WORD_16		(8 << 9)
+
+/* Errata Definitions */
+#define	DMA_CHAINING_ERRATA		(1 << 0)
+#define DMA_BUFF_DISABLE_ERRATA		(1 << 1)
+#define OMAP3_3_ERRATUM			(1 << 2)
+#define DMA_SYSCONFIG_ERRATA		(1 << 3)
+#define DMA_CH_DISABLE_ERRATA		(1 << 4)
+#define DMA_IRQ_STATUS_ERRATA		(1 << 5)
+
+#define OMAP_DMA_ACTIVE			0x01
+#define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
+
+/*
+ * DMA request lines for omap1 and omap2.
+ * Should go to respective mach/dma.h files?
+ * DMA client drivers should fix these macros usage.
+ */
 /* DMA channels for omap1 */
 #define OMAP_DMA_NO_DEVICE		0
 #define OMAP_DMA_MCSI1_TX		1
@@ -321,85 +273,6 @@
 #define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
 #define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */
 
-/*----------------------------------------------------------------------------*/
-
-#define OMAP1_DMA_TOUT_IRQ		(1 << 0)
-#define OMAP_DMA_DROP_IRQ		(1 << 1)
-#define OMAP_DMA_HALF_IRQ		(1 << 2)
-#define OMAP_DMA_FRAME_IRQ		(1 << 3)
-#define OMAP_DMA_LAST_IRQ		(1 << 4)
-#define OMAP_DMA_BLOCK_IRQ		(1 << 5)
-#define OMAP1_DMA_SYNC_IRQ		(1 << 6)
-#define OMAP2_DMA_PKT_IRQ		(1 << 7)
-#define OMAP2_DMA_TRANS_ERR_IRQ		(1 << 8)
-#define OMAP2_DMA_SECURE_ERR_IRQ	(1 << 9)
-#define OMAP2_DMA_SUPERVISOR_ERR_IRQ	(1 << 10)
-#define OMAP2_DMA_MISALIGNED_ERR_IRQ	(1 << 11)
-
-#define OMAP_DMA_CCR_EN			(1 << 7)
-
-#define OMAP_DMA_DATA_TYPE_S8		0x00
-#define OMAP_DMA_DATA_TYPE_S16		0x01
-#define OMAP_DMA_DATA_TYPE_S32		0x02
-
-#define OMAP_DMA_SYNC_ELEMENT		0x00
-#define OMAP_DMA_SYNC_FRAME		0x01
-#define OMAP_DMA_SYNC_BLOCK		0x02
-#define OMAP_DMA_SYNC_PACKET		0x03
-
-#define OMAP_DMA_SRC_SYNC		0x01
-#define OMAP_DMA_DST_SYNC		0x00
-
-#define OMAP_DMA_PORT_EMIFF		0x00
-#define OMAP_DMA_PORT_EMIFS		0x01
-#define OMAP_DMA_PORT_OCP_T1		0x02
-#define OMAP_DMA_PORT_TIPB		0x03
-#define OMAP_DMA_PORT_OCP_T2		0x04
-#define OMAP_DMA_PORT_MPUI		0x05
-
-#define OMAP_DMA_AMODE_CONSTANT		0x00
-#define OMAP_DMA_AMODE_POST_INC		0x01
-#define OMAP_DMA_AMODE_SINGLE_IDX	0x02
-#define OMAP_DMA_AMODE_DOUBLE_IDX	0x03
-
-#define DMA_DEFAULT_FIFO_DEPTH		0x10
-#define DMA_DEFAULT_ARB_RATE		0x01
-/* Pass THREAD_RESERVE ORed with THREAD_FIFO for tparams */
-#define DMA_THREAD_RESERVE_NORM		(0x00 << 12) /* Def */
-#define DMA_THREAD_RESERVE_ONET		(0x01 << 12)
-#define DMA_THREAD_RESERVE_TWOT		(0x02 << 12)
-#define DMA_THREAD_RESERVE_THREET	(0x03 << 12)
-#define DMA_THREAD_FIFO_NONE		(0x00 << 14) /* Def */
-#define DMA_THREAD_FIFO_75		(0x01 << 14)
-#define DMA_THREAD_FIFO_25		(0x02 << 14)
-#define DMA_THREAD_FIFO_50		(0x03 << 14)
-
-/* DMA4_OCP_SYSCONFIG bits */
-#define DMA_SYSCONFIG_MIDLEMODE_MASK		(3 << 12)
-#define DMA_SYSCONFIG_CLOCKACTIVITY_MASK	(3 << 8)
-#define DMA_SYSCONFIG_EMUFREE			(1 << 5)
-#define DMA_SYSCONFIG_SIDLEMODE_MASK		(3 << 3)
-#define DMA_SYSCONFIG_SOFTRESET			(1 << 2)
-#define DMA_SYSCONFIG_AUTOIDLE			(1 << 0)
-
-#define DMA_SYSCONFIG_MIDLEMODE(n)		((n) << 12)
-#define DMA_SYSCONFIG_SIDLEMODE(n)		((n) << 3)
-
-#define DMA_IDLEMODE_SMARTIDLE			0x2
-#define DMA_IDLEMODE_NO_IDLE			0x1
-#define DMA_IDLEMODE_FORCE_IDLE			0x0
-
-/* Chaining modes*/
-#ifndef CONFIG_ARCH_OMAP1
-#define OMAP_DMA_STATIC_CHAIN		0x1
-#define OMAP_DMA_DYNAMIC_CHAIN		0x2
-#define OMAP_DMA_CHAIN_ACTIVE		0x1
-#define OMAP_DMA_CHAIN_INACTIVE		0x0
-#endif
-
-#define DMA_CH_PRIO_HIGH		0x1
-#define DMA_CH_PRIO_LOW			0x0 /* Def */
-
 enum omap_dma_burst_mode {
 	OMAP_DMA_DATA_BURST_DIS = 0,
 	OMAP_DMA_DATA_BURST_4,
@@ -530,9 +403,7 @@ struct omap_dma_channel_params {
 	unsigned char read_prio;/* read priority */
 	unsigned char write_prio;/* write priority */
 
-#ifndef CONFIG_ARCH_OMAP1
 	enum omap_dma_burst_mode burst_mode; /* Burst mode 4/8/16 words */
-#endif
 };
 
 struct omap_dma_lch {
@@ -643,29 +514,6 @@ void omap_dma_global_context_restore(void);
 
 extern void omap_dma_disable_irq(int lch);
 
-/* Chaining APIs */
-#ifndef CONFIG_ARCH_OMAP1
-extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-				  void (*callback) (int lch, u16 ch_status,
-						    void *data),
-				  int *chain_id, int no_of_chans,
-				  int chain_mode,
-				  struct omap_dma_channel_params params);
-extern int omap_free_dma_chain(int chain_id);
-extern int omap_dma_chain_a_transfer(int chain_id, int src_start,
-				     int dest_start, int elem_count,
-				     int frame_count, void *callbk_data);
-extern int omap_start_dma_chain_transfers(int chain_id);
-extern int omap_stop_dma_chain_transfers(int chain_id);
-extern int omap_get_dma_chain_index(int chain_id, int *ei, int *fi);
-extern int omap_get_dma_chain_dst_pos(int chain_id);
-extern int omap_get_dma_chain_src_pos(int chain_id);
-
-extern int omap_modify_dma_chain_params(int chain_id,
-					struct omap_dma_channel_params params);
-extern int omap_dma_chain_status(int chain_id);
-#endif
-
 #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_FB_OMAP)
 #include <mach/lcd_dma.h>
 #else
-- 
1.7.0.4

