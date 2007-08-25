From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-rc3-omap-git 2/2] musb_hdrc cleanup -- cppi and sparse
Date: Sat, 25 Aug 2007 14:42:12 -0700
Message-ID: <200708251442.13105.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Cleanup for CPPI DMA (for DaVinci, and someday TUSB6020):

 - Move state ram structs to CPPI header, it's not DaVinci-specific

 - Do some associated CamelCase removal, in conjunction with removing
   inappropriate "volatile" declarations.

This resolves a bunch of "sparse" warnings with this code, most of which
seem to have been caused by bugs in older versions of "sparse".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/musb/cppi_dma.c |  179 +++++++++++++++++++++-----------------------
 drivers/usb/musb/cppi_dma.h |   32 +++++++
 drivers/usb/musb/davinci.h  |   27 ------
 3 files changed, 121 insertions(+), 117 deletions(-)

--- o26.orig/drivers/usb/musb/davinci.h	2007-08-25 11:53:18.000000000 -0700
+++ o26/drivers/usb/musb/davinci.h	2007-08-25 11:53:43.000000000 -0700
@@ -40,6 +40,8 @@
 #define DAVINCI_USB_EOI_REG		0x3c
 #define DAVINCI_USB_EOI_INTVEC		0x40
 
+/* BEGIN CPPI-generic (?) */
+
 /* CPPI related registers */
 #define DAVINCI_TXCPPI_CTRL_REG		0x80
 #define DAVINCI_TXCPPI_TEAR_REG		0x84
@@ -76,30 +78,7 @@
 #define DAVINCI_DMA_ALL_CHANNELS_ENABLE	0xF
 #define DAVINCI_DMA_ALL_CHANNELS_DISABLE 0xF
 
-/* FIXME relying on "volatile" here is wrong ... */
-
-/* define structures of Rx/Tx stateRam entries */
-struct cppi_tx_stateram {
-	volatile u32 headPtr;
-	volatile u32 sopDescPtr;
-	volatile u32 currDescPtr;
-	volatile u32 currBuffPtr;
-	volatile u32 flags;
-	volatile u32 remLength;
-	volatile u32 dummy;
-	volatile u32 completionPtr;
-};
-
-struct cppi_rx_stateram {
-	volatile u32 buffOffset;
-	volatile u32 headPtr;
-	volatile u32 sopDescPtr;
-	volatile u32 currDescPtr;
-	volatile u32 currBuffPtr;
-	volatile u32 pktLength;
-	volatile u32 byteCount;
-	volatile u32 completionPtr;
-};
+/* END CPPI-generic (?) */
 
 #define DAVINCI_USB_TX_ENDPTS_MASK	0x1f		/* ep0 + 4 tx */
 #define DAVINCI_USB_RX_ENDPTS_MASK	0x1e		/* 4 rx */
--- o26.orig/drivers/usb/musb/cppi_dma.h	2007-08-25 11:53:18.000000000 -0700
+++ o26/drivers/usb/musb/cppi_dma.h	2007-08-25 11:53:43.000000000 -0700
@@ -11,9 +11,39 @@
 
 #include "musb_dma.h"
 #include "musb_core.h"
+
+
+/* FIXME fully isolate CPPI from DaVinci ... the "CPPI generic" registers
+ * would seem to be shared with the TUSB6020 (over VLYNQ).
+ */
+
 #include "davinci.h"
 
 
+/* CPPI RX/TX state RAM */
+
+struct cppi_tx_stateram {
+	u32 tx_head;			/* "DMA packet" head descriptor */
+	u32 tx_buf;
+	u32 tx_current;			/* current descriptor */
+	u32 tx_buf_current;
+	u32 tx_info;			/* flags, remaining buflen */
+	u32 tx_rem_len;
+	u32 tx_dummy;			/* unused */
+	u32 tx_complete;
+};
+
+struct cppi_rx_stateram {
+	u32 rx_skipbytes;
+	u32 rx_head;
+	u32 rx_sop;			/* "DMA packet" head descriptor */
+	u32 rx_current;			/* current descriptor */
+	u32 rx_buf_current;
+	u32 rx_len_len;
+	u32 rx_cnt_cnt;
+	u32 rx_complete;
+};
+
 /* hOptions bit masks for CPPI BDs */
 #define CPPI_SOP_SET	((u32)(1 << 31))
 #define CPPI_EOP_SET	((u32)(1 << 30))
