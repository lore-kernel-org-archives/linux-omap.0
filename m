From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 23/52] musb_hdrc: Search and replace bIsSharedFifo with
	is_shared_fifo
Date: Mon, 13 Aug 2007 06:48:58 -0700
Message-ID: <1187013024836-git-send-email-tony@atomide.com>
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
	<1187013000811-git-send-email-tony@atomide.com>
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
	<1187013007355-git-send-email-tony@atomide.com>
	<11870130103320-git-send-email-tony@atomide.com>
	<11870130122117-git-send-email-tony@atomide.com>
	<11870130153038-git-send-email-tony@atomide.com>
	<11870130183634-git-send-email-tony@atomide.com>
	<11870130203742-git-send-email-tony@atomide.com>
	<1187013022688-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1187013022688-git-send-email-tony@atomide.com>
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

Search and replace bIsSharedFifo with is_shared_fifo

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |   12 ++++++------
 drivers/usb/musb/musb_host.c   |   14 +++++++-------
 drivers/usb/musb/musbdefs.h    |    2 +-
 drivers/usb/musb/plat_uds.c    |   10 +++++-----
 4 files changed, 19 insertions(+), 19 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -896,7 +896,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	if (desc->bEndpointAddress & USB_DIR_IN) {
 		u16 wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
 
-		if (hw_ep->bIsSharedFifo)
+		if (hw_ep->is_shared_fifo)
 			musb_ep->is_in = 1;
 		if (!musb_ep->is_in)
 			goto fail;
@@ -926,7 +926,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	} else {
 		u16 wIntrRxE = musb_readw(mbase, MGC_O_HDRC_INTRRXE);
 
-		if (hw_ep->bIsSharedFifo)
+		if (hw_ep->is_shared_fifo)
 			musb_ep->is_in = 0;
 		if (musb_ep->is_in)
 			goto fail;
@@ -942,7 +942,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		musb_writew(regs, MGC_O_HDRC_RXMAXP, tmp);
 
 		/* force shared fifo to OUT-only mode */
-		if (hw_ep->bIsSharedFifo) {
+		if (hw_ep->is_shared_fifo) {
 			csr = musb_readw(regs, MGC_O_HDRC_TXCSR);
 			csr &= ~(MGC_M_TXCSR_MODE | MGC_M_TXCSR_TXPKTRDY);
 			musb_writew(regs, MGC_O_HDRC_TXCSR, csr);
@@ -1569,7 +1569,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 	INIT_LIST_HEAD(&ep->req_list);
 
 	sprintf(ep->name, "ep%d%s", epnum,
-			(!epnum || hw_ep->bIsSharedFifo) ? "" : (
+			(!epnum || hw_ep->is_shared_fifo) ? "" : (
 				is_in ? "in" : "out"));
 	ep->end_point.name = ep->name;
 	INIT_LIST_HEAD(&ep->end_point.ep_list);
@@ -1603,7 +1603,7 @@ static inline void __init musb_g_init_endpoints(struct musb *musb)
 	for (epnum = 0, hw_ep = musb->endpoints;
 			epnum < musb->nr_endpoints;
 			epnum++, hw_ep++) {
-		if (hw_ep->bIsSharedFifo /* || !epnum */) {
+		if (hw_ep->is_shared_fifo /* || !epnum */) {
 			init_peripheral_ep(musb, &hw_ep->ep_in, epnum, 0);
 			count++;
 		} else {
@@ -1800,7 +1800,7 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 				i < musb->nr_endpoints;
 				i++, hw_ep++) {
 			musb_ep_select(musb->mregs, i);
-			if (hw_ep->bIsSharedFifo /* || !epnum */) {
+			if (hw_ep->is_shared_fifo /* || !epnum */) {
 				nuke(&hw_ep->ep_in, -ESHUTDOWN);
 			} else {
 				if (hw_ep->wMaxPacketSizeTx)
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -216,7 +216,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 			epnum, pBuffer, dwLength);
 
 	/* Configure endpoint */
-	if (is_in || hw_ep->bIsSharedFifo)
+	if (is_in || hw_ep->is_shared_fifo)
 		hw_ep->in_qh = qh;
 	else
 		hw_ep->out_qh = qh;
@@ -322,7 +322,7 @@ static inline void musb_save_toggle(struct musb_hw_ep *ep, int is_in, struct urb
 	 * problems getting toggle correct.
 	 */
 
-	if (is_in || ep->bIsSharedFifo)
+	if (is_in || ep->is_shared_fifo)
 		qh = ep->in_qh;
 	else
 		qh = ep->out_qh;
@@ -349,7 +349,7 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 	struct musb		*musb = ep->musb;
 	int			ready = qh->is_ready;
 
-	if (ep->bIsSharedFifo)
+	if (ep->is_shared_fifo)
 		is_in = 1;
 	else
 		is_in = usb_pipein(urb->pipe);
@@ -382,7 +382,7 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 			ep->tx_reinit = 1;
 
 		/* clobber old pointers to this qh */
-		if (is_in || ep->bIsSharedFifo)
+		if (is_in || ep->is_shared_fifo)
 			ep->in_qh = NULL;
 		else
 			ep->out_qh = NULL;
@@ -429,7 +429,7 @@ musb_advance_schedule(struct musb *musb, struct urb *urb,
 {
 	struct musb_qh	*qh;
 
-	if (is_in || hw_ep->bIsSharedFifo)
+	if (is_in || hw_ep->is_shared_fifo)
 		qh = hw_ep->in_qh;
 	else
 		qh = hw_ep->out_qh;
@@ -578,7 +578,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	 */
 
 	/* if programmed for Tx, put it in RX mode */
-	if (ep->bIsSharedFifo) {
+	if (ep->is_shared_fifo) {
 		csr = musb_readw(ep->regs, MGC_O_HDRC_TXCSR);
 		if (csr & MGC_M_TXCSR_MODE) {
 			musb_h_tx_flush_fifo(ep);
@@ -636,7 +636,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	struct musb_qh		*qh;
 	u16			wPacketSize;
 
-	if (!is_out || hw_ep->bIsSharedFifo)
+	if (!is_out || hw_ep->is_shared_fifo)
 		qh = hw_ep->in_qh;
 	else
 		qh = hw_ep->out_qh;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -266,7 +266,7 @@ struct musb_hw_ep {
 	u8			epnum;
 
 	/* hardware configuration, possibly dynamic */
-	u8			bIsSharedFifo;
+	u8			is_shared_fifo;
 	u8			tx_double_buffered;
 	u8			rx_double_buffered;
 	u16			wMaxPacketSizeTx;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1078,7 +1078,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		hw_ep->tx_double_buffered = hw_ep->rx_double_buffered;
 		hw_ep->wMaxPacketSizeTx = maxpacket;
 
-		hw_ep->bIsSharedFifo = TRUE;
+		hw_ep->is_shared_fifo = TRUE;
 		break;
 	}
 
@@ -1204,11 +1204,11 @@ static int __init ep_config_from_hw(struct musb *musb)
 		/* shared TX/RX FIFO? */
 		if ((reg & 0xf0) == 0xf0) {
 			hw_ep->wMaxPacketSizeRx = hw_ep->wMaxPacketSizeTx;
-			hw_ep->bIsSharedFifo = TRUE;
+			hw_ep->is_shared_fifo = TRUE;
 			continue;
 		} else {
 			hw_ep->wMaxPacketSizeRx = 1 << ((reg & 0xf0) >> 4);
-			hw_ep->bIsSharedFifo = FALSE;
+			hw_ep->is_shared_fifo = FALSE;
 		}
 
 		/* FIXME set up hw_ep->{rx,tx}_double_buffered */
@@ -1388,12 +1388,12 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 			printk(KERN_DEBUG
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
-				hw_ep->bIsSharedFifo ? "shared" : "tx",
+				hw_ep->is_shared_fifo ? "shared" : "tx",
 				hw_ep->tx_double_buffered
 					? "doublebuffer, " : "",
 				hw_ep->wMaxPacketSizeTx);
 		}
-		if (hw_ep->wMaxPacketSizeRx && !hw_ep->bIsSharedFifo) {
+		if (hw_ep->wMaxPacketSizeRx && !hw_ep->is_shared_fifo) {
 			printk(KERN_DEBUG
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
-- 
1.5.2.3
