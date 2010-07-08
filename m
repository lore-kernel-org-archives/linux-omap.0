From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 08/10] OMAP: DMA: Move IRQ handlers to mach-omap
Date: Fri,  9 Jul 2010 04:21:20 +0530
Message-ID: <1278629482-32501-9-git-send-email-manjugk@ti.com>
References: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37476 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758716Ab0GHWyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 18:54:15 -0400
In-Reply-To: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

The DMA IRQ handling is completely differnet between
omap1 and omap2 plus processors hence the IRQ handlers are
moved to respective dma.c in mach-omap directories.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/dma.c |   71 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dma.c |  111 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 57be4f5..fb5bf0d 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -175,6 +175,77 @@ static struct omap_dma_lch *omap1_dma_chan;
 static void __iomem *dma_base;
 static int enable_1510_mode;
 
+static int omap1_dma_handle_ch(int ch)
+{
+	u32 csr;
+	u32 reg, ch_reg_base;
+
+	ch_reg_base = r->lch_base * ch;
+
+	if (enable_1510_mode && ch >= 6) {
+		csr = omap1_dma_chan[ch].saved_csr;
+		omap1_dma_chan[ch].saved_csr = 0;
+	} else {
+		reg = ch_reg_base + r->common_ch.csr;
+		csr = omap1_dma_read(reg);
+	}
+	if (enable_1510_mode && ch <= 2 && (csr >> 7) != 0) {
+		omap1_dma_chan[ch + 6].saved_csr = csr >> 7;
+		csr &= 0x7f;
+	}
+	if ((csr & 0x3f) == 0)
+		return 0;
+	if (unlikely(omap1_dma_chan[ch].dev_id == -1)) {
+		printk(KERN_WARNING "Spurious interrupt from DMA channel "
+		       "%d (CSR %04x)\n", ch, csr);
+		return 0;
+	}
+	if (unlikely(csr & OMAP1_DMA_TOUT_IRQ))
+		printk(KERN_WARNING "DMA timeout with device %d\n",
+		       omap1_dma_chan[ch].dev_id);
+	if (unlikely(csr & OMAP_DMA_DROP_IRQ))
+		printk(KERN_WARNING "DMA synchronization event drop occurred "
+		       "with device %d\n", omap1_dma_chan[ch].dev_id);
+	if (likely(csr & OMAP_DMA_BLOCK_IRQ))
+		omap1_dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
+
+	if (likely(omap1_dma_chan[ch].callback != NULL))
+		omap1_dma_chan[ch].callback(ch, csr, omap1_dma_chan[ch].data);
+
+	return 1;
+}
+
+static irqreturn_t omap_dma_irq_handler(int irq, void *dev_id)
+{
+	int ch = ((int) dev_id) - 1;
+	int handled = 0;
+
+	for (;;) {
+		int handled_now = 0;
+
+		handled_now += omap1_dma_handle_ch(ch);
+
+		if (enable_1510_mode &&
+				omap1_dma_chan[ch + 6].saved_csr)
+			handled_now += omap1_dma_handle_ch(ch + 6);
+
+		if (!handled_now)
+			break;
+		handled += handled_now;
+	}
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int dma_irq_register(int dma_irq, int irq_count,
+		void __iomem *omap_dma_base, struct omap_dma_lch *dma_chan)
+{
+	int ret = request_irq(dma_irq, omap_dma_irq_handler, 0, "DMA",
+						(void *) (irq_count+1));
+	dma_base = omap_dma_base;
+	omap1_dma_chan = dma_chan;
+	return ret;
+}
+
 static int __init omap1_system_dma_init(void)
 {
 	struct platform_device *pdev;
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index f5fe0f5..42a96cf 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -134,6 +134,117 @@ static void __iomem *dma_base;
 static struct dma_link_info *dma_linked_lch;
 static u32 dma_chan_count;
 
+static int omap2_dma_handle_ch(int ch)
+{
+	u32 reg, ch_reg_base, status;
+
+	ch_reg_base = (r->lch_base * ch);
+	reg = ch_reg_base + r->common_ch.csr;
+	status = omap2_dma_read(reg);
+
+	if (!status) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
+									ch);
+			omap2_dma_write(1 << ch, r->irqreg.irq_status_l0);
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
+
+		if (omap2_pdata->errata & DMA_CH_DISABLE_ERRATA) {
+			u32 ccr;
+
+			reg = ch_reg_base + r->common_ch.ccr;
+			ccr = omap2_dma_read(reg);
+			ccr &= ~OMAP_DMA_CCR_EN;
+			omap2_dma_write(ccr, reg);
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
+	reg = ch_reg_base + r->common_ch.csr;
+	omap2_dma_write(OMAP2_DMA_CSR_CLEAR_MASK, reg);
+	omap2_dma_write(1 << ch, r->irqreg.irq_status_l0);
+
+	/* If the ch is not chained then chain_id will be -1 */
+	if (dma_chan[ch].chain_id != -1) {
+		int chain_id = dma_chan[ch].chain_id;
+		dma_chan[ch].state = DMA_CH_NOTSTARTED;
+		reg = ch_reg_base + r->common_ch.clnk_ctrl;
+		if (omap2_dma_read(reg) & (1 << 15))
+			dma_chan[dma_chan[ch].next_linked_ch].state =
+							DMA_CH_STARTED;
+		if (dma_linked_lch[chain_id].chain_mode ==
+						OMAP_DMA_DYNAMIC_CHAIN)
+			omap_disable_lnk(ch);
+
+		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
+			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
+
+		status = omap2_dma_read(reg);
+	}
+
+	omap2_dma_write(status, reg);
+
+	if (likely(dma_chan[ch].callback != NULL))
+		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
+
+	return 0;
+}
+
+static irqreturn_t omap_dma_irq_handler(int irq, void *dev_id)
+{
+	u32 val, enable_reg, i;
+
+	val = omap2_dma_read(r->irqreg.irq_status_l0);
+	if (val == 0) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "Spurious DMA IRQ\n");
+		return IRQ_HANDLED;
+	}
+	enable_reg = omap2_dma_read(r->irqreg.irq_enable_l0);
+	val &= enable_reg; /* Dispatch only relevant interrupts */
+	for (i = 0; i < d->dma_lch_count && val != 0; i++) {
+		if (val & 1)
+			omap2_dma_handle_ch(i);
+		val >>= 1;
+	}
+	return IRQ_HANDLED;
+}
+
+static struct irqaction omap24xx_dma_irq = {
+	.name = "DMA",
+	.handler = omap_dma_irq_handler,
+	.flags = IRQF_DISABLED,
+};
+
+static int dma_irq_register(int dma_irq, int irq_count,
+			struct omap_dma_lch *omap2_dma_chan)
+{
+	int ret;
+	ret = setup_irq(dma_irq, &omap24xx_dma_irq);
+	dma_chan = omap2_dma_chan;
+	return ret;
+}
+
 /* Create chain of DMA channesls */
 static void create_dma_lch_chain(int lch_head, int lch_queue)
 {
-- 
1.7.0.4

