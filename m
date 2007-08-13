From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/52] musb_hdrc: Search and replace aLocalEnd with endpoints
Date: Mon, 13 Aug 2007 06:48:48 -0700
Message-ID: <1187013000811-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
	<11870129934099-git-send-email-tony@atomide.com>
	<1187012995338-git-send-email-tony@atomide.com>
	<1187012998290-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1187012998290-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace aLocalEnd with endpoints

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   28 ++++++++++++++--------------
 drivers/usb/musb/musb_gadget.c |   28 ++++++++++++++--------------
 drivers/usb/musb/musb_host.c   |   12 ++++++------
 drivers/usb/musb/musb_procfs.c |    2 +-
 drivers/usb/musb/musbdefs.h    |    6 +++---
 drivers/usb/musb/plat_uds.c    |   16 ++++++++--------
 6 files changed, 46 insertions(+), 46 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -41,8 +41,8 @@
 
 #include "musbdefs.h"
 
-/* ep0 is always musb->aLocalEnd[0].ep_in */
-#define	next_ep0_request(musb)	next_in_request(&(musb)->aLocalEnd[0])
+/* ep0 is always musb->endpoints[0].ep_in */
+#define	next_ep0_request(musb)	next_in_request(&(musb)->endpoints[0])
 
 /*
  * Locking note:  we use only the controller lock, for simpler correctness.
@@ -116,11 +116,11 @@ static int service_tx_status_request(
 		is_in = bEnd & USB_DIR_IN;
 		if (is_in) {
 			bEnd &= 0x0f;
-			ep = &musb->aLocalEnd[bEnd].ep_in;
+			ep = &musb->endpoints[bEnd].ep_in;
 		} else {
-			ep = &musb->aLocalEnd[bEnd].ep_out;
+			ep = &musb->endpoints[bEnd].ep_out;
 		}
-		regs = musb->aLocalEnd[bEnd].regs;
+		regs = musb->endpoints[bEnd].regs;
 
 		if (bEnd >= MUSB_C_NUM_EPS || !ep->desc) {
 			handled = -EINVAL;
@@ -151,7 +151,7 @@ static int service_tx_status_request(
 
 		if (len > 2)
 			len = 2;
-		musb_write_fifo(&musb->aLocalEnd[0], len, bResult);
+		musb_write_fifo(&musb->endpoints[0], len, bResult);
 	}
 
 	return handled;
@@ -197,7 +197,7 @@ service_in_request(struct musb *musb,
 static void musb_g_ep0_giveback(struct musb *musb, struct usb_request *req)
 {
 	musb->ep0_state = MGC_END0_STAGE_SETUP;
-	musb_g_giveback(&musb->aLocalEnd[0].ep_in, req, 0);
+	musb_g_giveback(&musb->endpoints[0].ep_in, req, 0);
 }
 
 /*
@@ -266,9 +266,9 @@ __acquires(musb->Lock)
 					break;
 
 				if (pControlRequest->wIndex & USB_DIR_IN)
-					musb_ep = &musb->aLocalEnd[bEnd].ep_in;
+					musb_ep = &musb->endpoints[bEnd].ep_in;
 				else
-					musb_ep = &musb->aLocalEnd[bEnd].ep_out;
+					musb_ep = &musb->endpoints[bEnd].ep_out;
 				if (!musb_ep->desc)
 					break;
 
@@ -378,7 +378,7 @@ stall:
 							!= USB_ENDPOINT_HALT)
 					break;
 
-				ep = musb->aLocalEnd + bEnd;
+				ep = musb->endpoints + bEnd;
 				regs = ep->regs;
 				is_in = pControlRequest->wIndex & USB_DIR_IN;
 				if (is_in)
@@ -454,7 +454,7 @@ static void ep0_rxstate(struct musb *this)
 			req->status = -EOVERFLOW;
 			tmp = len;
 		}
-		musb_read_fifo(&this->aLocalEnd[0], tmp, buf);
+		musb_read_fifo(&this->endpoints[0], tmp, buf);
 		req->actual += tmp;
 		tmp = MGC_M_CSR0_P_SVDRXPKTRDY;
 		if (tmp < 64 || req->actual == req->length) {
@@ -499,7 +499,7 @@ static void ep0_txstate(struct musb *musb)
 	pFifoSource = (u8 *) pRequest->buf + pRequest->actual;
 	fifo_count = min((unsigned) MGC_END0_FIFOSIZE,
 		pRequest->length - pRequest->actual);
-	musb_write_fifo(&musb->aLocalEnd[0], fifo_count, pFifoSource);
+	musb_write_fifo(&musb->endpoints[0], fifo_count, pFifoSource);
 	pRequest->actual += fifo_count;
 
 	/* update the flags */
