From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/52] musb_hdrc: Search and replace pRegs with mregs
Date: Mon, 13 Aug 2007 06:48:40 -0700
Message-ID: <1187012980445-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870129782148-git-send-email-tony@atomide.com>
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

Search and replace pRegs with mregs

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/davinci.c       |   10 +++---
 drivers/usb/musb/g_ep0.c         |   12 ++++----
 drivers/usb/musb/musb_gadget.c   |   42 ++++++++++++++--------------
 drivers/usb/musb/musb_host.c     |   16 +++++-----
 drivers/usb/musb/musb_procfs.c   |   18 ++++++------
 drivers/usb/musb/musbdefs.h      |    4 +-
 drivers/usb/musb/musbhdrc.h      |    2 +-
 drivers/usb/musb/omap2430.c      |    6 ++--
 drivers/usb/musb/plat_uds.c      |   54 +++++++++++++++++++-------------------
 drivers/usb/musb/tusb6010.c      |   14 +++++-----
 drivers/usb/musb/tusb6010_omap.c |    4 +-
 drivers/usb/musb/virthub.c       |   12 ++++----
 12 files changed, 97 insertions(+), 97 deletions(-)

--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -116,7 +116,7 @@ void musb_platform_disable(struct musb *musb)
 			  DAVINCI_USB_USBINT_MASK
 			| DAVINCI_USB_TXINT_MASK
 			| DAVINCI_USB_RXINT_MASK);
-	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, 0);
 	musb_writel(musb->ctrl_base, DAVINCI_USB_EOI_REG, 0);
 
 	if (is_dma_capable() && !dma_off)
