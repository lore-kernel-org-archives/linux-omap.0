From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 09/10] OMAP: DMA: API's Clean up
Date: Fri,  9 Jul 2010 04:21:21 +0530
Message-ID: <1278629482-32501-10-git-send-email-manjugk@ti.com>
References: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39647 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758716Ab0GHWyI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 18:54:08 -0400
In-Reply-To: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

This patch will clean up API's in plat-omap dma library

The API's are cleaned up for eliminating cpu_is_xxxx
checks and machine specific API/code is moved to corresponding mach-omap
directories.

Note: The code in plat-omap dma library will be removed in another patch.
This is to avoid build break.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/dma.c |  253 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dma.c |  296 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 548 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index fb5bf0d..dd03937 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -170,11 +170,149 @@ static struct omap_dma_reg_offset dma_reg_offset[] = {
 };
 struct omap_dma_reg_offset *r = (struct omap_dma_reg_offset *)&dma_reg_offset;
 
+static inline void enable_lnk(int lch);
+static inline void disable_lnk(int lch);
+static inline void omap_enable_channel_irq(int lch);
+static irqreturn_t omap_dma_irq_handler(int irq, void *dev_id);
 
 static struct omap_dma_lch *omap1_dma_chan;
 static void __iomem *dma_base;
 static int enable_1510_mode;
 