@@ -534,7 +534,7 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 	struct usb_request	*r;
 	void __iomem		*regs = musb->control_ep->regs;
 
-	musb_read_fifo(&musb->aLocalEnd[0], sizeof *req, (u8 *)req);
+	musb_read_fifo(&musb->endpoints[0], sizeof *req, (u8 *)req);
 
 	/* NOTE:  earlier 2.6 versions changed setup packets to host
 	 * order, but now USB packets always stay in USB byte order.
@@ -601,7 +601,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 	u16		wCsrVal;
 	u16		len;
 	void __iomem	*mbase = musb->mregs;
-	void __iomem	*regs = musb->aLocalEnd[0].regs;
+	void __iomem	*regs = musb->endpoints[0].regs;
 	irqreturn_t	retval = IRQ_NONE;
 
 	MGC_SelectEnd(mbase, 0);	/* select ep0 */
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -159,7 +159,7 @@ __acquires(ep->musb->Lock)
 static void nuke(struct musb_ep *ep, const int status)
 {
 	struct musb_request	*req = NULL;
-	void __iomem *epio = ep->musb->aLocalEnd[ep->bEndNumber].regs;
+	void __iomem *epio = ep->musb->endpoints[ep->bEndNumber].regs;
 
 	ep->busy = 1;
 
@@ -254,7 +254,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 {
 	u8			bEnd = req->bEnd;
 	struct musb_ep		*musb_ep;
-	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
+	void __iomem		*epio = musb->endpoints[bEnd].regs;
 	struct usb_request	*pRequest;
 	u16			fifo_count = 0, wCsrVal;
 	int			use_dma = 0;
@@ -407,8 +407,8 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
 	u8 __iomem		*mbase = musb->mregs;
-	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_in;
-	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
+	struct musb_ep		*musb_ep = &musb->endpoints[bEnd].ep_in;
+	void __iomem		*epio = musb->endpoints[bEnd].regs;
 	struct dma_channel	*dma;
 
 	MGC_SelectEnd(mbase, bEnd);
@@ -575,8 +575,8 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	u16			wCsrVal = 0;
 	const u8		bEnd = req->bEnd;
 	struct usb_request	*pRequest = &req->request;
-	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
-	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
+	struct musb_ep		*musb_ep = &musb->endpoints[bEnd].ep_out;
+	void __iomem		*epio = musb->endpoints[bEnd].regs;
 	u16			fifo_count = 0;
 	u16			len = musb_ep->wPacketSize;
 
@@ -737,8 +737,8 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
 	void __iomem		*mbase = musb->mregs;
-	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
-	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
+	struct musb_ep		*musb_ep = &musb->endpoints[bEnd].ep_out;
+	void __iomem		*epio = musb->endpoints[bEnd].regs;
 	struct dma_channel	*dma;
 
 	MGC_SelectEnd(mbase, bEnd);
@@ -1007,7 +1007,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 	musb_ep = to_musb_ep(ep);
 	musb = musb_ep->musb;
 	bEnd = musb_ep->bEndNumber;
-	epio = musb->aLocalEnd[bEnd].regs;
+	epio = musb->endpoints[bEnd].regs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 	MGC_SelectEnd(musb->mregs, bEnd);
@@ -1231,7 +1231,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
 	u8			bEnd = musb_ep->bEndNumber;
 	struct musb		*musb = musb_ep->musb;
-	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
+	void __iomem		*epio = musb->endpoints[bEnd].regs;
 	void __iomem		*mbase;
 	unsigned long		flags;
 	u16			wCsr;
@@ -1331,7 +1331,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	struct musb_ep	*musb_ep = to_musb_ep(ep);
 	struct musb	*musb = musb_ep->musb;
 	u8		nEnd = musb_ep->bEndNumber;
-	void __iomem	*epio = musb->aLocalEnd[nEnd].regs;
+	void __iomem	*epio = musb->endpoints[nEnd].regs;
 	void __iomem	*mbase;
 	unsigned long	flags;
 	u16		wCsr, wIntrTxE;
@@ -1557,7 +1557,7 @@ static void musb_gadget_release(struct device *dev)
 static void __init
 init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 bEnd, int is_in)
 {
-	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
+	struct musb_hw_ep	*hw_ep = musb->endpoints + bEnd;
 
 	memset(ep, 0, sizeof *ep);
 
@@ -1600,7 +1600,7 @@ static inline void __init musb_g_init_endpoints(struct musb *musb)
 	/* intialize endpoint list just once */
 	INIT_LIST_HEAD(&(musb->g.ep_list));
 
-	for (bEnd = 0, hw_ep = musb->aLocalEnd;
+	for (bEnd = 0, hw_ep = musb->endpoints;
 			bEnd < musb->bEndCount;
 			bEnd++, hw_ep++) {
 		if (hw_ep->bIsSharedFifo /* || !bEnd */) {
@@ -1796,7 +1796,7 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 	 * then report disconnect
 	 */
 	if (driver) {
-		for (i = 0, hw_ep = musb->aLocalEnd;
+		for (i = 0, hw_ep = musb->endpoints;
 				i < musb->bEndCount;
 				i++, hw_ep++) {
 			MGC_SelectEnd(musb->mregs, i);
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -475,7 +475,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 	u8 bDone = FALSE;
 	u32			length;
 	int			do_flush = 0;
-	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
+	struct musb_hw_ep	*hw_ep = musb->endpoints + bEnd;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
 	int			nPipe = pUrb->pipe;
@@ -631,7 +631,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 	struct dma_channel	*pDmaChannel;
 	u8			bDmaOk;
 	void __iomem		*mbase = musb->mregs;
-	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
+	struct musb_hw_ep	*hw_ep = musb->endpoints + bEnd;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh;
 	u16			wPacketSize;
@@ -1170,7 +1170,7 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
 	size_t			wLength = 0;
 	u8			*pBuffer = NULL;
 	struct urb		*pUrb;
-	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
+	struct musb_hw_ep	*hw_ep = musb->endpoints + bEnd;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->out_qh;
 	u32			status = 0;
@@ -1380,7 +1380,7 @@ finish:
 void musb_host_rx(struct musb *musb, u8 bEnd)
 {
 	struct urb		*pUrb;
-	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
+	struct musb_hw_ep	*hw_ep = musb->endpoints + bEnd;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
 	size_t			xfer_len;
@@ -1711,7 +1711,7 @@ static int musb_schedule(
 
 		if (musb->periodic[nEnd])
 			continue;
-		hw_ep = &musb->aLocalEnd[nEnd];
+		hw_ep = &musb->endpoints[nEnd];
 		if (hw_ep == musb->bulk_ep)
 			continue;
 
@@ -1729,7 +1729,7 @@ static int musb_schedule(
 		return -ENOSPC;
 
 	idle = 1;
-	hw_ep = musb->aLocalEnd + nBestEnd;
+	hw_ep = musb->endpoints + nBestEnd;
 	musb->periodic[nBestEnd] = qh;
 	DBG(4, "qh %p periodic slot %d\n", qh, nBestEnd);
 success:
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -237,7 +237,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
 {
 	int			code = 0;
 	char			*buf = aBuffer;
-	struct musb_hw_ep	*hw_ep = &musb->aLocalEnd[bEnd];
+	struct musb_hw_ep	*hw_ep = &musb->endpoints[bEnd];
 
 	do {
 		MGC_SelectEnd(musb->mregs, bEnd);
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -282,7 +282,7 @@ struct musb_hw_ep {
 	void __iomem		*conf;
 #endif
 
-	/* index in musb->aLocalEnd[]  */
+	/* index in musb->endpoints[]  */
 	u8			epnum;
 
 	/* hardware configuration, possibly dynamic */
@@ -397,8 +397,8 @@ struct musb {
 
 	int nIrq;
 
-	struct musb_hw_ep	 aLocalEnd[MUSB_C_NUM_EPS];
-#define control_ep		aLocalEnd
+	struct musb_hw_ep	 endpoints[MUSB_C_NUM_EPS];
+#define control_ep		endpoints
 
 #define VBUSERR_RETRY_COUNT	3
 	u16			vbuserr_retry;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -271,7 +271,7 @@ static const u8 musb_test_packet[53] = {
 
 void musb_load_testpacket(struct musb *musb)
 {
-	void __iomem	*regs = musb->aLocalEnd[0].regs;
+	void __iomem	*regs = musb->endpoints[0].regs;
 
 	MGC_SelectEnd(musb->mregs, 0);
 	musb_write_fifo(musb->control_ep,
@@ -670,7 +670,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 
 		/* start any periodic Tx transfers waiting for current frame */
 		wFrame = musb_readw(mbase, MGC_O_HDRC_FRAME);
-		ep = musb->aLocalEnd;
+		ep = musb->endpoints;
 		for (bEnd = 1; (bEnd < musb->bEndCount)
 					&& (musb->wEndMask >= (1 << bEnd));
 				bEnd++, ep++) {
@@ -1099,7 +1099,7 @@ static int __init ep_config_from_table(struct musb *musb)
 	const struct fifo_cfg	*cfg;
 	unsigned		i, n;
 	int			offset;
-	struct musb_hw_ep	*hw_ep = musb->aLocalEnd;
+	struct musb_hw_ep	*hw_ep = musb->endpoints;
 
 	switch (fifo_mode) {
 	default:
@@ -1188,7 +1188,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 
 	for (bEnd = 1; bEnd < MUSB_C_NUM_EPS; bEnd++) {
 		MGC_SelectEnd(mbase, bEnd);
-		hw_ep = musb->aLocalEnd + bEnd;
+		hw_ep = musb->endpoints + bEnd;
 
 		/* read from core using indexed model */
 		reg = musb_readb(hw_ep->regs, 0x10 + MGC_O_HDRC_FIFOSIZE);
@@ -1334,8 +1334,8 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 			musb_driver_name, type, aRevision, aDate);
 
 	/* configure ep0 */
-	musb->aLocalEnd[0].wMaxPacketSizeTx = MGC_END0_FIFOSIZE;
-	musb->aLocalEnd[0].wMaxPacketSizeRx = MGC_END0_FIFOSIZE;
+	musb->endpoints[0].wMaxPacketSizeTx = MGC_END0_FIFOSIZE;
+	musb->endpoints[0].wMaxPacketSizeRx = MGC_END0_FIFOSIZE;
 
 	/* discover endpoint configuration */
 	musb->bEndCount = 1;
@@ -1362,7 +1362,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 
 	/* finish init, and print endpoint config */
 	for (i = 0; i < musb->bEndCount; i++) {
-		struct musb_hw_ep	*hw_ep = musb->aLocalEnd + i;
+		struct musb_hw_ep	*hw_ep = musb->endpoints + i;
 
 		hw_ep->fifo = MUSB_FIFO_OFFSET(i) + mbase;
 #ifdef CONFIG_USB_TUSB6010
@@ -1771,7 +1771,7 @@ allocate_instance(struct device *dev, void __iomem *mbase)
 	musb->mregs = mbase;
 	musb->ctrl_base = mbase;
 	musb->nIrq = -ENODEV;
-	for (epnum = 0, ep = musb->aLocalEnd;
+	for (epnum = 0, ep = musb->endpoints;
 			epnum < MUSB_C_NUM_EPS;
 			epnum++, ep++) {
 
-- 
1.5.2.3
