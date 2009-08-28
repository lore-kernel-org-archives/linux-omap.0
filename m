From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 15:14:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
 <4A97A1FF.5050501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59812 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbZH1Jol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 05:44:41 -0400
In-Reply-To: <4A97A1FF.5050501@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "B, Ravi" <ravibabu@ti.com>

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]
> Sent: Friday, August 28, 2009 2:53 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
> felipe.balbi@nokia.com; david-b@pacbell.net; Subbrathnam, Swaminathan; B,
> Ravi
> Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
> 
> Hello.
> 
> Ajay Kumar Gupta wrote:
> 
> > Isochronous Tx DMA is getting programmed but never getting started
> > for CPPI and TUSB DMAs and thus Isochronous Tx doesn't work.
> >
> 
>    That's not true.

We have tested and it doesn't work with current driver. Have you tested it and was it working for you ?

> 
> > Fixing it by starting DMAs using musb_h_tx_dma_start().
> >
> > Signed-off-by: Swaminathan S <swami.iyer@ti.com>
> > Signed-off-by: Babu Ravi <ravibabu@ti.com>
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> >
> 
>    NAK.
> 
> > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > index cf94511..e3ab40a 100644
> > --- a/drivers/usb/musb/musb_host.c
> > +++ b/drivers/usb/musb/musb_host.c
> > @@ -1301,8 +1301,11 @@ void musb_host_tx(struct musb *musb, u8 epnum)
> >  		return;
> >  	} else	if (usb_pipeisoc(pipe) && dma) {
> >  		if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
> > -				offset, length))
> > +				offset, length)) {
> > +			if (is_cppi_enabled() || tusb_dma_omap())
> > +				musb_h_tx_dma_start(hw_ep);
> >  			return;
> >
> 
>    It will have been already started by this moment -- from
> musb_start_urb() which is enough . Otherwise it wouldn't work, and I've
> made sure it *does* work.


This part is being done at musb_host_rx() doing next packet programming within same urb and *not* starting next urb. Thus musb_start_urb() doesn't come into this path. So it wouldn't start the DMAs.

In case of PIO, it does load the FIFO and sets the TXPKTREADY.

-Ajay

> 
> WBR, Sergei
> 
> 

