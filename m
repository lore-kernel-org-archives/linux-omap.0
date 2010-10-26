From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3 11/13] OMAP: DMA: Use DMA device attributes
Date: Tue, 26 Oct 2010 18:55:11 +0530
Message-ID: <1288099513-1854-12-git-send-email-manjugk@ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1288099513-1854-1-git-send-email-manjugk@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Existing DMA API's are using cpu_*is_* checks for differentiating
omap1 and omap2plus code.

Replace cpu_*is_* checks with DMA device attributes and
also move API's which are OMAP1 and OMAP2plus specific into respective
mach-omap dma driver files.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/dma.c              |  385 ++++++-
 arch/arm/mach-omap1/include/mach/dma.h |   22 +
 arch/arm/mach-omap2/dma.c              | 1099 ++++++++++++++++++-
 arch/arm/mach-omap2/include/mach/dma.h |   51 +
 arch/arm/plat-omap/dma.c               | 1872 +++-----------------------------
 arch/arm/plat-omap/include/plat/dma.h  |   77 +-
 6 files changed, 1670 insertions(+), 1836 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 38a7294..d373458 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -36,34 +36,16 @@
 
 #define OMAP1_DMA_BASE			(0xfffed800)
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
+#define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
 
 static u32 errata;
 static u32 enable_1510_mode;
 
