From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 2/5] musb: use system DMA to fix Inventra DMA issue on
 RTL-1.4
Date: Thu, 13 May 2010 17:27:53 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F9F44E9@dbde02.ent.ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>,<20100512175113.GA3285@gandalf>
 <5A47E75E594F054BAF48C5E4FC4B92AB03216237DA@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044E40516E@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F9F43A6@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044E4052E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33115 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494Ab0EML6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 07:58:00 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E4052E6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
 

>-----Original Message-----
>From: Gupta, Ajay Kumar 
>Sent: Thursday, May 13, 2010 3:41 PM
>To: Kalliguddi, Hema; Gadiyar, Anand; me@felipebalbi.com
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>Subject: RE: [PATCH 2/5] musb: use system DMA to fix Inventra 
>DMA issue on RTL-1.4
>
>Hi,
>> >> > > Another approach to use PIO mode in opposite direction would
>> >> > > increase
>> >> the
>> >> > > cpu loading and thus using system DMA is preferred workaround.
>> >> > >
>> >> > > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> >> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> >> >
>> >> > I think falling back to pio is better than this patch.
>> >At the cost of cpu, which certainly is not preferred.
>> >
>> >>> It will most likely be only one transfer.
>> >
>> >How about host mode with multiple devices connected and doing
>> >transfers?
>> >Falling back to PIO would kill the cpu.
>> >
>> >>> Another approach is to allocate dma channels on a transfer basis.
>> >
>> >Can you elaborate this?
>> 
>> It might be good idea to allocate the dma channels on 
>tarnsfer basis as
>> Felipe
>> Suggested. The musb driver allocates dma channels for the 
>first 8 enabled
>> endpoints and  higher endpoints works in PIO mode.
>> For system dma if there are more nummber of Rx endpoints 
>enabled but not
>> used for data
>> Transfer you might end up having many sdma channles 
>allocated biut not
>> used which will
>> Impact in the system of not utilizing the sdma channels effectively.
>
>Felipe, Is this what you meant? If so then I have a patch 
>(copied below)
>to fix this and I can post this one along with others.
>
>-------------- cut here -----------------
>Currently DMA channels are allocated and they remain allocated
>even if there is no active data transfer. Added channel_release()
>whenever there is no pending request.
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>---
> drivers/usb/musb/musb_gadget.c |   27 +++++++++++++++++++++------
> drivers/usb/musb/musb_host.c   |   14 ++++++++++++--
> 2 files changed, 33 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/usb/musb/musb_gadget.c 
>b/drivers/usb/musb/musb_gadget.c
>index fd842af..477a009 100644
>--- a/drivers/usb/musb/musb_gadget.c
>+++ b/drivers/usb/musb/musb_gadget.c
>@@ -297,9 +297,13 @@ static void txstate(struct musb *musb, 
>struct musb_request *req)
> 			csr);
> 
> #ifndef	CONFIG_MUSB_PIO_ONLY
>-	if (is_dma_capable() && musb_ep->dma) {
>+
>+	if (is_dma_capable() && musb->dma_controller) {
> 		struct dma_controller	*c = musb->dma_controller;
> 
>+		if (!musb_ep->dma)
>+			musb_ep->dma = c->channel_alloc(c, 
>musb_ep->hw_ep, 1);

If the channel_alloc returns failure then there should be a way to fallback to PIO mode.
I am posting a patch for dynamic dma channel allocation for mentor dma for gadget driver.

~Hema
>+
> 		use_dma = (request->dma != DMA_ADDR_INVALID);
> 
> 		/* MUSB_TXCSR_P_ISO is still set correctly */
>@@ -433,6 +437,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> 	u8 __iomem		*mbase = musb->mregs;
> 	struct musb_ep		*musb_ep = 
>&musb->endpoints[epnum].ep_in;
> 	void __iomem		*epio = musb->endpoints[epnum].regs;
>+	struct dma_controller	*c = musb->dma_controller;
> 	struct dma_channel	*dma;
> 
> 	musb_ep_select(mbase, epnum);
>@@ -535,6 +540,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> 			if (!request) {
> 				DBG(4, "%s idle now\n",
> 					musb_ep->end_point.name);
>+				if (musb_ep->dma) {
>+					
>c->channel_release(musb_ep->dma);
>+					musb_ep->dma = NULL;
>+				}
> 				return;
> 			}
> 		}
>@@ -585,6 +594,7 @@ static void rxstate(struct musb *musb, 
>struct musb_request *req)
> 	struct usb_request	*request = &req->request;
> 	struct musb_ep		*musb_ep = 
>&musb->endpoints[epnum].ep_out;
> 	void __iomem		*epio = musb->endpoints[epnum].regs;
>+	struct dma_controller	*c = musb->dma_controller;
> 	unsigned		fifo_count = 0;
> 	u16			len = musb_ep->packet_sz;
> 	u16			csr = musb_readw(epio, MUSB_RXCSR);
>@@ -601,8 +611,10 @@ static void rxstate(struct musb *musb, 
>struct musb_request *req)
> 		return;
> 	}
> 
>+	if (is_dma_capable() && musb->dma_controller && !musb_ep->dma)
>+		musb_ep->dma = c->channel_alloc(c, musb_ep->hw_ep, 0);
>+
> 	if ((is_cppi_enabled() || is_cppi41_enabled()) && 
>musb_ep->dma) {
>-		struct dma_controller	*c = musb->dma_controller;
> 		struct dma_channel	*channel = musb_ep->dma;
> 
> 		/* NOTE:  CPPI won't actually stop advancing the DMA
>@@ -633,11 +645,9 @@ static void rxstate(struct musb *musb, 
>struct musb_request *req)
> 		if (request->actual < request->length) {
> #ifdef CONFIG_USB_INVENTRA_DMA
> 			if (is_dma_capable() && musb_ep->dma) {
>-				struct dma_controller	*c;
> 				struct dma_channel	*channel;
> 				int			use_dma = 0;
> 
>-				c = musb->dma_controller;
> 				channel = musb_ep->dma;
> 
> 	/* We use DMA Req mode 0 in rx_csr, and DMA controller 
>operates in
>@@ -719,7 +729,6 @@ static void rxstate(struct musb *musb, 
>struct musb_request *req)
> 
> #ifdef	CONFIG_USB_TUSB_OMAP_DMA
> 			if (tusb_dma_omap() && musb_ep->dma) {
>-				struct dma_controller *c = 
>musb->dma_controller;
> 				struct dma_channel *channel = 
>musb_ep->dma;
> 				u32 dma_addr = request->dma + 
>request->actual;
> 				int ret;
>@@ -764,6 +773,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
> 	void __iomem		*mbase = musb->mregs;
> 	struct musb_ep		*musb_ep = 
>&musb->endpoints[epnum].ep_out;
> 	void __iomem		*epio = musb->endpoints[epnum].regs;
>+	struct dma_controller	*c = musb->dma_controller;
> 	struct dma_channel	*dma;
> 
> 	musb_ep_select(mbase, epnum);
>@@ -838,8 +848,13 @@ void musb_g_rx(struct musb *musb, u8 epnum)
> 		musb_g_giveback(musb_ep, request, 0);
> 
> 		request = next_request(musb_ep);
>-		if (!request)
>+		if (!request) {
>+			if (musb_ep->dma) {
>+				c->channel_release(musb_ep->dma);
>+				musb_ep->dma = NULL;
>+			}
> 			return;
>+		}
> 	}
> 
> 	/* analyze request if the ep is hot */
>diff --git a/drivers/usb/musb/musb_host.c 
>b/drivers/usb/musb/musb_host.c
>index 89c8c35..001a1d6 100644
>--- a/drivers/usb/musb/musb_host.c
>+++ b/drivers/usb/musb/musb_host.c
>@@ -460,11 +460,21 @@ static void musb_advance_schedule(struct 
>musb *musb, struct urb *urb,
> 	 */
> 	if (list_empty(&qh->hep->urb_list)) {
> 		struct list_head	*head;
>+		struct dma_controller	*dma = musb->dma_controller;
> 
>-		if (is_in)
>+		if (is_in) {
> 			ep->rx_reinit = 1;
>-		else
>+			if (ep->rx_channel) {
>+				dma->channel_release(ep->rx_channel);
>+				ep->rx_channel = NULL;
>+			}
>+		} else {
> 			ep->tx_reinit = 1;
>+			if (ep->tx_channel) {
>+				dma->channel_release(ep->tx_channel);
>+				ep->tx_channel = NULL;
>+			}
>+		}
> 
> 		/* Clobber old pointers to this qh */
> 		musb_ep_set_qh(ep, is_in, NULL);
>-- 
>1.6.2.4
>
>
>-----------------------------------------
>-Ajay
>> 
>