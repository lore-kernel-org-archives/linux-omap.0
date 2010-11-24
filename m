From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5 10/14] OMAP: DMA: Use DMA device attributes
Date: Wed, 24 Nov 2010 18:21:46 +0530
Message-ID: <1290603110-14119-11-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50337 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab0KXMwt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 07:52:49 -0500
In-Reply-To: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Existing DMA API's are using cpu_*is_* checks for differentiating
omap1 and omap2+ code and handle cpu_*is_* checks with DMA device
attributes.

Also, move OMAP1 and OMAP2+ specific API's into respective mach-omap
dma driver files.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap1/dma.c              |  320 +++++++-
 arch/arm/mach-omap2/dma.c              | 1047 +++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h |   56 ++
 arch/arm/plat-omap/dma.c               | 1465 ++----------------------=
--------
 arch/arm/plat-omap/include/plat/dma.h  |   62 +-
 5 files changed, 1533 insertions(+), 1417 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 06af97a..80c3380 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -24,6 +24,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
=20
 #include <plat/dma.h>
 #include <plat/tc.h>
@@ -32,12 +34,16 @@
 #define OMAP1_DMA_BASE			(0xfffed800)
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
 #define OMAP1_DMA_STRIDE		0x40
+#define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
=20
 static u32 errata;
 static u32 enable_1510_mode;
 static u8 dma_stride;
 static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
=20
+static struct omap_dma_lch *dma_chan;
+static struct omap_dma_dev_attr *d;
+
 static u16 reg_map[] =3D {
 	[GCR]		=3D 0x400,
 	[GSCR]		=3D 0x404,
@@ -212,6 +218,184 @@ static inline u32 dma_read(int reg, int lch)
 	return val;
 }