@@ -73,7 +103,7 @@ struct cppi_channel {
 	u32			currOffset;	/* requested segments */
 	u32			actualLen;	/* completed (Channel.actual) */
 
-	void __iomem		*stateRam;	/* CPPI state */
+	void __iomem		*state_ram;	/* CPPI state */
 
 	/* BD management fields */
 	struct cppi_descriptor	*bdPoolHead;
--- o26.orig/drivers/usb/musb/cppi_dma.c	2007-08-25 11:53:18.000000000 -0700
+++ o26/drivers/usb/musb/cppi_dma.c	2007-08-25 11:55:30.000000000 -0700
@@ -76,18 +76,29 @@ cppi_bd_free(struct cppi_channel *c, str
  *  Initialize the Dma Controller as necessary.
  */
 
-#define	CAST (void *__force __iomem)
-
 /* zero out entire rx state RAM entry for the channel */
-static void cppi_reset_rx(struct cppi_rx_stateram *__iomem rx)
+static void cppi_reset_rx(struct cppi_rx_stateram __iomem *rx)
 {
-	musb_writel(CAST &rx->buffOffset, 0, 0);
-	musb_writel(CAST &rx->headPtr, 0, 0);
-	musb_writel(CAST &rx->sopDescPtr, 0, 0);
-	musb_writel(CAST &rx->currDescPtr, 0, 0);
-	musb_writel(CAST &rx->currBuffPtr, 0, 0);
-	musb_writel(CAST &rx->pktLength, 0, 0);
-	musb_writel(CAST &rx->byteCount, 0, 0);
+	musb_writel(&rx->rx_skipbytes, 0, 0);
+	musb_writel(&rx->rx_head, 0, 0);
+	musb_writel(&rx->rx_sop, 0, 0);
+	musb_writel(&rx->rx_current, 0, 0);
+	musb_writel(&rx->rx_buf_current, 0, 0);
+	musb_writel(&rx->rx_len_len, 0, 0);
+	musb_writel(&rx->rx_cnt_cnt, 0, 0);
+}
+
+/* zero out entire tx state RAM entry for the channel */
+static void cppi_reset_tx(struct cppi_tx_stateram __iomem *tx, u32 ptr)
+{
+	musb_writel(&tx->tx_head, 0, 0);
+	musb_writel(&tx->tx_buf, 0, 0);
+	musb_writel(&tx->tx_current, 0, 0);
+	musb_writel(&tx->tx_buf_current, 0, 0);
+	musb_writel(&tx->tx_info, 0, 0);
+	musb_writel(&tx->tx_rem_len, 0, 0);
+	/* musb_writel(&tx->tx_dummy, 0, 0); */
+	musb_writel(&tx->tx_complete, 0, ptr);
 }
 
 static void __init cppi_pool_init(struct cppi *cppi, struct cppi_channel *c)
@@ -139,7 +150,7 @@ static void cppi_pool_free(struct cppi_c
 static int __init cppi_controller_start(struct dma_controller *c)
 {
 	struct cppi	*controller;
-	void		*__iomem regBase;
+	void __iomem	*regBase;
 	int		i;
 
 	controller = container_of(c, struct cppi, Controller);
@@ -168,32 +179,23 @@ static int __init cppi_controller_start(
 	/* initialise tx/rx channel head pointers to zero */
 	for (i = 0; i < ARRAY_SIZE(controller->txCppi); i++) {
 		struct cppi_channel	*txChannel = controller->txCppi + i;
-		struct cppi_tx_stateram *__iomem txState;
+		struct cppi_tx_stateram __iomem *tx;
 
 		INIT_LIST_HEAD(&txChannel->tx_complete);
 
-		txState = regBase + DAVINCI_TXCPPI_STATERAM_OFFSET(i);
-		txChannel->stateRam = txState;
-		/* zero out entire state RAM entry for the channel */
-		txState->headPtr = 0;
-		txState->sopDescPtr = 0;
-		txState->currDescPtr = 0;
-		txState->currBuffPtr = 0;
-		txState->flags = 0;
-		txState->remLength = 0;
-		/*txState->dummy = 0; */
-		txState->completionPtr = 0;
-
+		tx = regBase + DAVINCI_TXCPPI_STATERAM_OFFSET(i);
+		txChannel->state_ram = tx;
+		cppi_reset_tx(tx, 0);
 	}
 	for (i = 0; i < ARRAY_SIZE(controller->rxCppi); i++) {
 		struct cppi_channel	*rxChannel = controller->rxCppi + i;
-		struct cppi_rx_stateram *__iomem rxState;
+		struct cppi_rx_stateram __iomem *rx;
 
 		INIT_LIST_HEAD(&rxChannel->tx_complete);
 
-		rxState = regBase + DAVINCI_RXCPPI_STATERAM_OFFSET(i);
-		rxChannel->stateRam = rxState;
-		cppi_reset_rx(rxChannel->stateRam);
+		rx = regBase + DAVINCI_RXCPPI_STATERAM_OFFSET(i);
+		rxChannel->state_ram = rx;
+		cppi_reset_rx(rx);
 	}
 
 	/* enable individual cppi channels */
@@ -354,7 +356,8 @@ static void cppi_channel_release(struct 
 static void
 cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 {
-	void	*__iomem base = c->controller->pCoreBase;
+	void __iomem			*base = c->controller->pCoreBase;
+	struct cppi_rx_stateram __iomem	*rx = c->state_ram;
 
 	musb_ep_select(base, c->chNo + 1);
 
@@ -367,15 +370,15 @@ cppi_dump_rx(int level, struct cppi_chan
 			DAVINCI_RXCPPI_BUFCNT0_REG + 4 *c->chNo),
 		musb_readw(c->hw_ep->regs, MUSB_RXCSR),
 
-		musb_readl(c->stateRam, 0 * 4),	/* buf offset */
-		musb_readl(c->stateRam, 1 * 4),	/* head ptr */
-		musb_readl(c->stateRam, 2 * 4),	/* sop bd */
-		musb_readl(c->stateRam, 3 * 4),	/* current bd */
-
-		musb_readl(c->stateRam, 4 * 4),	/* current buf */
-		musb_readl(c->stateRam, 5 * 4),	/* pkt len */
-		musb_readl(c->stateRam, 6 * 4),	/* byte cnt */
-		musb_readl(c->stateRam, 7 * 4)	/* completion */
+		musb_readl(&rx->rx_skipbytes, 0),
+		musb_readl(&rx->rx_head, 0),
+		musb_readl(&rx->rx_sop, 0),
+		musb_readl(&rx->rx_current, 0),
+
+		musb_readl(&rx->rx_buf_current, 0),
+		musb_readl(&rx->rx_len_len, 0),
+		musb_readl(&rx->rx_cnt_cnt, 0),
+		musb_readl(&rx->rx_complete, 0)
 		);
 }
 
@@ -383,7 +386,8 @@ cppi_dump_rx(int level, struct cppi_chan
 static void
 cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
 {
-	void	*__iomem base = c->controller->pCoreBase;
+	void __iomem			*base = c->controller->pCoreBase;
+	struct cppi_tx_stateram __iomem	*tx = c->state_ram;
 
 	musb_ep_select(base, c->chNo + 1);
 
@@ -394,22 +398,22 @@ cppi_dump_tx(int level, struct cppi_chan
 		c->chNo, tag,
 		musb_readw(c->hw_ep->regs, MUSB_TXCSR),
 
-		musb_readl(c->stateRam, 0 * 4),	/* head ptr */
-		musb_readl(c->stateRam, 1 * 4),	/* sop bd */
-		musb_readl(c->stateRam, 2 * 4),	/* current bd */
-		musb_readl(c->stateRam, 3 * 4),	/* buf offset */
+		musb_readl(&tx->tx_head, 0),
+		musb_readl(&tx->tx_buf, 0),
+		musb_readl(&tx->tx_current, 0),
+		musb_readl(&tx->tx_buf_current, 0),
 
-		musb_readl(c->stateRam, 4 * 4),	/* flags */
-		musb_readl(c->stateRam, 5 * 4),	/* len */
+		musb_readl(&tx->tx_info, 0),
+		musb_readl(&tx->tx_rem_len, 0),
 		/* dummy/unused word 6 */
-		musb_readl(c->stateRam, 7 * 4)	/* completion */
+		musb_readl(&tx->tx_complete, 0)
 		);
 }
 
 /* Context: controller irqlocked */
 static inline void
 cppi_rndis_update(struct cppi_channel *c, int is_rx,
-		void *__iomem tibase, int is_rndis)
+		void __iomem *tibase, int is_rndis)
 {
 	/* we may need to change the rndis flag for this cppi channel */
 	if (c->bLastModeRndis != is_rndis) {
@@ -455,7 +459,7 @@ static void cppi_dump_rxq(int level, con
  * so we won't ever use it (see "CPPI RX Woes" below).
  */
 static inline int cppi_autoreq_update(struct cppi_channel *rx,
-		void *__iomem tibase, int onepacket, unsigned n_bds)
+		void __iomem *tibase, int onepacket, unsigned n_bds)
 {
 	u32	val;
 
@@ -497,7 +501,7 @@ static inline int cppi_autoreq_update(st
 
 	/* REQPKT is turned off after each segment */
 	if (n_bds && rx->actualLen) {
-		void		*__iomem regs = rx->hw_ep->regs;
+		void __iomem	*regs = rx->hw_ep->regs;
 
 		val = musb_readw(regs, MUSB_RXCSR);
 		if (!(val & MUSB_RXCSR_H_REQPKT)) {
@@ -570,7 +574,7 @@ cppi_next_tx_segment(struct musb *musb, 
 	struct cppi_descriptor	*bd;
 	unsigned		n_bds;
 	unsigned		i;
-	struct cppi_tx_stateram	*txState = tx->stateRam;
+	struct cppi_tx_stateram	__iomem *tx_ram = tx->state_ram;
 	int			rndis;
 
 	/* TX can use the CPPI "rndis" mode, where we can probably fit this
@@ -661,8 +665,8 @@ cppi_next_tx_segment(struct musb *musb, 
 	/* BDs live in DMA-coherent memory, but writes might be pending */
 	cpu_drain_writebuffer();
 
-	/* Write to the HeadPtr in StateRam to trigger */
-	txState->headPtr = (u32)tx->bdPoolHead->dma;
+	/* Write to the HeadPtr in state RAM to trigger */
+	musb_writel(&tx_ram->tx_head, 0, (u32)tx->bdPoolHead->dma);
 
 	cppi_dump_tx(5, tx, "/S");
 }
@@ -768,8 +772,9 @@ cppi_next_rx_segment(struct musb *musb, 
 	struct cppi_descriptor	*bd, *tail;
 	unsigned		n_bds;
 	unsigned		i;
-	void			*__iomem tibase = musb->ctrl_base;
+	void __iomem		*tibase = musb->ctrl_base;
 	int			is_rndis = 0;
+	struct cppi_rx_stateram	__iomem *rx_ram = rx->state_ram;
 
 	if (onepacket) {
 		/* almost every USB driver, host or peripheral side */
@@ -904,7 +909,7 @@ cppi_next_rx_segment(struct musb *musb, 
 	/* REVISIT specs say to write this AFTER the BUFCNT register
 	 * below ... but that loses badly.
 	 */
-	musb_writel(rx->stateRam, 4, bd->dma);
+	musb_writel(&rx_ram->rx_head, 0, bd->dma);
 
 	/* bufferCount must be at least 3, and zeroes on completion
 	 * unless it underflows below zero, or stops at two, or keeps
@@ -1001,13 +1006,13 @@ static int cppi_channel_program(struct d
 static int cppi_rx_scan(struct cppi *cppi, unsigned ch)
 {
 	struct cppi_channel		*rx = &cppi->rxCppi[ch];
-	struct cppi_rx_stateram		*state = rx->stateRam;
+	struct cppi_rx_stateram __iomem	*state = rx->state_ram;
 	struct cppi_descriptor		*bd;
 	struct cppi_descriptor		*last = rx->lastHwBDProcessed;
 	int				completed = 0, acked = 0;
 	int				i;
 	dma_addr_t			safe2ack;
-	void				*__iomem regs = rx->hw_ep->regs;
+	void __iomem			*regs = rx->hw_ep->regs;
 
 	cppi_dump_rx(6, rx, "/K");
 
@@ -1016,7 +1021,7 @@ static int cppi_rx_scan(struct cppi *cpp
 		return 0;
 
 	/* run through all completed BDs */
-	for (i = 0, safe2ack = musb_readl(CAST &state->completionPtr, 0);
+	for (i = 0, safe2ack = musb_readl(&state->rx_complete, 0);
 			(safe2ack || completed) && bd && i < NUM_RXCHAN_BD;
 			i++, bd = bd->next) {
 		u16	len;
@@ -1060,8 +1065,8 @@ static int cppi_rx_scan(struct cppi *cpp
 		 * lost acks and states where BD ownership is unclear.
 		 */
 		if (bd->dma == safe2ack) {
-			musb_writel(CAST &state->completionPtr, 0, safe2ack);
-			safe2ack = musb_readl(CAST &state->completionPtr, 0);
+			musb_writel(&state->rx_complete, 0, safe2ack);
+			safe2ack = musb_readl(&state->rx_complete, 0);
 			acked = 1;
 			if (bd->dma == safe2ack)
 				safe2ack = 0;
@@ -1083,7 +1088,7 @@ static int cppi_rx_scan(struct cppi *cpp
 		int	csr;
 
 		if (safe2ack == 0 || safe2ack == rx->lastHwBDProcessed->dma)
-			musb_writel(CAST &state->completionPtr, 0, safe2ack);
+			musb_writel(&state->rx_complete, 0, safe2ack);
 		if (safe2ack == 0) {
 			cppi_bd_free(rx, last);
 			rx->lastHwBDProcessed = NULL;
@@ -1135,7 +1140,7 @@ static int cppi_rx_scan(struct cppi *cpp
 
 void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 {
-	void			*__iomem regBase;
+	void __iomem		*regBase;
 	int			i, chanNum, numCompleted;
 	u8			bReqComplete;
 	struct cppi		*cppi;
@@ -1151,10 +1156,10 @@ void cppi_completion(struct musb *musb, 
 	for (chanNum = 0; tx; tx = tx >> 1, chanNum++) {
 		if (tx & 1) {
 			struct cppi_channel		*txChannel;
-			struct cppi_tx_stateram		*txState;
+			struct cppi_tx_stateram __iomem	*txState;
 
 			txChannel = cppi->txCppi + chanNum;
-			txState = txChannel->stateRam;
+			txState = txChannel->state_ram;
 
 			/* FIXME  need a cppi_tx_scan() routine, which
 			 * can also be called from abort code
@@ -1207,7 +1212,8 @@ void cppi_completion(struct musb *musb, 
 				 * REVISIT have observed bit 18 set; huh??
 				 */
 				/* if ((bdPtr->hOptions & CPPI_EOQ_MASK)) */
-					txState->completionPtr = bdPtr->dma;
+					musb_writel(&txState->tx_complete, 0,
+							bdPtr->dma);
 
 				/* stop scanning on end-of-segment */
 				if (bdPtr->hNext == 0)
@@ -1363,9 +1369,9 @@ static int cppi_channel_abort(struct dma
 	struct cppi_channel	*otgCh;
 	struct cppi		*controller;
 	int			chNum;
-	void			*__iomem mbase;
-	void			*__iomem regBase;
-	void			*__iomem regs;
+	void __iomem		*mbase;
+	void __iomem		*regBase;
+	void __iomem		*regs;
 	u32			regVal;
 	struct cppi_descriptor	*queue;
 
@@ -1406,7 +1412,7 @@ static int cppi_channel_abort(struct dma
 	musb_ep_select(mbase, chNum + 1);
 
 	if (otgCh->transmit) {
-		struct cppi_tx_stateram	*__iomem txState;
+		struct cppi_tx_stateram __iomem *txState;
 		int			enabled;
 
 		/* mask interrupts raised to signal teardown complete.  */
@@ -1426,11 +1432,11 @@ static int cppi_channel_abort(struct dma
 		} while (!(regVal & CPPI_TEAR_READY));
 		musb_writel(regBase, DAVINCI_TXCPPI_TEAR_REG, chNum);
 
-		txState = otgCh->stateRam;
+		txState = otgCh->state_ram;
 		do {
-			regVal = txState->completionPtr;
+			regVal = musb_readl(&txState->tx_complete, 0);
 		} while (0xFFFFFFFC != regVal);
-		txState->completionPtr = 0xFFFFFFFC;
+		musb_writel(&txState->tx_complete, 0, 0xFFFFFFFC);
 
 		/* FIXME clean up the transfer state ... here?
 		 * the completion routine should get called with
@@ -1448,28 +1454,17 @@ static int cppi_channel_abort(struct dma
 			musb_writel(regBase, DAVINCI_TXCPPI_INTENAB_REG,
 					(1 << otgCh->chNo));
 
-		txState->headPtr = 0;
-		txState->sopDescPtr = 0;
-		txState->currBuffPtr = 0;
-		txState->currDescPtr = 0;
-		txState->flags = 0;
-		txState->remLength = 0;
-
-		/* Ensure that we clean up any Interrupt asserted
+		/* While we scrub the TX state RAM, ensure that we clean
+		 * up any interrupt that's currently asserted:
 		 * 1. Write to completion Ptr value 0x1(bit 0 set)
 		 *    (write back mode)
 		 * 2. Write to completion Ptr value 0x0(bit 0 cleared)
 		 *    (compare mode)
-		 * Value written is compared(for bits 31:2) and being
-		 * equal interrupt deasserted?
-		 */
-
-		/* write back mode, bit 0 set, hence completion Ptr
-		 * must be updated
+		 * Value written is compared(for bits 31:2) and when
+		 * equal, interrupt is deasserted.
 		 */
-		txState->completionPtr = 0x1;
-		/* compare mode, write back zero now */
-		txState->completionPtr = 0;
+		cppi_reset_tx(txState, 1);
+		musb_writel(&txState->tx_complete, 0, 0);
 
 		cppi_dump_tx(5, otgCh, " (done teardown)");
 
@@ -1509,10 +1504,10 @@ static int cppi_channel_abort(struct dma
 		musb_writew(regs, MUSB_RXCSR, csr);
 		csr = musb_readw(regs, MUSB_RXCSR);
 
-		/* quiesce: wait for current dma to finish (if not cleanup)
-		 * we can't use bit zero of stateram->sopDescPtr since that
+		/* Quiesce: wait for current dma to finish (if not cleanup).
+		 * We can't use bit zero of stateram->rx_sop, since that
 		 * refers to an entire "DMA packet" not just emptying the
-		 * current fifo; most segments need multiple usb packets.
+		 * current fifo.  Most segments need multiple usb packets.
 		 */
 		if (channel->status == MUSB_DMA_STATUS_BUSY)
 			udelay(50);
@@ -1533,7 +1528,7 @@ static int cppi_channel_abort(struct dma
 		 *
 		 * REVISIT does using rndis mode change that?
 		 */
-		cppi_reset_rx(otgCh->stateRam);
+		cppi_reset_rx(otgCh->state_ram);
 
 		/* next DMA request _should_ load cppi head ptr */
 
