From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 21/36] musb_hdrc: Search and replace wVal with val,
	except for wValue
Date: Thu, 16 Aug 2007 02:40:44 -0700
Message-ID: <11872573092269-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573062287-git-send-email-tony@atomide.com>
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

Search and replace wVal with val, except for wValue

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 58499ee..837fbbf 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1386,7 +1386,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	size_t			xfer_len;
 	void __iomem		*mbase = musb->mregs;
 	int			pipe;
-	u16			rx_csr, wVal;
+	u16			rx_csr, val;
 	u8			iso_err = FALSE;
 	u8			done = FALSE;
 	u32			status;
@@ -1399,14 +1399,14 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	status = 0;
 	xfer_len = 0;
 
-	wVal = rx_csr = musb_readw(epio, MUSB_RXCSR);
+	val = rx_csr = musb_readw(epio, MUSB_RXCSR);
 
 	if (unlikely(!urb)) {
 		/* REVISIT -- THIS SHOULD NEVER HAPPEN ... but, at least
 		 * usbtest #11 (unlinks) triggers it regularly, sometimes
 		 * with fifo full.  (Only with DMA??)
 		 */
-		DBG(3, "BOGUS RX%d ready, csr %04x, count %d\n", epnum, wVal,
+		DBG(3, "BOGUS RX%d ready, csr %04x, count %d\n", epnum, val,
 			musb_readw(epio, MUSB_RXCOUNT));
 		musb_h_flush_rxfifo(hw_ep, MUSB_RXCSR_CLRDATATOG);
 		return;
@@ -1509,11 +1509,11 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	if (dma && (rx_csr & MUSB_RXCSR_DMAENAB)) {
 		xfer_len = dma->actual_len;
 
-		wVal &= ~(MUSB_RXCSR_DMAENAB
+		val &= ~(MUSB_RXCSR_DMAENAB
 			| MUSB_RXCSR_H_AUTOREQ
 			| MUSB_RXCSR_AUTOCLEAR
 			| MUSB_RXCSR_RXPKTRDY);
-		musb_writew(hw_ep->regs, MUSB_RXCSR, wVal);
+		musb_writew(hw_ep->regs, MUSB_RXCSR, val);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 		/* done if urb buffer is full or short packet is recd */
@@ -1523,9 +1523,9 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 		/* send IN token for next packet, without AUTOREQ */
 		if (!done) {
-			wVal |= MUSB_RXCSR_H_REQPKT;
+			val |= MUSB_RXCSR_H_REQPKT;
 			musb_writew(epio, MUSB_RXCSR,
-				MUSB_RXCSR_H_WZC_BITS | wVal);
+				MUSB_RXCSR_H_WZC_BITS | val);
 		}
 
 		DBG(4, "ep %d dma %s, rxcsr %04x, rxcount %d\n", epnum,
@@ -1546,8 +1546,8 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 // SCRUB (RX)
 			/* do the proper sequence to abort the transfer */
 			musb_ep_select(mbase, epnum);
-			wVal &= ~MUSB_RXCSR_H_REQPKT;
-			musb_writew(epio, MUSB_RXCSR, wVal);
+			val &= ~MUSB_RXCSR_H_REQPKT;
+			musb_writew(epio, MUSB_RXCSR, val);
 			goto finish;
 		}
 
@@ -1599,17 +1599,17 @@ void musb_host_rx(struct musb *musb, u8 epnum)
  *	wait for an interrupt when the pkt is recd. Well, you won't get any!
  */
 
-			wVal = musb_readw(epio, MUSB_RXCSR);
-			wVal &= ~MUSB_RXCSR_H_REQPKT;
+			val = musb_readw(epio, MUSB_RXCSR);
+			val &= ~MUSB_RXCSR_H_REQPKT;
 
 			if (dma->desired_mode == 0)
-				wVal &= ~MUSB_RXCSR_H_AUTOREQ;
+				val &= ~MUSB_RXCSR_H_AUTOREQ;
 			else
-				wVal |= MUSB_RXCSR_H_AUTOREQ;
-			wVal |= MUSB_RXCSR_AUTOCLEAR | MUSB_RXCSR_DMAENAB;
+				val |= MUSB_RXCSR_H_AUTOREQ;
+			val |= MUSB_RXCSR_AUTOCLEAR | MUSB_RXCSR_DMAENAB;
 
 			musb_writew(epio, MUSB_RXCSR,
-				MUSB_RXCSR_H_WZC_BITS | wVal);
+				MUSB_RXCSR_H_WZC_BITS | val);
 
 			/* REVISIT if when actual_length != 0,
 			 * transfer_buffer_length needs to be
-- 
1.5.2.3
