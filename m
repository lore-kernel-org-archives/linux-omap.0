From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Thu, 13 May 2010 09:43:00 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E405169@dbde02.ent.ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
 <20100512175433.GC3285@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41837 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726Ab0EMENM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 00:13:12 -0400
In-Reply-To: <20100512175433.GC3285@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> On Wed, May 12, 2010 at 05:19:38PM +0530, Ajay Kumar Gupta wrote:
> > MUSB RTL version 1.8 onward (OMAP3630, AM/DM37x, OMAP4) DMA requires
> > the buffers to be aligned on a four byte boundary. This affects USB
> > CDC/RNDIS class application where buffers are always unaligned.
> >
> > Use system DMA for unaligned buffers as a workaround of this issue.
> >
> > Current patch supports device side CDC/RNDIS. Host side would require
> > change in Tx programming path for mode-0 operation when transfer length
> > is more than packet size.
> >
> > Also fixed an issue in device Tx completion path where 'is_dma' is
> getting
> > set unconditionally. This would fail the io if Tx transfer is done in
> > mode-0. Fixed it by updating it based on 'request->actual' length.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> [..]
> 
> > @@ -166,6 +166,12 @@ config MUSB_USE_SYSTEM_DMA_WORKAROUND
> >            DMA channels are simultaneously enabled. To work around this
> issue,
> >            you can choose to use System DMA for RX channels.
> >
> > +	  Also on Mentor DMA in MUSB RTL version 1.8 (OMAP3630, AM/DM37x)
> > +	  requires buffers to be aligned on a four byte boundary. This
> affects
> > +	  USB CDC/RNDIS class application where buffers are always
> unaligned.
> > +	  To work around this issue, you can choose to use System DMA for
> > +	  unaligned buffers.
> 
> instead of this patch, it's a whole lot easier to simply use a bounce
> buffer:
> 
> if (unaligned) {
> 	bounce = dma_alloc_coherent(......);
> 	memcpy(request->buf, bounce, request->length);
> }

How about this 'memcpy', this would affect both cpu loading
and performance. That's why using system dma would be a better
approach.

-Ajay 
> 
> and use that buffer on channel_program();
> 
> --
> balbi