-enum {
-	GCR1 = 0,	GSCR,		GRST,		HW_ID,
-	PCH2_ID,	PCH0_ID,	PCH1_ID,	PCHG_ID,
-	PCHD_ID,	CAPS_0_U,	CAPS_0_L,	CAPS_1_U,
-	CAPS_1_L,	CAPS_2,		CAPS_3,		CAPS_4,
-	PCH2_SR,	PCH0_SR,	PCH1_SR,	PCHD_SR,
-
-	CH_COMMON_START,
-
-	/* Common Registers */
-	CSDP1,		CCR1,		CICR1,		CSR1,
-	CEN1,		CFN1,		CSFI1,		CSEI1,
-	CPC,		CSAC1,		CDAC1,		CDEI1,
-	CDFI1,		CLNK_CTRL1,
-
-	/* Channel specific register offsets */
-	CSSA_L,		CSSA_U,		CDSA_L,		CDSA_U,
-	COLOR_L,	COLOR_U,	CCR1_2,		LCH_CTRL,
-
-	CH_COMMON_END,
-};
+static struct omap_dma_lch *dma_chan;
+static struct omap_dma_dev_attr *d;
 
 static u16 reg_map[] = {
-	[GCR1]		= 0x400,
+	[GCR]		= 0x400,
 	[GSCR]		= 0x404,
 	[GRST]		= 0x408,
 	[HW_ID]		= 0x442,
@@ -85,20 +67,20 @@ static u16 reg_map[] = {
 	[PCHD_SR]	= 0x4c0,
 
 	/* Common Registers */
-	[CSDP1]		= 0x00,
-	[CCR1]		= 0x02,
-	[CICR1]		= 0x04,
-	[CSR1]		= 0x06,
-	[CEN1]		= 0x10,
-	[CFN1]		= 0x12,
-	[CSFI1]		= 0x14,
-	[CSEI1]		= 0x16,
+	[CSDP]		= 0x00,
+	[CCR]		= 0x02,
+	[CICR]		= 0x04,
+	[CSR]		= 0x06,
+	[CEN]		= 0x10,
+	[CFN]		= 0x12,
+	[CSFI]		= 0x14,
+	[CSEI]		= 0x16,
 	[CPC]		= 0x18,	/* 15xx only */
-	[CSAC1]		= 0x18,
-	[CDAC1]		= 0x1a,
-	[CDEI1]		= 0x1c,
-	[CDFI1]		= 0x1e,
-	[CLNK_CTRL1]	= 0x28,
+	[CSAC]		= 0x18,
+	[CDAC]		= 0x1a,
+	[CDEI]		= 0x1c,
+	[CDFI]		= 0x1e,
+	[CLNK_CTRL]	= 0x28,
 
 	/* Channel specific register offsets */
 	[CSSA_L]	= 0x08,
@@ -107,7 +89,7 @@ static u16 reg_map[] = {
 	[CDSA_U]	= 0x0e,
 	[COLOR_L]	= 0x20,
 	[COLOR_U]	= 0x22,
-	[CCR1_2]	= 0x24,
+	[CCR2]		= 0x24,
 	[LCH_CTRL]	= 0x2a,
 };
 
@@ -222,6 +204,195 @@ static inline u16 dma_read(int reg, int lch)
 		return __raw_readw(dma_base + reg_map[reg]);
 }
 
+static void
+set_src_params(int lch, unsigned long src_start, int src_ei, int src_fi)
+{
+	dma_write(src_start >> 16, CSSA_U, lch);
+	dma_write((u16)src_start, CSSA_L, lch);
+
+	dma_write(src_ei, CSEI, lch);
+	dma_write(src_fi, CSFI, lch);
+}
+
+static void set_dest_params(int lch, unsigned long dest_start, int dst_ei,
+								int dst_fi)
+{
+	dma_write(dest_start >> 16, CDSA_U, lch);
+	dma_write(dest_start, CDSA_L, lch);
+
+	dma_write(dst_ei, CDEI, lch);
+	dma_write(dst_fi, CDFI, lch);
+}
+
+static inline void omap1_enable_channel_irq(int lch)
+{
+	u32 status;
+
+	/* Clear CSR */
+	status = dma_read(CSR, lch);
+	dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
+}
+
+static void omap1_disable_channel_irq(int lch)
+{
+	dma_write(0, CICR, lch);
+}
+
+static inline void omap1_enable_lnk(int lch)
+{
+	u32 l;
+
+	l = dma_read(CLNK_CTRL, lch);
+	l &= ~(1 << 14);
+
+	/* Set the ENABLE_LNK bits */
+	if (dma_chan[lch].next_lch != -1)
+		l = dma_chan[lch].next_lch | (1 << 15);
+
+	dma_write(l, CLNK_CTRL, lch);
+}
+
+static inline void omap1_disable_lnk(int lch)
+{
+	u32 l;
+
+	/* Disable interrupts */
+	l = dma_read(CLNK_CTRL, lch);
+	dma_write(0, CICR, lch);
+	/* Set the STOP_LNK bit */
+	l |= 1 << 14;
+	dma_write(l, CLNK_CTRL, lch);
+
+	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
+}
+
+static dma_addr_t get_src_pos(int lch)
+{
+	dma_addr_t offset = 0;
+
+	if (enable_1510_mode)
+		offset = dma_read(CPC, lch);
+	else
+		offset = dma_read(CSAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
+		offset = dma_read(CSAC, lch);
+
+	offset |= (dma_read(CSSA_U, lch) << 16);
+
+	return offset;
+}
+
+static dma_addr_t get_dst_pos(int lch)
+{
+	dma_addr_t offset = 0;
+
+	if (enable_1510_mode)
+		offset = dma_read(CPC, lch);
+	else
+		offset = dma_read(CDAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
+		offset = dma_read(CDAC, lch);
+
+	offset |= (dma_read(CDSA_U, lch) << 16);
+
+	return offset;
+}
+
+static void
+set_transfer_params(int lch, int data_type, int sync_mode, int dma_trigger,
+							int src_or_dst_synch)
+{
+	u16 ccr;
+	u32 l;
+
+	l = dma_read(CSDP, lch);
+	l &= ~0x03;
+	l |= data_type;
+	dma_write(l, CSDP, lch);
+
+	ccr = dma_read(CCR, lch);
+	ccr &= ~(1 << 5);
+	if (sync_mode == OMAP_DMA_SYNC_FRAME)
+		ccr |= 1 << 5;
+	dma_write(ccr, CCR, lch);
+
+	ccr = dma_read(CCR2, lch);
+	ccr &= ~(1 << 2);
+	if (sync_mode == OMAP_DMA_SYNC_BLOCK)
+		ccr |= 1 << 2;
+	dma_write(ccr, CCR2, lch);
+}
+
+static void cpc_cdac_init(int lch)
+{
+	if (enable_1510_mode)
+		dma_write(0, CPC, lch);
+	else
+		dma_write(0, CDAC, lch);
+}
+
+static void omap1_clear_lch_regs(int lch)
+{
+	int i = CH_COMMON_START + 1;
+
+	for (; i <= CH_COMMON_END; i += 1)
+		dma_write(0, i, lch);
+}
+
+static inline int omap1_get_gdma_dev(int req)
+{
+	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
+	int shift = ((req - 1) % 5) * 6;
+
+	return ((omap_readl(reg) >> shift) & 0x3f) + 1;
+}
+
+static inline void omap1_set_gdma_dev(int req, int dev)
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
+static void set_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
+{
+	u16 w;
+
+	w = dma_read(CCR2, lch);
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
+	dma_write(w, CCR2, lch);
+
+	w = dma_read(LCH_CTRL, lch);
+	w &= ~0x0f;
+	/* Default is channel type 2D */
+	if (mode) {
+		dma_write((u16)color, COLOR_L, lch);
+		dma_write((u16)(color >> 16), COLOR_U, lch);
+		w |= 1;		/* Channel type G */
+	}
+	dma_write(w, LCH_CTRL, lch);
+}
+
 static void omap1_show_dma_caps(void)
 {
 	if (enable_1510_mode) {
@@ -259,12 +430,93 @@ static u32 configure_dma_errata(void)
 	return errata;
 }
 
+static int omap1_dma_handle_ch(int ch)
+{
+	u32 csr;
+
+	if (enable_1510_mode && ch >= 6) {
+		csr = dma_chan[ch].saved_csr;
+		dma_chan[ch].saved_csr = 0;
+	} else
+		csr = dma_read(CSR, ch);
+	if (enable_1510_mode && ch <= 2 && (csr >> 7) != 0) {
+		dma_chan[ch + 6].saved_csr = csr >> 7;
+		csr &= 0x7f;
+	}
+	if ((csr & 0x3f) == 0)
+		return 0;
+	if (unlikely(dma_chan[ch].dev_id == -1)) {
+		printk(KERN_WARNING "Spurious interrupt from DMA channel "
+		       "%d (CSR %04x)\n", ch, csr);
+		return 0;
+	}
+	if (unlikely(csr & OMAP1_DMA_TOUT_IRQ))
+		printk(KERN_WARNING "DMA timeout with device %d\n",
+		       dma_chan[ch].dev_id);
+	if (unlikely(csr & OMAP_DMA_DROP_IRQ))
+		printk(KERN_WARNING "DMA synchronization event drop occurred "
+		       "with device %d\n", dma_chan[ch].dev_id);
+	if (likely(csr & OMAP_DMA_BLOCK_IRQ))
+		dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
+	if (likely(dma_chan[ch].callback != NULL))
+		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
+
+	return 1;
+}
+
+static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
+{
+	int ch = ((int) dev_id) - 1;
+	int handled = 0;
+
+	for (;;) {
+		int handled_now = 0;
+
+		handled_now += omap1_dma_handle_ch(ch);
+		if (enable_1510_mode && dma_chan[ch + 6].saved_csr)
+			handled_now += omap1_dma_handle_ch(ch + 6);
+		if (!handled_now)
+			break;
+		handled += handled_now;
+	}
+
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
+{
+	if (!(d->dev_caps & ENABLE_1510_MODE)) {
+		u32 l;
+
+		l = dma_read(LCH_CTRL, lch);
+		l &= ~0x7;
+		l |= mode;
+		dma_write(l, LCH_CTRL, lch);
+	}
+}
+EXPORT_SYMBOL(omap_set_dma_channel_mode);
+
+void omap_set_dma_src_index(int lch, int eidx, int fidx)
+{
+	dma_write(eidx, CSEI, lch);
+	dma_write(fidx, CSFI, lch);
+}
+EXPORT_SYMBOL(omap_set_dma_src_index);
+
+void omap_set_dma_dest_index(int lch, int eidx, int fidx)
+{
+	dma_write(eidx, CDEI, lch);
+	dma_write(fidx, CDFI, lch);
+}
+EXPORT_SYMBOL(omap_set_dma_dest_index);
+
 static int __init omap1_system_dma_init(void)
 {
 	struct omap_system_dma_plat_info	*p;
-	struct omap_dma_dev_attr		*d;
 	struct platform_device			*pdev;
-	int ret;
+	int ret, ch, irq_rel;
+	char irq_name[4];
+	int dma_irq = 0;
 
 	pdev = platform_device_alloc("omap_dma_system", 0);
 	if (!pdev) {
@@ -287,8 +539,8 @@ static int __init omap1_system_dma_init(void)
 		ret = -ENOMEM;
 		goto exit_device_put;
 	}
-
 	d = p->dma_attr;
+
 	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
 					(d->lch_count), GFP_KERNEL);
 	if (!d->chan) {
@@ -321,10 +573,51 @@ static int __init omap1_system_dma_init(void)
 			d->chan_count = 9;
 	}
 
+	for (ch = 0; ch < d->chan_count; ch++) {
+		if (ch >= 6 && enable_1510_mode)
+			continue;
+
+		sprintf(&irq_name[0], "%d", ch);
+		dma_irq = platform_get_irq_byname(pdev, irq_name);
+		if (dma_irq < 0) {
+			dev_err(&pdev->dev, "%s:unable to get irq\n",
+								__func__);
+			ret = dma_irq;
+			goto exit_release_irq;
+		}
+
+		ret = request_irq(dma_irq, omap1_dma_irq_handler, 0, "DMA",
+							(void *) (ch + 1));
+		if (ret != 0)
+			goto exit_release_irq;
+	}
+
 	p->omap_dma_base	= (void __iomem *)res[0].start;
 	dma_base		= p->omap_dma_base;
 
 	p->show_dma_caps	= omap1_show_dma_caps;
+	p->enable_channel_irq	= omap1_enable_channel_irq;
+	p->disable_channel_irq	= omap1_disable_channel_irq;
+	p->enable_lnk		= omap1_enable_lnk;
+	p->disable_lnk		= omap1_disable_lnk;
+	p->clear_lch_regs	= omap1_clear_lch_regs;
+	p->set_transfer_params	= set_transfer_params;
+	p->set_color_mode	= set_color_mode;
+	p->set_src_params	= set_src_params;
+	p->set_dest_params	= set_dest_params;
+	p->get_src_pos		= get_src_pos;
+	p->get_dst_pos		= get_dst_pos;
+	p->cpc_cdac_init	= cpc_cdac_init;
+
+	if (cpu_is_omap16xx()) {
+		p->get_gdma_dev = omap1_get_gdma_dev;
+		p->set_gdma_dev = omap1_set_gdma_dev;
+	}
+
+	p->enable_irq_lch	= NULL;
+	p->disable_irq_lch	= NULL;
+	p->clear_channel_int	= NULL;
+	p->set_global_params	= NULL;
 	p->disable_irq_lch	= NULL;
 
 	/* Configure errata handling for all omap1+ */
@@ -342,14 +635,28 @@ static int __init omap1_system_dma_init(void)
 			__func__, pdev->name, pdev->id);
 		goto exit_release_chan;
 	}
+	dma_chan = d->chan;
 	return ret;
 
 exit_release_chan:
 	kfree(d->chan);
+
+exit_release_irq:
+	printk(KERN_ERR "unable to request IRQ %d"
+				"for DMA (error %d)\n", dma_irq, ret);
+	if (enable_1510_mode)
+		ch = 6;
+	for (irq_rel = 0; irq_rel < ch; irq_rel++) {
+		dma_irq = platform_get_irq(pdev, irq_rel);
+		free_irq(dma_irq, (void *)(irq_rel + 1));
+	}
+
 exit_release_p:
 	kfree(p);
+
 exit_device_put:
 	platform_device_put(pdev);
+
 exit_device_del:
 	platform_device_del(pdev);
 
diff --git a/arch/arm/mach-omap1/include/mach/dma.h b/arch/arm/mach-omap1/include/mach/dma.h
index 7949e3f..2ad11ff 100644
--- a/arch/arm/mach-omap1/include/mach/dma.h
+++ b/arch/arm/mach-omap1/include/mach/dma.h
@@ -26,4 +26,26 @@
 #ifndef __ASM_ARCH_OMAP1_DMA_H
 #define __ASM_ARCH_OMAP1_DMA_H
 
+enum {
+	GCR = 0,	GSCR,		GRST,		HW_ID,
+	PCH2_ID,	PCH0_ID,	PCH1_ID,	PCHG_ID,
+	PCHD_ID,	CAPS_0_U,	CAPS_0_L,	CAPS_1_U,
+	CAPS_1_L,	CAPS_2,		CAPS_3,		CAPS_4,
+	PCH2_SR,	PCH0_SR,	PCH1_SR,	PCHD_SR,
+
+	CH_COMMON_START,
+
+	/* Common Registers */
+	CSDP,		CCR,		CICR,		CSR,
+	CEN,		CFN,		CSFI,		CSEI,
+	CPC,		CSAC,		CDAC,		CDEI,
+	CDFI,		CLNK_CTRL,
+
+	/* Channel specific register offsets */
+	CSSA_L,		CSSA_U,		CDSA_L,		CDSA_U,
+	COLOR_L,	COLOR_U,	CCR2,		LCH_CTRL,
+
+	CH_COMMON_END,
+};
+
 #endif /* __ASM_ARCH_OMAP1_DMA_H */
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 5ca519b..6df4835 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -40,35 +40,71 @@
 #include <plat/dma.h>
 
 static u32 errata;
+static int dma_chan_count;
+
 static struct omap_dma_dev_attr *d;
+static struct dma_link_info *dma_linked_lch;
+static struct omap_dma_lch *dma_chan;
+static struct platform_device *pd;
 
-enum {
-	REVISION = 0,	GCR2,		IRQSTATUS_L0,	IRQSTATUS_L1,
-	IRQSTATUS_L2,	IRQSTATUS_L3,	IRQENABLE_L0,	IRQENABLE_L1,
-	IRQENABLE_L2,	IRQENABLE_L3,	SYSSTATUS,	OCP_SYSCONFIG,
-	CAPS_0,		CAPS_2,		CAPS_3,		CAPS_4,
+/* Chain handling macros */
+#define OMAP_DMA_CHAIN_QINIT(chain_id)					\
+	do {								\
+		dma_linked_lch[chain_id].q_head =			\
+		dma_linked_lch[chain_id].q_tail =			\
+		dma_linked_lch[chain_id].q_count = 0;			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QFULL(chain_id)					\
+		(dma_linked_lch[chain_id].no_of_lchs_linked ==		\
+		dma_linked_lch[chain_id].q_count)
+#define OMAP_DMA_CHAIN_QLAST(chain_id)					\
+	do {								\
+		((dma_linked_lch[chain_id].no_of_lchs_linked-1) ==	\
+		dma_linked_lch[chain_id].q_count)			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
+		(0 == dma_linked_lch[chain_id].q_count)
+#define __OMAP_DMA_CHAIN_INCQ(end)					\
+	((end) = ((end)+1) % dma_linked_lch[chain_id].no_of_lchs_linked)
+#define OMAP_DMA_CHAIN_INCQHEAD(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_head);	\
+		dma_linked_lch[chain_id].q_count--;			\
+	} while (0)
 
-	CH_COMMON_START,
+#define OMAP_DMA_CHAIN_INCQTAIL(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_tail);	\
+		dma_linked_lch[chain_id].q_count++; \
+	} while (0)
 
-	/* Common register offsets */
-	CCR2,		CLNK_CTRL2,	CICR2,		CSR2,
-	CSDP2,		CEN2,		CFN2,		CSEI2,
-	CSFI2,		CDEI2,		CDFI2,		CSAC2,
-	CDAC2,
+enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
+	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
+};
 
-	/* Channel specific register offsets */
-	CSSA,		CDSA,		CCEN,		CCFN,
-	COLOR,
+enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
-	/* OMAP4 specific registers */
-	CDP,		CNDP,		CCDN,
+struct dma_link_info {
+	int *linked_dmach_q;
+	int no_of_lchs_linked;
+
+	int q_count;
+	int q_tail;
+	int q_head;
+
+	int chain_state;
+	int chain_mode;
 
-	CH_COMMON_END,
 };
 
+static struct omap_dma_global_context_registers {
+	u32 dma_irqenable_l0;
+	u32 dma_gcr;
+} omap_dma_global_context;
+
 static u16 reg_map[] = {
 	[REVISION]		= 0x00,
-	[GCR2]			= 0x78,
+	[GCR]			= 0x78,
 	[IRQSTATUS_L0]		= 0x08,
 	[IRQSTATUS_L1]		= 0x0c,
 	[IRQSTATUS_L2]		= 0x10,
@@ -85,19 +121,19 @@ static u16 reg_map[] = {
 	[CAPS_4]		= 0x74,
 
 	/* Common register offsets */
-	[CCR2]			= 0x80,
-	[CLNK_CTRL2]		= 0x84,
-	[CICR2]			= 0x88,
-	[CSR2]			= 0x8c,
-	[CSDP2]			= 0x90,
-	[CEN2]			= 0x94,
-	[CFN2]			= 0x98,
-	[CSEI2]			= 0xa4,
-	[CSFI2]			= 0xa8,
-	[CDEI2]			= 0xac,
-	[CDFI2]			= 0xb0,
-	[CSAC2]			= 0xb4,
-	[CDAC2]			= 0xb8,
+	[CCR]			= 0x80,
+	[CLNK_CTRL]		= 0x84,
+	[CICR]			= 0x88,
+	[CSR]			= 0x8c,
+	[CSDP]			= 0x90,
+	[CEN]			= 0x94,
+	[CFN]			= 0x98,
+	[CSEI]			= 0xa4,
+	[CSFI]			= 0xa8,
+	[CDEI]			= 0xac,
+	[CDFI]			= 0xb0,
+	[CSAC]			= 0xb4,
+	[CDAC]			= 0xb8,
 
 	/* Channel specific register offsets */
 	[CSSA]			= 0x9c,
@@ -137,7 +173,16 @@ static inline u32 dma_read(int reg, int lch)
 		return __raw_readl(dma_base + reg_map[reg]);
 }
 
-static inline void disable_irq_lch(int lch)
+static inline void omap2_enable_irq_lch(int lch)
+{
+	u32 val;
+
+	val = dma_read(IRQENABLE_L0, lch);
+	val |= 1 << lch;
+	dma_write(val, IRQENABLE_L0, lch);
+}
+
+static inline void omap2_disable_irq_lch(int lch)
 {
 	u32 val;
 
@@ -146,6 +191,336 @@ static inline void disable_irq_lch(int lch)
 	dma_write(val, IRQENABLE_L0, lch);
 }
 
+static inline void omap2_clear_channel_interrupt(int lch)
+{
+	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
+	dma_write(1 << lch, IRQSTATUS_L0, lch);
+}
+
+static inline void omap2_enable_channel_irq(int lch)
+{
+	/* Clear CSR */
+	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
+
+	dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
+}
+
+static void omap2_disable_channel_irq(int lch)
+{
+	dma_write(0, CICR, lch);
+}
+
+static inline void omap2_enable_lnk(int lch)
+{
+	u32 l;
+
+	l = dma_read(CLNK_CTRL, lch);
+
+	/* Set the ENABLE_LNK bits */
+	if (dma_chan[lch].next_lch != -1)
+		l = dma_chan[lch].next_lch | (1 << 15);
+
+	if (dma_chan[lch].next_linked_ch != -1)
+		l = dma_chan[lch].next_linked_ch | (1 << 15);
+
+	dma_write(l, CLNK_CTRL, lch);
+}
+
+static inline void omap2_disable_lnk(int lch)
+{
+	u32 l;
+
+	l = dma_read(CLNK_CTRL, lch);
+
+	omap2_disable_channel_irq(lch);
+	/* Clear the ENABLE_LNK bit */
+	l &= ~(1 << 15);
+
+	dma_write(l, CLNK_CTRL, lch);
+	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
+}
+
+static void
+omap2_set_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
+{
+	u32 val;
+
+	val = dma_read(CCR, lch);
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
+	dma_write(val, CCR, lch);
+
+	color &= 0xffffff;
+	dma_write(color, COLOR, lch);
+}
+
+void omap_dma_global_context_save(void)
+{
+	omap_dma_global_context.dma_irqenable_l0 =
+		dma_read(IRQENABLE_L0, 0);
+
+	omap_dma_global_context.dma_gcr = dma_read(GCR, 0);
+}
+
+void omap_dma_global_context_restore(void)
+{
+	int ch;
+
+	dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
+
+	dma_write(omap_dma_global_context.dma_irqenable_l0,
+		IRQENABLE_L0, 0);
+
+	/*
+	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
+	 * after secure sram context save and restore. Hence we need to
+	 * manually clear those IRQs to avoid spurious interrupts. This
+	 * affects only secure devices.
+	 */
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		dma_write(0x3 , IRQSTATUS_L0, 0);
+
+	for (ch = 0; ch < dma_chan_count; ch++)
+		if (dma_chan[ch].dev_id != -1)
+			omap_clear_dma(ch);
+}
+
+void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
+{
+	u32 csdp;
+
+	csdp = dma_read(CSDP, lch);
+	csdp &= ~(0x3 << 16);
+	csdp |= (mode << 16);
+	dma_write(csdp, CSDP, lch);
+}
+EXPORT_SYMBOL(omap_set_dma_write_mode);
+
+/**
+ * @brief omap_dma_set_global_params : Set global priority settings for dma
+ *
+ * @param arb_rate
+ * @param max_fifo_depth
+ * @param tparams - Number of threads to reserve:
+ * DMA_THREAD_RESERVE_NORM
+ * DMA_THREAD_RESERVE_ONET
+ * DMA_THREAD_RESERVE_TWOT
+ * DMA_THREAD_RESERVE_THREET
+ */
+void
+omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
+{
+	u32 reg;
+
+	if (max_fifo_depth == 0)
+		max_fifo_depth = 1;
+	if (arb_rate == 0)
+		arb_rate = 1;
+
+	reg = 0xff & max_fifo_depth;
+	reg |= (0x3 & tparams) << 12;
+	reg |= (arb_rate & 0xff) << 16;
+
+	dma_write(reg, GCR, 0);
+}
+EXPORT_SYMBOL(omap_dma_set_global_params);
+
+static int omap2_dma_handle_ch(int ch)
+{
+	u32 status = dma_read(CSR, ch);
+
+	if (!status) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
+				ch);
+		dma_write(1 << ch, IRQSTATUS_L0, ch);
+		return 0;
+	}
+	if (unlikely(dma_chan[ch].dev_id == -1)) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "IRQ %04x for non-allocated DMA"
+					"channel %d\n", status, ch);
+		return 0;
+	}
+	if (unlikely(status & OMAP_DMA_DROP_IRQ))
+		printk(KERN_INFO
+		       "DMA synchronization event drop occurred with device "
+		       "%d\n", dma_chan[ch].dev_id);
+	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
+		printk(KERN_INFO "DMA transaction error with device %d\n",
+		       dma_chan[ch].dev_id);
+		if (IS_DMA_ERRATA(DMA_ERRATA_i378)) {
+			u32 ccr;
+
+			ccr = dma_read(CCR, ch);
+			ccr &= ~OMAP_DMA_CCR_EN;
+			dma_write(ccr, CCR, ch);
+			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
+		}
+	}
+	if (unlikely(status & OMAP2_DMA_SECURE_ERR_IRQ))
+		printk(KERN_INFO "DMA secure error with device %d\n",
+		       dma_chan[ch].dev_id);
+	if (unlikely(status & OMAP2_DMA_MISALIGNED_ERR_IRQ))
+		printk(KERN_INFO "DMA misaligned error with device %d\n",
+		       dma_chan[ch].dev_id);
+
+	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, ch);
+	dma_write(1 << ch, IRQSTATUS_L0, ch);
+
+	/* If the ch is not chained then chain_id will be -1 */
+	if (dma_chan[ch].chain_id != -1) {
+		int chain_id = dma_chan[ch].chain_id;
+		dma_chan[ch].state = DMA_CH_NOTSTARTED;
+		if (dma_read(CLNK_CTRL, ch) & (1 << 15))
+			dma_chan[dma_chan[ch].next_linked_ch].state =
+							DMA_CH_STARTED;
+		if (dma_linked_lch[chain_id].chain_mode ==
+						OMAP_DMA_DYNAMIC_CHAIN)
+			omap2_disable_lnk(ch);
+
+		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
+			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
+
+		status = dma_read(CSR, ch);
+	}
+
+	dma_write(status, CSR, ch);
+
+	if (likely(dma_chan[ch].callback != NULL))
+		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
+
+	return 0;
+}
+
+/* STATUS register count is from 1-32 while our is 0-31 */
+static irqreturn_t irq_handler(int irq, void *dev_id)
+{
+	u32 val, enable_reg;
+	int i;
+
+	val = dma_read(IRQSTATUS_L0, 0);
+	if (val == 0) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "Spurious DMA IRQ\n");
+		return IRQ_HANDLED;
+	}
+	enable_reg = dma_read(IRQENABLE_L0, 0);
+	val &= enable_reg; /* Dispatch only relevant interrupts */
+	for (i = 0; i < dma_chan_count && val != 0; i++) {
+		if (val & 1)
+			omap2_dma_handle_ch(i);
+		val >>= 1;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction omap24xx_dma_irq = {
+	.name = "DMA",
+	.handler = irq_handler,
+	.flags = IRQF_DISABLED
+};
+
+static void omap2_set_transfer_params(int lch, int data_type, int sync_mode,
+				int dma_trigger, int src_or_dst_synch)
+{
+	u32 val, l;
+
+	l = dma_read(CSDP, lch);
+	l &= ~0x03;
+	l |= data_type;
+	dma_write(l, CSDP, lch);
+
+	if (dma_trigger) {
+		val = dma_read(CCR, lch);
+
+		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
+		val &= ~((1 << 23) | (3 << 19) | 0x1f);
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
+		if (src_or_dst_synch == OMAP_DMA_DST_SYNC_PREFETCH) {
+			val &= ~(1 << 24);	/* dest synch */
+			val |= (1 << 23);	/* Prefetch */
+		} else if (src_or_dst_synch) {
+			val |= 1 << 24;		/* source synch */
+		} else {
+			val &= ~(1 << 24);	/* dest synch */
+		}
+		dma_write(val, CCR, lch);
+	}
+}
+
+static void omap2_set_src_params(int lch, unsigned long src_start, int src_ei,
+								int src_fi)
+{
+	dma_write(src_start, CSSA, lch);
+
+	dma_write(src_ei, CSEI, lch);
+	dma_write(src_fi, CSFI, lch);
+}
+
+static void omap2_set_dest_params(int lch, unsigned long dest_start, int dst_ei,
+								int dst_fi)
+{
+	dma_write(dest_start, CDSA, lch);
+
+	dma_write(dst_ei, CDEI, lch);
+	dma_write(dst_fi, CDFI, lch);
+}
+
+static dma_addr_t omap2_set_src_pos(int lch)
+{
+	dma_addr_t offset = 0;
+
+	offset = dma_read(CSAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
+		offset = dma_read(CSAC, lch);
+
+	return offset;
+}
+
+static dma_addr_t omap2_get_dst_pos(int lch)
+{
+	dma_addr_t offset = 0;
+
+	offset = dma_read(CDAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && (offset == 0))
+		offset = dma_read(CDAC, lch);
+
+	return offset;
+}
+
+static void omap2_cpc_cdac_init(int lch)
+{
+	dma_write(0, CDAC, lch);
+}
+
 static void omap2_show_dma_caps(void)
 {
 	u8 revision = dma_read(REVISION, 0) & 0xff;
@@ -225,12 +600,620 @@ static u32 configure_dma_errata(void)
 	return errata;
 }
 
+/* Create chain of DMA channesls */
+static void create_dma_lch_chain(int lch_head, int lch_queue)
+{
+	u32 l;
+
+	/* Check if this is the first link in chain */
+	if (dma_chan[lch_head].next_linked_ch == -1) {
+		dma_chan[lch_head].next_linked_ch = lch_queue;
+		dma_chan[lch_head].prev_linked_ch = lch_queue;
+		dma_chan[lch_queue].next_linked_ch = lch_head;
+		dma_chan[lch_queue].prev_linked_ch = lch_head;
+	}
+
+	/* a link exists, link the new channel in circular chain */
+	else {
+		dma_chan[lch_queue].next_linked_ch =
+					dma_chan[lch_head].next_linked_ch;
+		dma_chan[lch_queue].prev_linked_ch = lch_head;
+		dma_chan[lch_head].next_linked_ch = lch_queue;
+		dma_chan[dma_chan[lch_queue].next_linked_ch].prev_linked_ch =
+					lch_queue;
+	}
+
+	l = dma_read(CLNK_CTRL, lch_head);
+	l &= ~(0x1f);
+	l |= lch_queue;
+	dma_write(l, CLNK_CTRL, lch_head);
+
+	l = dma_read(CLNK_CTRL, lch_queue);
+	l &= ~(0x1f);
+	l |= (dma_chan[lch_queue].next_linked_ch);
+	dma_write(l, CLNK_CTRL, lch_queue);
+}
+
+/**
+ * @brief omap_request_dma_chain : Request a chain of DMA channels
+ *
+ * @param dev_id - Device id using the dma channel
+ * @param dev_name - Device name
+ * @param callback - Call back function
+ * @chain_id -
+ * @no_of_chans - Number of channels requested
+ * @chain_mode - Dynamic or static chaining : OMAP_DMA_STATIC_CHAIN
+ * OMAP_DMA_DYNAMIC_CHAIN
+ * @params - Channel parameters
+ *
+ * @return - Success : 0
+ *           Failure: -EINVAL/-ENOMEM
+ */
+int omap_request_dma_chain(int dev_id, const char *dev_name,
+			   void (*callback) (int lch, u16 ch_status,
+					     void *data),
+			   int *chain_id, int no_of_chans, int chain_mode,
+			   struct omap_dma_channel_params params)
+{
+	int *channels;
+	int i, err;
+
+	/* Is the chain mode valid ? */
+	if (chain_mode != OMAP_DMA_STATIC_CHAIN
+			&& chain_mode != OMAP_DMA_DYNAMIC_CHAIN) {
+		printk(KERN_ERR "Invalid chain mode requested\n");
+		return -EINVAL;
+	}
+
+	if (unlikely((no_of_chans < 1
+			|| no_of_chans > dma_chan_count))) {
+		printk(KERN_ERR "Invalid Number of channels requested\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate a queue to maintain the status of the channels
+	 * in the chain
+	 */
+	channels = kmalloc(sizeof(*channels) * no_of_chans, GFP_KERNEL);
+	if (channels == NULL) {
+		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
+		return -ENOMEM;
+	}
+
+	/* request and reserve DMA channels for the chain */
+	for (i = 0; i < no_of_chans; i++) {
+		err = omap_request_dma(dev_id, dev_name,
+					callback, NULL, &channels[i]);
+		if (err < 0) {
+			int j;
+			for (j = 0; j < i; j++)
+				omap_free_dma(channels[j]);
+			kfree(channels);
+			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
+			return err;
+		}
+		dma_chan[channels[i]].prev_linked_ch = -1;
+		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
+
+		/*
+		 * Allowing client drivers to set common parameters now,
+		 * so that later only relevant (src_start, dest_start
+		 * and element count) can be set
+		 */
+		omap_set_dma_params(channels[i], &params);
+	}
+
+	*chain_id = channels[0];
+	dma_linked_lch[*chain_id].linked_dmach_q = channels;
+	dma_linked_lch[*chain_id].chain_mode = chain_mode;
+	dma_linked_lch[*chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
+	dma_linked_lch[*chain_id].no_of_lchs_linked = no_of_chans;
+
+	for (i = 0; i < no_of_chans; i++)
+		dma_chan[channels[i]].chain_id = *chain_id;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(*chain_id);
+
+	/* Set up the chain */
+	if (no_of_chans == 1)
+		create_dma_lch_chain(channels[0], channels[0]);
+	else {
+		for (i = 0; i < (no_of_chans - 1); i++)
+			create_dma_lch_chain(channels[i], channels[i + 1]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_request_dma_chain);
+
+/**
+ * @brief omap_modify_dma_chain_param : Modify the chain's params - Modify the
+ * params after setting it. Dont do this while dma is running!!
+ *
+ * @param chain_id - Chained logical channel id.
+ * @param params
+ *
+ * @return - Success : 0
+ *           Failure : -EINVAL
+ */
+int omap_modify_dma_chain_params(int chain_id,
+				struct omap_dma_channel_params params)
+{
+	int *channels;
+	u32 i;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0
+			|| chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+		/*
+		 * Allowing client drivers to set common parameters now,
+		 * so that later only relevant (src_start, dest_start
+		 * and element count) can be set
+		 */
+		omap_set_dma_params(channels[i], &params);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_modify_dma_chain_params);
+
+/**
+ * @brief omap_free_dma_chain - Free all the logical channels in a chain.
+ *
+ * @param chain_id
+ *
+ * @return - Success : 0
+ *           Failure : -EINVAL
+ */
+int omap_free_dma_chain(int chain_id)
+{
+	int *channels;
+	u32 i;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+		dma_chan[channels[i]].next_linked_ch = -1;
+		dma_chan[channels[i]].prev_linked_ch = -1;
+		dma_chan[channels[i]].chain_id = -1;
+		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
+		omap_free_dma(channels[i]);
+	}
+
+	kfree(channels);
+
+	dma_linked_lch[chain_id].linked_dmach_q = NULL;
+	dma_linked_lch[chain_id].chain_mode = -1;
+	dma_linked_lch[chain_id].chain_state = -1;
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_free_dma_chain);
+
+/**
+ * @brief omap_dma_chain_status - Check if the chain is in
+ * active / inactive state.
+ * @param chain_id
+ *
+ * @return - Success : OMAP_DMA_CHAIN_ACTIVE/OMAP_DMA_CHAIN_INACTIVE
+ *           Failure : -EINVAL
+ */
+int omap_dma_chain_status(int chain_id)
+{
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	pr_debug("CHAINID=%d, qcnt=%d\n", chain_id,
+			dma_linked_lch[chain_id].q_count);
+
+	if (OMAP_DMA_CHAIN_QEMPTY(chain_id))
+		return OMAP_DMA_CHAIN_INACTIVE;
+
+	return OMAP_DMA_CHAIN_ACTIVE;
+}
+EXPORT_SYMBOL(omap_dma_chain_status);
+
+/**
+ * @brief omap_dma_chain_a_transfer - Get a free channel from a chain,
+ * set the params and start the transfer.
+ *
+ * @param chain_id
+ * @param src_start - buffer start address
+ * @param dest_start - Dest address
+ * @param elem_count
+ * @param frame_count
+ * @param callbk_data - channel callback parameter data.
+ *
+ * @return  - Success : 0
+ *            Failure: -EINVAL/-EBUSY
+ */
+int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
+			int elem_count, int frame_count, void *callbk_data)
+{
+	int *channels;
+	u32 l, lch;
+	int start_dma = 0;
+
+	/*
+	 * if buffer size is less than 1 then there is
+	 * no use of starting the chain
+	 */
+	if (elem_count < 1) {
+		printk(KERN_ERR "Invalid buffer size\n");
+		return -EINVAL;
+	}
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0
+			|| chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exist\n");
+		return -EINVAL;
+	}
+
+	/* Check if all the channels in chain are in use */
+	if (OMAP_DMA_CHAIN_QFULL(chain_id))
+		return -EBUSY;
+
+	/* Frame count may be negative in case of indexed transfers */
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get a free channel */
+	lch = channels[dma_linked_lch[chain_id].q_tail];
+
+	/* Store the callback data */
+	dma_chan[lch].data = callbk_data;
+
+	/* Increment the q_tail */
+	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
+
+	/* Set the params to the free channel */
+	if (src_start != 0)
+		dma_write(src_start, CSSA, lch);
+	if (dest_start != 0)
+		dma_write(dest_start, CDSA, lch);
+
+	/* Write the buffer size */
+	dma_write(elem_count, CEN, lch);
+	dma_write(frame_count, CFN, lch);
+
+	/*
+	 * If the chain is dynamically linked,
+	 * then we may have to start the chain if its not active
+	 */
+	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_DYNAMIC_CHAIN) {
+
+		/*
+		 * In Dynamic chain, if the chain is not started,
+		 * queue the channel
+		 */
+		if (dma_linked_lch[chain_id].chain_state ==
+						DMA_CHAIN_NOTSTARTED) {
+			/* Enable the link in previous channel */
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
+								DMA_CH_QUEUED)
+				omap2_enable_lnk(dma_chan[lch].prev_linked_ch);
+			dma_chan[lch].state = DMA_CH_QUEUED;
+		}
+
+		/*
+		 * Chain is already started, make sure its active,
+		 * if not then start the chain
+		 */
+		else {
+			start_dma = 1;
+
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
+							DMA_CH_STARTED) {
+				omap2_enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state = DMA_CH_QUEUED;
+				start_dma = 0;
+				if (0 == ((1 << 7) & dma_read(
+					CCR, dma_chan[lch].prev_linked_ch))) {
+					omap2_disable_lnk(dma_chan[lch].
+						    prev_linked_ch);
+					pr_debug("\n prev ch is stopped\n");
+					start_dma = 1;
+				}
+			}
+
+			else if (dma_chan[dma_chan[lch].prev_linked_ch].state
+							== DMA_CH_QUEUED) {
+				omap2_enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state = DMA_CH_QUEUED;
+				start_dma = 0;
+			}
+			omap2_enable_channel_irq(lch);
+
+			l = dma_read(CCR, lch);
+
+			if ((0 == (l & (1 << 24))))
+				l &= ~(1 << 25);
+			else
+				l |= (1 << 25);
+			if (start_dma == 1) {
+				if (0 == (l & (1 << 7))) {
+					l |= (1 << 7);
+					dma_chan[lch].state = DMA_CH_STARTED;
+					pr_debug("starting %d\n", lch);
+					dma_write(l, CCR, lch);
+				} else
+					start_dma = 0;
+			} else {
+				if (0 == (l & (1 << 7)))
+					dma_write(l, CCR, lch);
+			}
+			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_dma_chain_a_transfer);
+
+/**
+ * @brief omap_start_dma_chain_transfers - Start the chain
+ *
+ * @param chain_id
+ *
+ * @return - Success : 0
+ *           Failure : -EINVAL/-EBUSY
+ */
+int omap_start_dma_chain_transfers(int chain_id)
+{
+	int *channels;
+	u32 l, i;
+
+	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	if (dma_linked_lch[channels[0]].chain_state == DMA_CHAIN_STARTED) {
+		printk(KERN_ERR "Chain is already started\n");
+		return -EBUSY;
+	}
+
+	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_STATIC_CHAIN) {
+		for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked;
+									i++) {
+			omap2_enable_lnk(channels[i]);
+			omap2_enable_channel_irq(channels[i]);
+		}
+	} else {
+		omap2_enable_channel_irq(channels[0]);
+	}
+
+	l = dma_read(CCR, channels[0]);
+	l |= (1 << 7);
+	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
+	dma_chan[channels[0]].state = DMA_CH_STARTED;
+
+	if ((0 == (l & (1 << 24))))
+		l &= ~(1 << 25);
+	else
+		l |= (1 << 25);
+	dma_write(l, CCR, channels[0]);
+
+	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_start_dma_chain_transfers);
+
+/**
+ * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a chain.
+ *
+ * @param chain_id
+ *
+ * @return - Success : 0
+ *           Failure : EINVAL
+ */
+int omap_stop_dma_chain_transfers(int chain_id)
+{
+	int *channels;
+	u32 l, i;
+	u32 sys_cf = 0;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
+		omap_device_mstandby(pd, &sys_cf, true);
+
+	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+
+		/* Stop the Channel transmission */
+		l = dma_read(CCR, channels[i]);
+		l &= ~(1 << 7);
+		dma_write(l, CCR, channels[i]);
+
+		/* Disable the link in all the channels */
+		omap2_disable_lnk(channels[i]);
+		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
+
+	}
+	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(chain_id);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
+		omap_device_mstandby(pd, &sys_cf, false);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
+
+/* Get the index of the ongoing DMA in chain */
+/**
+ * @brief omap_get_dma_chain_index - Get the element and frame index
+ * of the ongoing DMA in chain
+ *
+ * @param chain_id
+ * @param ei - Element index
+ * @param fi - Frame index
+ *
+ * @return - Success : 0
+ *           Failure : -EINVAL
+ */
+int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
+{
+	int lch;
+	int *channels;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	if ((!ei) || (!fi))
+		return -EINVAL;
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch = channels[dma_linked_lch[chain_id].q_head];
+
+	*ei = dma_read(CCEN, lch);
+	*fi = dma_read(CCFN, lch);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_get_dma_chain_index);
+
+/**
+ * @brief omap_get_dma_chain_dst_pos - Get the destination position of the
+ * ongoing DMA in chain
+ *
+ * @param chain_id
+ *
+ * @return - Success : Destination position
+ *           Failure : -EINVAL
+ */
+int omap_get_dma_chain_dst_pos(int chain_id)
+{
+	int lch;
+	int *channels;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch = channels[dma_linked_lch[chain_id].q_head];
+
+	return dma_read(CDAC, lch);
+}
+EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
+
+/**
+ * @brief omap_get_dma_chain_src_pos - Get the source position
+ * of the ongoing DMA in chain
+ * @param chain_id
+ *
+ * @return - Success : Destination position
+ *           Failure : -EINVAL
+ */
+int omap_get_dma_chain_src_pos(int chain_id)
+{
+	int lch;
+	int *channels;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch = channels[dma_linked_lch[chain_id].q_head];
+
+	return dma_read(CSAC, lch);
+}
+EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
+
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 {
 	struct omap_device			*od;
 	struct omap_system_dma_plat_info	*p;
 	struct resource				*mem;
+	int dma_irq, ret;
 	char					*name = "omap_dma_system";
 
 	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
@@ -241,8 +1224,31 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	}
 	p->regs			= reg_map;
 	p->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
-	p->disable_irq_lch	= disable_irq_lch;
-	p->show_dma_caps	= omap2_show_dma_caps;
+
+	p->show_dma_caps		= omap2_show_dma_caps;
+	p->cpc_cdac_init		= omap2_cpc_cdac_init;
+	p->set_transfer_params		= omap2_set_transfer_params;
+	p->set_color_mode		= omap2_set_color_mode;
+
+	p->set_src_params		= omap2_set_src_params;
+	p->set_dest_params		= omap2_set_dest_params;
+	p->get_src_pos			= omap2_set_src_pos;
+	p->get_dst_pos			= omap2_get_dst_pos;
+
+	p->clear_channel_int		= omap2_clear_channel_interrupt;
+
+	p->enable_irq_lch		= omap2_enable_irq_lch;
+	p->disable_irq_lch		= omap2_disable_irq_lch;
+	p->enable_channel_irq		= omap2_enable_channel_irq;
+	p->disable_channel_irq		= omap2_disable_channel_irq;
+	p->enable_lnk			= omap2_enable_lnk;
+	p->disable_lnk			= omap2_disable_lnk;
+
+	p->set_global_params		= omap_dma_set_global_params;
+
+	p->clear_lch_regs	= NULL;
+	p->get_gdma_dev		= NULL;
+	p->set_gdma_dev		= NULL;
 
 	/* Configure errata handling for all omap2+'s */
 	p->errata		= configure_dma_errata();
@@ -257,6 +1263,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		return IS_ERR(od);
 	}
 	kfree(p);
