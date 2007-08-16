From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 25/36] musb_hdrc: Search and replace wFrame with frame
Date: Thu, 16 Aug 2007 02:40:48 -0700
Message-ID: <1187257318333-git-send-email-tony@atomide.com>
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
	<11872573092269-git-send-email-tony@atomide.com>
	<1187257311394-git-send-email-tony@atomide.com>
	<11872573133142-git-send-email-tony@atomide.com>
	<11872573161558-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573161558-git-send-email-tony@atomide.com>
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

Search and replace wFrame with frame

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |    6 +++---
 drivers/usb/musb/plat_uds.c  |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 1f3ef7b..68c7ca1 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -169,7 +169,7 @@ static inline void cppi_host_txdma_start(struct musb_hw_ep *ep)
 static void
 musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 {
-	u16			wFrame;
+	u16			frame;
 	u32			len;
 	void			*buf;
 	void __iomem		*mbase =  musb->mregs;
@@ -232,12 +232,12 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	case USB_ENDPOINT_XFER_INT:
 		DBG(3, "check whether there's still time for periodic Tx\n");
 		qh->iso_idx = 0;
-		wFrame = musb_readw(mbase, MUSB_FRAME);
+		frame = musb_readw(mbase, MUSB_FRAME);
 		/* FIXME this doesn't implement that scheduling policy ...
 		 * or handle framecounter wrapping
 		 */
 		if ((urb->transfer_flags & URB_ISO_ASAP)
-				|| (wFrame >= urb->start_frame)) {
+				|| (frame >= urb->start_frame)) {
 			/* REVISIT the SOF irq handler shouldn't duplicate
 			 * this code; and we don't init urb->start_frame...
 			 */
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 1ea7803..e17ee52 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -663,20 +663,20 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 int_usb,
 		void __iomem *mbase = musb->mregs;
 		struct musb_hw_ep	*ep;
 		u8 epnum;
-		u16 wFrame;
+		u16 frame;
 
 		DBG(6, "START_OF_FRAME\n");
 		handled = IRQ_HANDLED;
 
 		/* start any periodic Tx transfers waiting for current frame */
-		wFrame = musb_readw(mbase, MUSB_FRAME);
+		frame = musb_readw(mbase, MUSB_FRAME);
 		ep = musb->endpoints;
 		for (epnum = 1; (epnum < musb->nr_endpoints)
 					&& (musb->epmask >= (1 << epnum));
 				epnum++, ep++) {
 			// FIXME handle framecounter wraps (12 bits)
 			// eliminate duplicated StartUrb logic
-			if (ep->dwWaitFrame >= wFrame) {
+			if (ep->dwWaitFrame >= frame) {
 				ep->dwWaitFrame = 0;
 				printk("SOF --> periodic TX%s on %d\n",
 					ep->tx_channel ? " DMA" : "",
-- 
1.5.2.3