+static inline int get_gdma_dev(int req)
+{
+	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
+	int shift = ((req - 1) % 5) * 6;
+
+	return ((omap_readl(reg) >> shift) & 0x3f) + 1;
+}
+
+static inline void set_gdma_dev(int req, int dev)
+{
+	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
+	int shift = ((req - 1) % 5) * 6;
+	u32 l;
+
+	l = omap_readl(reg);
+	l &= ~(0x3f << shift);
+	l |= (dev - 1) << shift;
+	omap_writel(l, reg);
+}
+
+static void sync_device_set(int dev_id, int free_ch)
+{
+	u32 reg;
+
+	reg = (r->lch_base * free_ch) + r->common_ch.ccr;
+	if (cpu_is_omap16xx()) {
+		/* If the sync device is set, configure it dynamically. */
+		if (dev_id != 0) {
+			set_gdma_dev(free_ch + 1, dev_id);
+			dev_id = free_ch + 1;
+		}
+		/*
+		 * Disable the 1510 compatibility mode and set the sync device
+		 * id.
+		 */
+		omap1_dma_write(dev_id | (1 << 10), reg);
+	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
+		omap1_dma_write(dev_id, reg);
+	}
+}
+
+static inline void omap_enable_channel_irq(int lch)
+{
+	u32 reg;
+
+	/* Clear CSR */
+	reg = (r->lch_base * lch) + r->common_ch.csr;
+	omap1_dma_read(reg);
+
+	/* Enable some nice interrupts. */
+	reg = (r->lch_base * lch) + r->common_ch.cicr;
+	omap1_dma_write(omap1_dma_chan[lch].enabled_irqs, reg);
+}
+
+static inline void enable_lnk(int lch)
+{
+	u32 reg, l;
+
+	reg = (r->lch_base * lch) + r->common_ch.clnk_ctrl;
+	l = omap1_dma_read(reg);
+
+	if (omap1_dma_chan[lch].next_linked_ch != -1)
+		l = omap1_dma_chan[lch].next_linked_ch | (1 << 15);
+
+	/* Set the ENABLE_LNK bits */
+	if (omap1_dma_chan[lch].next_lch != -1)
+		l = omap1_dma_chan[lch].next_lch | (1 << 15);
+
+	omap1_dma_write(l, reg);
+}
+
+static inline void disable_lnk(int lch)
+{
+	u32 reg, l;
+
+	reg = (r->lch_base * lch) + r->common_ch.clnk_ctrl;
+	l = omap1_dma_read(reg);
+
+	/* Clear CSR */
+	reg = (r->lch_base * lch) + r->common_ch.cicr;
+	omap1_dma_write(0, reg);
+
+	/* Clear the ENABLE_LNK bit */
+	l &= ~(1 << 15);
+
+	reg = (r->lch_base * lch) + r->common_ch.clnk_ctrl;
+	omap1_dma_write(l, reg);
+	omap1_dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
+}
+
+static void clear_lch_regs(int lch)
+{
+	int reg_count;
+	u32 ch_reg_base, reg;
+
+	ch_reg_base = r->lch_base * lch;
+
+	for (reg_count = 0; reg_count < 0x2c; reg_count += 2) {
+		reg = ch_reg_base + reg_count;
+		omap1_dma_write(0, reg);
+	}
+}
+
+static void clear_ccr_csr(int lch)
+{
+	u32 reg;
+	int l;
+
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	l =  omap1_dma_read(reg);
+	l &= ~OMAP_DMA_CCR_EN;
+	omap1_dma_write(l, reg);
+
+	/* Clear pending interrupts */
+	reg = r->lch_base + r->common_ch.csr;
+	omap1_dma_read(reg);
+}
+
+static int set_prio_lch(int lch, unsigned char read_prio,
+		      unsigned char write_prio)
+{
+	u32 l = 0;
+	l |= ((read_prio & 0x1) << 6);
+	return l;
+}
+
+static int dma_running(int dma_chan_count)
+{
+	if (omap_lcd_dma_running())
+		return 1;
+
+	return 0;
+}
+
 static int omap1_dma_handle_ch(int ch)
 {
 	u32 csr;
@@ -246,6 +384,121 @@ static int dma_irq_register(int dma_irq, int irq_count,
 	return ret;
 }
 
+void omap_set_dma_priority(int lch, int dst_port, int priority)
+{
+	unsigned long reg;
+	u32 l;
+
+	switch (dst_port) {
+	case OMAP_DMA_PORT_OCP_T1:	/* FFFECC00 */
+		reg = OMAP_TC_OCPT1_PRIOR;
+		break;
+	case OMAP_DMA_PORT_OCP_T2:	/* FFFECCD0 */
+		reg = OMAP_TC_OCPT2_PRIOR;
+		break;
+	case OMAP_DMA_PORT_EMIFF:	/* FFFECC08 */
+		reg = OMAP_TC_EMIFF_PRIOR;
+		break;
+	case OMAP_DMA_PORT_EMIFS:	/* FFFECC04 */
+		reg = OMAP_TC_EMIFS_PRIOR;
+		break;
+	default:
+		BUG();
+		return;
+	}
+	l = omap_readl(reg);
+	l &= ~(0xf << 8);
+	l |= (priority & 0xf) << 8;
+	omap_writel(l, reg);
+}
+EXPORT_SYMBOL(omap_set_dma_priority);
+
+void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
+				  int frame_count, int sync_mode,
+				  int dma_trigger, int src_or_dst_synch)
+{
+	u32 reg, l;
+	u16 ccr;
+
+	reg = (r->lch_base * lch) + r->common_ch.csdp;
+	l = omap1_dma_read(reg);
+	l &= ~0x03;
+	l |= data_type;
+	omap1_dma_write(l, reg);
+
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	ccr = omap1_dma_read(reg);
+	ccr &= ~(1 << 5);
+	if (sync_mode == OMAP_DMA_SYNC_FRAME)
+		ccr |= 1 << 5;
+	omap1_dma_write(ccr, reg);
+
+	reg = (r->lch_base * lch) + r->ch_specific.ccr2;
+	ccr = omap1_dma_read(reg);
+	ccr &= ~(1 << 2);
+	if (sync_mode == OMAP_DMA_SYNC_BLOCK)
+		ccr |= 1 << 2;
+	omap1_dma_write(ccr, reg);
+}
+EXPORT_SYMBOL(omap_set_dma_transfer_params);
+
+void set_dma_color_mode(int lch,
+		enum omap_dma_color_mode mode, u32 color)
+{
+	u32 reg;
+	u16 w;
+
+	BUG_ON(enable_1510_mode);
+
+	reg = (r->lch_base * lch) + r->ch_specific.ccr2;
+	w = omap1_dma_read(reg);
+	w &= ~0x03;
+
+	switch (mode) {
+	case OMAP_DMA_CONSTANT_FILL:
+		w |= 0x01;
+		break;
+	case OMAP_DMA_TRANSPARENT_COPY:
+		w |= 0x02;
+		break;
+	case OMAP_DMA_COLOR_DIS:
+		break;
+	default:
+		BUG();
+	}
+	omap1_dma_write(w, reg);
+
+	reg = (r->lch_base * lch) + r->ch_specific.lch_ctrl;
+	w = omap1_dma_read(reg);
+	w &= ~0x0f;
+	/* Default is channel type 2D */
+	if (mode) {
+		reg = (r->lch_base * lch) + r->ch_specific.color_l;
+		omap1_dma_write((u16)color, reg);
+		reg = (r->lch_base * lch) + r->ch_specific.color_u;
+		omap1_dma_write((u16)color >> 16, reg);
+		w |= 1;		/* Channel type G */
+	}
+	reg = (r->lch_base * lch) + r->ch_specific.lch_ctrl;
+	omap1_dma_write(w, reg);
+}
+EXPORT_SYMBOL(set_dma_color_mode);
+
+void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
+{
+	u32 reg;
+
+	if (!enable_1510_mode) {
+		u32 l;
+		reg = (r->lch_base * lch) + r->ch_specific.lch_ctrl;
+		l = omap1_dma_read(reg);
+		l &= ~0x7;
+		l |= mode;
+		omap1_dma_write(l, reg);
+	}
+}
+EXPORT_SYMBOL(omap_set_dma_channel_mode);
+
 static int __init omap1_system_dma_init(void)
 {
 	struct platform_device *pdev;
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 42a96cf..e315096 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -83,6 +83,12 @@ struct dma_link_info {
 
 };
 
+static struct omap_dma_global_context_registers {
+	u32 dma_irqenable_l0;
+	u32 dma_ocp_sysconfig;
+	u32 dma_gcr;
+} omap_dma_global_context;
+
 struct omap_device_pm_latency omap2_dma_latency[] = {
 	{
 	.deactivate_func = omap_device_idle_hwmods,
@@ -129,11 +135,155 @@ struct omap_dma_reg_offset *r = (struct omap_dma_reg_offset *)&dma_reg_offset;
 
 struct omap_dma_dev_attr *d;
 
-static struct omap_system_dma_plat_info *omap2_pdata;
+static inline void omap_enable_lnk(int lch);
+static inline void omap_disable_lnk(int lch);
+static inline void omap_enable_channel_irq(int lch);
+static inline void omap_disable_channel_irq(int lch);
+
+static struct omap_dma_lch *dma_chan;
 static void __iomem *dma_base;
+static struct omap_system_dma_plat_info *omap2_pdata;
 static struct dma_link_info *dma_linked_lch;
 static u32 dma_chan_count;
 
+static inline void omap_enable_channel_irq(int lch)
+{
+	u32 reg;
+
+	/* Clear CSR */
+	reg = (r->lch_base * lch) + r->common_ch.csr;
+	omap2_dma_write(OMAP2_DMA_CSR_CLEAR_MASK, reg);
+
+	/* Enable interrupts. */
+	reg = (r->lch_base * lch) + r->common_ch.cicr;
+	omap2_dma_write(dma_chan[lch].enabled_irqs, reg);
+}
+
+static void omap_disable_channel_irq(int lch)
+{
+	u32 reg;
+	reg = (r->lch_base * lch) + r->common_ch.cicr;
+	omap2_dma_write(0, reg);
+}
+
+static inline void omap_enable_lnk(int lch)
+{
+	u32 reg, l;
+
+	reg = (r->lch_base * lch) + r->common_ch.clnk_ctrl;
+	l = omap2_dma_read(reg);
+
+	/* Set the ENABLE_LNK bits */
+	if (dma_chan[lch].next_lch != -1)
+		l = dma_chan[lch].next_lch | (1 << 15);
+
+	if (dma_chan[lch].next_linked_ch != -1)
+		l = dma_chan[lch].next_linked_ch | (1 << 15);
+
+	omap2_dma_write(l, reg);
+}
+
+static inline void omap_disable_lnk(int lch)
+{
+	u32 reg, l;
+
+	reg = (r->lch_base * lch) + r->common_ch.clnk_ctrl;
+	l = omap2_dma_read(reg);
+
+	/* Disable interrupts */
+	omap_disable_channel_irq(lch);
+
+	/* Clear the ENABLE_LNK bit */
+	l &= ~(1 << 15);
+
+	omap2_dma_write(l, reg);
+	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
+}
+
+static inline void enable_irq_lch(int lch)
+{
+	u32 reg, val;
+
+	reg = r->irqreg.irq_enable_l0;
+	val = omap2_dma_read(reg);
+	val |= 1 << lch;
+	omap2_dma_write(val, reg);
+}
+
+static inline void disable_irq_lch(int lch)
+{
+	u32 reg, val;
+
+	reg = r->irqreg.irq_enable_l0;
+
+	val = omap2_dma_read(reg);
+	val &= ~(1 << lch);
+	omap2_dma_write(val, reg);
+}
+
+static int set_prio_lch(int l, unsigned char read_prio,
+		      unsigned char write_prio)
+{
+	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
+		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
+	else
+		l |= ((read_prio & 0x1) << 6);
+
+	return l;
+}
+
+static int dma_running(int dma_chan_count)
+{
+	u32 lch, reg = 0;
+
+	for (lch = 0; lch < dma_chan_count; lch++) {
+		reg = (r->lch_base * lch) + r->common_ch.ccr;
+		if ((omap2_dma_read(reg)) & OMAP_DMA_CCR_EN)
+			return 1;
+	}
+	return 0;
+}
+
+static void dma_ocpsysconfig_errata(int chain_id)
+{
+	int *channels;
+	u32 sys_cf;
+	u32 reg, l, i;
+
+	/*
+	 * DMA Errata:
+	 * Special programming model needed to disable DMA before end of block
+	 */
+	sys_cf = omap2_dma_read(r->ocp_sysconfig);
+	l = sys_cf;
+	/* Middle mode reg set no Standby */
+	l &= ~((1 << 12)|(1 << 13));
+	omap2_dma_write(l, r->ocp_sysconfig);
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+
+		/* Stop the Channel transmission */
+		reg = (r->lch_base * channels[i]) + r->common_ch.ccr;
+		l = omap2_dma_read(reg);
+		l &= ~(1 << 7);
+		omap2_dma_write(l, reg);
+
+		/* Disable the link in all the channels */
+		omap_disable_lnk(channels[i]);
+		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
+
+	}
+	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(chain_id);
+
+	/* Errata - put in the old value */
+	omap2_dma_write(sys_cf, r->ocp_sysconfig);
+}
+
 static int omap2_dma_handle_ch(int ch)
 {
 	u32 reg, ch_reg_base, status;
@@ -283,6 +433,150 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 	omap2_dma_write(l, reg);
 }
 
+void omap_dma_global_context_save(void)
+{
+	omap_dma_global_context.dma_irqenable_l0  =
+		omap2_dma_read(r->irqreg.irq_enable_l0);
+	omap_dma_global_context.dma_ocp_sysconfig =
+		omap2_dma_read(r->ocp_sysconfig);
+	omap_dma_global_context.dma_gcr           =
+		omap2_dma_read(r->gcr);
+}
+EXPORT_SYMBOL(omap_dma_global_context_save);
+
+void omap_dma_global_context_restore(void)
+{
+	int ch;
+
+	omap2_dma_write(omap_dma_global_context.dma_gcr, r->gcr);
+	omap2_dma_write(omap_dma_global_context.dma_ocp_sysconfig,
+					r->ocp_sysconfig);
+	omap2_dma_write(omap_dma_global_context.dma_irqenable_l0,
+					r->irqreg.irq_enable_l0);
+
+	if (omap2_pdata->errata & DMA_IRQ_STATUS_ERRATA)
+		omap2_dma_write(0x3, r->irqreg.irq_status_l0);
+
+	for (ch = 0; ch < dma_chan_count; ch++)
+		if (dma_chan[ch].dev_id != -1)
+			omap_clear_dma(ch);
+}
+EXPORT_SYMBOL(omap_dma_global_context_restore);
+
+void omap_set_dma_priority(int lch, int dst_port, int priority)
+{
+	u32 reg;
+	int ccr;
+
+	reg = (r->lch_base * lch) + r->common_ch.ccr;
+	ccr = omap2_dma_read(reg);
+
+	if (priority)
+		ccr |=  (1 << 6);
+	else
+		ccr &= ~(1 << 6);
+
+	omap2_dma_write(ccr, reg);
+}
+EXPORT_SYMBOL(omap_set_dma_priority);
+
+
+
+void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
+				  int frame_count, int sync_mode,
+				  int dma_trigger, int src_or_dst_synch)
+{
+	u32 reg, ch_reg_base, l;
+
+	ch_reg_base = r->lch_base * lch;
+	reg = ch_reg_base + r->common_ch.csdp;
+	l = omap2_dma_read(reg);
+	l &= ~0x03;
+	l |= data_type;
+	omap2_dma_write(l, reg);
+
+	if (dma_trigger) {
+		u32 val;
+
+		reg = ch_reg_base + r->common_ch.ccr;
+		val = omap2_dma_read(reg);
+
+		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
+		val &= ~((3 << 19) | 0x1f);
+		val |= (dma_trigger & ~0x1f) << 14;
+		val |= dma_trigger & 0x1f;
+
+		if (sync_mode & OMAP_DMA_SYNC_FRAME)
+			val |= 1 << 5;
+		else
+			val &= ~(1 << 5);
+
+		if (sync_mode & OMAP_DMA_SYNC_BLOCK)
+			val |= 1 << 18;
+		else
+			val &= ~(1 << 18);
+
+		if (src_or_dst_synch)
+			val |= 1 << 24;		/* source synch */
+		else
+			val &= ~(1 << 24);	/* dest synch */
+
+		omap2_dma_write(val, reg);
+	}
+
+	reg = ch_reg_base + r->common_ch.cen;
+	omap2_dma_write(elem_count, reg);
+
+	reg = ch_reg_base + r->common_ch.cfn;
+	omap2_dma_write(frame_count, reg);
+}
+EXPORT_SYMBOL(omap_set_dma_transfer_params);
+
+void set_dma_color_mode(int lch, enum omap_dma_color_mode mode,
+								u32 color)
+{
+	u32 reg, ch_reg_base, val;
+
+	ch_reg_base = r->lch_base * lch;
+	reg = ch_reg_base + r->common_ch.ccr;
+
+	val = omap2_dma_read(reg);
+	val &= ~((1 << 17) | (1 << 16));
+
+	switch (mode) {
+	case OMAP_DMA_CONSTANT_FILL:
+		val |= 1 << 16;
+		break;
+	case OMAP_DMA_TRANSPARENT_COPY:
+		val |= 1 << 17;
+		break;
+	case OMAP_DMA_COLOR_DIS:
+		break;
+	default:
+		BUG();
+	}
+	omap2_dma_write(val, reg);
+
+	color &= 0xffffff;
+	reg = ch_reg_base + r->ch_specific.color;
+	omap2_dma_write(val, reg);
+}
+EXPORT_SYMBOL(set_dma_color_mode);
+
+void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
+{
+	u32 reg, ch_reg_base, val;
+
+	ch_reg_base = r->lch_base * lch;
+
+	reg = ch_reg_base + r->common_ch.csdp;
+	val = omap2_dma_read(reg);
+	val &= ~(0x3 << 16);
+	val |= (mode << 16);
+	omap2_dma_write(val, reg);
+}
+EXPORT_SYMBOL(omap_set_dma_write_mode);
+
 /**
  * @brief omap_request_dma_chain : Request a chain of DMA channels
  *
-- 
1.7.0.4