=20
+static void
+set_src_params(int lch, unsigned long src_start, int src_ei, int src_f=
i)
+{
+	dma_write(src_start, CSSA, lch);
+
+	dma_write(src_ei, CSEI, lch);
+	dma_write(src_fi, CSFI, lch);
+}
+
+static void set_dest_params(int lch, unsigned long dest_start, int dst=
_ei,
+								int dst_fi)
+{
+	dma_write(dest_start, CDSA, lch);
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
+	status =3D dma_read(CSR, lch);
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
+	l =3D dma_read(CLNK_CTRL, lch);
+	l &=3D ~(1 << 14);
+
+	/* Set the ENABLE_LNK bits */
+	if (dma_chan[lch].next_lch !=3D -1)
+		l =3D dma_chan[lch].next_lch | (1 << 15);
+
+	dma_write(l, CLNK_CTRL, lch);
+}
+
+static inline void omap1_disable_lnk(int lch)
+{
+	u32 l;
+
+	/* Disable interrupts */
+	l =3D dma_read(CLNK_CTRL, lch);
+	dma_write(0, CICR, lch);
+	/* Set the STOP_LNK bit */
+	l |=3D 1 << 14;
+	dma_write(l, CLNK_CTRL, lch);
+
+	dma_chan[lch].flags &=3D ~OMAP_DMA_ACTIVE;
+}
+
+static dma_addr_t get_src_pos(int lch)
+{
+	dma_addr_t offset =3D 0;
+
+	if (enable_1510_mode)
+		offset =3D dma_read(CPC, lch);
+	else
+		offset =3D dma_read(CSAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset =3D=3D 0)
+		offset =3D dma_read(CSAC, lch);
+
+	offset |=3D dma_read(CSSA, lch) & 0xFFFF0000;
+
+	return offset;
+}
+
+static dma_addr_t get_dst_pos(int lch)
+{
+	dma_addr_t offset =3D 0;
+
+	if (enable_1510_mode)
+		offset =3D dma_read(CPC, lch);
+	else
+		offset =3D dma_read(CDAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset =3D=3D 0)
+		offset =3D dma_read(CDAC, lch);
+
+	offset |=3D dma_read(CDSA, lch) & 0xFFFF0000;
+
+	return offset;
+}
+
+static void
+set_transfer_params(int lch, int data_type, int sync_mode, int dma_tri=
gger,
+							int src_or_dst_synch)
+{
+	u16 ccr;
+	u32 l;
+
+	l =3D dma_read(CSDP, lch);
+	l &=3D ~0x03;
+	l |=3D data_type;
+	dma_write(l, CSDP, lch);
+
+	ccr =3D dma_read(CCR, lch);
+	ccr &=3D ~(1 << 5);
+	if (sync_mode =3D=3D OMAP_DMA_SYNC_FRAME)
+		ccr |=3D 1 << 5;
+	dma_write(ccr, CCR, lch);
+
+	ccr =3D dma_read(CCR2, lch);
+	ccr &=3D ~(1 << 2);
+	if (sync_mode =3D=3D OMAP_DMA_SYNC_BLOCK)
+		ccr |=3D 1 << 2;
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
+static inline int omap1_get_gdma_dev(int req)
+{
+	u32 reg =3D OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
+	int shift =3D ((req - 1) % 5) * 6;
+
+	return ((omap_readl(reg) >> shift) & 0x3f) + 1;
+}
+
+static inline void omap1_set_gdma_dev(int req, int dev)
+{
+	u32 reg =3D OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
+	int shift =3D ((req - 1) % 5) * 6;
+	u32 l;
+
+	l =3D omap_readl(reg);
+	l &=3D ~(0x3f << shift);
+	l |=3D (dev - 1) << shift;
+	omap_writel(l, reg);
+}
+
+static void set_color_mode(int lch, enum omap_dma_color_mode mode, u32=
 color)
+{
+	u16 w;
+
+	w =3D dma_read(CCR2, lch);
+	w &=3D ~0x03;
+
+	switch (mode) {
+	case OMAP_DMA_CONSTANT_FILL:
+		w |=3D 0x01;
+		break;
+	case OMAP_DMA_TRANSPARENT_COPY:
+		w |=3D 0x02;
+		break;
+	case OMAP_DMA_COLOR_DIS:
+		break;
+	default:
+		BUG();
+	}
+	dma_write(w, CCR2, lch);
+
+	w =3D dma_read(LCH_CTRL, lch);
+	w &=3D ~0x0f;
+	/* Default is channel type 2D */
+	if (mode) {
+		dma_write(color, COLOR, lch);
+		w |=3D 1;		/* Channel type G */
+	}
+	dma_write(w, LCH_CTRL, lch);
+}
+
 static void omap1_clear_lch_regs(int lch)
 {
 	int i =3D dma_common_ch_start;
@@ -266,12 +450,93 @@ static u32 configure_dma_errata(void)
 	return errata;
 }
=20
+static int omap1_dma_handle_ch(int ch)
+{
+	u32 csr;
+
+	if (enable_1510_mode && ch >=3D 6) {
+		csr =3D dma_chan[ch].saved_csr;
+		dma_chan[ch].saved_csr =3D 0;
+	} else
+		csr =3D dma_read(CSR, ch);
+	if (enable_1510_mode && ch <=3D 2 && (csr >> 7) !=3D 0) {
+		dma_chan[ch + 6].saved_csr =3D csr >> 7;
+		csr &=3D 0x7f;
+	}
+	if ((csr & 0x3f) =3D=3D 0)
+		return 0;
+	if (unlikely(dma_chan[ch].dev_id =3D=3D -1)) {
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
+		dma_chan[ch].flags &=3D ~OMAP_DMA_ACTIVE;
+	if (likely(dma_chan[ch].callback !=3D NULL))
+		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
+
+	return 1;
+}
+
+static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
+{
+	int ch =3D ((int) dev_id) - 1;
+	int handled =3D 0;
+
+	for (;;) {
+		int handled_now =3D 0;
+
+		handled_now +=3D omap1_dma_handle_ch(ch);
+		if (enable_1510_mode && dma_chan[ch + 6].saved_csr)
+			handled_now +=3D omap1_dma_handle_ch(ch + 6);
+		if (!handled_now)
+			break;
+		handled +=3D handled_now;
+	}
+
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mod=
e)
+{
+	if (!(d->dev_caps & ENABLE_1510_MODE)) {
+		u32 l;
+
+		l =3D dma_read(LCH_CTRL, lch);
+		l &=3D ~0x7;
+		l |=3D mode;
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
+	int dma_irq =3D 0;
=20
 	pdev =3D platform_device_alloc("omap_dma_system", 0);
 	if (!pdev) {
@@ -328,6 +593,25 @@ static int __init omap1_system_dma_init(void)
 			d->chan_count =3D 9;
 	}
=20
+	for (ch =3D 0; ch < d->chan_count; ch++) {
+		if (ch >=3D 6 && enable_1510_mode)
+			continue;
+
+		sprintf(&irq_name[0], "%d", ch);
+		dma_irq =3D platform_get_irq_byname(pdev, irq_name);
+		if (dma_irq < 0) {
+			dev_err(&pdev->dev, "%s:unable to get irq\n",
+								__func__);
+			ret =3D dma_irq;
+			goto exit_release_irq;
+		}
+
+		ret =3D request_irq(dma_irq, omap1_dma_irq_handler, 0, "DMA",
+							(void *) (ch + 1));
+		if (ret !=3D 0)
+			goto exit_release_irq;
+	}
+
 	dma_base		=3D (void __iomem *)res[0].start;
=20
 	p->show_dma_caps	=3D omap1_show_dma_caps;
@@ -335,6 +619,28 @@ static int __init omap1_system_dma_init(void)
 	p->clear_dma		=3D omap1_clear_dma;
 	p->dma_write		=3D dma_write;
 	p->dma_read		=3D dma_read;
+	p->enable_channel_irq	=3D omap1_enable_channel_irq;
+	p->disable_channel_irq	=3D omap1_disable_channel_irq;
+	p->enable_lnk		=3D omap1_enable_lnk;
+	p->disable_lnk		=3D omap1_disable_lnk;
+	p->clear_lch_regs	=3D omap1_clear_lch_regs;
+	p->set_transfer_params	=3D set_transfer_params;
+	p->set_color_mode	=3D set_color_mode;
+	p->set_src_params	=3D set_src_params;
+	p->set_dest_params	=3D set_dest_params;
+	p->get_src_pos		=3D get_src_pos;
+	p->get_dst_pos		=3D get_dst_pos;
+	p->cpc_cdac_init	=3D cpc_cdac_init;
+
+	if (cpu_is_omap16xx()) {
+		p->get_gdma_dev =3D omap1_get_gdma_dev;
+		p->set_gdma_dev =3D omap1_set_gdma_dev;
+	}
+
+	p->enable_irq_lch	=3D NULL;
+	p->disable_irq_lch	=3D NULL;
+	p->clear_channel_int	=3D NULL;
+	p->set_global_params	=3D NULL;
 	p->disable_irq_lch	=3D NULL;
=20
 	p->errata =3D configure_dma_errata();
@@ -353,6 +659,7 @@ static int __init omap1_system_dma_init(void)
 		goto exit_release_chan;
 	}
=20
+	dma_chan		=3D d->chan;
 	dma_stride		=3D OMAP1_DMA_STRIDE;
 	dma_common_ch_start	=3D CPC;
 	dma_common_ch_end	=3D COLOR;
@@ -361,6 +668,15 @@ static int __init omap1_system_dma_init(void)
=20
 exit_release_chan:
 	kfree(d->chan);
+exit_release_irq:
+	dev_err(&pdev->dev, "unable to request IRQ %d"
+				"for DMA (error %d)\n", dma_irq, ret);
+	if (enable_1510_mode)
+		ch =3D 6;
+	for (irq_rel =3D 0; irq_rel < ch; irq_rel++) {
+		dma_irq =3D platform_get_irq(pdev, irq_rel);
+		free_irq(dma_irq, (void *)(irq_rel + 1));
+	}
 exit_release_p:
 	kfree(p);
 exit_device_put:
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 4a9a56a..2ce1969 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -27,6 +27,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
=20
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -36,11 +38,70 @@
=20
 static u32 errata;
 static u8 dma_stride;
+static int dma_chan_count;
=20
 static struct omap_dma_dev_attr *d;
+static struct dma_link_info *dma_linked_lch;
+static struct omap_dma_lch *dma_chan;
+static struct platform_device *pd;
=20
 static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
=20
+/* Chain handling macros */
+#define OMAP_DMA_CHAIN_QINIT(chain_id)					\
+	do {								\
+		dma_linked_lch[chain_id].q_head =3D			\
+		dma_linked_lch[chain_id].q_tail =3D			\
+		dma_linked_lch[chain_id].q_count =3D 0;			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QFULL(chain_id)					\
+		(dma_linked_lch[chain_id].no_of_lchs_linked =3D=3D		\
+		dma_linked_lch[chain_id].q_count)
+#define OMAP_DMA_CHAIN_QLAST(chain_id)					\
+	do {								\
+		((dma_linked_lch[chain_id].no_of_lchs_linked-1) =3D=3D	\
+		dma_linked_lch[chain_id].q_count)			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
+		(0 =3D=3D dma_linked_lch[chain_id].q_count)
+#define __OMAP_DMA_CHAIN_INCQ(end)					\
+	((end) =3D ((end)+1) % dma_linked_lch[chain_id].no_of_lchs_linked)
+#define OMAP_DMA_CHAIN_INCQHEAD(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_head);	\
+		dma_linked_lch[chain_id].q_count--;			\
+	} while (0)
+
+#define OMAP_DMA_CHAIN_INCQTAIL(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_tail);	\
+		dma_linked_lch[chain_id].q_count++; \
+	} while (0)
+
+enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
+	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
+};
+
+enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
+
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
+
+};
+
+static struct omap_dma_global_context_registers {
+	u32 dma_irqenable_l0;
+	u32 dma_gcr;
+} omap_dma_global_context;
+
 static u16 reg_map[] =3D {
 	[REVISION]		=3D 0x00,
 	[GCR]			=3D 0x78,
@@ -126,6 +187,15 @@ static inline void omap2_disable_irq_lch(int lch)
 	dma_write(val, IRQENABLE_L0, lch);
 }
=20
+static inline void omap2_enable_irq_lch(int lch)
+{
+	u32 val;
+
+	val =3D dma_read(IRQENABLE_L0, lch);
+	val |=3D 1 << lch;
+	dma_write(val, IRQENABLE_L0, lch);
+}
+
 static void omap2_clear_dma(int lch)
 {
 	int i =3D dma_common_ch_start;
@@ -134,6 +204,332 @@ static void omap2_clear_dma(int lch)
 		dma_write(0, i, lch);
 }
=20
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
+	l =3D dma_read(CLNK_CTRL, lch);
+
+	/* Set the ENABLE_LNK bits */
+	if (dma_chan[lch].next_lch !=3D -1)
+		l =3D dma_chan[lch].next_lch | (1 << 15);
+
+	if (dma_chan[lch].next_linked_ch !=3D -1)
+		l =3D dma_chan[lch].next_linked_ch | (1 << 15);
+
+	dma_write(l, CLNK_CTRL, lch);
+}
+
+static inline void omap2_disable_lnk(int lch)
+{
+	u32 l;
+
+	l =3D dma_read(CLNK_CTRL, lch);
+
+	omap2_disable_channel_irq(lch);
+	/* Clear the ENABLE_LNK bit */
+	l &=3D ~(1 << 15);
+
+	dma_write(l, CLNK_CTRL, lch);
+	dma_chan[lch].flags &=3D ~OMAP_DMA_ACTIVE;
+}
+
+static void
+omap2_set_color_mode(int lch, enum omap_dma_color_mode mode, u32 color=
)
+{
+	u32 val;
+
+	val =3D dma_read(CCR, lch);
+	val &=3D ~((1 << 17) | (1 << 16));
+
+	switch (mode) {
+	case OMAP_DMA_CONSTANT_FILL:
+		val |=3D 1 << 16;
+		break;
+	case OMAP_DMA_TRANSPARENT_COPY:
+		val |=3D 1 << 17;
+		break;
+	case OMAP_DMA_COLOR_DIS:
+		break;
+	default:
+		BUG();
+	}
+	dma_write(val, CCR, lch);
+
+	color &=3D 0xffffff;
+	dma_write(color, COLOR, lch);
+}
+
+void omap_dma_global_context_save(void)
+{
+	omap_dma_global_context.dma_irqenable_l0 =3D
+		dma_read(IRQENABLE_L0, 0);
+
+	omap_dma_global_context.dma_gcr =3D dma_read(GCR, 0);
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
+	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
+		dma_write(0x3 , IRQSTATUS_L0, 0);
+
+	for (ch =3D 0; ch < dma_chan_count; ch++)
+		if (dma_chan[ch].dev_id !=3D -1)
+			omap_clear_dma(ch);
+}
+
+void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
+{
+	u32 csdp;
+
+	csdp =3D dma_read(CSDP, lch);
+	csdp &=3D ~(0x3 << 16);
+	csdp |=3D (mode << 16);
+	dma_write(csdp, CSDP, lch);
+}
+EXPORT_SYMBOL(omap_set_dma_write_mode);
+
+/**
+ * @brief omap_dma_set_global_params : Set global priority settings fo=
r dma
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
+omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tpara=
ms)
+{
+	u32 reg;
+
+	if (max_fifo_depth =3D=3D 0)
+		max_fifo_depth =3D 1;
+	if (arb_rate =3D=3D 0)
+		arb_rate =3D 1;
+
+	reg =3D 0xff & max_fifo_depth;
+	reg |=3D (0x3 & tparams) << 12;
+	reg |=3D (arb_rate & 0xff) << 16;
+
+	dma_write(reg, GCR, 0);
+}
+EXPORT_SYMBOL(omap_dma_set_global_params);
+
+static int omap2_dma_handle_ch(int ch)
+{
+	u32 status =3D dma_read(CSR, ch);
+
+	if (!status) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
+				ch);
+		dma_write(1 << ch, IRQSTATUS_L0, ch);
+		return 0;
+	}
+	if (unlikely(dma_chan[ch].dev_id =3D=3D -1)) {
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
+			ccr =3D dma_read(CCR, ch);
+			ccr &=3D ~OMAP_DMA_CCR_EN;
+			dma_write(ccr, CCR, ch);
+			dma_chan[ch].flags &=3D ~OMAP_DMA_ACTIVE;
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
+	/* read back the register to flush the write */
+	dma_read(IRQSTATUS_L0, ch);
+
+	/* If the ch is not chained then chain_id will be -1 */
+	if (dma_chan[ch].chain_id !=3D -1) {
+		int chain_id =3D dma_chan[ch].chain_id;
+		dma_chan[ch].state =3D DMA_CH_NOTSTARTED;
+		if (dma_read(CLNK_CTRL, ch) & (1 << 15))
+			dma_chan[dma_chan[ch].next_linked_ch].state =3D
+							DMA_CH_STARTED;
+		if (dma_linked_lch[chain_id].chain_mode =3D=3D
+						OMAP_DMA_DYNAMIC_CHAIN)
+			omap2_disable_lnk(ch);
+
+		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
+			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
+
+		status =3D dma_read(CSR, ch);
+	}
+
+	dma_write(status, CSR, ch);
+
+	if (likely(dma_chan[ch].callback !=3D NULL))
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
+	val =3D dma_read(IRQSTATUS_L0, 0);
+	if (val =3D=3D 0) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "Spurious DMA IRQ\n");
+		return IRQ_HANDLED;
+	}
+	enable_reg =3D dma_read(IRQENABLE_L0, 0);
+	val &=3D enable_reg; /* Dispatch only relevant interrupts */
+	for (i =3D 0; i < dma_chan_count && val !=3D 0; i++) {
+		if (val & 1)
+			omap2_dma_handle_ch(i);
+		val >>=3D 1;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction omap24xx_dma_irq =3D {
+	.name =3D "DMA",
+	.handler =3D irq_handler,
+	.flags =3D IRQF_DISABLED
+};
+
+static void omap2_set_transfer_params(int lch, int data_type, int sync=
_mode,
+				int dma_trigger, int src_or_dst_synch)
+{
+	u32 val, l;
+
+	l =3D dma_read(CSDP, lch);
+	l &=3D ~0x03;
+	l |=3D data_type;
+	dma_write(l, CSDP, lch);
+
+	if (dma_trigger) {
+		val =3D dma_read(CCR, lch);
+
+		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
+		val &=3D ~((1 << 23) | (3 << 19) | 0x1f);
+		val |=3D (dma_trigger & ~0x1f) << 14;
+		val |=3D dma_trigger & 0x1f;
+
+		if (sync_mode & OMAP_DMA_SYNC_FRAME)
+			val |=3D 1 << 5;
+		else
+			val &=3D ~(1 << 5);
+
+		if (sync_mode & OMAP_DMA_SYNC_BLOCK)
+			val |=3D 1 << 18;
+		else
+			val &=3D ~(1 << 18);
+
+		if (src_or_dst_synch =3D=3D OMAP_DMA_DST_SYNC_PREFETCH) {
+			val &=3D ~(1 << 24);	/* dest synch */
+			val |=3D (1 << 23);	/* Prefetch */
+		} else if (src_or_dst_synch) {
+			val |=3D 1 << 24;		/* source synch */
+		} else {
+			val &=3D ~(1 << 24);	/* dest synch */
+		}
+		dma_write(val, CCR, lch);
+	}
+}
+
+static void omap2_set_src_params(int lch, unsigned long src_start, int=
 src_ei,
+								int src_fi)
+{
+	dma_write(src_start, CSSA, lch);
+
+	dma_write(src_ei, CSEI, lch);
+	dma_write(src_fi, CSFI, lch);
+}
+
+static void omap2_set_dest_params(int lch, unsigned long dest_start, i=
nt dst_ei,
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
+	dma_addr_t offset =3D 0;
+
+	offset =3D dma_read(CSAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset =3D=3D 0)
+		offset =3D dma_read(CSAC, lch);
+
+	return offset;
+}
+
+static dma_addr_t omap2_get_dst_pos(int lch)
+{
+	dma_addr_t offset =3D 0;
+
+	offset =3D dma_read(CDAC, lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && (offset =3D=3D 0))
+		offset =3D dma_read(CDAC, lch);
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
 	u8 revision =3D dma_read(REVISION, 0) & 0xff;
@@ -225,12 +621,624 @@ static u32 configure_dma_errata(void)
 	return errata;
 }
=20
+/* Create chain of DMA channesls */
+static void create_dma_lch_chain(int lch_head, int lch_queue)
+{
+	u32 l;
+
+	/* Check if this is the first link in chain */
+	if (dma_chan[lch_head].next_linked_ch =3D=3D -1) {
+		dma_chan[lch_head].next_linked_ch =3D lch_queue;
+		dma_chan[lch_head].prev_linked_ch =3D lch_queue;
+		dma_chan[lch_queue].next_linked_ch =3D lch_head;
+		dma_chan[lch_queue].prev_linked_ch =3D lch_head;
+	}
+
+	/* a link exists, link the new channel in circular chain */
+	else {
+		dma_chan[lch_queue].next_linked_ch =3D
+					dma_chan[lch_head].next_linked_ch;
+		dma_chan[lch_queue].prev_linked_ch =3D lch_head;
+		dma_chan[lch_head].next_linked_ch =3D lch_queue;
+		dma_chan[dma_chan[lch_queue].next_linked_ch].prev_linked_ch =3D
+					lch_queue;
+	}
+
+	l =3D dma_read(CLNK_CTRL, lch_head);
+	l &=3D ~(0x1f);
+	l |=3D lch_queue;
+	dma_write(l, CLNK_CTRL, lch_head);
+
+	l =3D dma_read(CLNK_CTRL, lch_queue);
+	l &=3D ~(0x1f);
+	l |=3D (dma_chan[lch_queue].next_linked_ch);
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
+	if (chain_mode !=3D OMAP_DMA_STATIC_CHAIN
+			&& chain_mode !=3D OMAP_DMA_DYNAMIC_CHAIN) {
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
+	channels =3D kmalloc(sizeof(*channels) * no_of_chans, GFP_KERNEL);
+	if (channels =3D=3D NULL) {
+		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
+		return -ENOMEM;
+	}
+
+	/* request and reserve DMA channels for the chain */
+	for (i =3D 0; i < no_of_chans; i++) {
+		err =3D omap_request_dma(dev_id, dev_name,
+					callback, NULL, &channels[i]);
+		if (err < 0) {
+			int j;
+			for (j =3D 0; j < i; j++)
+				omap_free_dma(channels[j]);
+			kfree(channels);
+			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
+			return err;
+		}
+		dma_chan[channels[i]].prev_linked_ch =3D -1;
+		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
+
+		/*
+		 * Allowing client drivers to set common parameters now,
+		 * so that later only relevant (src_start, dest_start
+		 * and element count) can be set
+		 */
+		omap_set_dma_params(channels[i], &params);
+	}
+
+	*chain_id =3D channels[0];
+	dma_linked_lch[*chain_id].linked_dmach_q =3D channels;
+	dma_linked_lch[*chain_id].chain_mode =3D chain_mode;
+	dma_linked_lch[*chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;
+	dma_linked_lch[*chain_id].no_of_lchs_linked =3D no_of_chans;
+
+	for (i =3D 0; i < no_of_chans; i++)
+		dma_chan[channels[i]].chain_id =3D *chain_id;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(*chain_id);
+
+	/* Set up the chain */
+	if (no_of_chans =3D=3D 1)
+		create_dma_lch_chain(channels[0], channels[0]);
+	else {
+		for (i =3D 0; i < (no_of_chans - 1); i++)
+			create_dma_lch_chain(channels[i], channels[i + 1]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_request_dma_chain);
+
+/**
+ * @brief omap_modify_dma_chain_param : Modify the chain's params - Mo=
dify the
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
+			|| chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
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
+ * @brief omap_free_dma_chain - Free all the logical channels in a cha=
in.
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
+	if (unlikely((chain_id < 0 || chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+		dma_chan[channels[i]].next_linked_ch =3D -1;
+		dma_chan[channels[i]].prev_linked_ch =3D -1;
+		dma_chan[channels[i]].chain_id =3D -1;
+		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
+		omap_free_dma(channels[i]);
+	}
+
+	kfree(channels);
+
+	dma_linked_lch[chain_id].linked_dmach_q =3D NULL;
+	dma_linked_lch[chain_id].chain_mode =3D -1;
+	dma_linked_lch[chain_id].chain_state =3D -1;
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
+	if (unlikely((chain_id < 0 || chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	pr_debug("CHAINID=3D%d, qcnt=3D%d\n", chain_id,
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
+int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_st=
art,
+			int elem_count, int frame_count, void *callbk_data)
+{
+	int *channels;
+	u32 l, lch;
+	int start_dma =3D 0;
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
+			|| chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exist\n");
+		return -EINVAL;
+	}
+
+	/* Check if all the channels in chain are in use */
+	if (OMAP_DMA_CHAIN_QFULL(chain_id))
+		return -EBUSY;
+
+	/* Frame count may be negative in case of indexed transfers */
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get a free channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_tail];
+
+	/* Store the callback data */
+	dma_chan[lch].data =3D callbk_data;
+
+	/* Increment the q_tail */
+	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
+
+	/* Set the params to the free channel */
+	if (src_start !=3D 0)
+		dma_write(src_start, CSSA, lch);
+	if (dest_start !=3D 0)
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
+	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_DYNAMIC_CHAIN=
) {
+
+		/*
+		 * In Dynamic chain, if the chain is not started,
+		 * queue the channel
+		 */
+		if (dma_linked_lch[chain_id].chain_state =3D=3D
+						DMA_CHAIN_NOTSTARTED) {
+			/* Enable the link in previous channel */
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
+								DMA_CH_QUEUED)
+				omap2_enable_lnk(dma_chan[lch].prev_linked_ch);
+			dma_chan[lch].state =3D DMA_CH_QUEUED;
+		}
+
+		/*
+		 * Chain is already started, make sure its active,
+		 * if not then start the chain
+		 */
+		else {
+			start_dma =3D 1;
+
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
+							DMA_CH_STARTED) {
+				omap2_enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state =3D DMA_CH_QUEUED;
+				start_dma =3D 0;
+				if (0 =3D=3D ((1 << 7) & dma_read(
+					CCR, dma_chan[lch].prev_linked_ch))) {
+					omap2_disable_lnk(dma_chan[lch].
+						    prev_linked_ch);
+					pr_debug("\n prev ch is stopped\n");
+					start_dma =3D 1;
+				}
+			}
+
+			else if (dma_chan[dma_chan[lch].prev_linked_ch].state
+							=3D=3D DMA_CH_QUEUED) {
+				omap2_enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state =3D DMA_CH_QUEUED;
+				start_dma =3D 0;
+			}
+			omap2_enable_channel_irq(lch);
+
+			l =3D dma_read(CCR, lch);
+
+			if ((0 =3D=3D (l & (1 << 24))))
+				l &=3D ~(1 << 25);
+			else
+				l |=3D (1 << 25);
+			if (start_dma =3D=3D 1) {
+				if (0 =3D=3D (l & (1 << 7))) {
+					l |=3D (1 << 7);
+					dma_chan[lch].state =3D DMA_CH_STARTED;
+					pr_debug("starting %d\n", lch);
+					dma_write(l, CCR, lch);
+				} else
+					start_dma =3D 0;
+			} else {
+				if (0 =3D=3D (l & (1 << 7)))
+					dma_write(l, CCR, lch);
+			}
+			dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
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
+	if (unlikely((chain_id < 0 || chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	if (dma_linked_lch[channels[0]].chain_state =3D=3D DMA_CHAIN_STARTED)=
 {
+		printk(KERN_ERR "Chain is already started\n");
+		return -EBUSY;
+	}
+
+	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_STATIC_CHAIN)=
 {
+		for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked;
+									i++) {
+			omap2_enable_lnk(channels[i]);
+			omap2_enable_channel_irq(channels[i]);
+		}
+	} else {
+		omap2_enable_channel_irq(channels[0]);
+	}
+
+	l =3D dma_read(CCR, channels[0]);
+	l |=3D (1 << 7);
+	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_STARTED;
+	dma_chan[channels[0]].state =3D DMA_CH_STARTED;
+
+	if ((0 =3D=3D (l & (1 << 24))))
+		l &=3D ~(1 << 25);
+	else
+		l |=3D (1 << 25);
+	dma_write(l, CCR, channels[0]);
+
+	dma_chan[channels[0]].flags |=3D OMAP_DMA_ACTIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_start_dma_chain_transfers);
+
+/**
+ * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a c=
hain.
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
+	u32 sys_cf =3D 0;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
+		sys_cf =3D dma_read(OCP_SYSCONFIG, 0);
+		l =3D sys_cf;
+		/* Middle mode reg set no Standby */
+		l &=3D ~((1 << 12)|(1 << 13));
+		dma_write(l, OCP_SYSCONFIG, 0);
+	}
+	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+
+		/* Stop the Channel transmission */
+		l =3D dma_read(CCR, channels[i]);
+		l &=3D ~(1 << 7);
+		dma_write(l, CCR, channels[i]);
+
+		/* Disable the link in all the channels */
+		omap2_disable_lnk(channels[i]);
+		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
+
+	}
+	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(chain_id);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
+		dma_write(sys_cf, OCP_SYSCONFIG, 0);
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
+	if (unlikely((chain_id < 0 || chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	if ((!ei) || (!fi))
+		return -EINVAL;
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_head];
+
+	*ei =3D dma_read(CCEN, lch);
+	*fi =3D dma_read(CCFN, lch);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_get_dma_chain_index);
+
+/**
+ * @brief omap_get_dma_chain_dst_pos - Get the destination position of=
 the
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
+	if (unlikely((chain_id < 0 || chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_head];
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
+	if (unlikely((chain_id < 0 || chain_id >=3D dma_chan_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_head];
+
+	return dma_read(CSAC, lch);
+}
+EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
+
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, voi=
d *unused)
 {
 	struct omap_device			*od;
 	struct omap_system_dma_plat_info	*p;
 	struct resource				*mem;
+	int dma_irq, ret;
 	char					*name =3D "omap_dma_system";
=20
 	dma_stride		=3D OMAP2_DMA_STRIDE;
@@ -249,12 +1257,27 @@ static int __init omap2_system_dma_init_dev(stru=
ct omap_hwmod *oh, void *unused)
=20
 	p->dma_attr		=3D (struct omap_dma_dev_attr *)oh->dev_attr;
 	p->disable_irq_lch	=3D omap2_disable_irq_lch;
+	p->enable_irq_lch	=3D omap2_enable_irq_lch;
+	p->cpc_cdac_init	=3D omap2_cpc_cdac_init;
+	p->set_transfer_params	=3D omap2_set_transfer_params;
+	p->set_color_mode	=3D omap2_set_color_mode;
+	p->set_src_params	=3D omap2_set_src_params;
+	p->set_dest_params	=3D omap2_set_dest_params;
+	p->get_src_pos		=3D omap2_set_src_pos;
+	p->get_dst_pos		=3D omap2_get_dst_pos;
+	p->clear_channel_int	=3D omap2_clear_channel_interrupt;
+	p->enable_channel_irq	=3D omap2_enable_channel_irq;
+	p->disable_channel_irq	=3D omap2_disable_channel_irq;
+	p->enable_lnk		=3D omap2_enable_lnk;
+	p->disable_lnk		=3D omap2_disable_lnk;
 	p->show_dma_caps	=3D omap2_show_dma_caps;
 	p->clear_dma		=3D omap2_clear_dma;
 	p->dma_write		=3D dma_write;
 	p->dma_read		=3D dma_read;
=20
 	p->clear_lch_regs	=3D NULL;
+	p->get_gdma_dev		=3D NULL;
+	p->set_gdma_dev		=3D NULL;
=20
 	p->errata		=3D configure_dma_errata();
=20
@@ -266,6 +1289,7 @@ static int __init omap2_system_dma_init_dev(struct=
 omap_hwmod *oh, void *unused)
 			__func__, name, oh->name);
 		return IS_ERR(od);
 	}
+	pd =3D &od->pdev;
=20
 	mem =3D platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -279,6 +1303,20 @@ static int __init omap2_system_dma_init_dev(struc=
t omap_hwmod *oh, void *unused)
 	}
=20
 	d =3D oh->dev_attr;
+	dma_irq =3D platform_get_irq_byname(&od->pdev, "0");
+	ret =3D setup_irq(dma_irq, &omap24xx_dma_irq);
+	if (ret) {
+		dev_err(&od->pdev.dev, "%s:irq handler setup fail\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Get DMA device attributes from hwmod data base */
+	d =3D (struct omap_dma_dev_attr *)oh->dev_attr;
+
+	/* OMAP2 Plus: physical and logical channel count is same */
+	d->chan_count  =3D d->lch_count;
+	dma_chan_count =3D d->chan_count;
+
 	d->chan =3D kzalloc(sizeof(struct omap_dma_lch) *
 					(d->lch_count), GFP_KERNEL);
=20
@@ -286,6 +1324,15 @@ static int __init omap2_system_dma_init_dev(struc=
t omap_hwmod *oh, void *unused)
 		dev_err(&od->pdev.dev, "%s: kzalloc fail\n", __func__);
 		return -ENOMEM;
 	}
+
+	dma_linked_lch =3D kzalloc(sizeof(struct dma_link_info) *
+						dma_chan_count, GFP_KERNEL);
+	if (!dma_linked_lch) {
+		kfree(d->chan);
+		return -ENOMEM;
+	}
+	dma_chan =3D d->chan;
+
 	return 0;
 }