+	pd = &od->pdev;
 
 	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -269,8 +1276,21 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		dev_err(&od->pdev.dev, "%s: ioremap fail\n", __func__);
 		return -ENOMEM;
 	}
-
 	d = oh->dev_attr;
+	dma_irq = platform_get_irq_byname(&od->pdev, "0");
+	ret = setup_irq(dma_irq, &omap24xx_dma_irq);
+	if (ret) {
+		dev_err(&od->pdev.dev, "%s:irq handler setup fail\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Get DMA device attributes from hwmod data base */
+	d = (struct omap_dma_dev_attr *)oh->dev_attr;
+
+	/* OMAP2 Plus: physical and logical channel count is same */
+	d->chan_count  = d->lch_count;
+	dma_chan_count = d->chan_count;
+
 	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
 					(d->lch_count), GFP_KERNEL);
 
@@ -278,6 +1298,15 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		dev_err(&od->pdev.dev, "%s: kzalloc fail\n", __func__);
 		return -ENOMEM;
 	}
+
+	dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
+						dma_chan_count, GFP_KERNEL);
+	if (!dma_linked_lch) {
+		kfree(d->chan);
+		return -ENOMEM;
+	}
+	dma_chan = d->chan;
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
index d13c5c0..4313539 100644
--- a/arch/arm/mach-omap2/include/mach/dma.h
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -32,4 +32,55 @@
 /* Should be part of hwmod data base ? */
 #define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
 
