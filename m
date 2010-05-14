From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/10] OMAP2/3/4: DMA: disable channel interrupts in
	omap_init_dma()
Date: Fri, 14 May 2010 14:27:47 -0700
Message-ID: <20100514212747.25599.60817.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56173 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab0ENV1u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:27:50 -0400
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

If we are softbooting another kernel using kexec, DMA controller state is not
known when we are performing omap_init_dma(). It is possible that some DMA
channels are already active. For example after kexec we get:

<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5

To prevent any weird things happening, we disable all channel interrupts during
init.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 1d95996..ad42ec3 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -709,6 +709,21 @@ static inline void omap2_enable_irq_lch(int lch)
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
+static inline void omap2_disable_irq_lch(int lch)
+{
+	u32 val;
+	unsigned long flags;
+
+	if (!cpu_class_is_omap2())
+		return;
+
+	spin_lock_irqsave(&dma_chan_lock, flags);
+	val = dma_read(IRQENABLE_L0);
+	val &= ~(1 << lch);
+	dma_write(val, IRQENABLE_L0);
+	spin_unlock_irqrestore(&dma_chan_lock, flags);
+}
+
 int omap_request_dma(int dev_id, const char *dev_name,
 		     void (*callback)(int lch, u16 ch_status, void *data),
 		     void *data, int *dma_ch_out)
@@ -807,14 +822,7 @@ void omap_free_dma(int lch)
 	}
 
 	if (cpu_class_is_omap2()) {
-		u32 val;
-
-		spin_lock_irqsave(&dma_chan_lock, flags);
-		/* Disable interrupts */
-		val = dma_read(IRQENABLE_L0);
-		val &= ~(1 << lch);
-		dma_write(val, IRQENABLE_L0);
-		spin_unlock_irqrestore(&dma_chan_lock, flags);
+		omap2_disable_irq_lch(lch);
 
 		/* Clear the CSR register and IRQ status register */
 		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
@@ -2107,6 +2115,9 @@ static int __init omap_init_dma(void)
 
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
+		if (cpu_class_is_omap2())
+			omap2_disable_irq_lch(ch);
+
 		dma_chan[ch].dev_id = -1;
 		dma_chan[ch].next_lch = -1;
 