=20
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-oma=
p2/include/mach/dma.h
new file mode 100644
index 0000000..c6f1a20
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -0,0 +1,56 @@
+/*
+ *  OMAP2+ DMA driver API declarations
+ *
+ *  Copyright (C) 2003 Nokia Corporation
+ *  Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ *
+ *  Copyright (C) 2009 Texas Instruments
+ *  Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ *  Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.=
com/
+ *  Converted DMA library into platform driver
+ *          - G, Manjunath Kondaiah <manjugk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __ASM_ARCH_OMAP2_DMA_H
+#define __ASM_ARCH_OMAP2_DMA_H
+
+/* Chaining modes*/
+#define OMAP_DMA_STATIC_CHAIN		0x1
+#define OMAP_DMA_DYNAMIC_CHAIN		0x2
+#define OMAP_DMA_CHAIN_ACTIVE		0x1
+#define OMAP_DMA_CHAIN_INACTIVE		0x0
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
+#endif /* __ASM_ARCH_OMAP2_DMA_H */
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 3770cc6..c33c630 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -27,151 +27,33 @@
=20
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
=20
-#include <asm/system.h>
-#include <mach/hardware.h>
 #include <plat/dma.h>
-
 #include <plat/tc.h>
=20
-#undef DEBUG
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
-
 static struct omap_system_dma_plat_info *p;
 static struct omap_dma_dev_attr *d;
