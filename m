From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 24/52] musb_hdrc: Search and replace wMaxPacketSizeTx with
	max_packet_sz_tx
Date: Mon, 13 Aug 2007 06:48:59 -0700
Message-ID: <11870130272865-git-send-email-tony@atomide.com>
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
	<1187013024836-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1187013024836-git-send-email-tony@atomide.com>
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

Search and replace wMaxPacketSizeTx with max_packet_sz_tx

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |   10 +++++-----
 drivers/usb/musb/musb_host.c   |    6 +++---
 drivers/usb/musb/musbdefs.h    |    2 +-
 drivers/usb/musb/plat_uds.c    |   18 +++++++++---------
 4 files changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -203,7 +203,7 @@ static void nuke(struct musb_ep *ep, const int status)
 static inline int max_ep_writesize(struct musb *musb, struct musb_ep *ep)
 {
 	if (can_bulk_split(musb, ep->type))
-		return ep->hw_ep->wMaxPacketSizeTx;
+		return ep->hw_ep->max_packet_sz_tx;
 	else
 		return ep->wPacketSize;
 }
@@ -900,7 +900,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			musb_ep->is_in = 1;
 		if (!musb_ep->is_in)
 			goto fail;
-		if (tmp > hw_ep->wMaxPacketSizeTx)
+		if (tmp > hw_ep->max_packet_sz_tx)
 			goto fail;
 
 		wIntrTxE |= (1 << epnum);