@@ -200,7 +200,7 @@ static struct timer_list otg_workaround;
 static void otg_timer(unsigned long _musb)
 {
 	struct musb		*musb = (void *)_musb;
-	void	*__iomem	mregs = musb->pRegs;
+	void	*__iomem	mregs = musb->mregs;
 	u8			devctl;
 	unsigned long		flags;
 
@@ -309,7 +309,7 @@ static irqreturn_t davinci_interrupt(int irq, void *__hci)
 	 */
 	if (tmp & (DAVINCI_INTR_DRVVBUS << DAVINCI_USB_USBINT_SHIFT)) {
 		int	drvvbus = musb_readl(tibase, DAVINCI_USB_STAT_REG);
-		void	*__iomem mregs = musb->pRegs;
+		void	*__iomem mregs = musb->mregs;
 		u8	devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
 		int	err = musb->int_usb & MGC_M_INTR_VBUSERROR;
 
@@ -381,7 +381,7 @@ int __init musb_platform_init(struct musb *musb)
 	void	*__iomem tibase = musb->ctrl_base;
 	u32	revision;
 
-	musb->pRegs += DAVINCI_BASE_OFFSET;
+	musb->mregs += DAVINCI_BASE_OFFSET;
 #if 0
 	/* REVISIT there's something odd about clocking, this
 	 * didn't appear do the job ...
@@ -440,7 +440,7 @@ int musb_platform_exit(struct musb *musb)
 		 * long time to fall, especially on EVM with huge C133.
 		 */
 		do {
-			devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+			devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 			if (!(devctl & MGC_M_DEVCTL_VBUS))
 				break;
 			if ((devctl & MGC_M_DEVCTL_VBUS) != warn) {
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -74,7 +74,7 @@ static int service_tx_status_request(
 	struct musb *musb,
 	const struct usb_ctrlrequest *pControlRequest)
 {
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 	int handled = 1;
 	u8 bResult[2], bEnd = 0;
 	const u8 bRecip = pControlRequest->bRequestType & USB_RECIP_MASK;
@@ -205,7 +205,7 @@ static void musb_g_ep0_giveback(struct musb *musb, struct usb_request *req)
  */
 static inline void musb_try_b_hnp_enable(struct musb *musb)
 {
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 	u8		devctl;
 
 	DBG(1, "HNP: Setting HR\n");
@@ -230,7 +230,7 @@ __releases(musb->Lock)
 __acquires(musb->Lock)
 {
 	int handled = -EINVAL;
-	void __iomem *pBase = musb->pRegs;
+	void __iomem *pBase = musb->mregs;
 	const u8 bRecip = pControlRequest->bRequestType & USB_RECIP_MASK;
 
 	/* the gadget driver handles everything except what we MUST handle */
@@ -600,7 +600,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 {
 	u16		wCsrVal;
 	u16		wCount;
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 	void __iomem	*regs = musb->aLocalEnd[0].regs;
 	irqreturn_t	retval = IRQ_NONE;
 
@@ -864,7 +864,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 			ep->name, ep->is_in ? "IN/TX" : "OUT/RX",
 			req->request.length);
 
-	MGC_SelectEnd(musb->pRegs, 0);
+	MGC_SelectEnd(musb->mregs, 0);
 
 	/* sequence #1, IN ... start writing the data */
 	if (musb->ep0_state == MGC_END0_STAGE_TX)
@@ -917,7 +917,7 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 
 	ep = to_musb_ep(e);
 	musb = ep->musb;
-	base = musb->pRegs;
+	base = musb->mregs;
 	regs = musb->control_ep->regs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -406,7 +406,7 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 {
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
-	u8 __iomem		*pBase = musb->pRegs;
+	u8 __iomem		*pBase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_in;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
@@ -736,7 +736,7 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 {
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
-	void __iomem		*pBase = musb->pRegs;
+	void __iomem		*pBase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
@@ -868,7 +868,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	hw_ep = musb_ep->hw_ep;
 	regs = hw_ep->regs;
 	musb = musb_ep->musb;
-	pBase = musb->pRegs;
+	pBase = musb->mregs;
 	bEnd = musb_ep->bEndNumber;
 
 	spin_lock_irqsave(&musb->Lock, flags);
@@ -1010,18 +1010,18 @@ static int musb_gadget_disable(struct usb_ep *ep)
 	epio = musb->aLocalEnd[bEnd].regs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
-	MGC_SelectEnd(musb->pRegs, bEnd);
+	MGC_SelectEnd(musb->mregs, bEnd);
 
 	/* zero the endpoint sizes */
 	if (musb_ep->is_in) {
-		u16 wIntrTxE = musb_readw(musb->pRegs, MGC_O_HDRC_INTRTXE);
+		u16 wIntrTxE = musb_readw(musb->mregs, MGC_O_HDRC_INTRTXE);
 		wIntrTxE &= ~(1 << bEnd);
-		musb_writew(musb->pRegs, MGC_O_HDRC_INTRTXE, wIntrTxE);
+		musb_writew(musb->mregs, MGC_O_HDRC_INTRTXE, wIntrTxE);
 		musb_writew(epio, MGC_O_HDRC_TXMAXP, 0);
 	} else {
-		u16 wIntrRxE = musb_readw(musb->pRegs, MGC_O_HDRC_INTRRXE);
+		u16 wIntrRxE = musb_readw(musb->mregs, MGC_O_HDRC_INTRRXE);
 		wIntrRxE &= ~(1 << bEnd);
-		musb_writew(musb->pRegs, MGC_O_HDRC_INTRRXE, wIntrRxE);
+		musb_writew(musb->mregs, MGC_O_HDRC_INTRRXE, wIntrRxE);
 		musb_writew(epio, MGC_O_HDRC_RXMAXP, 0);
 	}
 
@@ -1086,7 +1086,7 @@ static void musb_ep_restart(struct musb *musb, struct musb_request *req)
 		req->bTx ? "TX/IN" : "RX/OUT",
 		&req->request, req->request.length, req->bEnd);
 
-	MGC_SelectEnd(musb->pRegs, req->bEnd);
+	MGC_SelectEnd(musb->mregs, req->bEnd);
 	if (req->bTx)
 		txstate(musb, req);
 	else
@@ -1201,7 +1201,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 	else if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->pDmaController;
 
-		MGC_SelectEnd(musb->pRegs, musb_ep->bEndNumber);
+		MGC_SelectEnd(musb->mregs, musb_ep->bEndNumber);
 		if (c->channel_abort)
 			status = c->channel_abort(musb_ep->dma);
 		else
@@ -1240,7 +1240,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 
 	if (!ep)
 		return -EINVAL;
-	pBase = musb->pRegs;
+	pBase = musb->mregs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 
@@ -1312,7 +1312,7 @@ static int musb_gadget_fifo_status(struct usb_ep *ep)
 	if (musb_ep->desc && !musb_ep->is_in) {
 		struct musb		*musb = musb_ep->musb;
 		int			bEnd = musb_ep->bEndNumber;
-		void __iomem		*mbase = musb->pRegs;
+		void __iomem		*mbase = musb->mregs;
 		unsigned long		flags;
 
 		spin_lock_irqsave(&musb->Lock, flags);
@@ -1336,7 +1336,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	unsigned long	flags;
 	u16		wCsr, wIntrTxE;
 
-	mbase = musb->pRegs;
+	mbase = musb->mregs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 	MGC_SelectEnd(mbase, (u8) nEnd);
@@ -1383,13 +1383,13 @@ static int musb_gadget_get_frame(struct usb_gadget *gadget)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
-	return (int)musb_readw(musb->pRegs, MGC_O_HDRC_FRAME);
+	return (int)musb_readw(musb->mregs, MGC_O_HDRC_FRAME);
 }
 
 static int musb_gadget_wakeup(struct usb_gadget *gadget)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
-	void __iomem	*mregs = musb->pRegs;
+	void __iomem	*mregs = musb->mregs;
 	unsigned long	flags;
 	int		status = -EINVAL;
 	u8		power, devctl;
@@ -1467,7 +1467,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 {
 	u8 power;
 
-	power = musb_readb(musb->pRegs, MGC_O_HDRC_POWER);
+	power = musb_readb(musb->mregs, MGC_O_HDRC_POWER);
 	if (is_on)
 		power |= MGC_M_POWER_SOFTCONN;
 	else
@@ -1477,7 +1477,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 
 	DBG(3, "gadget %s D+ pullup %s\n",
 		musb->pGadgetDriver->function, is_on ? "on" : "off");
-	musb_writeb(musb->pRegs, MGC_O_HDRC_POWER, power);
+	musb_writeb(musb->mregs, MGC_O_HDRC_POWER, power);
 }
 
 #if 0
@@ -1799,7 +1799,7 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 		for (i = 0, hw_ep = musb->aLocalEnd;
 				i < musb->bEndCount;
 				i++, hw_ep++) {
-			MGC_SelectEnd(musb->pRegs, i);
+			MGC_SelectEnd(musb->mregs, i);
 			if (hw_ep->bIsSharedFifo /* || !bEnd */) {
 				nuke(&hw_ep->ep_in, -ESHUTDOWN);
 			} else {
@@ -1902,7 +1902,7 @@ void musb_g_suspend(struct musb *musb)
 {
 	u8	devctl;
 
-	devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 	DBG(3, "devctl %02x\n", devctl);
 
 	switch (musb->xceiv.state) {
@@ -1936,7 +1936,7 @@ void musb_g_wakeup(struct musb *musb)
 /* called when VBUS drops below session threshold, and in other cases */
 void musb_g_disconnect(struct musb *musb)
 {
-	void __iomem	*mregs = musb->pRegs;
+	void __iomem	*mregs = musb->mregs;
 	u8	devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
 
 	DBG(3, "devctl %02x\n", devctl);
@@ -1979,7 +1979,7 @@ void musb_g_reset(struct musb *musb)
 __releases(musb->Lock)
 __acquires(musb->Lock)
 {
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 	u8		devctl = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
 	u8		power;
 
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -172,7 +172,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	u16			wFrame;
 	u32			dwLength;
 	void			*pBuffer;
-	void __iomem		*pBase =  musb->pRegs;
+	void __iomem		*pBase =  musb->mregs;
 	struct urb		*urb = next_urb(qh);
 	struct musb_hw_ep	*hw_ep = qh->hw_ep;
 	unsigned		nPipe = urb->pipe;
@@ -607,7 +607,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 		musb_writeb(ep->target_regs, MGC_O_HDRC_RXHUBPORT,
 			qh->h_port_reg);
 	} else
-		musb_writeb(musb->pRegs, MGC_O_HDRC_FADDR, qh->addr_reg);
+		musb_writeb(musb->mregs, MGC_O_HDRC_FADDR, qh->addr_reg);
 
 	/* protocol/endpoint, interval/NAKlimit, i/o size */
 	musb_writeb(ep->regs, MGC_O_HDRC_RXTYPE, qh->type_reg);
@@ -630,7 +630,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 	struct dma_controller	*pDmaController;
 	struct dma_channel	*pDmaChannel;
 	u8			bDmaOk;
-	void __iomem		*pBase = musb->pRegs;
+	void __iomem		*pBase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh;
@@ -1023,7 +1023,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	struct urb		*pUrb;
 	u16			wCsrVal, wCount;
 	int			status = 0;
-	void __iomem		*pBase = musb->pRegs;
+	void __iomem		*pBase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
@@ -1174,7 +1174,7 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->out_qh;
 	u32			status = 0;
-	void __iomem		*pBase = musb->pRegs;
+	void __iomem		*pBase = musb->mregs;
 	struct dma_channel	*dma;
 
 	pUrb = next_urb(qh);
@@ -1384,7 +1384,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
 	size_t			xfer_len;
-	void __iomem		*pBase = musb->pRegs;
+	void __iomem		*pBase = musb->mregs;
 	int			nPipe;
 	u16			wRxCsrVal, wVal;
 	u8			bIsochError = FALSE;
@@ -1904,7 +1904,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 	struct musb_hw_ep	*ep = qh->hw_ep;
 	void __iomem		*epio = ep->regs;
 	unsigned		hw_end = ep->bLocalEnd;
-	void __iomem		*regs = ep->musb->pRegs;
+	void __iomem		*regs = ep->musb->mregs;
 	u16			csr;
 	int			status = 0;
 
@@ -2107,7 +2107,7 @@ static int musb_h_get_frame_number(struct usb_hcd *hcd)
 {
 	struct musb	*musb = hcd_to_musb(hcd);
 
-	return musb_readw(musb->pRegs, MGC_O_HDRC_FRAME);
+	return musb_readw(musb->mregs, MGC_O_HDRC_FRAME);
 }
 
 static int musb_h_start(struct usb_hcd *hcd)
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -240,7 +240,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
 	struct musb_hw_ep	*hw_ep = &musb->aLocalEnd[bEnd];
 
 	do {
-		MGC_SelectEnd(musb->pRegs, bEnd);
+		MGC_SelectEnd(musb->mregs, bEnd);
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 		if (is_host_active(musb)) {
 			int		dump_rx, dump_tx;
@@ -284,13 +284,13 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
 					musb_readw(regs, MGC_O_HDRC_RXMAXP),
 					musb_readb(regs, MGC_O_HDRC_RXTYPE),
 					/* FIXME:  assumes multipoint */
-					musb_readb(musb->pRegs,
+					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(bEnd,
 						MGC_O_HDRC_RXFUNCADDR)),
-					musb_readb(musb->pRegs,
+					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(bEnd,
 						MGC_O_HDRC_RXHUBADDR)),
-					musb_readb(musb->pRegs,
+					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(bEnd,
 						MGC_O_HDRC_RXHUBPORT))
 					);
@@ -372,13 +372,13 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
 					musb_readw(regs, MGC_O_HDRC_TXMAXP),
 					musb_readb(regs, MGC_O_HDRC_TXTYPE),
 					/* FIXME:  assumes multipoint */
-					musb_readb(musb->pRegs,
+					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(bEnd,
 						MGC_O_HDRC_TXFUNCADDR)),
-					musb_readb(musb->pRegs,
+					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(bEnd,
 						MGC_O_HDRC_TXHUBADDR)),
-					musb_readb(musb->pRegs,
+					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(bEnd,
 						MGC_O_HDRC_TXHUBPORT))
 					);
@@ -485,7 +485,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
 static int dump_header_stats(struct musb *musb, char *buffer)
 {
 	int code, count = 0;
-	const void __iomem *pBase = musb->pRegs;
+	const void __iomem *pBase = musb->mregs;
 
 	*buffer = 0;
 	count = sprintf(buffer, "Status: %sHDRC, Mode=%s "
@@ -653,7 +653,7 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 	char cmd;
 	u8 bReg;
 	struct musb *musb = (struct musb *)data;
-	void __iomem *pBase = musb->pRegs;
+	void __iomem *pBase = musb->mregs;
 
 	/* MOD_INC_USE_COUNT; */
 
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -242,7 +242,7 @@ enum musb_g_ep0_state {
 	{ (_pthis)->bIsHost=FALSE; }
 
 #define test_devctl_hst_mode(_x) \
-	(musb_readb((_x)->pRegs, MGC_O_HDRC_DEVCTL)&MGC_M_DEVCTL_HM)
+	(musb_readb((_x)->mregs, MGC_O_HDRC_DEVCTL)&MGC_M_DEVCTL_HM)
 
 #define MUSB_MODE(musb) ((musb)->bIsHost ? "Host" : "Peripheral")
 
@@ -380,7 +380,7 @@ struct musb {
 
 	struct device		*controller;
 	void __iomem		*ctrl_base;
-	void __iomem		*pRegs;
+	void __iomem		*mregs;
 
 #ifdef CONFIG_USB_TUSB6010
 	dma_addr_t		async;
--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -61,7 +61,7 @@
 #define MGC_O_HDRC_INDEX        0x0E	/* 8 bit */
 #define MGC_O_HDRC_TESTMODE     0x0F	/* 8 bit */
 
-/* Get offset for a given FIFO from musb->pRegs */
+/* Get offset for a given FIFO from musb->mregs */
 #ifdef	CONFIG_USB_TUSB6010
 #define MUSB_FIFO_OFFSET(epnum)	(0x200 + ((epnum) * 0x20))
 #else
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -59,7 +59,7 @@ static void omap_set_vbus(struct musb *musb, int is_on)
 	 * that must be ignored.
 	 */
 
-	devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 
 	if (is_on) {
 		musb->is_active = 1;
@@ -81,12 +81,12 @@ static void omap_set_vbus(struct musb *musb, int is_on)
 
 		MUSB_DEV_MODE(musb);
 	}
-	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, devctl);
+	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, devctl);
 
 	DBG(1, "VBUS %s, devctl %02x "
 		/* otg %3x conf %08x prcm %08x */ "\n",
 		otg_state_string(musb),
-		musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL));
+		musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL));
 }
 static int omap_set_power(struct otg_transceiver *x, unsigned mA)
 {
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -273,7 +273,7 @@ void musb_load_testpacket(struct musb *musb)
 {
 	void __iomem	*regs = musb->aLocalEnd[0].regs;
 
-	MGC_SelectEnd(musb->pRegs, 0);
+	MGC_SelectEnd(musb->mregs, 0);
 	musb_write_fifo(musb->control_ep,
 			sizeof(musb_test_packet), musb_test_packet);
 	musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_TXPKTRDY);
@@ -315,7 +315,7 @@ static DEFINE_TIMER(musb_otg_timer, musb_otg_timer_func, 0, 0);
 void musb_hnp_stop(struct musb *musb)
 {
 	struct usb_hcd	*hcd = musb_to_hcd(musb);
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 	u8	reg;
 
 	switch (musb->xceiv.state) {
@@ -365,7 +365,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 {
 	irqreturn_t handled = IRQ_NONE;
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
-	void __iomem *pBase = musb->pRegs;
+	void __iomem *pBase = musb->mregs;
 #endif
 
 	DBG(3, "<== Power=%02x, DevCtl=%02x, bIntrUSB=0x%x\n", power, devctl,
@@ -660,7 +660,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
  * to support ISO transfers yet.
  */
 	if (bIntrUSB & MGC_M_INTR_SOF) {
-		void __iomem *pBase = musb->pRegs;
+		void __iomem *pBase = musb->mregs;
 		struct musb_hw_ep	*ep;
 		u8 bEnd;
 		u16 wFrame;
@@ -785,7 +785,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 */
 void musb_start(struct musb *musb)
 {
-	void __iomem	*regs = musb->pRegs;
+	void __iomem	*regs = musb->mregs;
 	u8		devctl = musb_readb(regs, MGC_O_HDRC_DEVCTL);
 
 	DBG(2, "<== devctl %02x\n", devctl);
@@ -835,7 +835,7 @@ void musb_start(struct musb *musb)
 
 static void musb_generic_disable(struct musb *musb)
 {
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 	u16	temp;
 
 	/* disable interrupts */
@@ -1022,7 +1022,7 @@ static int __init
 fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		const struct fifo_cfg *cfg, u16 offset)
 {
-	void __iomem	*mbase = musb->pRegs;
+	void __iomem	*mbase = musb->mregs;
 	int	size = 0;
 	u16	maxpacket = cfg->maxpacket;
 	u16	c_off = offset >> 3;
@@ -1180,7 +1180,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 {
 	u8 bEnd = 0, reg;
 	struct musb_hw_ep *hw_ep;
-	void *pBase = musb->pRegs;
+	void *pBase = musb->mregs;
 
 	DBG(2, "<== static silicon ep config\n");
 
@@ -1252,7 +1252,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	char *type;
 	u16 wRelease, wRelMajor, wRelMinor;
 	char aInfo[78], aRevision[32], aDate[12];
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 	int		status = 0;
 	int		i;
 
@@ -1421,9 +1421,9 @@ static irqreturn_t generic_interrupt(int irq, void *__hci)
 
 	spin_lock_irqsave(&musb->Lock, flags);
 
-	musb->int_usb = musb_readb(musb->pRegs, MGC_O_HDRC_INTRUSB);
-	musb->int_tx = musb_readw(musb->pRegs, MGC_O_HDRC_INTRTX);
-	musb->int_rx = musb_readw(musb->pRegs, MGC_O_HDRC_INTRRX);
+	musb->int_usb = musb_readb(musb->mregs, MGC_O_HDRC_INTRUSB);
+	musb->int_tx = musb_readw(musb->mregs, MGC_O_HDRC_INTRTX);
+	musb->int_rx = musb_readw(musb->mregs, MGC_O_HDRC_INTRRX);
 
 	if (musb->int_usb || musb->int_tx || musb->int_rx)
 		retval = musb_interrupt(musb);
@@ -1457,8 +1457,8 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	int		ep_num;
 	u32		reg;
 
-	devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
-	power = musb_readb(musb->pRegs, MGC_O_HDRC_POWER);
+	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+	power = musb_readb(musb->mregs, MGC_O_HDRC_POWER);
 
 	DBG(4, "** IRQ %s usb%04x tx%04x rx%04x\n",
 		(devctl & MGC_M_DEVCTL_HM) ? "host" : "peripheral",
@@ -1486,7 +1486,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	ep_num = 1;
 	while (reg) {
 		if (reg & 1) {
-			// MGC_SelectEnd(musb->pRegs, ep_num);
+			// MGC_SelectEnd(musb->mregs, ep_num);
 			/* REVISIT just retval = ep->rx_irq(...) */
 			retval = IRQ_HANDLED;
 			if (devctl & MGC_M_DEVCTL_HM) {
@@ -1507,7 +1507,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	ep_num = 1;
 	while (reg) {
 		if (reg & 1) {
-			// MGC_SelectEnd(musb->pRegs, ep_num);
+			// MGC_SelectEnd(musb->mregs, ep_num);
 			/* REVISIT just retval |= ep->tx_irq(...) */
 			retval = IRQ_HANDLED;
 			if (devctl & MGC_M_DEVCTL_HM) {
@@ -1540,7 +1540,7 @@ MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
 
 void musb_dma_completion(struct musb *musb, u8 bLocalEnd, u8 bTransmit)
 {
-	u8	devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+	u8	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 
 	/* called with controller lock already held */
 
@@ -1640,7 +1640,7 @@ musb_cable_show(struct device *dev, struct device_attribute *attr, char *buf)
 	 * VBUS high for a long time after power has been removed, can
 	 * cause temporary false indications of a connection.
 	 */
-	vbus = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+	vbus = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 	if (vbus & 0x10) {
 		/* REVISIT retest on real OTG hardware */
 		switch (musb->board_mode) {
@@ -1768,7 +1768,7 @@ allocate_instance(struct device *dev, void __iomem *mbase)
 
 #endif
 
-	musb->pRegs = mbase;
+	musb->mregs = mbase;
 	musb->ctrl_base = mbase;
 	musb->nIrq = -ENODEV;
 	for (epnum = 0, ep = musb->aLocalEnd;
@@ -1814,9 +1814,9 @@ static void musb_free(struct musb *musb)
 		dma_controller_destroy(c);
 	}
 
-	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, 0);
 	musb_platform_exit(musb);
-	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, 0);
 
 	if (musb->clock) {
 		clk_disable(musb->clock);
@@ -1835,7 +1835,7 @@ static void musb_free(struct musb *musb)
  *
  * @pDevice: the controller (already clocked, etc)
  * @nIrq: irq
- * @pRegs: virtual address of controller registers,
+ * @mregs: virtual address of controller registers,
  *	not yet corrected for platform-specific offsets
  */
 static int __init
@@ -1903,7 +1903,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 	/* assume vbus is off */
 
-	/* platform adjusts musb->pRegs and musb->isr if needed,
+	/* platform adjusts musb->mregs and musb->isr if needed,
 	 * and activates clocks
 	 */
 	musb->isr = generic_interrupt;
@@ -1920,7 +1920,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (use_dma && dev->dma_mask) {
 		struct dma_controller	*c;
 
-		c = dma_controller_create(musb, musb->pRegs);
+		c = dma_controller_create(musb, musb->mregs);
 		musb->pDmaController = c;
 		if (c)
 			(void) c->start(c->pPrivateData);
@@ -1990,8 +1990,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 		DBG(1, "%s mode, status %d, devctl %02x %c\n",
 			"HOST", status,
-			musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL),
-			(musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL)
+			musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL),
+			(musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL)
 					& MGC_M_DEVCTL_BDEVICE
 				? 'B' : 'A'));
 
@@ -2005,7 +2005,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		DBG(1, "%s mode, status %d, dev%02x\n",
 			is_otg_enabled(musb) ? "OTG" : "PERIPHERAL",
 			status,
-			musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL));
+			musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL));
 
 	}
 
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -504,7 +504,7 @@ static void tusb_source_power(struct musb *musb, int is_on)
 
 	prcm = musb_readl(base, TUSB_PRCM_MNGMT);
 	conf = musb_readl(base, TUSB_DEV_CONF);
-	devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 
 	if (is_on) {
 		musb->is_active = 1;
@@ -535,11 +535,11 @@ static void tusb_source_power(struct musb *musb, int is_on)
 	musb_writel(base, TUSB_PRCM_MNGMT, prcm);
 	musb_writel(base, TUSB_DEV_OTG_TIMER, timer);
 	musb_writel(base, TUSB_DEV_CONF, conf);
-	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, devctl);
+	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, devctl);
 
 	DBG(1, "VBUS %s, devctl %02x otg %3x conf %08x prcm %08x\n",
 		otg_state_string(musb),
-		musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL),
+		musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL),
 		musb_readl(base, TUSB_DEV_OTG_STAT),
 		conf, prcm);
 }
@@ -679,10 +679,10 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *base)
 			switch (musb->xceiv.state) {
 			case OTG_STATE_A_IDLE:
 				DBG(2, "Got SRP, turning on VBUS\n");
-				devctl = musb_readb(musb->pRegs,
+				devctl = musb_readb(musb->mregs,
 							MGC_O_HDRC_DEVCTL);
 				devctl |= MGC_M_DEVCTL_SESSION;
-				musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL,
+				musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL,
 							devctl);
 				musb->xceiv.state = OTG_STATE_A_WAIT_VRISE;
 
@@ -726,7 +726,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *base)
 			/* VBUS has probably been valid for a while now,
 			 * but may well have bounced out of range a bit
 			 */
-			devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+			devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 			if (otg_stat & TUSB_DEV_OTG_STAT_VBUS_VALID) {
 				if ((devctl & MGC_M_DEVCTL_VBUS)
 						!= MGC_M_DEVCTL_VBUS) {
@@ -1077,7 +1077,7 @@ int __init musb_platform_init(struct musb *musb)
 	/* Offsets from base: VLYNQ at 0x000, MUSB regs at 0x400,
 	 * FIFOs at 0x600, TUSB at 0x800
 	 */
-	musb->pRegs += TUSB_BASE_OFFSET;
+	musb->mregs += TUSB_BASE_OFFSET;
 
 	ret = tusb_start(musb);
 	if (ret) {
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -145,7 +145,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	struct musb		*musb = chdat->musb;
 	struct musb_hw_ep	*hw_ep = chdat->hw_ep;
 	void __iomem		*ep_conf = hw_ep->conf;
-	void __iomem		*musb_base = musb->pRegs;
+	void __iomem		*musb_base = musb->mregs;
 	unsigned long		remaining, flags, pio;
 	int			ch;
 
@@ -240,7 +240,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	struct tusb_omap_dma		*tusb_dma = chdat->tusb_dma;
 	struct musb			*musb = chdat->musb;
 	struct musb_hw_ep		*hw_ep = chdat->hw_ep;
-	void __iomem			*musb_base = musb->pRegs;
+	void __iomem			*musb_base = musb->mregs;
 	void __iomem			*ep_conf = hw_ep->conf;
 	dma_addr_t			fifo = hw_ep->fifo_sync;
 	struct omap_dma_channel_params	dma_params;
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -49,7 +49,7 @@
 static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 {
 	u8		power;
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 
 	if (!is_host_active(musb))
 		return;
@@ -110,7 +110,7 @@ static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 static void musb_port_reset(struct musb *musb, u8 bReset)
 {
 	u8		power;
-	void __iomem	*pBase = musb->pRegs;
+	void __iomem	*pBase = musb->mregs;
 
 #ifdef CONFIG_USB_MUSB_OTG
 	/* REVISIT this looks wrong for HNP */
@@ -308,11 +308,11 @@ int musb_hub_control(
 				&& time_after(jiffies, musb->rh_timer)) {
 			u8		power;
 
-			power = musb_readb(musb->pRegs, MGC_O_HDRC_POWER);
+			power = musb_readb(musb->mregs, MGC_O_HDRC_POWER);
 			power &= ~MGC_M_POWER_RESUME;
 			DBG(4, "root port resume stopped, power %02x\n",
 					power);
-			musb_writeb(musb->pRegs, MGC_O_HDRC_POWER, power);
+			musb_writeb(musb->mregs, MGC_O_HDRC_POWER, power);
 
 			/* ISSUE:  DaVinci (RTL 1.300) disconnects after
 			 * resume of high speed peripherals (but not full
@@ -388,7 +388,7 @@ int musb_hub_control(
 				temp = MGC_M_TEST_FORCE_HOST
 					| MGC_M_TEST_FORCE_HS;
 
-				musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+				musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
 				break;
 			case 6:
 				pr_debug("TEST_FIFO_ACCESS\n");
@@ -397,7 +397,7 @@ int musb_hub_control(
 			default:
 				goto error;
 			}
-			musb_writeb(musb->pRegs, MGC_O_HDRC_TESTMODE, temp);
+			musb_writeb(musb->mregs, MGC_O_HDRC_TESTMODE, temp);
 			break;
 		default:
 			goto error;
-- 
1.5.2.3