+static struct omap_dma_lch		*dma_chan;
=20
 static int enable_1510_mode;
-static u32 errata;
-
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
-		dma_linked_lch[chain_id].q_head =3D			\
-		dma_linked_lch[chain_id].q_tail =3D			\
-		dma_linked_lch[chain_id].q_count =3D 0;			\
-	} while (0)
-#define OMAP_DMA_CHAIN_QFULL(chain_id)					\
-		(dma_linked_lch[chain_id].no_of_lchs_linked =3D=3D		\
-		dma_linked_lch[chain_id].q_count)
-#define OMAP_DMA_CHAIN_QLAST(chain_id)					\
-	do {								\
-		((dma_linked_lch[chain_id].no_of_lchs_linked-1) =3D=3D	\
-		dma_linked_lch[chain_id].q_count)			\
-	} while (0)
-#define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
-		(0 =3D=3D dma_linked_lch[chain_id].q_count)
-#define __OMAP_DMA_CHAIN_INCQ(end)					\
-	((end) =3D ((end)+1) % dma_linked_lch[chain_id].no_of_lchs_linked)
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
+static u32 errata;
=20
 static spinlock_t dma_chan_lock;
-static struct omap_dma_lch *dma_chan;
-
-static inline void disable_lnk(int lch);
-static void omap_disable_channel_irq(int lch);
-static inline void omap_enable_channel_irq(int lch);
-
-#define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
-						__func__);
-
-#ifdef CONFIG_ARCH_OMAP15XX
-/* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 other=
wise */
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
-	u32 reg =3D OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
-	int shift =3D ((req - 1) % 5) * 6;
-
-	return ((omap_readl(reg) >> shift) & 0x3f) + 1;
-}
-
-static inline void set_gdma_dev(int req, int dev)
-{
-	u32 reg =3D OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
-	int shift =3D ((req - 1) % 5) * 6;
-	u32 l;
-
-	l =3D omap_readl(reg);
-	l &=3D ~(0x3f << shift);
-	l |=3D (dev - 1) << shift;
-	omap_writel(l, reg);
-}
-#else
-#define set_gdma_dev(req, dev)	do {} while (0)
-#endif
=20
 void omap_set_dma_priority(int lch, int dst_port, int priority)
 {
 	unsigned long reg;
 	u32 l;
=20
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		switch (dst_port) {
 		case OMAP_DMA_PORT_OCP_T1:	/* FFFECC00 */
 			reg =3D OMAP_TC_OCPT1_PRIOR;
@@ -193,9 +75,7 @@ void omap_set_dma_priority(int lch, int dst_port, in=
t priority)
 		l &=3D ~(0xf << 8);
 		l |=3D (priority & 0xf) << 8;
 		omap_writel(l, reg);
-	}
-
-	if (cpu_class_is_omap2()) {
+	} else {
 		u32 ccr;
=20
 		ccr =3D p->dma_read(CCR, lch);
@@ -212,151 +92,21 @@ void omap_set_dma_transfer_params(int lch, int da=
ta_type, int elem_count,
 				  int frame_count, int sync_mode,
 				  int dma_trigger, int src_or_dst_synch)
 {
-	u32 l;
-
-	l =3D p->dma_read(CSDP, lch);
-	l &=3D ~0x03;
-	l |=3D data_type;
-	p->dma_write(l, CSDP, lch);
-
-	if (cpu_class_is_omap1()) {
-		u16 ccr;
-
-		ccr =3D p->dma_read(CCR, lch);
-		ccr &=3D ~(1 << 5);
-		if (sync_mode =3D=3D OMAP_DMA_SYNC_FRAME)
-			ccr |=3D 1 << 5;
-		p->dma_write(ccr, CCR, lch);
-
-		ccr =3D p->dma_read(CCR2, lch);
-		ccr &=3D ~(1 << 2);
-		if (sync_mode =3D=3D OMAP_DMA_SYNC_BLOCK)
-			ccr |=3D 1 << 2;
-		p->dma_write(ccr, CCR2, lch);
-	}
-
-	if (cpu_class_is_omap2() && dma_trigger) {
-		u32 val;
-
-		val =3D p->dma_read(CCR, lch);
-
-		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
-		val &=3D ~((1 << 23) | (3 << 19) | 0x1f);
-		val |=3D (dma_trigger & ~0x1f) << 14;
-		val |=3D dma_trigger & 0x1f;
-
-		if (sync_mode & OMAP_DMA_SYNC_FRAME)
-			val |=3D 1 << 5;
-		else
-			val &=3D ~(1 << 5);
-
-		if (sync_mode & OMAP_DMA_SYNC_BLOCK)
-			val |=3D 1 << 18;
-		else
-			val &=3D ~(1 << 18);
-
-		if (src_or_dst_synch =3D=3D OMAP_DMA_DST_SYNC_PREFETCH) {
-			val &=3D ~(1 << 24);	/* dest synch */
-			val |=3D (1 << 23);	/* Prefetch */
-		} else if (src_or_dst_synch) {
-			val |=3D 1 << 24;		/* source synch */
-		} else {
-			val &=3D ~(1 << 24);	/* dest synch */
-		}
-		p->dma_write(val, CCR, lch);
-	}
-
 	p->dma_write(elem_count, CEN, lch);
 	p->dma_write(frame_count, CFN, lch);
+
+	p->set_transfer_params(lch, data_type, sync_mode, dma_trigger,
+							src_or_dst_synch);
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
=20
 void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u=
32 color)
 {
-	BUG_ON(omap_dma_in_1510_mode());
-
-	if (cpu_class_is_omap1()) {
-		u16 w;
-
-		w =3D p->dma_read(CCR2, lch);
-		w &=3D ~0x03;
-
-		switch (mode) {
-		case OMAP_DMA_CONSTANT_FILL:
-			w |=3D 0x01;
-			break;
-		case OMAP_DMA_TRANSPARENT_COPY:
-			w |=3D 0x02;
-			break;
-		case OMAP_DMA_COLOR_DIS:
-			break;
-		default:
-			BUG();
-		}
-		p->dma_write(w, CCR2, lch);
-
-		w =3D p->dma_read(LCH_CTRL, lch);
-		w &=3D ~0x0f;
-		/* Default is channel type 2D */
-		if (mode) {
-			p->dma_write(color, COLOR, lch);
-			w |=3D 1;		/* Channel type G */
-		}
-		p->dma_write(w, LCH_CTRL, lch);
-	}
-
-	if (cpu_class_is_omap2()) {
-		u32 val;
-
-		val =3D p->dma_read(CCR, lch);
-		val &=3D ~((1 << 17) | (1 << 16));
-
-		switch (mode) {
-		case OMAP_DMA_CONSTANT_FILL:
-			val |=3D 1 << 16;
-			break;
-		case OMAP_DMA_TRANSPARENT_COPY:
-			val |=3D 1 << 17;
-			break;
-		case OMAP_DMA_COLOR_DIS:
-			break;
-		default:
-			BUG();
-		}
-		p->dma_write(val, CCR, lch);
-
-		color &=3D 0xffffff;
-		p->dma_write(color, COLOR, lch);
-	}
+	BUG_ON(enable_1510_mode);
+	p->set_color_mode(lch, mode, color);
 }
 EXPORT_SYMBOL(omap_set_dma_color_mode);
=20
-void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
-{
-	if (cpu_class_is_omap2()) {
-		u32 csdp;
-
-		csdp =3D p->dma_read(CSDP, lch);
-		csdp &=3D ~(0x3 << 16);
-		csdp |=3D (mode << 16);
-		p->dma_write(csdp, CSDP, lch);
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_write_mode);
-
-void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mod=
e)
-{
-	if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
-		u32 l;
-
-		l =3D p->dma_read(LCH_CTRL, lch);
-		l &=3D ~0x7;
-		l |=3D mode;
-		p->dma_write(l, LCH_CTRL, lch);
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_channel_mode);
-
 /* Note that src_port is only for omap1 */
 void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 			     unsigned long src_start,
@@ -364,7 +114,7 @@ void omap_set_dma_src_params(int lch, int src_port,=
 int src_amode,
 {
 	u32 l;
=20
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		u16 w;
=20
 		w =3D p->dma_read(CSDP, lch);
@@ -378,10 +128,7 @@ void omap_set_dma_src_params(int lch, int src_port=
, int src_amode,
 	l |=3D src_amode << 12;
 	p->dma_write(l, CCR, lch);
=20
-	p->dma_write(src_start, CSSA, lch);
-
-	p->dma_write(src_ei, CSEI, lch);
-	p->dma_write(src_fi, CSFI, lch);
+	p->set_src_params(lch, src_start, src_ei, src_fi);
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
=20
@@ -404,16 +151,6 @@ void omap_set_dma_params(int lch, struct omap_dma_=
channel_params *params)
 }
 EXPORT_SYMBOL(omap_set_dma_params);
=20
-void omap_set_dma_src_index(int lch, int eidx, int fidx)
-{
-	if (cpu_class_is_omap2())
-		return;
-
-	p->dma_write(eidx, CSEI, lch);
-	p->dma_write(fidx, CSFI, lch);
-}
-EXPORT_SYMBOL(omap_set_dma_src_index);
-
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
 	u32 l;
@@ -438,26 +175,24 @@ void omap_set_dma_src_burst_mode(int lch, enum om=
ap_dma_burst_mode burst_mode)
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_class_is_omap2())
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst =3D 0x1;
 		else
 			burst =3D 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst =3D 0x2;
-			break;
-		}
+		break;
 		/*
 		 * not supported by current hardware on OMAP1
 		 * w |=3D (0x03 << 7);
 		 * fall through
 		 */
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst =3D 0x3;
-			break;
-		}
+		break;
 		/*
 		 * OMAP1 don't support burst 16
 		 * fall through
@@ -473,40 +208,26 @@ EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
=20
 /* Note that dest_port is only for OMAP1 */
 void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
-			      unsigned long dest_start,
-			      int dst_ei, int dst_fi)
+		      unsigned long dest_start, int dst_ei, int dst_fi)
 {
 	u32 l;
=20
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		l =3D p->dma_read(CSDP, lch);
 		l &=3D ~(0x1f << 9);
 		l |=3D dest_port << 9;
 		p->dma_write(l, CSDP, lch);
 	}
