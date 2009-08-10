From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH 1/3] ARM: OMAP: DMA: Add support for DMA
	channel self linking on OMAP1510
Date: Mon, 10 Aug 2009 10:50:00 +0200
Message-ID: <200908101050.02530.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Implement DMA channel self linking on OMAP1510 using AUTO_INIT and REPEAT
flags of the DMA CCR register.

Created against linux-2.6.31-rc5.

Tested on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Note:
In its current form, enable_lnk() seems not very consistent (ie. result of a
conditional assignment is then overwritten unconditionally). As rather
different from OMAP1510 that I am familiar with, I am not quite sure how
support for other OMAP models should really look like. So I decided to leave
it as is and put my bit in a separate block, adding an additional FIXME
comment.

--- linux-2.6.31-rc5/arch/arm/plat-omap/dma.c.orig	2009-08-07 13:38:02.000000000 +0200
+++ linux-2.6.31-rc5/arch/arm/plat-omap/dma.c	2009-08-10 09:01:41.000000000 +0200
@@ -653,8 +653,21 @@ static inline void enable_lnk(int lch)
 {
 	u32 l;
 
+	if (omap_dma_in_1510_mode()) {
+		/* only self linking is supported */
+		if (dma_chan[lch].next_lch == lch) {
+			/* set AUTO_INIT | REPEAT bits in CCR */
+			l = dma_read(CCR(lch));
+			l |= 3 << 8;
+			dma_write(l, CCR(lch));
+		}
+		return;
+	}
+
 	l = dma_read(CLNK_CTRL(lch));
 
+	/* FIXME:
+	 * this conditional assignment is then overwritten unconditionally */
 	if (cpu_class_is_omap1())
 		l &= ~(1 << 14);
 
@@ -675,13 +688,21 @@ static inline void disable_lnk(int lch)
 {
 	u32 l;
 
-	l = dma_read(CLNK_CTRL(lch));
+	if (omap_dma_in_1510_mode())
+		l = dma_read(CCR(lch));
+	else
+		l = dma_read(CLNK_CTRL(lch));
 
 	/* Disable interrupts */
 	if (cpu_class_is_omap1()) {
 		dma_write(0, CICR(lch));
-		/* Set the STOP_LNK bit */
-		l |= 1 << 14;
+		if (omap_dma_in_1510_mode()) {
+			/* Unset AUTO_INIT & REPEAT bits */
+			l &= ~(3 << 8);
+		} else {
+			/* Set the STOP_LNK bit */
+			l |= 1 << 14;
+		}
 	}
 
 	if (cpu_class_is_omap2()) {
@@ -690,7 +711,10 @@ static inline void disable_lnk(int lch)
 		l &= ~(1 << 15);
 	}
 
-	dma_write(l, CLNK_CTRL(lch));
+	if (omap_dma_in_1510_mode())
+		dma_write(l, CCR(lch));
+	else
+		dma_write(l, CLNK_CTRL(lch));
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 
@@ -928,7 +952,7 @@ void omap_start_dma(int lch)
 {
 	u32 l;
 
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
+	if (dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
 
@@ -979,7 +1003,7 @@ void omap_stop_dma(int lch)
 {
 	u32 l;
 
-	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
+	if (dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
 
@@ -1130,7 +1154,7 @@ int omap_dma_running(void)
  */
 void omap_dma_link_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	if (omap_dma_in_1510_mode() && (lch_head != lch_queue)) {
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
 		BUG();
 		return;
@@ -1152,7 +1176,7 @@ EXPORT_SYMBOL(omap_dma_link_lch);
  */
 void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
-	if (omap_dma_in_1510_mode()) {
+	if (omap_dma_in_1510_mode() && (lch_head != lch_queue)) {
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
 		BUG();
 		return;
@@ -1822,7 +1846,7 @@ static int omap1_dma_handle_ch(int ch)
 	if (unlikely(csr & OMAP_DMA_DROP_IRQ))
 		printk(KERN_WARNING "DMA synchronization event drop occurred "
 		       "with device %d\n", dma_chan[ch].dev_id);
-	if (likely(csr & OMAP_DMA_BLOCK_IRQ))
+	if (likely(csr & OMAP_DMA_BLOCK_IRQ) && (dma_chan[ch].next_lch != ch))
 		dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
