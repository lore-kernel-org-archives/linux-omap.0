From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 17/36] musb_hdrc: Search and replace bDmaOk with dma_ok
Date: Thu, 16 Aug 2007 02:40:40 -0700
Message-ID: <11872572981150-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11872572962771-git-send-email-tony@atomide.com>
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

Search and replace bDmaOk with dma_ok

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 240c9fc..5268d9b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -629,7 +629,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 {
 	struct dma_controller	*dma_controller;
 	struct dma_channel	*dma_channel;
-	u8			bDmaOk;
+	u8			dma_ok;
 	void __iomem		*mbase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
 	void __iomem		*epio = hw_ep->regs;
@@ -791,12 +791,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 			musb_writew(epio, MUSB_TXCSR, csr);
 
-			bDmaOk = dma_controller->channel_program(
+			dma_ok = dma_controller->channel_program(
 					dma_channel, packet_sz,
 					dma_channel->desired_mode,
 					urb->transfer_dma,
 					qh->segsize);
-			if (bDmaOk) {
+			if (dma_ok) {
 				load_count = 0;
 			} else {
 				dma_controller->channel_release(dma_channel);
@@ -830,14 +830,14 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			/* TX uses "rndis" mode automatically, but needs help
 			 * to identify the zero-length-final-packet case.
 			 */
-			bDmaOk = dma_controller->channel_program(
+			dma_ok = dma_controller->channel_program(
 					dma_channel, packet_sz,
 					(urb->transfer_flags
 							& URB_ZERO_PACKET)
 						== URB_ZERO_PACKET,
 					urb->transfer_dma,
 					qh->segsize);
-			if (bDmaOk) {
+			if (dma_ok) {
 				load_count = 0;
 			} else {
 				dma_controller->channel_release(dma_channel);
@@ -915,13 +915,13 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				/* unless caller treats short rx transfers as
 				 * errors, we dare not queue multiple transfers.
 				 */
-				bDmaOk = dma_controller->channel_program(
+				dma_ok = dma_controller->channel_program(
 						dma_channel, packet_sz,
 						!(urb->transfer_flags
 							& URB_SHORT_NOT_OK),
 						urb->transfer_dma,
 						qh->segsize);
-				if (!bDmaOk) {
+				if (!dma_ok) {
 					dma_controller->channel_release(
 							dma_channel);
 					dma_channel = hw_ep->rx_channel = NULL;
-- 
1.5.2.3
