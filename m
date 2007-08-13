From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 50/52] musb_hdrc: Search and replace bTx with tx
Date: Mon, 13 Aug 2007 06:49:25 -0700
Message-ID: <11870131023809-git-send-email-tony@atomide.com>
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
	<1187013029823-git-send-email-tony@atomide.com>
	<11870130314189-git-send-email-tony@atomide.com>
	<11870130343298-git-send-email-tony@atomide.com>
	<11870130371106-git-send-email-tony@atomide.com>
	<11870130411622-git-send-email-tony@atomide.com>
	<1187013048432-git-send-email-tony@atomide.com>
	<11870130521115-git-send-email-tony@atomide.com>
	<11870130543254-git-send-email-tony@atomide.com>
	<11870130573814-git-send-email-tony@atomide.com>
	<1187013062890-git-send-email-tony@atomide.com>
	<11870130643220-git-send-email-tony@atomide.com>
	<1187013066263-git-send-email-tony@atomide.com>
	<11870130701028-git-send-email-tony@atomide.com>
	<1187013072449-git-send-email-tony@atomide.com>
	<11870130741506-git-send-email-tony@atomide.com>
	<11870130771666-git-send-email-tony@atomide.com>
	<11870130793168-git-send-email-tony@atomide.com>
	<11870130811602-git-send-email-tony@atomide.com>
	<1187013084570-git-send-email-tony@atomide.com>
	<11870130862981-git-send-email-tony@atomide.com>
	<11870130891386-git-send-email-tony@atomide.com>
	<11870130913983-git-send-email-tony@atomide.com>
	<11870130932989-git-send-email-tony@atomide.com>
	<11870130953685-git-send-email-tony@atomide.com>
	<118701309984-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <118701309984-git-send-email-tony@atomide.com>
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

Search and replace bTx with tx

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |    2 +-
 drivers/usb/musb/musb_gadget.c |   14 +++++++-------
 drivers/usb/musb/musb_gadget.h |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -835,7 +835,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	req->musb = musb;
 	req->request.actual = 0;
 	req->request.status = -EINPROGRESS;
-	req->bTx = ep->is_in;
+	req->tx = ep->is_in;
 
 	spin_lock_irqsave(&musb->lock, lockflags);
 
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -123,7 +123,7 @@ __acquires(ep->musb->lock)
 			dma_unmap_single(musb->controller,
 					req->request.dma,
 					req->request.length,
-					req->bTx
+					req->tx
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
 			req->request.dma = DMA_ADDR_INVALID;
@@ -132,7 +132,7 @@ __acquires(ep->musb->lock)
 			dma_sync_single_for_cpu(musb->controller,
 					req->request.dma,
 					req->request.length,
-					req->bTx
+					req->tx
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
 	}
@@ -1083,11 +1083,11 @@ struct free_record {
 static void musb_ep_restart(struct musb *musb, struct musb_request *req)
 {
 	DBG(3, "<== %s request %p len %u on hw_ep%d\n",
-		req->bTx ? "TX/IN" : "RX/OUT",
+		req->tx ? "TX/IN" : "RX/OUT",
 		&req->request, req->request.length, req->epnum);
 
 	musb_ep_select(musb->mregs, req->epnum);
-	if (req->bTx)
+	if (req->tx)
 		txstate(musb, req);
 	else
 		rxstate(musb, req);
@@ -1122,7 +1122,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	request->request.actual = 0;
 	request->request.status = -EINPROGRESS;
 	request->epnum = musb_ep->current_epnum;
-	request->bTx = musb_ep->is_in;
+	request->tx = musb_ep->is_in;
 
 	if (is_dma_capable() && musb_ep->dma) {
 		if (request->request.dma == DMA_ADDR_INVALID) {
@@ -1130,7 +1130,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 					musb->controller,
 					request->request.buf,
 					request->request.length,
-					request->bTx
+					request->tx
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
 			request->mapped = 1;
@@ -1138,7 +1138,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 			dma_sync_single_for_device(musb->controller,
 					request->request.dma,
 					request->request.length,
-					request->bTx
+					request->tx
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
 			request->mapped = 0;
--- a/drivers/usb/musb/musb_gadget.h
+++ b/drivers/usb/musb/musb_gadget.h
@@ -38,7 +38,7 @@ struct musb_request {
 	struct usb_request	request;
 	struct musb_ep		*ep;
 	struct musb		*musb;
-	u8 bTx;			/* endpoint direction */
+	u8 tx;			/* endpoint direction */
 	u8 epnum;
 	u8 mapped;
 };
-- 
1.5.2.3