-
 	l =3D p->dma_read(CCR, lch);
 	l &=3D ~(0x03 << 14);
 	l |=3D dest_amode << 14;
 	p->dma_write(l, CCR, lch);
=20
-	p->dma_write(dest_start, CDSA, lch);
+	p->set_dest_params(lch, dest_start, dst_ei, dst_fi);
=20
-	p->dma_write(dst_ei, CDEI, lch);
-	p->dma_write(dst_fi, CDFI, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
=20
-void omap_set_dma_dest_index(int lch, int eidx, int fidx)
-{
-	if (cpu_class_is_omap2())
-		return;
-
-	p->dma_write(eidx, CDEI, lch);
-	p->dma_write(fidx, CDFI, lch);
-}
-EXPORT_SYMBOL(omap_set_dma_dest_index);
-
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
 	u32 l;
@@ -531,22 +252,21 @@ void omap_set_dma_dest_burst_mode(int lch, enum o=
map_dma_burst_mode burst_mode)
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_class_is_omap2())
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst =3D 0x1;
 		else
 			burst =3D 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_class_is_omap2())
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst =3D 0x2;
 		else
 			burst =3D 0x3;
 		break;
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_class_is_omap2()) {
+		if (!(d->dev_caps & IS_BURST_ONLY4))
 			burst =3D 0x3;
-			break;
-		}
+		break;
 		/*
 		 * OMAP1 don't support burst 16
 		 * fall through
@@ -561,26 +281,6 @@ void omap_set_dma_dest_burst_mode(int lch, enum om=
ap_dma_burst_mode burst_mode)
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
=20
-static inline void omap_enable_channel_irq(int lch)
-{
-	u32 status;
-
-	/* Clear CSR */
-	if (cpu_class_is_omap1())
-		status =3D p->dma_read(CSR, lch);
-	else if (cpu_class_is_omap2())
-		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
-
-	/* Enable some nice interrupts. */
-	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
-}
-
-static void omap_disable_channel_irq(int lch)
-{
-	if (cpu_class_is_omap2())
-		p->dma_write(0, CICR, lch);
-}
-
 void omap_enable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs |=3D bits;
@@ -593,81 +293,6 @@ void omap_disable_dma_irq(int lch, u16 bits)
 }
 EXPORT_SYMBOL(omap_disable_dma_irq);
=20
-static inline void enable_lnk(int lch)
-{
-	u32 l;
-
-	l =3D p->dma_read(CLNK_CTRL, lch);
-
-	if (cpu_class_is_omap1())
-		l &=3D ~(1 << 14);
-
-	/* Set the ENABLE_LNK bits */
-	if (dma_chan[lch].next_lch !=3D -1)
-		l =3D dma_chan[lch].next_lch | (1 << 15);
-
-#ifndef CONFIG_ARCH_OMAP1
-	if (cpu_class_is_omap2())
-		if (dma_chan[lch].next_linked_ch !=3D -1)
-			l =3D dma_chan[lch].next_linked_ch | (1 << 15);
-#endif
-
-	p->dma_write(l, CLNK_CTRL, lch);
-}
-
-static inline void disable_lnk(int lch)
-{
-	u32 l;
-
-	l =3D p->dma_read(CLNK_CTRL, lch);
-
-	/* Disable interrupts */
-	if (cpu_class_is_omap1()) {
-		p->dma_write(0, CICR, lch);
-		/* Set the STOP_LNK bit */
-		l |=3D 1 << 14;
-	}
-
-	if (cpu_class_is_omap2()) {
-		omap_disable_channel_irq(lch);
-		/* Clear the ENABLE_LNK bit */
-		l &=3D ~(1 << 15);
-	}
-
-	p->dma_write(l, CLNK_CTRL, lch);
-	dma_chan[lch].flags &=3D ~OMAP_DMA_ACTIVE;
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
-	val =3D p->dma_read(IRQENABLE_L0, lch);
-	val |=3D 1 << lch;
-	p->dma_write(val, IRQENABLE_L0, lch);
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
-	val =3D p->dma_read(IRQENABLE_L0, lch);
-	val &=3D ~(1 << lch);
-	p->dma_write(val, IRQENABLE_L0, lch);
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-}
-
 int omap_request_dma(int dev_id, const char *dev_name,
 		     void (*callback)(int lch, u16 ch_status, void *data),
 		     void *data, int *dma_ch_out)