@@ -1579,7 +1579,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 		musb->g.ep0 = &ep->end_point;
 	} else {
 		if (is_in)
-			ep->end_point.maxpacket = hw_ep->wMaxPacketSizeTx;
+			ep->end_point.maxpacket = hw_ep->max_packet_sz_tx;
 		else
 			ep->end_point.maxpacket = hw_ep->wMaxPacketSizeRx;
 		ep->end_point.ops = &musb_ep_ops;
@@ -1607,7 +1607,7 @@ static inline void __init musb_g_init_endpoints(struct musb *musb)
 			init_peripheral_ep(musb, &hw_ep->ep_in, epnum, 0);
 			count++;
 		} else {
-			if (hw_ep->wMaxPacketSizeTx) {
+			if (hw_ep->max_packet_sz_tx) {
 				init_peripheral_ep(musb, &hw_ep->ep_in,
 							epnum, 1);
 				count++;
@@ -1803,7 +1803,7 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 			if (hw_ep->is_shared_fifo /* || !epnum */) {
 				nuke(&hw_ep->ep_in, -ESHUTDOWN);
 			} else {
-				if (hw_ep->wMaxPacketSizeTx)
+				if (hw_ep->max_packet_sz_tx)
 					nuke(&hw_ep->ep_in, -ESHUTDOWN);
 				if (hw_ep->wMaxPacketSizeRx)
 					nuke(&hw_ep->ep_out, -ESHUTDOWN);
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -740,7 +740,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			if (can_bulk_split(musb, qh->type))
 				musb_writew(epio, MGC_O_HDRC_TXMAXP,
 					wPacketSize
-					| ((hw_ep->wMaxPacketSizeTx /
+					| ((hw_ep->max_packet_sz_tx /
 						wPacketSize) - 1) << 11);
 			else
 				musb_writew(epio, MGC_O_HDRC_TXMAXP,
@@ -754,7 +754,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		}
 
 		if (can_bulk_split(musb, qh->type))
-			wLoadCount = min((u32) hw_ep->wMaxPacketSizeTx,
+			wLoadCount = min((u32) hw_ep->max_packet_sz_tx,
 						dwLength);
 		else
 			wLoadCount = min((u32) wPacketSize, dwLength);
@@ -1718,7 +1718,7 @@ static int musb_schedule(
 		if (is_in)
 			diff = hw_ep->wMaxPacketSizeRx - qh->maxpacket;
 		else
-			diff = hw_ep->wMaxPacketSizeTx - qh->maxpacket;
+			diff = hw_ep->max_packet_sz_tx - qh->maxpacket;
 
 		if (diff > 0 && wBestDiff > diff) {
 			wBestDiff = diff;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -269,7 +269,7 @@ struct musb_hw_ep {
 	u8			is_shared_fifo;
 	u8			tx_double_buffered;
 	u8			rx_double_buffered;
-	u16			wMaxPacketSizeTx;
+	u16			max_packet_sz_tx;
 	u16			wMaxPacketSizeRx;
 
 	struct dma_channel	*tx_channel;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1059,7 +1059,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		musb_writeb(mbase, MGC_O_HDRC_TXFIFOSZ, c_size);
 		musb_writew(mbase, MGC_O_HDRC_TXFIFOADD, c_off);
 		hw_ep->tx_double_buffered = !!(c_size & MGC_M_FIFOSZ_DPB);
-		hw_ep->wMaxPacketSizeTx = maxpacket;
+		hw_ep->max_packet_sz_tx = maxpacket;
 		break;
 	case FIFO_RX:
 		musb_writeb(mbase, MGC_O_HDRC_RXFIFOSZ, c_size);
@@ -1076,7 +1076,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		musb_writeb(mbase, MGC_O_HDRC_RXFIFOSZ, c_size);
 		musb_writew(mbase, MGC_O_HDRC_RXFIFOADD, c_off);
 		hw_ep->tx_double_buffered = hw_ep->rx_double_buffered;
-		hw_ep->wMaxPacketSizeTx = maxpacket;
+		hw_ep->max_packet_sz_tx = maxpacket;
 
 		hw_ep->is_shared_fifo = TRUE;
 		break;
@@ -1199,11 +1199,11 @@ static int __init ep_config_from_hw(struct musb *musb)
 		musb->nr_endpoints++;
 		musb->wEndMask |= (1 << epnum);
 
-		hw_ep->wMaxPacketSizeTx = 1 << (reg & 0x0f);
+		hw_ep->max_packet_sz_tx = 1 << (reg & 0x0f);
 
 		/* shared TX/RX FIFO? */
 		if ((reg & 0xf0) == 0xf0) {
-			hw_ep->wMaxPacketSizeRx = hw_ep->wMaxPacketSizeTx;
+			hw_ep->wMaxPacketSizeRx = hw_ep->max_packet_sz_tx;
 			hw_ep->is_shared_fifo = TRUE;
 			continue;
 		} else {
@@ -1215,7 +1215,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 		/* pick an RX/TX endpoint for bulk */
-		if (hw_ep->wMaxPacketSizeTx < 512
+		if (hw_ep->max_packet_sz_tx < 512
 				|| hw_ep->wMaxPacketSizeRx < 512)
 			continue;
 
@@ -1334,7 +1334,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 			musb_driver_name, type, aRevision, aDate);
 
 	/* configure ep0 */
-	musb->endpoints[0].wMaxPacketSizeTx = MGC_END0_FIFOSIZE;
+	musb->endpoints[0].max_packet_sz_tx = MGC_END0_FIFOSIZE;
 	musb->endpoints[0].wMaxPacketSizeRx = MGC_END0_FIFOSIZE;
 
 	/* discover endpoint configuration */
@@ -1384,14 +1384,14 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 		hw_ep->tx_reinit = 1;
 #endif
 
-		if (hw_ep->wMaxPacketSizeTx) {
+		if (hw_ep->max_packet_sz_tx) {
 			printk(KERN_DEBUG
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
 				hw_ep->is_shared_fifo ? "shared" : "tx",
 				hw_ep->tx_double_buffered
 					? "doublebuffer, " : "",
-				hw_ep->wMaxPacketSizeTx);
+				hw_ep->max_packet_sz_tx);
 		}
 		if (hw_ep->wMaxPacketSizeRx && !hw_ep->is_shared_fifo) {
 			printk(KERN_DEBUG
@@ -1402,7 +1402,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 					? "doublebuffer, " : "",
 				hw_ep->wMaxPacketSizeRx);
 		}
-		if (!(hw_ep->wMaxPacketSizeTx || hw_ep->wMaxPacketSizeRx))
+		if (!(hw_ep->max_packet_sz_tx || hw_ep->wMaxPacketSizeRx))
 			DBG(1, "hw_ep %d not configured\n", i);
 	}
 
-- 
1.5.2.3