+/* Chaining modes*/
+#define OMAP_DMA_STATIC_CHAIN		0x1
+#define OMAP_DMA_DYNAMIC_CHAIN		0x2
+#define OMAP_DMA_CHAIN_ACTIVE		0x1
+#define OMAP_DMA_CHAIN_INACTIVE		0x0
+
+enum {
+	REVISION = 0,	GCR,		IRQSTATUS_L0,	IRQSTATUS_L1,
+	IRQSTATUS_L2,	IRQSTATUS_L3,	IRQENABLE_L0,	IRQENABLE_L1,
+	IRQENABLE_L2,	IRQENABLE_L3,	SYSSTATUS,	OCP_SYSCONFIG,
+	CAPS_0,		CAPS_2,		CAPS_3,		CAPS_4,
+
+	CH_COMMON_START,
+
+	/* Common register offsets */
+	CCR,		CLNK_CTRL,	CICR,		CSR,
+	CSDP,		CEN,		CFN,		CSEI,
+	CSFI,		CDEI,		CDFI,		CSAC,
+	CDAC,
+
+	/* Channel specific register offsets */
+	CSSA,		CDSA,		CCEN,		CCFN,
+	COLOR,
+
+	CH_COMMON_END,
+
+	/* OMAP4 specific registers */
+	CDP,		CNDP,		CCDN,
+};
+
+/* Chaining APIs */
+extern int omap_request_dma_chain(int dev_id, const char *dev_name,
+				  void (*callback) (int lch, u16 ch_status,
+						    void *data),
+				  int *chain_id, int no_of_chans,
+				  int chain_mode,
+				  struct omap_dma_channel_params params);
+extern int omap_free_dma_chain(int chain_id);
+extern int omap_dma_chain_a_transfer(int chain_id, int src_start,
+				     int dest_start, int elem_count,
+				     int frame_count, void *callbk_data);
+extern int omap_start_dma_chain_transfers(int chain_id);
+extern int omap_stop_dma_chain_transfers(int chain_id);
+extern int omap_get_dma_chain_index(int chain_id, int *ei, int *fi);
+extern int omap_get_dma_chain_dst_pos(int chain_id);
+extern int omap_get_dma_chain_src_pos(int chain_id);
+
+extern int omap_modify_dma_chain_params(int chain_id,
+					struct omap_dma_channel_params params);
+extern int omap_dma_chain_status(int chain_id);
+
 #endif /* __ASM_ARCH_OMAP2_DMA_H */
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index d8e9886..eb00b22 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -38,255 +38,41 @@
 
 #include <asm/system.h>
 #include <mach/hardware.h>