@@ -691,10 +316,9 @@ int omap_request_dma(int dev_id, const char *dev_n=
ame,
 	chan =3D dma_chan + free_ch;
 	chan->dev_id =3D dev_id;
=20
-	if (p->clear_lch_regs)
+	if (d->dev_caps & IS_WORD_16)
 		p->clear_lch_regs(free_ch);
-
-	if (cpu_class_is_omap2())
+	else
 		omap_clear_dma(free_ch);
=20
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
@@ -704,25 +328,23 @@ int omap_request_dma(int dev_id, const char *dev_=
name,
 	chan->data =3D data;
 	chan->flags =3D 0;
=20
-#ifndef CONFIG_ARCH_OMAP1
-	if (cpu_class_is_omap2()) {
+	if (d->dev_caps & DMA_LINKED_LCH) {
 		chan->chain_id =3D -1;
 		chan->next_linked_ch =3D -1;
 	}
-#endif
=20
 	chan->enabled_irqs =3D OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
=20
-	if (cpu_class_is_omap1())
+	if (d->dev_caps & IS_WORD_16)
 		chan->enabled_irqs |=3D OMAP1_DMA_TOUT_IRQ;
-	else if (cpu_class_is_omap2())
+	else
 		chan->enabled_irqs |=3D OMAP2_DMA_MISALIGNED_ERR_IRQ |
 			OMAP2_DMA_TRANS_ERR_IRQ;
=20
-	if (cpu_is_omap16xx()) {
+	if (p->set_gdma_dev) {
 		/* If the sync device is set, configure it dynamically. */
 		if (dev_id !=3D 0) {
-			set_gdma_dev(free_ch + 1, dev_id);
+			p->set_gdma_dev(free_ch + 1, dev_id);
 			dev_id =3D free_ch + 1;
 		}
 		/*
@@ -730,18 +352,17 @@ int omap_request_dma(int dev_id, const char *dev_=
name,
 		 * id.
 		 */
 		p->dma_write(dev_id | (1 << 10), CCR, free_ch);
-	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
+	} else if (d->dev_caps & IS_WORD_16)
 		p->dma_write(dev_id, CCR, free_ch);
-	}
=20
-	if (cpu_class_is_omap2()) {
-		omap2_enable_irq_lch(free_ch);
-		omap_enable_channel_irq(free_ch);
+	if (p->enable_irq_lch) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->enable_irq_lch(free_ch);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
+		p->enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
-		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, free_ch);
-		p->dma_write(1 << free_ch, IRQSTATUS_L0, 0);
+		p->clear_channel_int(free_ch);
 	}
-
 	*dma_ch_out =3D free_ch;
=20
 	return 0;
@@ -758,19 +379,20 @@ void omap_free_dma(int lch)
 		return;
 	}
=20
-	if (cpu_class_is_omap1()) {
+	if (d->dev_caps & IS_WORD_16) {
 		/* Disable all DMA interrupts for the channel. */
 		p->dma_write(0, CICR, lch);
 		/* Make sure the DMA transfer is stopped. */
 		p->dma_write(0, CCR, lch);
 	}
=20
-	if (cpu_class_is_omap2()) {
-		omap2_disable_irq_lch(lch);
+	if (p->disable_irq_lch) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->disable_irq_lch(lch);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
=20
 		/* Clear the CSR register and IRQ status register */
-		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
-		p->dma_write(1 << lch, IRQSTATUS_L0, lch);
+		p->clear_channel_int(lch);
=20
 		/* Disable all DMA interrupts for the channel. */
 		p->dma_write(0, CICR, lch);
@@ -789,39 +411,6 @@ void omap_free_dma(int lch)
 EXPORT_SYMBOL(omap_free_dma);
=20
 /**
- * @brief omap_dma_set_global_params : Set global priority settings fo=
r dma
- *
- * @param arb_rate
- * @param max_fifo_depth
- * @param tparams - Number of threads to reserve : DMA_THREAD_RESERVE_=
NORM
- * 						   DMA_THREAD_RESERVE_ONET
- * 						   DMA_THREAD_RESERVE_TWOT
- * 						   DMA_THREAD_RESERVE_THREET
- */
-void
-omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tpara=
ms)
-{
-	u32 reg;
-
-	if (!cpu_class_is_omap2()) {
-		printk(KERN_ERR "FIXME: no %s on 15xx/16xx\n", __func__);
-		return;
-	}
-
-	if (max_fifo_depth =3D=3D 0)
-		max_fifo_depth =3D 1;
-	if (arb_rate =3D=3D 0)
-		arb_rate =3D 1;
-
-	reg =3D 0xff & max_fifo_depth;
-	reg |=3D (0x3 & tparams) << 12;
-	reg |=3D (arb_rate & 0xff) << 16;
-
-	p->dma_write(reg, GCR, 0);
-}
-EXPORT_SYMBOL(omap_dma_set_global_params);
-
-/**
  * @brief omap_dma_set_prio_lch : Set channel wise priority settings
  *
  * @param lch
@@ -841,12 +430,13 @@ omap_dma_set_prio_lch(int lch, unsigned char read=
_prio,
 		return -EINVAL;
 	}
 	l =3D p->dma_read(CCR, lch);
-	l &=3D ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
+	if (d->dev_caps & IS_RW_PRIORITY) {
+		l &=3D ~((1 << 6) | (1 << 26));
 		l |=3D ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
-	else
+	} else {
+		l &=3D ~(1 << 6);
 		l |=3D ((read_prio & 0x1) << 6);
-
+	}
 	p->dma_write(l, CCR, lch);
=20
 	return 0;
@@ -875,18 +465,16 @@ void omap_start_dma(int lch)
 	 * The CPC/CDAC register needs to be initialized to zero
 	 * before starting dma transfer.
 	 */
-	if (cpu_is_omap15xx())
-		p->dma_write(0, CPC, lch);
-	else
-		p->dma_write(0, CDAC, lch);
+	p->cpc_cdac_init(lch);
=20
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch !=3D -1) {
+
+	if (!enable_1510_mode && dma_chan[lch].next_lch !=3D -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[dma_lch_count];
+		char dma_chan_link_map[dma_chan_count];
=20
 		dma_chan_link_map[lch] =3D 1;
 		/* Set the link register of the first channel */
-		enable_lnk(lch);
+		p->enable_lnk(lch);
=20
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		cur_lch =3D dma_chan[lch].next_lch;
@@ -899,22 +487,24 @@ void omap_start_dma(int lch)
 			/* Mark the current channel */
 			dma_chan_link_map[cur_lch] =3D 1;
=20
-			enable_lnk(cur_lch);
-			omap_enable_channel_irq(cur_lch);
+			p->enable_lnk(cur_lch);
+			p->enable_channel_irq(cur_lch);
=20
 			cur_lch =3D next_lch;
 		} while (next_lch !=3D -1);
 	} else if (IS_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS))
 		p->dma_write(lch, CLNK_CTRL, lch);
=20
-	omap_enable_channel_irq(lch);
+	p->enable_channel_irq(lch);
=20
 	l =3D p->dma_read(CCR, lch);
-
-	if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
+	if (d->dev_caps & IS_WORD_16)
+		l |=3D OMAP_DMA_CCR_EN;
+	else {
+		if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
 			l |=3D OMAP_DMA_CCR_BUFFERING_DISABLE;
-	l |=3D OMAP_DMA_CCR_EN;
-
+		l |=3D OMAP_DMA_CCR_EN;
+	}
 	p->dma_write(l, CCR, lch);
=20
 	dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
@@ -923,10 +513,10 @@ EXPORT_SYMBOL(omap_start_dma);
=20
 void omap_stop_dma(int lch)
 {
-	u32 l;
+	u32 l =3D 0;
=20
 	/* Disable all interrupts on the channel */
-	if (cpu_class_is_omap1())
+	if (d->dev_caps & IS_WORD_16)
 		p->dma_write(0, CICR, lch);
=20
 	l =3D p->dma_read(CCR, lch);
@@ -964,7 +554,7 @@ void omap_stop_dma(int lch)
 		p->dma_write(l, CCR, lch);
 	}
