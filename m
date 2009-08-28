From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 15:58:27 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A4A635@dbde02.ent.ti.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
 <4A97A1FF.5050501@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
 <4A97AB42.4070008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38623 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbZH1KaR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 06:30:17 -0400
In-Reply-To: <4A97AB42.4070008@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "B, Ravi" <ravibabu@ti.com>

> > We have tested and it doesn't work with current driver. Have you tested
> it and was it working for you ?
> >
> 
>    Not with the current driver, I must admit. I'll try it today...
> 
> >>> diff --git a/drivers/usb/musb/musb_host.c
> b/drivers/usb/musb/musb_host.c
> >>> index cf94511..e3ab40a 100644
> >>> --- a/drivers/usb/musb/musb_host.c
> >>> +++ b/drivers/usb/musb/musb_host.c
> >>> @@ -1301,8 +1301,11 @@ void musb_host_tx(struct musb *musb, u8 epnum)
> >>>  		return;
> >>>  	} else	if (usb_pipeisoc(pipe) && dma) {
> >>>  		if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
> >>> -				offset, length))
> >>> +				offset, length)) {
> >>> +			if (is_cppi_enabled() || tusb_dma_omap())
> >>> +				musb_h_tx_dma_start(hw_ep);
> >>>  			return;
> >>>
> >>>
> >>    It will have been already started by this moment -- from
> >> musb_start_urb() which is enough . Otherwise it wouldn't work, and I've
> >> made sure it *does* work.
> >>
> >
> > This part is being done at musb_host_rx()
> 
>    You're doing it in musb_host_tx() actually. Although musb_host_rx()
> is also broken WRT the isochronous transfers.
> 
> >  doing next packet programming within same urb and *not* starting next
> urb. Thus musb_start_urb() doesn't come into this path.
> 
>    What? Read the code, please -- musb_start_urb() call should always
> precede musb_host_tx() which handles the DMA interrupt. Unless something
> clears DMAReqEnab after musb_start_urb() call, setting it only once
> should work.

musb_start_urb() call does precede musb_host_tx() but when urb is *completed*. 

check the 'done' flag and musb_advance_schedule getting called in the path.

if (done) {
                /* set status */
                urb->status = status;
                urb->actual_length = qh->offset;
                musb_advance_schedule(musb, urb, hw_ep, USB_DIR_OUT);
                return;
} else  if (usb_pipeisoc(pipe) && dma) {
         if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
                                offset, length)) {
                if (is_cppi_enabled() || tusb_dma_omap()
                                || is_cppi41_enabled())
                    musb_h_tx_dma_start(hw_ep);
           return;
}


> 
> > So it wouldn't start the DMAs.
> >
> 
>    How musb_host_tx() can be called without musb_start_urb()?
> 
> > In case of PIO, it does load the FIFO and sets the TXPKTREADY.
> >
> 
>    Only is URB_ISO_ASAP is not set.
> 
> WBR, Sergei
> 
> > -Ajay
> 
> WBR, Sergei
> 
> 