-#include <plat/dma.h>
 
+#include <plat/dma.h>
 #include <plat/tc.h>
-
-#undef DEBUG
-
-enum {
-	GCR1 = 0,	GSCR,		GRST,		HW_ID,
-	PCH2_ID,	PCH0_ID,	PCH1_ID,	PCHG_ID,
-	PCHD_ID,	CAPS1_0_U,	CAPS1_0_L,	CAPS1_1_U,
-	CAPS1_1_L,	CAPS1_2,	CAPS1_3,	CAPS1_4,
-	PCH2_SR,	PCH0_SR,	PCH1_SR,	PCHD_SR,
-
-	OMAP1_CH_COMMON_START,
-
-	/* Common Registers */
-	CSDP1,		CCR1,		CICR1,		CSR1,
-	CEN1,		CFN1,		CSFI1,		CSEI1,
-	CPC,		CSAC1,		CDAC1,		CDEI1,
-	CDFI1,		CLNK_CTRL1,
-
-	/* Channel specific register offsets */
-	CSSA_L,		CSSA_U,		CDSA_L,		CDSA_U,
-	COLOR_L,	COLOR_U,	CCR1_2,		LCH_CTRL,
-
-	OMAP1_CH_COMMON_END,
-};
-
-static u16 reg_map_omap1[] = {
-	[GCR1]		= 0x400,
-	[GSCR]		= 0x404,
-	[GRST]		= 0x408,
-	[HW_ID]		= 0x442,
-	[PCH2_ID]	= 0x444,
-	[PCH0_ID]	= 0x446,
-	[PCH1_ID]	= 0x448,
-	[PCHG_ID]	= 0x44a,
-	[PCHD_ID]	= 0x44c,
-	[CAPS1_0_U]	= 0x44e,
-	[CAPS1_0_L]	= 0x450,
-	[CAPS1_1_U]	= 0x452,
-	[CAPS1_1_L]	= 0x454,
-	[CAPS1_2]	= 0x456,
-	[CAPS1_3]	= 0x458,
-	[CAPS1_4]	= 0x45a,
-	[PCH2_SR]	= 0x460,
-	[PCH0_SR]	= 0x480,
-	[PCH1_SR]	= 0x482,
-	[PCHD_SR]	= 0x4c0,
-
-	/* Common Registers */
-	[CSDP1]		= 0x00,
-	[CCR1]		= 0x02,
-	[CICR1]		= 0x04,
-	[CSR1]		= 0x06,
-	[CEN1]		= 0x10,
-	[CFN1]		= 0x12,
-	[CSFI1]		= 0x14,
-	[CSEI1]		= 0x16,
-	[CPC]		= 0x18,	/* 15xx only */
-	[CSAC1]		= 0x18,
-	[CDAC1]		= 0x1a,
-	[CDEI1]		= 0x1c,
-	[CDFI1]		= 0x1e,
-	[CLNK_CTRL1]	= 0x28,
-
-	/* Channel specific register offsets */
-	[CSSA_L]	= 0x08,
-	[CSSA_U]	= 0x0a,
-	[CDSA_L]	= 0x0c,
-	[CDSA_U]	= 0x0e,
-	[COLOR_L]	= 0x20,
-	[COLOR_U]	= 0x22,
-	[CCR1_2]	= 0x24,
-	[LCH_CTRL]	= 0x2a,
-};
-
-enum {
-	REVISION = 0,	GCR2,		IRQSTATUS_L0,	IRQSTATUS_L1,
-	IRQSTATUS_L2,	IRQSTATUS_L3,	IRQENABLE_L0,	IRQENABLE_L1,
-	IRQENABLE_L2,	IRQENABLE_L3,	SYSSTATUS,	OCP_SYSCONFIG,
-	CAPS2_0,	CAPS2_2,	CAPS2_3,	CAPS2_4,
-
-	OMAP2_CH_COMMON_START,
-
-	/* Common register offsets */
-	CCR2,		CLNK_CTRL2,	CICR2,		CSR2,
-	CSDP2,		CEN2,		CFN2,		CSEI2,
-	CSFI2,		CDEI2,		CDFI2,		CSAC2,
-	CDAC2,
-
-	/* Channel specific register offsets */
-	CSSA,		CDSA,		CCEN,		CCFN,
-	COLOR,
-
-	/* OMAP4 specific registers */
-	CDP,		CNDP,		CCDN,
-
-	OMAP2_CH_COMMON_END,
-};
-
-static u16 reg_map_omap2[] = {
-	[REVISION]		= 0x00,
-	[GCR2]			= 0x78,
-	[IRQSTATUS_L0]		= 0x08,
-	[IRQSTATUS_L1]		= 0x0c,
-	[IRQSTATUS_L2]		= 0x10,
-	[IRQSTATUS_L3]		= 0x14,
-	[IRQENABLE_L0]		= 0x18,
-	[IRQENABLE_L1]		= 0x1c,
-	[IRQENABLE_L2]		= 0x20,
-	[IRQENABLE_L3]		= 0x24,
-	[SYSSTATUS]		= 0x28,
-	[OCP_SYSCONFIG]		= 0x2c,
-	[CAPS2_0]		= 0x64,
-	[CAPS2_2]		= 0x6c,
-	[CAPS2_3]		= 0x70,
-	[CAPS2_4]		= 0x74,
-
-	/* Common register offsets */
-	[CCR2]			= 0x80,
-	[CLNK_CTRL2]		= 0x84,
-	[CICR2]			= 0x88,
-	[CSR2]			= 0x8c,
-	[CSDP2]			= 0x90,
-	[CEN2]			= 0x94,
-	[CFN2]			= 0x98,
-	[CSEI2]			= 0xa4,
-	[CSFI2]			= 0xa8,
-	[CDEI2]			= 0xac,
-	[CDFI2]			= 0xb0,
-	[CSAC2]			= 0xb4,
-	[CDAC2]			= 0xb8,
-
-	/* Channel specific register offsets */
-	[CSSA]			= 0x9c,
-	[CDSA]			= 0xa0,
-	[CCEN]			= 0xbc,
-	[CCFN]			= 0xc0,
-	[COLOR]			= 0xc4,
-
-	/* OMAP4 specific registers */
-	[CDP]			= 0xd0,
-	[CNDP]			= 0xd4,
-	[CCDN]			= 0xd8,
-};
-
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
+#include <plat/omap_device.h>
 
 static struct omap_system_dma_plat_info *p;
 static struct omap_dma_dev_attr *d;
+static struct omap_dma_lch		*dma_chan;
+static struct platform_device		*pd;
+
 static u16 *reg_map;
 static int enable_1510_mode;
 static u32 errata;
 
-static struct omap_dma_global_context_registers {
-	u32 dma_irqenable_l0;
-	u32 dma_ocp_sysconfig;
-	u32 dma_gcr;
-} omap_dma_global_context;
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
 static int dma_lch_count;
 static int dma_chan_count;
 static int omap_dma_reserve_channels;
 
 static spinlock_t dma_chan_lock;
-static struct omap_dma_lch *dma_chan;
 static void __iomem *dma_base;
-static inline void disable_lnk(int lch);
-static void omap_disable_channel_irq(int lch);
-static inline void omap_enable_channel_irq(int lch);
-
-#define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
-						__func__);
 
 static inline void dma_write(u32 val, int reg, int lch)
 {
-	if (cpu_class_is_omap1()) {
-		if (reg > OMAP1_CH_COMMON_START)
+	if (d->dev_caps & IS_WORD_16) {
+		if (reg >= CH_COMMON_START)
 			__raw_writew(val, dma_base +
-				(reg_map_omap1[reg] + 0x40 * lch));
+				(reg_map[reg] + 0x40 * lch));
 		else
-			__raw_writew(val, dma_base + reg_map_omap1[reg]);
+			__raw_writew(val, dma_base + reg_map[reg]);
 	} else {
-		if (reg > OMAP2_CH_COMMON_START)
+		if (reg > CH_COMMON_START)
 			__raw_writel(val, dma_base +
-				(reg_map_omap2[reg] + 0x60 * lch));
+				(reg_map[reg] + 0x60 * lch));
 		else
-			__raw_writel(val, dma_base + reg_map_omap2[reg]);
+			__raw_writel(val, dma_base + reg_map[reg]);
 	}
 }
 