=20
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch !=3D -1) {
+	if (!enable_1510_mode && dma_chan[lch].next_lch !=3D -1) {
 		int next_lch, cur_lch =3D lch;
 		char dma_chan_link_map[dma_lch_count];
=20
@@ -976,7 +566,7 @@ void omap_stop_dma(int lch)
 			/* Mark the current channel */
 			dma_chan_link_map[cur_lch] =3D 1;
=20
-			disable_lnk(cur_lch);
+			p->disable_lnk(cur_lch);
=20
 			next_lch =3D dma_chan[cur_lch].next_lch;
 			cur_lch =3D next_lch;
@@ -1024,20 +614,7 @@ EXPORT_SYMBOL(omap_set_dma_callback);
  */
 dma_addr_t omap_get_dma_src_pos(int lch)
 {
-	dma_addr_t offset =3D 0;
-
-	if (cpu_is_omap15xx())
-		offset =3D p->dma_read(CPC, lch);
-	else
-		offset =3D p->dma_read(CSAC, lch);
-
-	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset =3D=3D 0)
-		offset =3D p->dma_read(CSAC, lch);
-
-	if (cpu_class_is_omap1())
-		offset |=3D (p->dma_read(CSSA, lch) & 0xFFFF0000);
-
-	return offset;
+	return p->get_src_pos(lch);
 }
 EXPORT_SYMBOL(omap_get_dma_src_pos);
=20
@@ -1051,24 +628,7 @@ EXPORT_SYMBOL(omap_get_dma_src_pos);
  */
 dma_addr_t omap_get_dma_dst_pos(int lch)
 {
-	dma_addr_t offset =3D 0;
-
-	if (cpu_is_omap15xx())
-		offset =3D p->dma_read(CPC, lch);
-	else
-		offset =3D p->dma_read(CDAC, lch);
-
-	/*
-	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	if (!cpu_is_omap15xx() && offset =3D=3D 0)
-		offset =3D p->dma_read(CDAC, lch);
-
-	if (cpu_class_is_omap1())
-		offset |=3D (p->dma_read(CDSA, lch) & 0xFFFF0000);
-
-	return offset;
+	return p->get_dst_pos(lch);
 }
 EXPORT_SYMBOL(omap_get_dma_dst_pos);
=20
@@ -1082,7 +642,7 @@ int omap_dma_running(void)
 {
 	int lch;
=20
-	if (cpu_class_is_omap1())
+	if (d->dev_caps & IS_WORD_16)
 		if (omap_lcd_dma_running())
 			return 1;
=20
@@ -1100,7 +660,7 @@ int omap_dma_running(void)
  */
 void omap_dma_link_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	if (enable_1510_mode) {
 		if (lch_head =3D=3D lch_queue) {
 			p->dma_write(p->dma_read(CCR, lch_head) | (3 << 8),
 								CCR, lch_head);
@@ -1127,7 +687,7 @@ EXPORT_SYMBOL(omap_dma_link_lch);
  */
 void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	if (enable_1510_mode) {
 		if (lch_head =3D=3D lch_queue) {
 			p->dma_write(p->dma_read(CCR, lch_head) & ~(3 << 8),
 								CCR, lch_head);
@@ -1156,820 +716,9 @@ void omap_dma_unlink_lch(int lch_head, int lch_q=
ueue)
 }
 EXPORT_SYMBOL(omap_dma_unlink_lch);
=20
-#ifndef CONFIG_ARCH_OMAP1
-/* Create chain of DMA channesls */
-static void create_dma_lch_chain(int lch_head, int lch_queue)
-{
-	u32 l;
-
-	/* Check if this is the first link in chain */
-	if (dma_chan[lch_head].next_linked_ch =3D=3D -1) {
-		dma_chan[lch_head].next_linked_ch =3D lch_queue;
-		dma_chan[lch_head].prev_linked_ch =3D lch_queue;
-		dma_chan[lch_queue].next_linked_ch =3D lch_head;
-		dma_chan[lch_queue].prev_linked_ch =3D lch_head;
-	}
-
-	/* a link exists, link the new channel in circular chain */
-	else {
-		dma_chan[lch_queue].next_linked_ch =3D
-					dma_chan[lch_head].next_linked_ch;
-		dma_chan[lch_queue].prev_linked_ch =3D lch_head;
-		dma_chan[lch_head].next_linked_ch =3D lch_queue;
-		dma_chan[dma_chan[lch_queue].next_linked_ch].prev_linked_ch =3D
-					lch_queue;
-	}
-
-	l =3D p->dma_read(CLNK_CTRL, lch_head);
-	l &=3D ~(0x1f);
-	l |=3D lch_queue;
-	p->dma_write(l, CLNK_CTRL, lch_head);
-
-	l =3D p->dma_read(CLNK_CTRL, lch_queue);
-	l &=3D ~(0x1f);
-	l |=3D (dma_chan[lch_queue].next_linked_ch);
-	p->dma_write(l, CLNK_CTRL, lch_queue);
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
-	if (chain_mode !=3D OMAP_DMA_STATIC_CHAIN
-			&& chain_mode !=3D OMAP_DMA_DYNAMIC_CHAIN) {
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
-	channels =3D kmalloc(sizeof(*channels) * no_of_chans, GFP_KERNEL);
-	if (channels =3D=3D NULL) {
-		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
-		return -ENOMEM;
-	}
-
-	/* request and reserve DMA channels for the chain */
-	for (i =3D 0; i < no_of_chans; i++) {
-		err =3D omap_request_dma(dev_id, dev_name,
-					callback, NULL, &channels[i]);
-		if (err < 0) {
-			int j;
-			for (j =3D 0; j < i; j++)
-				omap_free_dma(channels[j]);
-			kfree(channels);
-			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
-			return err;
-		}
-		dma_chan[channels[i]].prev_linked_ch =3D -1;
-		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
-
-		/*
-		 * Allowing client drivers to set common parameters now,
-		 * so that later only relevant (src_start, dest_start
-		 * and element count) can be set
-		 */
-		omap_set_dma_params(channels[i], &params);
-	}
-
-	*chain_id =3D channels[0];
-	dma_linked_lch[*chain_id].linked_dmach_q =3D channels;
-	dma_linked_lch[*chain_id].chain_mode =3D chain_mode;
-	dma_linked_lch[*chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;
-	dma_linked_lch[*chain_id].no_of_lchs_linked =3D no_of_chans;
-
-	for (i =3D 0; i < no_of_chans; i++)
-		dma_chan[channels[i]].chain_id =3D *chain_id;
-
-	/* Reset the Queue pointers */
-	OMAP_DMA_CHAIN_QINIT(*chain_id);
-
-	/* Set up the chain */
-	if (no_of_chans =3D=3D 1)
-		create_dma_lch_chain(channels[0], channels[0]);
-	else {
-		for (i =3D 0; i < (no_of_chans - 1); i++)
-			create_dma_lch_chain(channels[i], channels[i + 1]);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_request_dma_chain);
-
-/**
- * @brief omap_modify_dma_chain_param : Modify the chain's params - Mo=
dify the
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
-			|| chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-
-	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
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
- * @brief omap_free_dma_chain - Free all the logical channels in a cha=
in.
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
-	if (unlikely((chain_id < 0 || chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-		dma_chan[channels[i]].next_linked_ch =3D -1;
-		dma_chan[channels[i]].prev_linked_ch =3D -1;
-		dma_chan[channels[i]].chain_id =3D -1;
-		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
-		omap_free_dma(channels[i]);
-	}
-
-	kfree(channels);
-
-	dma_linked_lch[chain_id].linked_dmach_q =3D NULL;
-	dma_linked_lch[chain_id].chain_mode =3D -1;
-	dma_linked_lch[chain_id].chain_state =3D -1;
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
-	if (unlikely((chain_id < 0 || chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	pr_debug("CHAINID=3D%d, qcnt=3D%d\n", chain_id,
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
-int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_st=
art,
-			int elem_count, int frame_count, void *callbk_data)
-{
-	int *channels;
-	u32 l, lch;
-	int start_dma =3D 0;
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
-			|| chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exist\n");
-		return -EINVAL;
-	}
-
-	/* Check if all the channels in chain are in use */
-	if (OMAP_DMA_CHAIN_QFULL(chain_id))
-		return -EBUSY;
-
-	/* Frame count may be negative in case of indexed transfers */
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get a free channel */
-	lch =3D channels[dma_linked_lch[chain_id].q_tail];
-
-	/* Store the callback data */
-	dma_chan[lch].data =3D callbk_data;
-
-	/* Increment the q_tail */
-	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
-
-	/* Set the params to the free channel */
-	if (src_start !=3D 0)
-		p->dma_write(src_start, CSSA, lch);
-	if (dest_start !=3D 0)
-		p->dma_write(dest_start, CDSA, lch);
-
-	/* Write the buffer size */
-	p->dma_write(elem_count, CEN, lch);
-	p->dma_write(frame_count, CFN, lch);
-
-	/*
-	 * If the chain is dynamically linked,
-	 * then we may have to start the chain if its not active
-	 */
-	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_DYNAMIC_CHAIN=
) {
-
-		/*
-		 * In Dynamic chain, if the chain is not started,
-		 * queue the channel
-		 */
-		if (dma_linked_lch[chain_id].chain_state =3D=3D
-						DMA_CHAIN_NOTSTARTED) {
-			/* Enable the link in previous channel */
-			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
-								DMA_CH_QUEUED)
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-			dma_chan[lch].state =3D DMA_CH_QUEUED;
-		}
-
-		/*
-		 * Chain is already started, make sure its active,
-		 * if not then start the chain
-		 */
-		else {
-			start_dma =3D 1;
-
-			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
-							DMA_CH_STARTED) {
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-				dma_chan[lch].state =3D DMA_CH_QUEUED;
-				start_dma =3D 0;
-				if (0 =3D=3D ((1 << 7) & p->dma_read(
-					CCR, dma_chan[lch].prev_linked_ch))) {
-					disable_lnk(dma_chan[lch].
-						    prev_linked_ch);
-					pr_debug("\n prev ch is stopped\n");
-					start_dma =3D 1;
-				}
-			}
-
-			else if (dma_chan[dma_chan[lch].prev_linked_ch].state
-							=3D=3D DMA_CH_QUEUED) {
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-				dma_chan[lch].state =3D DMA_CH_QUEUED;
-				start_dma =3D 0;
-			}
-			omap_enable_channel_irq(lch);
-
-			l =3D p->dma_read(CCR, lch);
-
-			if ((0 =3D=3D (l & (1 << 24))))
-				l &=3D ~(1 << 25);
-			else
-				l |=3D (1 << 25);
-			if (start_dma =3D=3D 1) {
-				if (0 =3D=3D (l & (1 << 7))) {
-					l |=3D (1 << 7);
-					dma_chan[lch].state =3D DMA_CH_STARTED;
-					pr_debug("starting %d\n", lch);
-					p->dma_write(l, CCR, lch);
-				} else
-					start_dma =3D 0;
-			} else {
-				if (0 =3D=3D (l & (1 << 7)))
-					p->dma_write(l, CCR, lch);
-			}
-			dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
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
-	if (unlikely((chain_id < 0 || chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-
-	if (dma_linked_lch[channels[0]].chain_state =3D=3D DMA_CHAIN_STARTED)=
 {
-		printk(KERN_ERR "Chain is already started\n");
-		return -EBUSY;
-	}
-
-	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_STATIC_CHAIN)=
 {
-		for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked;
-									i++) {
-			enable_lnk(channels[i]);
-			omap_enable_channel_irq(channels[i]);
-		}
-	} else {
-		omap_enable_channel_irq(channels[0]);
-	}
-
-	l =3D p->dma_read(CCR, channels[0]);
-	l |=3D (1 << 7);
-	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_STARTED;
-	dma_chan[channels[0]].state =3D DMA_CH_STARTED;
-
-	if ((0 =3D=3D (l & (1 << 24))))
-		l &=3D ~(1 << 25);
-	else
-		l |=3D (1 << 25);
-	p->dma_write(l, CCR, channels[0]);
-
-	dma_chan[channels[0]].flags |=3D OMAP_DMA_ACTIVE;
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_start_dma_chain_transfers);
-
-/**
- * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a c=
hain.
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
-	u32 sys_cf =3D 0;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
-		sys_cf =3D p->dma_read(OCP_SYSCONFIG, 0);
-		l =3D sys_cf;
-		/* Middle mode reg set no Standby */
-		l &=3D ~((1 << 12)|(1 << 13));
-		p->dma_write(l, OCP_SYSCONFIG, 0);
-	}
-
-	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-
-		/* Stop the Channel transmission */
-		l =3D p->dma_read(CCR, channels[i]);
-		l &=3D ~(1 << 7);
-		p->dma_write(l, CCR, channels[i]);
-
-		/* Disable the link in all the channels */
-		disable_lnk(channels[i]);
-		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
-
-	}
-	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;
-
-	/* Reset the Queue pointers */
-	OMAP_DMA_CHAIN_QINIT(chain_id);
-
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
-		p->dma_write(sys_cf, OCP_SYSCONFIG, 0);
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
-	if (unlikely((chain_id < 0 || chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	if ((!ei) || (!fi))
-		return -EINVAL;
-
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch =3D channels[dma_linked_lch[chain_id].q_head];
-
-	*ei =3D p->dma_read(CCEN, lch);
-	*fi =3D p->dma_read(CCFN, lch);
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_get_dma_chain_index);
-
-/**
- * @brief omap_get_dma_chain_dst_pos - Get the destination position of=
 the
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
-	if (unlikely((chain_id < 0 || chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch =3D channels[dma_linked_lch[chain_id].q_head];
-
-	return p->dma_read(CDAC, lch);
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
-	if (unlikely((chain_id < 0 || chain_id >=3D dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch =3D channels[dma_linked_lch[chain_id].q_head];
-
-	return p->dma_read(CSAC, lch);
-}
-EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
-#endif	/* ifndef CONFIG_ARCH_OMAP1 */
-
-/*--------------------------------------------------------------------=
--------*/
-
-#ifdef CONFIG_ARCH_OMAP1
-
-static int omap1_dma_handle_ch(int ch)
-{
-	u32 csr;
-
-	if (enable_1510_mode && ch >=3D 6) {
-		csr =3D dma_chan[ch].saved_csr;
-		dma_chan[ch].saved_csr =3D 0;
-	} else
-		csr =3D p->dma_read(CSR, ch);
-	if (enable_1510_mode && ch <=3D 2 && (csr >> 7) !=3D 0) {
-		dma_chan[ch + 6].saved_csr =3D csr >> 7;
-		csr &=3D 0x7f;
-	}
-	if ((csr & 0x3f) =3D=3D 0)
-		return 0;
-	if (unlikely(dma_chan[ch].dev_id =3D=3D -1)) {
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
-		dma_chan[ch].flags &=3D ~OMAP_DMA_ACTIVE;
-	if (likely(dma_chan[ch].callback !=3D NULL))
-		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
-
-	return 1;
-}
-
-static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
-{
-	int ch =3D ((int) dev_id) - 1;
-	int handled =3D 0;
-
-	for (;;) {
-		int handled_now =3D 0;
-
-		handled_now +=3D omap1_dma_handle_ch(ch);
-		if (enable_1510_mode && dma_chan[ch + 6].saved_csr)
-			handled_now +=3D omap1_dma_handle_ch(ch + 6);
-		if (!handled_now)
-			break;
-		handled +=3D handled_now;
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
-	u32 status =3D p->dma_read(CSR, ch);
-
-	if (!status) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
-				ch);
-		p->dma_write(1 << ch, IRQSTATUS_L0, ch);
-		return 0;
-	}
-	if (unlikely(dma_chan[ch].dev_id =3D=3D -1)) {
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
-			ccr =3D p->dma_read(CCR, ch);
-			ccr &=3D ~OMAP_DMA_CCR_EN;
-			p->dma_write(ccr, CCR, ch);
-			dma_chan[ch].flags &=3D ~OMAP_DMA_ACTIVE;
-		}
-	}
-	if (unlikely(status & OMAP2_DMA_SECURE_ERR_IRQ))
-		printk(KERN_INFO "DMA secure error with device %d\n",
-		       dma_chan[ch].dev_id);
-	if (unlikely(status & OMAP2_DMA_MISALIGNED_ERR_IRQ))
-		printk(KERN_INFO "DMA misaligned error with device %d\n",
-		       dma_chan[ch].dev_id);
-
-	p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, ch);
-	p->dma_write(1 << ch, IRQSTATUS_L0, ch);
-	/* read back the register to flush the write */
-	p->dma_read(IRQSTATUS_L0, ch);
-
-	/* If the ch is not chained then chain_id will be -1 */
-	if (dma_chan[ch].chain_id !=3D -1) {
-		int chain_id =3D dma_chan[ch].chain_id;
-		dma_chan[ch].state =3D DMA_CH_NOTSTARTED;
-		if (p->dma_read(CLNK_CTRL, ch) & (1 << 15))
-			dma_chan[dma_chan[ch].next_linked_ch].state =3D
-							DMA_CH_STARTED;
-		if (dma_linked_lch[chain_id].chain_mode =3D=3D
-						OMAP_DMA_DYNAMIC_CHAIN)
-			disable_lnk(ch);
-
-		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
-			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
-
-		status =3D p->dma_read(CSR, ch);
-	}
-
-	p->dma_write(status, CSR, ch);
-
-	if (likely(dma_chan[ch].callback !=3D NULL))
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
-	val =3D p->dma_read(IRQSTATUS_L0, 0);
-	if (val =3D=3D 0) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ\n");
-		return IRQ_HANDLED;
-	}
-	enable_reg =3D p->dma_read(IRQENABLE_L0, 0);
-	val &=3D enable_reg; /* Dispatch only relevant interrupts */
-	for (i =3D 0; i < dma_lch_count && val !=3D 0; i++) {
-		if (val & 1)
-			omap2_dma_handle_ch(i);
-		val >>=3D 1;
-	}
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction omap24xx_dma_irq =3D {
-	.name =3D "DMA",
-	.handler =3D omap2_dma_irq_handler,
-	.flags =3D IRQF_DISABLED
-};
-
-#else
-static struct irqaction omap24xx_dma_irq;
-#endif
-
-/*--------------------------------------------------------------------=
--------*/
-
-void omap_dma_global_context_save(void)
-{
-	omap_dma_global_context.dma_irqenable_l0 =3D
-		p->dma_read(IRQENABLE_L0, 0);
-	omap_dma_global_context.dma_ocp_sysconfig =3D
-		p->dma_read(OCP_SYSCONFIG, 0);
-	omap_dma_global_context.dma_gcr =3D p->dma_read(GCR, 0);
-}
-
-void omap_dma_global_context_restore(void)
-{
-	int ch;
-
-	p->dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
-	p->dma_write(omap_dma_global_context.dma_ocp_sysconfig,
-		OCP_SYSCONFIG, 0);
-	p->dma_write(omap_dma_global_context.dma_irqenable_l0,
-		IRQENABLE_L0, 0);
-
-	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
-		p->dma_write(0x3 , IRQSTATUS_L0, 0);
-
-	for (ch =3D 0; ch < dma_chan_count; ch++)
-		if (dma_chan[ch].dev_id !=3D -1)
-			omap_clear_dma(ch);
-}
-
 static int __devinit omap_system_dma_probe(struct platform_device *pde=
v)
 {
-	int ch, ret =3D 0;
-	int dma_irq;
-	char irq_name[4];
+	int ch;
=20
 	p =3D pdev->dev.platform_data;
 	if (!p) {
@@ -1990,73 +739,26 @@ static int __devinit omap_system_dma_probe(struc=
t platform_device *pdev)
 	dma_chan		=3D d->chan;
 	enable_1510_mode	=3D d->dev_caps & ENABLE_1510_MODE;
=20
-	if (cpu_class_is_omap2()) {
-		dma_linked_lch =3D kzalloc(sizeof(struct dma_link_info) *
-						dma_lch_count, GFP_KERNEL);
-		if (!dma_linked_lch) {
-			ret =3D -ENOMEM;
-			goto exit_dma_chan;
-		}
-	}
-
 	spin_lock_init(&dma_chan_lock);
 	for (ch =3D 0; ch < dma_chan_count; ch++) {
+		unsigned long flags;
 		omap_clear_dma(ch);
-		if (cpu_class_is_omap2())
-			omap2_disable_irq_lch(ch);
+		if (p->disable_irq_lch) {
+			spin_lock_irqsave(&dma_chan_lock, flags);
+			p->disable_irq_lch(ch);
+			spin_unlock_irqrestore(&dma_chan_lock, flags);
+		}
=20
 		dma_chan[ch].dev_id =3D -1;
 		dma_chan[ch].next_lch =3D -1;
-
-		if (ch >=3D 6 && enable_1510_mode)
-			continue;
-
-		if (cpu_class_is_omap1()) {
-			/*
-			 * request_irq() doesn't like dev_id (ie. ch) being
-			 * zero, so we have to kludge around this.
-			 */
-			sprintf(&irq_name[0], "%d", ch);
-			dma_irq =3D platform_get_irq_byname(pdev, irq_name);
-
-			if (dma_irq < 0) {
-				dev_err(&pdev->dev, "%s:unable to get irq\n",
-								__func__);
-				ret =3D dma_irq;
-				goto exit_dma_chan;
-			}
-			ret =3D request_irq(dma_irq,
-					omap1_dma_irq_handler, 0, "DMA",
-					(void *) (ch + 1));
-			if (ret !=3D 0) {
-				int irq_rel;
-				dev_err(&pdev->dev, "unable to request IRQ %d"
-					"for DMA (error %d)\n", dma_irq, ret);
-				for (irq_rel =3D 0; irq_rel < ch;
-								irq_rel++) {
-					dma_irq =3D platform_get_irq(pdev,
-								irq_rel);
-					free_irq(dma_irq, (void *)
-							(irq_rel + 1));
-					goto exit_dma_chan;
-				}
-			}
-		}
 	}
=20
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
-		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
+	if ((d->dev_caps & GLOBAL_PRIORITY) && (p->set_global_params))
+		p->set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
=20
-	if (cpu_class_is_omap2()) {
-		strcpy(irq_name, "0");
-		dma_irq =3D platform_get_irq_byname(pdev, irq_name);
-		setup_irq(dma_irq, &omap24xx_dma_irq);
-	}
-
 	/* reserve dma channels 0 and 1 in high security devices */
-	if (cpu_is_omap34xx() &&
-		(omap_type() !=3D OMAP2_DEVICE_TYPE_GP)) {
+	if (d->dev_caps & RESERVE_CHANNEL) {
 		printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
 				"HS ROM code\n");
 		dma_chan[0].dev_id =3D 0;
@@ -2064,11 +766,6 @@ static int __devinit omap_system_dma_probe(struct=
 platform_device *pdev)
 	}
 	p->show_dma_caps();
 	return 0;
-
-exit_dma_chan:
-	kfree(dma_chan);
-	kfree(p);
-	return ret;
 }
=20
 static int __devexit omap_system_dma_remove(struct platform_device *pd=
ev)
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap=
/include/plat/dma.h
index d1c916f..cea7e12 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -268,17 +268,12 @@
 #define DMA_IDLEMODE_NO_IDLE			0x1
 #define DMA_IDLEMODE_FORCE_IDLE			0x0
=20
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
=20
+#define OMAP_DMA_ACTIVE			0x01
+#define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
+
 /* Errata handling */
 #define IS_DMA_ERRATA(id)		(errata & (id))
 #define SET_DMA_ERRATA(id)		(errata |=3D (id))
@@ -401,6 +396,10 @@ struct omap_dma_channel_params {
 #endif
 };
=20
+#ifdef CONFIG_ARCH_OMAP2PLUS
+#include <mach/dma.h>
+#endif
+
 struct omap_dma_lch {
 	int next_lch;
 	int dev_id;
@@ -432,6 +431,30 @@ struct omap_system_dma_plat_info {
 	void (*disable_irq_lch)(int lch);
 	void (*show_dma_caps)(void);
 	void (*clear_lch_regs)(int lch);
+	void (*cpc_cdac_init)(int lch);
+	int (*get_gdma_dev)(int req);
+	void (*set_gdma_dev)(int req, int dev);
+	void (*set_transfer_params)(int lch, int data_type, int sync_mode,
+				int dma_trigger, int src_or_dst_synch);
+	void (*set_color_mode)(int lch, enum omap_dma_color_mode mode,
+								u32 color);
+	void (*set_src_params)(int lch, unsigned long src_start, int src_ei,
+								int src_fi);
+	void (*set_dest_params)(int lch, unsigned long dest_start, int dst_ei=
,
+								int dst_fi);
+	dma_addr_t (*get_src_pos)(int lch);
+	dma_addr_t (*get_dst_pos)(int lch);
+
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
 	void (*clear_dma)(int lch);
 	void (*dma_write)(u32 val, int reg, int lch);
 	u32 (*dma_read)(int reg, int lch);
@@ -498,29 +521,6 @@ void omap_dma_global_context_restore(void);
=20
 extern void omap_dma_disable_irq(int lch);
=20
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
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
