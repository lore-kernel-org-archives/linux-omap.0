From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 25/52] musb_hdrc: Search and replace wMaxPacketSizeRx with
	max_packet_sz_rx
Date: Mon, 13 Aug 2007 06:49:00 -0700
Message-ID: <1187013029823-git-send-email-tony@atomide.com>
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
	<11870130272865-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11870130272865-git-send-email-tony@atomide.com>
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

Search and replace wMaxPacketSizeRx with max_packet_sz_rx

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |    8 ++++----
 drivers/usb/musb/musb_host.c   |    2 +-
 drivers/usb/musb/musbdefs.h    |    2 +-
 drivers/usb/musb/plat_uds.c    |   18 +++++++++---------
 4 files changed, 15 insertions(+), 15 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -930,7 +930,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			musb_ep->is_in = 0;
 		if (musb_ep->is_in)
 			goto fail;
-		if (tmp > hw_ep->wMaxPacketSizeRx)
+		if (tmp > hw_ep->max_packet_sz_rx)
 			goto fail;
 
 		wIntrRxE |= (1 << epnum);
@@ -1581,7 +1581,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 		if (is_in)
 			ep->end_point.maxpacket = hw_ep->max_packet_sz_tx;
 		else
-			ep->end_point.maxpacket = hw_ep->wMaxPacketSizeRx;
+			ep->end_point.maxpacket = hw_ep->max_packet_sz_rx;
 		ep->end_point.ops = &musb_ep_ops;
 		list_add_tail(&ep->end_point.ep_list, &musb->g.ep_list);
 	}
@@ -1612,7 +1612,7 @@ static inline void __init musb_g_init_endpoints(struct musb *musb)
 							epnum, 1);
 				count++;
 			}
-			if (hw_ep->wMaxPacketSizeRx) {
+			if (hw_ep->max_packet_sz_rx) {
 				init_peripheral_ep(musb, &hw_ep->ep_out,
 							epnum, 0);
 				count++;
@@ -1805,7 +1805,7 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 			} else {
 				if (hw_ep->max_packet_sz_tx)
 					nuke(&hw_ep->ep_in, -ESHUTDOWN);
-				if (hw_ep->wMaxPacketSizeRx)
+				if (hw_ep->max_packet_sz_rx)
 					nuke(&hw_ep->ep_out, -ESHUTDOWN);
 			}
 		}
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1716,7 +1716,7 @@ static int musb_schedule(
 			continue;
 
 		if (is_in)
-			diff = hw_ep->wMaxPacketSizeRx - qh->maxpacket;
+			diff = hw_ep->max_packet_sz_rx - qh->maxpacket;
 		else
 			diff = hw_ep->max_packet_sz_tx - qh->maxpacket;
 
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -270,7 +270,7 @@ struct musb_hw_ep {
 	u8			tx_double_buffered;
 	u8			rx_double_buffered;
 	u16			max_packet_sz_tx;
-	u16			wMaxPacketSizeRx;
+	u16			max_packet_sz_rx;
 
 	struct dma_channel	*tx_channel;
 	struct dma_channel	*rx_channel;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1065,13 +1065,13 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		musb_writeb(mbase, MGC_O_HDRC_RXFIFOSZ, c_size);
 		musb_writew(mbase, MGC_O_HDRC_RXFIFOADD, c_off);
 		hw_ep->rx_double_buffered = !!(c_size & MGC_M_FIFOSZ_DPB);
-		hw_ep->wMaxPacketSizeRx = maxpacket;
+		hw_ep->max_packet_sz_rx = maxpacket;
 		break;
 	case FIFO_RXTX:
 		musb_writeb(mbase, MGC_O_HDRC_TXFIFOSZ, c_size);
 		musb_writew(mbase, MGC_O_HDRC_TXFIFOADD, c_off);
 		hw_ep->rx_double_buffered = !!(c_size & MGC_M_FIFOSZ_DPB);
-		hw_ep->wMaxPacketSizeRx = maxpacket;
+		hw_ep->max_packet_sz_rx = maxpacket;
 
 		musb_writeb(mbase, MGC_O_HDRC_RXFIFOSZ, c_size);
 		musb_writew(mbase, MGC_O_HDRC_RXFIFOADD, c_off);
@@ -1203,11 +1203,11 @@ static int __init ep_config_from_hw(struct musb *musb)
 
 		/* shared TX/RX FIFO? */
 		if ((reg & 0xf0) == 0xf0) {
-			hw_ep->wMaxPacketSizeRx = hw_ep->max_packet_sz_tx;
+			hw_ep->max_packet_sz_rx = hw_ep->max_packet_sz_tx;
 			hw_ep->is_shared_fifo = TRUE;
 			continue;
 		} else {
-			hw_ep->wMaxPacketSizeRx = 1 << ((reg & 0xf0) >> 4);
+			hw_ep->max_packet_sz_rx = 1 << ((reg & 0xf0) >> 4);
 			hw_ep->is_shared_fifo = FALSE;
 		}
 
@@ -1216,7 +1216,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 		/* pick an RX/TX endpoint for bulk */
 		if (hw_ep->max_packet_sz_tx < 512
-				|| hw_ep->wMaxPacketSizeRx < 512)
+				|| hw_ep->max_packet_sz_rx < 512)
 			continue;
 
 		/* REVISIT:  this algorithm is lazy, we should at least
@@ -1335,7 +1335,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 
 	/* configure ep0 */
 	musb->endpoints[0].max_packet_sz_tx = MGC_END0_FIFOSIZE;
-	musb->endpoints[0].wMaxPacketSizeRx = MGC_END0_FIFOSIZE;
+	musb->endpoints[0].max_packet_sz_rx = MGC_END0_FIFOSIZE;
 
 	/* discover endpoint configuration */
 	musb->nr_endpoints = 1;
@@ -1393,16 +1393,16 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 					? "doublebuffer, " : "",
 				hw_ep->max_packet_sz_tx);
 		}
-		if (hw_ep->wMaxPacketSizeRx && !hw_ep->is_shared_fifo) {
+		if (hw_ep->max_packet_sz_rx && !hw_ep->is_shared_fifo) {
 			printk(KERN_DEBUG
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
 				"rx",
 				hw_ep->rx_double_buffered
 					? "doublebuffer, " : "",
-				hw_ep->wMaxPacketSizeRx);
+				hw_ep->max_packet_sz_rx);
 		}
-		if (!(hw_ep->max_packet_sz_tx || hw_ep->wMaxPacketSizeRx))
+		if (!(hw_ep->max_packet_sz_tx || hw_ep->max_packet_sz_rx))
 			DBG(1, "hw_ep %d not configured\n", i);
 	}
 
-- 
1.5.2.3