@@ -294,71 +80,28 @@ static inline u32 dma_read(int reg, int lch)
 {
 	u32 val;
 
-	if (cpu_class_is_omap1()) {
-		if (reg > OMAP1_CH_COMMON_START)
+	if (d->dev_caps & IS_WORD_16) {
+		if (reg >= CH_COMMON_START)
 			val = __raw_readw(dma_base +
-					(reg_map_omap1[reg] + 0x40 * lch));
+					(reg_map[reg] + 0x40 * lch));
 		else
-			val = __raw_readw(dma_base + reg_map_omap1[reg]);
+			val = __raw_readw(dma_base + reg_map[reg]);
 	} else {
-		if (reg > OMAP2_CH_COMMON_START)
+		if (reg >= CH_COMMON_START)
 			val = __raw_readl(dma_base +
-					(reg_map_omap2[reg] + 0x60 * lch));
+					(reg_map[reg] + 0x60 * lch));
 		else
-			val = __raw_readl(dma_base + reg_map_omap2[reg]);
+			val = __raw_readl(dma_base + reg_map[reg]);
 	}
 	return val;
 }
 
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
-	int i = OMAP1_CH_COMMON_START;
-
-	for (; i <= OMAP1_CH_COMMON_END; i += 1)
-		dma_write(0, i, lch);
-}
-
 void omap_set_dma_priority(int lch, int dst_port, int priority)
 {
 	unsigned long reg;
 	u32 l;
 
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		switch (dst_port) {
 		case OMAP_DMA_PORT_OCP_T1:	/* FFFECC00 */
 			reg = OMAP_TC_OCPT1_PRIOR;
@@ -380,17 +123,15 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 		l &= ~(0xf << 8);
 		l |= (priority & 0xf) << 8;
 		omap_writel(l, reg);
-	}
-
-	if (cpu_class_is_omap2()) {
+	} else {
 		u32 ccr;
 
-		ccr = dma_read(CCR2, lch);
+		ccr = dma_read(CCR, lch);
 		if (priority)
 			ccr |= (1 << 6);
 		else
 			ccr &= ~(1 << 6);
-		dma_write(ccr, CCR2, lch);
+		dma_write(ccr, CCR, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_priority);
@@ -399,161 +140,22 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 				  int frame_count, int sync_mode,
 				  int dma_trigger, int src_or_dst_synch)
 {
-	u32 l;
-
-	if (cpu_class_is_omap1()) {
-		u16 ccr;
-
-		l = dma_read(CSDP1, lch);
-		l &= ~0x03;
-		l |= data_type;
-		dma_write(l, CSDP1, lch);
-
-		ccr = dma_read(CCR1, lch);
-		ccr &= ~(1 << 5);
-		if (sync_mode == OMAP_DMA_SYNC_FRAME)
-			ccr |= 1 << 5;
-		dma_write(ccr, CCR1, lch);
-
-		ccr = dma_read(CCR1_2, lch);
-		ccr &= ~(1 << 2);
-		if (sync_mode == OMAP_DMA_SYNC_BLOCK)
-			ccr |= 1 << 2;
-		dma_write(ccr, CCR1_2, lch);
-	}
-
-	if (cpu_class_is_omap2() && dma_trigger) {
-		u32 val;
+	dma_write(elem_count, CEN, lch);
+	dma_write(frame_count, CFN, lch);
 
-		l = dma_read(CSDP2, lch);
-		l &= ~0x03;
-		l |= data_type;
-		dma_write(l, CSDP2, lch);
-
-		val = dma_read(CCR2, lch);
-
-		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
-		val &= ~((1 << 23) | (3 << 19) | 0x1f);
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
-		if (src_or_dst_synch == OMAP_DMA_DST_SYNC_PREFETCH) {
-			val &= ~(1 << 24);	/* dest synch */
-			val |= (1 << 23);	/* Prefetch */
-		} else if (src_or_dst_synch) {
-			val |= 1 << 24;		/* source synch */
-		} else {
-			val &= ~(1 << 24);	/* dest synch */
-		}
-		dma_write(val, CCR2, lch);
-	}
-	if (cpu_class_is_omap1()) {
-		dma_write(elem_count, CEN1, lch);
-		dma_write(frame_count, CFN1, lch);
-	} else {
-		dma_write(elem_count, CEN2, lch);
-		dma_write(frame_count, CFN2, lch);
-	}
+	p->set_transfer_params(lch, data_type, sync_mode, dma_trigger,
+							src_or_dst_synch);
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
 void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 {
-	BUG_ON(omap_dma_in_1510_mode());
-
-	if (cpu_class_is_omap1()) {
-		u16 w;
+	BUG_ON(enable_1510_mode);
+	p->set_color_mode(lch, mode, color);
 
-		w = dma_read(CCR1_2, lch);
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
-		dma_write(w, CCR1_2, lch);
-
-		w = dma_read(LCH_CTRL, lch);
-		w &= ~0x0f;
-		/* Default is channel type 2D */
-		if (mode) {
-			dma_write((u16)color, COLOR_L, lch);
-			dma_write((u16)(color >> 16), COLOR_U, lch);
-			w |= 1;		/* Channel type G */
-		}
-		dma_write(w, LCH_CTRL, lch);
-	}
-
-	if (cpu_class_is_omap2()) {
-		u32 val;
-
-		val = dma_read(CCR2, lch);
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
-		dma_write(val, CCR2, lch);
-
-		color &= 0xffffff;
-		dma_write(color, COLOR, lch);
-	}
 }
 EXPORT_SYMBOL(omap_set_dma_color_mode);
 
-void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
-{
-	if (cpu_class_is_omap2()) {
-		u32 csdp;
-
-		csdp = dma_read(CSDP2, lch);
-		csdp &= ~(0x3 << 16);
-		csdp |= (mode << 16);
-		dma_write(csdp, CSDP2, lch);
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_write_mode);
-
-void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
-{
-	if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
-		u32 l;
-
-		l = dma_read(LCH_CTRL, lch);
-		l &= ~0x7;
-		l |= mode;
-		dma_write(l, LCH_CTRL, lch);
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_channel_mode);
-
 /* Note that src_port is only for omap1 */
 void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 			     unsigned long src_start,
@@ -561,41 +163,22 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 {
 	u32 l;
 
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		u16 w;
 
-		w = dma_read(CSDP1, lch);
+		w = dma_read(CSDP, lch);
 		w &= ~(0x1f << 2);
 		w |= src_port << 2;
-		dma_write(w, CSDP1, lch);
+		dma_write(w, CSDP, lch);
 
-		l = dma_read(CCR1, lch);
-	} else
-		l = dma_read(CCR2, lch);
+	}
 
+	l = dma_read(CCR, lch);
 	l &= ~(0x03 << 12);
 	l |= src_amode << 12;
+	dma_write(l, CCR, lch);
 
-	if (cpu_class_is_omap1())
-		dma_write(l, CCR1, lch);
-	else
-		dma_write(l, CCR2, lch);
-
-	if (cpu_class_is_omap1()) {
-		dma_write(src_start >> 16, CSSA_U, lch);
-		dma_write((u16)src_start, CSSA_L, lch);
-	}
-
-	if (cpu_class_is_omap2())
-		dma_write(src_start, CSSA, lch);
-
-	if (cpu_class_is_omap1()) {
-		dma_write(src_ei, CSEI1, lch);
-		dma_write(src_fi, CSFI1, lch);
-	} else {
-		dma_write(src_ei, CSEI2, lch);
-		dma_write(src_fi, CSFI2, lch);
-	}
+	p->set_src_params(lch, src_start, src_ei, src_fi);
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
 
@@ -618,33 +201,15 @@ void omap_set_dma_params(int lch, struct omap_dma_channel_params *params)
 }
 EXPORT_SYMBOL(omap_set_dma_params);
 
-void omap_set_dma_src_index(int lch, int eidx, int fidx)
-{
-	if (cpu_class_is_omap2())
-		return;
-
-	dma_write(eidx, CSEI1, lch);
-	dma_write(fidx, CSFI1, lch);
-}
-EXPORT_SYMBOL(omap_set_dma_src_index);
-
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
 	u32 l;
 
-	if (cpu_class_is_omap1())
-		l = dma_read(CSDP1, lch);
-	else
-		l = dma_read(CSDP2, lch);
-
+	l = dma_read(CSDP, lch);
 	l &= ~(1 << 6);
 	if (enable)
 		l |= (1 << 6);
-
-	if (cpu_class_is_omap1())
-		dma_write(l, CSDP1, lch);
-	else
-		dma_write(l, CSDP2, lch);
+	dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_data_pack);
 
@@ -653,37 +218,31 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	unsigned int burst = 0;
 	u32 l;
 
-	if (cpu_class_is_omap2())
-		l = dma_read(CSDP2, lch);
-	else
-		l = dma_read(CSDP1, lch);
-
+	l = dma_read(CSDP, lch);
 	l &= ~(0x03 << 7);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_class_is_omap2())
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst = 0x1;
 		else
 			burst = 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst = 0x2;
-			break;
-		}
+		break;
 		/*
 		 * not supported by current hardware on OMAP1
 		 * w |= (0x03 << 7);
 		 * fall through
 		 */
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst = 0x3;
-			break;
-		}
+		break;
 		/*
 		 * OMAP1 don't support burst 16
 		 * fall through
@@ -694,83 +253,41 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 
 	l |= (burst << 7);
 
-	if (cpu_class_is_omap2())
-		dma_write(l, CSDP2, lch);
-	else
-		dma_write(l, CSDP1, lch);
+	dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
 
 /* Note that dest_port is only for OMAP1 */
 void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
-			      unsigned long dest_start,
-			      int dst_ei, int dst_fi)
+		      unsigned long dest_start, int dst_ei, int dst_fi)
 {
 	u32 l;
 
-	if (cpu_class_is_omap1()) {
-		l = dma_read(CSDP1, lch);
+	if (d->dev_caps & IS_WORD_16) {
+		l = dma_read(CSDP, lch);
 		l &= ~(0x1f << 9);
 		l |= dest_port << 9;
-		dma_write(l, CSDP1, lch);
-
-		l = dma_read(CCR1, lch);
-	} else
-		l = dma_read(CCR2, lch);
-
+		dma_write(l, CSDP, lch);
+	}
+	l = dma_read(CCR, lch);
 	l &= ~(0x03 << 14);
 	l |= dest_amode << 14;
+	dma_write(l, CCR, lch);
 
-	if (cpu_class_is_omap1())
-		dma_write(l, CCR1, lch);
-	else
-		dma_write(l, CCR2, lch);
-
-	if (cpu_class_is_omap1()) {
-		dma_write(dest_start >> 16, CDSA_U, lch);
-		dma_write(dest_start, CDSA_L, lch);
-	}
-
-	if (cpu_class_is_omap2())
-		dma_write(dest_start, CDSA, lch);
+	p->set_dest_params(lch, dest_start, dst_ei, dst_fi);
 
-	if (cpu_class_is_omap1()) {
-		dma_write(dst_ei, CDEI1, lch);
-		dma_write(dst_fi, CDFI1, lch);
-	} else {
-		dma_write(dst_ei, CDEI2, lch);
-		dma_write(dst_fi, CDFI2, lch);
-	}
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
 
-void omap_set_dma_dest_index(int lch, int eidx, int fidx)
-{
-	if (cpu_class_is_omap2())
-		return;
-
-	dma_write(eidx, CDEI1, lch);
-	dma_write(fidx, CDFI1, lch);
-}
-EXPORT_SYMBOL(omap_set_dma_dest_index);
-
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
 	u32 l;
 
-	if (cpu_class_is_omap2())
-		l = dma_read(CSDP2, lch);
-	else
-		l = dma_read(CSDP1, lch);
-
+	l = dma_read(CSDP, lch);
 	l &= ~(1 << 13);
 	if (enable)
 		l |= 1 << 13;
-
-	if (cpu_class_is_omap2())
-		dma_write(l, CSDP2, lch);
-	else
-		dma_write(l, CSDP1, lch);
+	dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
 
@@ -778,33 +295,29 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
 	unsigned int burst = 0;
 	u32 l;
-	if (cpu_class_is_omap2())
-		l = dma_read(CSDP2, lch);
-	else
-		l = dma_read(CSDP1, lch);
 
+	l = dma_read(CSDP, lch);
 	l &= ~(0x03 << 14);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_class_is_omap2())
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst = 0x1;
 		else
 			burst = 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_class_is_omap2())
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst = 0x2;
 		else
 			burst = 0x3;
 		break;
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst = 0x3;
-			break;
-		}
+		break;
 		/*
 		 * OMAP1 don't support burst 16
 		 * fall through
@@ -814,38 +327,11 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 		BUG();
 		return;
 	}
-
 	l |= (burst << 14);
-
-	if (cpu_class_is_omap2())
-		dma_write(l, CSDP2, lch);
-	else
-		dma_write(l, CSDP1, lch);
+	dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
-static inline void omap_enable_channel_irq(int lch)
-{
-	u32 status;
-
-	/* Clear CSR */
-	if (cpu_class_is_omap1()) {
-		status = dma_read(CSR1, lch);
-		dma_write(dma_chan[lch].enabled_irqs, CICR1, lch);
-	} else if (cpu_class_is_omap2()) {
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
-		dma_write(dma_chan[lch].enabled_irqs, CICR2, lch);
-	}
-}
-
-static void omap_disable_channel_irq(int lch)
-{
-	if (cpu_class_is_omap2())
-		dma_write(0, CICR2, lch);
-	else
-		dma_write(0, CICR1, lch);
-}
-
 void omap_enable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs |= bits;
@@ -858,81 +344,6 @@ void omap_disable_dma_irq(int lch, u16 bits)
 }
 EXPORT_SYMBOL(omap_disable_dma_irq);
 
-static inline void enable_lnk(int lch)
-{
-	u32 l;
-
-	if (cpu_class_is_omap1()) {
-		l = dma_read(CLNK_CTRL1, lch);
-		l &= ~(1 << 14);
-	} else
-		l = dma_read(CLNK_CTRL2, lch);
-
-	/* Set the ENABLE_LNK bits */
-	if (dma_chan[lch].next_lch != -1)
-		l = dma_chan[lch].next_lch | (1 << 15);
-
-	if (cpu_class_is_omap2()) {
-		if (dma_chan[lch].next_linked_ch != -1)
-			l = dma_chan[lch].next_linked_ch | (1 << 15);
-		dma_write(l, CLNK_CTRL2, lch);
-	} else
-		dma_write(l, CLNK_CTRL1, lch);
-}
-
-static inline void disable_lnk(int lch)
-{
-	u32 l;
-
-	/* Disable interrupts */
-	if (cpu_class_is_omap1()) {
-		l = dma_read(CLNK_CTRL1, lch);
-		dma_write(0, CICR1, lch);
-		/* Set the STOP_LNK bit */
-		l |= 1 << 14;
-		dma_write(l, CLNK_CTRL1, lch);
-	}
-
-	if (cpu_class_is_omap2()) {
-		l = dma_read(CLNK_CTRL2, lch);
-		omap_disable_channel_irq(lch);
-		/* Clear the ENABLE_LNK bit */
-		l &= ~(1 << 15);
-		dma_write(l, CLNK_CTRL2, lch);
-	}
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
-	val = dma_read(IRQENABLE_L0, 0);
-	val |= 1 << lch;
-	dma_write(val, IRQENABLE_L0, 0);
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
-	val = dma_read(IRQENABLE_L0, 0);
-	val &= ~(1 << lch);
-	dma_write(val, IRQENABLE_L0, 0);
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-}
-
 int omap_request_dma(int dev_id, const char *dev_name,
 		     void (*callback)(int lch, u16 ch_status, void *data),
 		     void *data, int *dma_ch_out)
@@ -956,10 +367,9 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan = dma_chan + free_ch;
 	chan->dev_id = dev_id;
 
-	if (cpu_class_is_omap1())
-		clear_lch_regs(free_ch);
-
-	if (cpu_class_is_omap2())
+	if (d->dev_caps & IS_WORD_16)
+		p->clear_lch_regs(free_ch);
+	else
 		omap_clear_dma(free_ch);
 
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
@@ -969,46 +379,42 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan->data = data;
 	chan->flags = 0;
 
