From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/36] musb_hdrc: Search and replace wLoadCount with
	load_count
Date: Thu, 16 Aug 2007 02:40:39 -0700
Message-ID: <11872572962771-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187257294890-git-send-email-tony@atomide.com>
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

Search and replace wLoadCount with load_count

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 093edc1..240c9fc 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -674,7 +674,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	if (is_out) {
 		u16	csr;
 		u16	int_txe;
-		u16	wLoadCount;
+		u16	load_count;
 
 		csr = musb_readw(epio, MUSB_TXCSR);
 
@@ -754,10 +754,10 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		}
 
 		if (can_bulk_split(musb, qh->type))
-			wLoadCount = min((u32) hw_ep->max_packet_sz_tx,
+			load_count = min((u32) hw_ep->max_packet_sz_tx,
 						len);
 		else
-			wLoadCount = min((u32) packet_sz, len);
+			load_count = min((u32) packet_sz, len);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 		if (dma_channel) {
@@ -797,7 +797,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					urb->transfer_dma,
 					qh->segsize);
 			if (bDmaOk) {
-				wLoadCount = 0;
+				load_count = 0;
 			} else {
 				dma_controller->channel_release(dma_channel);
 				if (is_out)
@@ -838,7 +838,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					urb->transfer_dma,
 					qh->segsize);
 			if (bDmaOk) {
-				wLoadCount = 0;
+				load_count = 0;
 			} else {
 				dma_controller->channel_release(dma_channel);
 				dma_channel = hw_ep->tx_channel = NULL;
@@ -850,12 +850,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			}
 		}
 
-		if (wLoadCount) {
+		if (load_count) {
 			/* ASSERT:  TXCSR_DMAENAB was already cleared */
 
 			/* PIO to load FIFO */
-			qh->segsize = wLoadCount;
-			musb_write_fifo(hw_ep, wLoadCount, buf);
+			qh->segsize = load_count;
+			musb_write_fifo(hw_ep, load_count, buf);
 			csr = musb_readw(epio, MUSB_TXCSR);
 			csr &= ~(MUSB_TXCSR_DMAENAB
 				| MUSB_TXCSR_DMAMODE
-- 
1.5.2.3
