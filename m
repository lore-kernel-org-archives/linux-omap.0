From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 16:05:02 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A4A63E@dbde02.ent.ti.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
 <4A97A1FF.5050501@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
 <4A97AB42.4070008@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E73940436A4A635@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40482 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbZH1Kfj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 06:35:39 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A4A635@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "B, Ravi" <ravibabu@ti.com>

> > > This part is being done at musb_host_rx()
> >
> >    You're doing it in musb_host_tx() actually. Although musb_host_rx()
> > is also broken WRT the isochronous transfers.
> >
> > >  doing next packet programming within same urb and *not* starting next
> > urb. Thus musb_start_urb() doesn't come into this path.
> >
> >    What? Read the code, please -- musb_start_urb() call should always
> > precede musb_host_tx() which handles the DMA interrupt. Unless something
> > clears DMAReqEnab after musb_start_urb() call, setting it only once
> > should work.
> 
> musb_start_urb() call does precede musb_host_tx() but when urb is
> *completed*.

I think you are aware that there are multiple packets within same isochronous urb and musb_start_urb() programs only for first packet.

============================================================
        case USB_ENDPOINT_XFER_ISOC:
                qh->iso_idx = 0;
                qh->frame = 0;
                offset = urb->iso_frame_desc[0].offset;
                len = urb->iso_frame_desc[0].length;
============================================================


-Ajay

> 
> check the 'done' flag and musb_advance_schedule getting called in the
> path.
> 
> if (done) {
>                 /* set status */
>                 urb->status = status;
>                 urb->actual_length = qh->offset;
>                 musb_advance_schedule(musb, urb, hw_ep, USB_DIR_OUT);
>                 return;
> } else  if (usb_pipeisoc(pipe) && dma) {
>          if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
>                                 offset, length)) {
>                 if (is_cppi_enabled() || tusb_dma_omap()
>                                 || is_cppi41_enabled())
>                     musb_h_tx_dma_start(hw_ep);
>            return;
> }
> 
> 
> >
> > > So it wouldn't start the DMAs.
> > >
> >
> >    How musb_host_tx() can be called without musb_start_urb()?
> >
> > > In case of PIO, it does load the FIFO and sets the TXPKTREADY.
> > >
> >
> >    Only is URB_ISO_ASAP is not set.
> >
> > WBR, Sergei
> >
> > > -Ajay
> >
> > WBR, Sergei
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