-#ifndef CONFIG_ARCH_OMAP1
-	if (cpu_class_is_omap2()) {
+	if (d->dev_caps & DMA_LINKED_LCH) {
 		chan->chain_id = -1;
 		chan->next_linked_ch = -1;
 	}
-#endif
 
 	chan->enabled_irqs = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
 
-	if (cpu_class_is_omap1())
+	if (d->dev_caps & IS_WORD_16)
 		chan->enabled_irqs |= OMAP1_DMA_TOUT_IRQ;
-	else if (cpu_class_is_omap2())
+	else
 		chan->enabled_irqs |= OMAP2_DMA_MISALIGNED_ERR_IRQ |
 			OMAP2_DMA_TRANS_ERR_IRQ;
 
-	if (cpu_is_omap16xx()) {
+	if (p->set_gdma_dev) {
 		/* If the sync device is set, configure it dynamically. */
 		if (dev_id != 0) {
-			set_gdma_dev(free_ch + 1, dev_id);
+			p->set_gdma_dev(free_ch + 1, dev_id);
 			dev_id = free_ch + 1;
 		}
 		/*
 		 * Disable the 1510 compatibility mode and set the sync device
 		 * id.
 		 */
-		dma_write(dev_id | (1 << 10), CCR1, free_ch);
-	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
-		dma_write(dev_id, CCR1, free_ch);
-	}
+		dma_write(dev_id | (1 << 10), CCR, free_ch);
+	} else if (d->dev_caps & IS_WORD_16)
+		dma_write(dev_id, CCR, free_ch);
 
-	if (cpu_class_is_omap2()) {
-		omap2_enable_irq_lch(free_ch);
-		omap_enable_channel_irq(free_ch);
+	if (p->enable_irq_lch) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->enable_irq_lch(free_ch);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
+		p->enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, free_ch);
-		dma_write(1 << free_ch, IRQSTATUS_L0, 0);
+		p->clear_channel_int(free_ch);
 	}
-
 	*dma_ch_out = free_ch;
-
 	return 0;
 }
 EXPORT_SYMBOL(omap_request_dma);
@@ -1023,28 +429,28 @@ void omap_free_dma(int lch)
 		return;
 	}
 
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR1, lch);
+		dma_write(0, CICR, lch);
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR1, lch);
+		dma_write(0, CCR, lch);
 	}
 
-	if (cpu_class_is_omap2()) {
-		omap2_disable_irq_lch(lch);
+	if (p->disable_irq_lch) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->disable_irq_lch(lch);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
 
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
-		dma_write(1 << lch, IRQSTATUS_L0, 0);
+		p->clear_channel_int(lch);
 
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR2, lch);
+		dma_write(0, CICR, lch);
 
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR2, lch);
+		dma_write(0, CCR, lch);
 		omap_clear_dma(lch);
 	}
-
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
@@ -1054,39 +460,6 @@ void omap_free_dma(int lch)
 EXPORT_SYMBOL(omap_free_dma);
 
 /**
- * @brief omap_dma_set_global_params : Set global priority settings for dma
- *
- * @param arb_rate
- * @param max_fifo_depth
- * @param tparams - Number of threads to reserve : DMA_THREAD_RESERVE_NORM
- * 						   DMA_THREAD_RESERVE_ONET
- * 						   DMA_THREAD_RESERVE_TWOT
- * 						   DMA_THREAD_RESERVE_THREET
- */
-void
-omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
-{
-	u32 reg;
-
-	if (!cpu_class_is_omap2()) {
-		printk(KERN_ERR "FIXME: no %s on 15xx/16xx\n", __func__);
-		return;
-	}
-
-	if (max_fifo_depth == 0)
-		max_fifo_depth = 1;
-	if (arb_rate == 0)
-		arb_rate = 1;
-
-	reg = 0xff & max_fifo_depth;
-	reg |= (0x3 & tparams) << 12;
-	reg |= (arb_rate & 0xff) << 16;
-
-	dma_write(reg, GCR2, 0);
-}
-EXPORT_SYMBOL(omap_dma_set_global_params);
-
-/**
  * @brief omap_dma_set_prio_lch : Set channel wise priority settings
  *
  * @param lch
@@ -1106,17 +479,15 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		return -EINVAL;
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx()) {
-		l = dma_read(CCR2, lch);
+	l = dma_read(CCR, lch);
+	if (d->dev_caps & IS_RW_PRIORITY) {
 		l &= ~((1 << 6) | (1 << 26));
 		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
-		dma_write(l, CCR2, lch);
 	} else {
-		l = dma_read(CCR1, lch);
-		l &= ~((1 << 6) | (1 << 26));
+		l &= ~(1 << 6);
 		l |= ((read_prio & 0x1) << 6);
-		dma_write(l, CCR1, lch);
 	}
+	dma_write(l, CCR, lch);
 
 	return 0;
 }
@@ -1132,24 +503,21 @@ void omap_clear_dma(int lch)
 
 	local_irq_save(flags);
 
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		u32 l;
 
-		l = dma_read(CCR1, lch);
+		l = dma_read(CCR, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR1, lch);
+		dma_write(l, CCR, lch);
 
 		/* Clear pending interrupts */
-		l = dma_read(CSR1, lch);
-	}
-
-	if (cpu_class_is_omap2()) {
-		int i = OMAP2_CH_COMMON_START;
+		l = dma_read(CSR, lch);
+	} else {
+		int i = CH_COMMON_START + 1;
 
-		for (; i <= OMAP2_CH_COMMON_END; i++)
+		for (; i < CH_COMMON_END; i++)
 			dma_write(0, i, lch);
 	}
-
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(omap_clear_dma);
@@ -1162,21 +530,16 @@ void omap_start_dma(int lch)
 	 * The CPC/CDAC register needs to be initialized to zero
 	 * before starting dma transfer.
 	 */
-	if (cpu_is_omap15xx())
-		dma_write(0, CPC, lch);
-	else if (cpu_class_is_omap1())
-		dma_write(0, CDAC1, lch);
-	else
-		dma_write(0, CDAC2, lch);
+	p->cpc_cdac_init(lch);
 
 
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
+	if (!enable_1510_mode && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
 		char dma_chan_link_map[dma_chan_count];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
-		enable_lnk(lch);
+		p->enable_lnk(lch);
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		cur_lch = dma_chan[lch].next_lch;
@@ -1189,29 +552,26 @@ void omap_start_dma(int lch)
 			/* Mark the current channel */
 			dma_chan_link_map[cur_lch] = 1;
 
-			enable_lnk(cur_lch);
-			omap_enable_channel_irq(cur_lch);
+			p->enable_lnk(cur_lch);
+			p->enable_channel_irq(cur_lch);
 
 			cur_lch = next_lch;
 		} while (next_lch != -1);
 	} else if (IS_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS))
-		dma_write(lch, CLNK_CTRL2, lch);
+		dma_write(lch, CLNK_CTRL, lch);
 
-	omap_enable_channel_irq(lch);
+	p->enable_channel_irq(lch);
 
-	if (cpu_class_is_omap1()) {
-		l = dma_read(CCR1, lch);
+	l = dma_read(CCR, lch);
+	if (d->dev_caps & IS_WORD_16)
 		l |= OMAP_DMA_CCR_EN;
-		dma_write(l, CCR1, lch);
-	} else {
-		l = dma_read(CCR2, lch);
-
+	else {
 		if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
 			l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 
 		l |= OMAP_DMA_CCR_EN;
-		dma_write(l, CCR2, lch);
 	}
+	dma_write(l, CCR, lch);
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
 EXPORT_SYMBOL(omap_start_dma);
@@ -1221,49 +581,41 @@ void omap_stop_dma(int lch)
 	u32 l = 0;
 
 	/* Disable all interrupts on the channel */
-	if (cpu_class_is_omap1())
-		dma_write(0, CICR1, lch);
+	if (d->dev_caps & IS_WORD_16)
+		dma_write(0, CICR, lch);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
 			(l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
-		u32 sys_cf;
+		u32 sys_cf = 0;
 
 		/* Configure No-Standby */
-		l = dma_read(OCP_SYSCONFIG, 0);
-		sys_cf = l;
-		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
-		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		dma_write(l , OCP_SYSCONFIG, 0);
+		omap_device_mstandby(pd, &sys_cf, true);
 
-		l = dma_read(CCR2, lch);
+		l = dma_read(CCR, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR2, lch);
+		dma_write(l, CCR, lch);
 
 		/* Wait for sDMA FIFO drain */
-		l = dma_read(CCR2, lch);
+		l = dma_read(CCR, lch);
 		while (i < 100 && (l & (OMAP_DMA_CCR_RD_ACTIVE |
 					OMAP_DMA_CCR_WR_ACTIVE))) {
 			udelay(5);
 			i++;
-			l = dma_read(CCR2, lch);
+			l = dma_read(CCR, lch);
 		}
 		if (i >= 100)
 			printk(KERN_ERR "DMA drain did not complete on "
 					"lch %d\n", lch);
 		/* Restore OCP_SYSCONFIG */
-		dma_write(sys_cf, OCP_SYSCONFIG, 0);
-	} else if (cpu_class_is_omap1()) {
-		l = dma_read(CCR1, lch);
-		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR1, lch);
+		omap_device_mstandby(pd, &sys_cf, false);
 	} else {
-		l = dma_read(CCR2, lch);
+		l = dma_read(CCR, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR2, lch);
+		dma_write(l, CCR, lch);
 	}
 
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
+	if (!enable_1510_mode && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[dma_chan_count];
 
@@ -1275,7 +627,7 @@ void omap_stop_dma(int lch)
 			/* Mark the current channel */
 			dma_chan_link_map[cur_lch] = 1;
 
-			disable_lnk(cur_lch);
+			p->disable_lnk(cur_lch);
 
 			next_lch = dma_chan[cur_lch].next_lch;
 			cur_lch = next_lch;
@@ -1323,26 +675,7 @@ EXPORT_SYMBOL(omap_set_dma_callback);
  */
 dma_addr_t omap_get_dma_src_pos(int lch)
 {
-	dma_addr_t offset = 0;
-
-	if (cpu_is_omap15xx())
-		offset = dma_read(CPC, lch);
-	else if (cpu_class_is_omap1())
-		offset = dma_read(CSAC1, lch);
-	else
-		offset = dma_read(CSAC2, lch);
-
-	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0) {
-		if (cpu_class_is_omap1())
-			offset = dma_read(CSAC1, lch);
-		else
-			offset = dma_read(CSAC2, lch);
-	}
-
-	if (cpu_class_is_omap1())
-		offset |= (dma_read(CSSA_U, lch) << 16);
-
-	return offset;
+	return p->get_src_pos(lch);
 }
 EXPORT_SYMBOL(omap_get_dma_src_pos);
 
@@ -1356,39 +689,13 @@ EXPORT_SYMBOL(omap_get_dma_src_pos);
  */
 dma_addr_t omap_get_dma_dst_pos(int lch)
 {
-	dma_addr_t offset = 0;
-
-	if (cpu_is_omap15xx())
-		offset = dma_read(CPC, lch);
-	else if (cpu_class_is_omap1())
-		offset = dma_read(CDAC1, lch);
-	else
-		offset = dma_read(CDAC2, lch);
-
-	/*
-	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	if (!cpu_is_omap15xx() && offset == 0) {
-		if (cpu_class_is_omap1())
-			offset = dma_read(CDAC1, lch);
-		else
-			offset = dma_read(CDAC2, lch);
-	}
-
-	if (cpu_class_is_omap1())
-		offset |= (dma_read(CDSA_U, lch) << 16);
-
-	return offset;
+	return p->get_dst_pos(lch);
 }
 EXPORT_SYMBOL(omap_get_dma_dst_pos);
 
 int omap_get_dma_active_status(int lch)
 {
-	if (cpu_class_is_omap1())
-		return (dma_read(CCR1, lch) & OMAP_DMA_CCR_EN) != 0;
-	else
-		return (dma_read(CCR2, lch) & OMAP_DMA_CCR_EN) != 0;
+	return (dma_read(CCR, lch) & OMAP_DMA_CCR_EN) != 0;
 }
 EXPORT_SYMBOL(omap_get_dma_active_status);
 
@@ -1396,15 +703,14 @@ int omap_dma_running(void)
 {
 	int lch;
 
-	for (lch = 0; lch < dma_chan_count; lch++) {
-		if (cpu_class_is_omap1()) {
-			if (dma_read(CCR1, lch) & OMAP_DMA_CCR_EN)
-				return 1;
-		} else {
-			if (dma_read(CCR2, lch) & OMAP_DMA_CCR_EN)
-				return 1;
-		}
-	}
+	if (d->dev_caps & IS_WORD_16)
+		if (omap_lcd_dma_running())
+			return 1;
+
+	for (lch = 0; lch < dma_chan_count; lch++)
+		if (dma_read(CCR, lch) & OMAP_DMA_CCR_EN)
+			return 1;
+
 	return 0;
 }
 
@@ -1415,10 +721,10 @@ int omap_dma_running(void)
  */
 void omap_dma_link_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	if (enable_1510_mode) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR1, lch_head) | (3 << 8),
