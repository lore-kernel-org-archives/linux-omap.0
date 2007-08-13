From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/52] musb_hdrc: Search and replace bEndNumber with
	current_epnum
Date: Mon, 13 Aug 2007 06:48:50 -0700
Message-ID: <11870130052666-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130023665-git-send-email-tony@atomide.com>
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

Search and replace bEndNumber with current_epnum

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |   20 ++++++++++----------
 drivers/usb/musb/musb_gadget.h |    2 +-
 drivers/usb/musb/musb_procfs.c |   10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -159,7 +159,7 @@ __acquires(ep->musb->Lock)
 static void nuke(struct musb_ep *ep, const int status)
 {
 	struct musb_request	*req = NULL;
-	void __iomem *epio = ep->musb->endpoints[ep->bEndNumber].regs;
+	void __iomem *epio = ep->musb->endpoints[ep->current_epnum].regs;
 
 	ep->busy = 1;
 
@@ -869,7 +869,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	regs = hw_ep->regs;
 	musb = musb_ep->musb;
 	mbase = musb->mregs;
-	bEnd = musb_ep->bEndNumber;
+	bEnd = musb_ep->current_epnum;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 
@@ -1006,7 +1006,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 
 	musb_ep = to_musb_ep(ep);
 	musb = musb_ep->musb;
-	bEnd = musb_ep->bEndNumber;
+	bEnd = musb_ep->current_epnum;
 	epio = musb->endpoints[bEnd].regs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
@@ -1052,7 +1052,7 @@ struct usb_request *musb_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	if (pRequest) {
 		INIT_LIST_HEAD(&pRequest->request.list);
 		pRequest->request.dma = DMA_ADDR_INVALID;
-		pRequest->bEnd = musb_ep->bEndNumber;
+		pRequest->bEnd = musb_ep->current_epnum;
 		pRequest->ep = musb_ep;
 	}
 
@@ -1121,7 +1121,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	/* request is mine now... */
 	pRequest->request.actual = 0;
 	pRequest->request.status = -EINPROGRESS;
-	pRequest->bEnd = musb_ep->bEndNumber;
+	pRequest->bEnd = musb_ep->current_epnum;
 	pRequest->bTx = musb_ep->is_in;
 
 	if (is_dma_capable() && musb_ep->dma) {
@@ -1201,7 +1201,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 	else if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->pDmaController;
 
-		MGC_SelectEnd(musb->mregs, musb_ep->bEndNumber);
+		MGC_SelectEnd(musb->mregs, musb_ep->current_epnum);
 		if (c->channel_abort)
 			status = c->channel_abort(musb_ep->dma);
 		else
@@ -1229,7 +1229,7 @@ done:
 int musb_gadget_set_halt(struct usb_ep *ep, int value)
 {
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
-	u8			bEnd = musb_ep->bEndNumber;
+	u8			bEnd = musb_ep->current_epnum;
 	struct musb		*musb = musb_ep->musb;
 	void __iomem		*epio = musb->endpoints[bEnd].regs;
 	void __iomem		*mbase;
@@ -1311,7 +1311,7 @@ static int musb_gadget_fifo_status(struct usb_ep *ep)
 
 	if (musb_ep->desc && !musb_ep->is_in) {
 		struct musb		*musb = musb_ep->musb;
-		int			bEnd = musb_ep->bEndNumber;
+		int			bEnd = musb_ep->current_epnum;
 		void __iomem		*mbase = musb->mregs;
 		unsigned long		flags;
 
@@ -1330,7 +1330,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 {
 	struct musb_ep	*musb_ep = to_musb_ep(ep);
 	struct musb	*musb = musb_ep->musb;
-	u8		nEnd = musb_ep->bEndNumber;
+	u8		nEnd = musb_ep->current_epnum;
 	void __iomem	*epio = musb->endpoints[nEnd].regs;
 	void __iomem	*mbase;
 	unsigned long	flags;
@@ -1561,7 +1561,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 bEnd, int is_in)
 
 	memset(ep, 0, sizeof *ep);
 
-	ep->bEndNumber = bEnd;
+	ep->current_epnum = bEnd;
 	ep->musb = musb;
 	ep->hw_ep = hw_ep;
 	ep->is_in = is_in;
--- a/drivers/usb/musb/musb_gadget.h
+++ b/drivers/usb/musb/musb_gadget.h
@@ -62,7 +62,7 @@ struct musb_ep {
 	char				name[12];
 	struct musb_hw_ep		*hw_ep;
 	struct musb			*musb;
-	u8				bEndNumber;
+	u8				current_epnum;
 
 	/* ... when enabled/disabled ... */
 	u8				type;
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -153,10 +153,10 @@ static int dump_ep(struct musb_ep *ep, char *buffer, unsigned max)
 
 		code = snprintf(buf, max,
 				"\n%s (hw%d): %s%s, csr %04x maxp %04x\n",
-				ep->name, ep->bEndNumber,
+				ep->name, ep->current_epnum,
 				mode, ep->dma ? " dma" : "",
 				musb_readw(regs,
-					(ep->is_in || !ep->bEndNumber)
+					(ep->is_in || !ep->current_epnum)
 						? MGC_O_HDRC_TXCSR
 						: MGC_O_HDRC_RXCSR),
 				musb_readw(regs, ep->is_in
@@ -169,8 +169,8 @@ static int dump_ep(struct musb_ep *ep, char *buffer, unsigned max)
 		buf += code;
 		max -= code;
 
-		if (is_cppi_enabled() && ep->bEndNumber) {
-			unsigned	cppi = ep->bEndNumber - 1;
+		if (is_cppi_enabled() && ep->current_epnum) {
+			unsigned	cppi = ep->current_epnum - 1;
 			void __iomem	*base = ep->musb->ctrl_base;
 			unsigned	off1 = cppi << 2;
 			void __iomem	*ram = base;
@@ -190,7 +190,7 @@ static int dump_ep(struct musb_ep *ep, char *buffer, unsigned max)
 					"%08x %08x, %08x %08x; "
 					"%08x %08x %08x .. %08x\n",
 				ep->is_in ? 'T' : 'R',
-				ep->bEndNumber - 1, tmp,
+				ep->current_epnum - 1, tmp,
 				musb_readl(ram, 0 * 4),
 				musb_readl(ram, 1 * 4),
 				musb_readl(ram, 2 * 4),
-- 
1.5.2.3