-							CCR1, lch_head);
+			dma_write(dma_read(CCR, lch_head) | (3 << 8),
+							CCR, lch_head);
 			return;
 		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1442,10 +748,10 @@ EXPORT_SYMBOL(omap_dma_link_lch);
  */
 void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	if (enable_1510_mode) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR1, lch_head) & ~(3 << 8),
-								CCR1, lch_head);
+			dma_write(dma_read(CCR, lch_head) & ~(3 << 8),
+								CCR, lch_head);
 			return;
 		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1471,826 +777,11 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 }
 EXPORT_SYMBOL(omap_dma_unlink_lch);
 
-#ifndef CONFIG_ARCH_OMAP1
-/* Create chain of DMA channesls */
-static void create_dma_lch_chain(int lch_head, int lch_queue)
-{
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
-	l = dma_read(CLNK_CTRL2, lch_head);
-	l &= ~(0x1f);
-	l |= lch_queue;
-	dma_write(l, CLNK_CTRL2, lch_head);
-
-	l = dma_read(CLNK_CTRL2, lch_queue);
-	l &= ~(0x1f);
-	l |= (dma_chan[lch_queue].next_linked_ch);
-	dma_write(l, CLNK_CTRL2, lch_queue);
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
-		return -EINVAL;
-	}
-
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
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_modify_dma_chain_params);
-
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
-		dma_write(src_start, CSSA, lch);
-	if (dest_start != 0)
-		dma_write(dest_start, CDSA, lch);
-
-	/* Write the buffer size */
-	dma_write(elem_count, CEN2, lch);
-	dma_write(frame_count, CFN2, lch);
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
-					CCR2, dma_chan[lch].prev_linked_ch))) {
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
-			l = dma_read(CCR2, lch);
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
-					dma_write(l, CCR2, lch);
-				} else
-					start_dma = 0;
-			} else {
-				if (0 == (l & (1 << 7)))
-					dma_write(l, CCR2, lch);
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
-	l = dma_read(CCR2, channels[0]);
-	l |= (1 << 7);
-	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
-	dma_chan[channels[0]].state = DMA_CH_STARTED;
-
-	if ((0 == (l & (1 << 24))))
-		l &= ~(1 << 25);
-	else
-		l |= (1 << 25);
-	dma_write(l, CCR2, channels[0]);
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
-	u32 sys_cf = 0;
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
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
-		sys_cf = dma_read(OCP_SYSCONFIG, 0);
-		l = sys_cf;
-		/* Middle mode reg set no Standby */
-		l &= ~((1 << 12)|(1 << 13));
-		dma_write(l, OCP_SYSCONFIG, 0);
-	}
-
-	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-
-		/* Stop the Channel transmission */
-		l = dma_read(CCR2, channels[i]);
-		l &= ~(1 << 7);
-		dma_write(l, CCR2, channels[i]);
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
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
-		dma_write(sys_cf, OCP_SYSCONFIG, 0);
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
-	*ei = dma_read(CCEN, lch);
-	*fi = dma_read(CCFN, lch);
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
-	return dma_read(CDAC2, lch);
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
-	return dma_read(CSAC2, lch);
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
-		csr = dma_read(CSR1, ch);
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
-	u32 status = dma_read(CSR2, ch);
-
-	if (!status) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
-				ch);
-		dma_write(1 << ch, IRQSTATUS_L0, 0);
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
-		if (IS_DMA_ERRATA(DMA_ERRATA_i378)) {
-			u32 ccr;
-
-			ccr = dma_read(CCR2, ch);
-			ccr &= ~OMAP_DMA_CCR_EN;
-			dma_write(ccr, CCR2, ch);
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
-	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, ch);
-	dma_write(1 << ch, IRQSTATUS_L0, 0);
-
-	/* If the ch is not chained then chain_id will be -1 */
-	if (dma_chan[ch].chain_id != -1) {
-		int chain_id = dma_chan[ch].chain_id;
-		dma_chan[ch].state = DMA_CH_NOTSTARTED;
-		if (dma_read(CLNK_CTRL2, ch) & (1 << 15))
-			dma_chan[dma_chan[ch].next_linked_ch].state =
-							DMA_CH_STARTED;
-		if (dma_linked_lch[chain_id].chain_mode ==
-						OMAP_DMA_DYNAMIC_CHAIN)
-			disable_lnk(ch);
-
-		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
-			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
-
-		status = dma_read(CSR2, ch);
-	}
-
-	dma_write(status, CSR2, ch);
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
-	val = dma_read(IRQSTATUS_L0, 0);
-	if (val == 0) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ\n");
-		return IRQ_HANDLED;
-	}
-	enable_reg = dma_read(IRQENABLE_L0, 0);
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
-		dma_read(IRQENABLE_L0, 0);
-	omap_dma_global_context.dma_ocp_sysconfig =
-		dma_read(OCP_SYSCONFIG, 0);
-	omap_dma_global_context.dma_gcr = dma_read(GCR2, 0);
-}
-
-void omap_dma_global_context_restore(void)
-{
-	int ch;
-
-	dma_write(omap_dma_global_context.dma_gcr, GCR2, 0);
-	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
-		OCP_SYSCONFIG, 0);
-	dma_write(omap_dma_global_context.dma_irqenable_l0,
-		IRQENABLE_L0, 0);
-
-	/*
-	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
-	 * after secure sram context save and restore. Hence we need to
-	 * manually clear those IRQs to avoid spurious interrupts. This
-	 * affects only secure devices.
-	 */
-	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
-		dma_write(0x3 , IRQSTATUS_L0, 0);
-
-	for (ch = 0; ch < dma_chan_count; ch++)
-		if (dma_chan[ch].dev_id != -1)
-			omap_clear_dma(ch);
-}
-
 static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 {
 	struct omap_system_dma_plat_info *pdata = pdev->dev.platform_data;
 	struct resource *mem;
 	int ch, ret = 0;
-	int dma_irq;
-	char irq_name[4];
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "%s: System DMA initialized without"
@@ -2299,6 +790,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 	}
 
 	p	= pdata;
+	pd	= pdev;
 	d	= p->dma_attr;
 	reg_map = pdata->regs;
 	errata	= p->errata;
@@ -2316,84 +808,38 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		goto exit_release_region;
 	}
 
-	if (cpu_class_is_omap2() && omap_dma_reserve_channels
+	spin_lock_init(&dma_chan_lock);
+
+	if (!(d->dev_caps & IS_WORD_16) && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
 		d->lch_count = omap_dma_reserve_channels;
 
 	dma_lch_count		= d->lch_count;
-	dma_chan_count		= dma_lch_count;
+	dma_chan_count		= d->chan_count;
 	dma_chan		= d->chan;
 
-	if (cpu_class_is_omap2()) {
-		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
-						dma_lch_count, GFP_KERNEL);
-		if (!dma_linked_lch) {
-			ret = -ENOMEM;
-			goto exit_dma_chan;
-		}
-	}
-	enable_1510_mode = d->dev_caps & ENABLE_1510_MODE;
-
-	p->show_dma_caps();
-
-	spin_lock_init(&dma_chan_lock);
 	for (ch = 0; ch < dma_chan_count; ch++) {
+		unsigned long flags;
 		omap_clear_dma(ch);
-		if (cpu_class_is_omap2())
-			omap2_disable_irq_lch(ch);
+		if (p->disable_irq_lch) {
+			spin_lock_irqsave(&dma_chan_lock, flags);
+			p->disable_irq_lch(ch);
+			spin_unlock_irqrestore(&dma_chan_lock, flags);
+		}
 
 		dma_chan[ch].dev_id = -1;
 		dma_chan[ch].next_lch = -1;
-
-		if (ch >= 6 && enable_1510_mode)
-			continue;
-
-		if (cpu_class_is_omap1()) {
-			/*
-			 * request_irq() doesn't like dev_id (ie. ch) being
-			 * zero, so we have to kludge around this.
-			 */
-			sprintf(&irq_name[0], "%d", ch);
-			dma_irq = platform_get_irq_byname(pdev, irq_name);
-
-			if (dma_irq < 0) {
-				dev_err(&pdev->dev, "%s:unable to get irq\n",
-								__func__);
-				ret = dma_irq;
-				goto exit_unmap;
-			}
-			ret = request_irq(dma_irq,
-					omap1_dma_irq_handler, 0, "DMA",
-					(void *) (ch + 1));
-			if (ret != 0) {
-				int irq_rel;
-				dev_err(&pdev->dev, "unable to request IRQ %d"
-					"for DMA (error %d)\n", dma_irq, ret);
-				for (irq_rel = 0; irq_rel < ch;
-								irq_rel++) {
-					dma_irq = platform_get_irq(pdev,
-								irq_rel);
-					free_irq(dma_irq, (void *)
-							(irq_rel + 1));
-					goto exit_dma_chan;
-				}
-			}
-		}
 	}
+	enable_1510_mode = d->dev_caps & ENABLE_1510_MODE;
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
-		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
-				DMA_DEFAULT_FIFO_DEPTH, 0);
+	p->show_dma_caps();
 
-	if (cpu_class_is_omap2()) {
-		strcpy(irq_name, "0");
-		dma_irq = platform_get_irq_byname(pdev, irq_name);
-		setup_irq(dma_irq, &omap24xx_dma_irq);
-	}
+	if ((d->dev_caps & GLOBAL_PRIORITY) && (p->set_global_params))
+		p->set_global_params(DMA_DEFAULT_ARB_RATE,
+				DMA_DEFAULT_FIFO_DEPTH, 0);
 
 	/* reserve dma channels 0 and 1 in high security devices */
-	if (cpu_is_omap34xx() &&
-		(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
+	if (d->dev_caps & RESERVE_CHANNEL) {
 		printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
 				"HS ROM code\n");
 		dma_chan[0].dev_id = 0;
@@ -2401,10 +847,6 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 	}
 	return 0;
 
-exit_dma_chan:
-	kfree(dma_chan);
-exit_unmap:
-	iounmap(dma_base);
 exit_release_region:
 	release_mem_region(mem->start, resource_size(mem));
 	return ret;
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index e3a927d..477f0d2 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -253,32 +253,12 @@
 #define DMA_THREAD_FIFO_25		(0x02 << 14)
 #define DMA_THREAD_FIFO_50		(0x03 << 14)
 
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
 #define DMA_CH_PRIO_HIGH		0x1
 #define DMA_CH_PRIO_LOW			0x0 /* Def */
 
+#define OMAP_DMA_ACTIVE			0x01
+#define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
+
 /* Errata handling */
 #define IS_DMA_ERRATA(id)		(errata &= (id))
 #define SET_DMA_ERRATA(id)		(errata |= (id))
@@ -402,8 +382,34 @@ struct omap_system_dma_plat_info {
 	void __iomem *omap_dma_base;
 	u32 errata;
 	u16 *regs;
-	void (*disable_irq_lch)(int lch);
+
 	void (*show_dma_caps)(void);
+	void (*clear_lch_regs)(int lch);
+	void (*cpc_cdac_init)(int lch);
+	int (*get_gdma_dev)(int req);
+	void (*set_gdma_dev)(int req, int dev);
+	void (*set_transfer_params)(int lch, int data_type, int sync_mode,
+				int dma_trigger, int src_or_dst_synch);
+	void (*set_color_mode)(int lch, enum omap_dma_color_mode mode,
+								u32 color);
+	void (*set_src_params)(int lch, unsigned long src_start, int src_ei,
+								int src_fi);
+	void (*set_dest_params)(int lch, unsigned long dest_start, int dst_ei,
+								int dst_fi);
+	dma_addr_t (*get_src_pos)(int lch);
+	dma_addr_t (*get_dst_pos)(int lch);
+
+	void (*disable_irq_lch)(int lch);
+	void (*enable_irq_lch)(int lch);
+	void (*enable_channel_irq)(int lch);
+	void (*disable_channel_irq)(int lch);
+	void (*enable_lnk)(int lch);
+	void (*disable_lnk)(int lch);
+
+	void (*clear_channel_int)(int lch);
+
+	void (*set_global_params)(int arb_rate,
+			int max_fifo_depth, int tparams);
 };
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
@@ -467,29 +473,6 @@ void omap_dma_global_context_restore(void);
 
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
1.7.1
