From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 6/6] musb: dma: use optimal transfer element for sdma
Date: Tue, 18 May 2010 15:41:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E5355F1@dbde02.ent.ti.com>
References: <1274094488-15925-1-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-2-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-3-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-4-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-5-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-6-git-send-email-ajay.gupta@ti.com>
 <4BF26245.4070707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49893 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147Ab0ERKLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 06:11:54 -0400
In-Reply-To: <4BF26245.4070707@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Hi,
> Ajay Kumar Gupta wrote:
> 
> > Use optimal values of transfer element based on buffer address in system
> > DMA programming. This would improve the performance.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >  drivers/usb/musb/musbhsdma.c |   29 ++++++++++++++++++++++++++---
> >  1 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > index d29e487..39c1801 100644
> > --- a/drivers/usb/musb/musbhsdma.c
> > +++ b/drivers/usb/musb/musbhsdma.c
> > @@ -52,11 +52,34 @@ static void musb_sdma_channel_program(struct musb
> *musb,
> >  		struct musb_dma_channel *musb_channel,
> >  		dma_addr_t dma_addr, u32 len)
> >  {
> > +	u16 frame = len;
> > +	int data_type = OMAP_DMA_DATA_TYPE_S8;
> > +
> > +	switch (dma_addr & 0x3) {
> > +	case 0:
> > +		if ((len % 4) == 0) {
> > +			data_type = OMAP_DMA_DATA_TYPE_S32;
> > +			frame = len / 4;
> > +			break;
> > +		}
> > +	case 2:
> > +		if ((len % 2) == 0) {
> > +			data_type = OMAP_DMA_DATA_TYPE_S16;
> > +			frame = len / 2;
> > +			break;
> > +		}
> > +	case 1:
> > +	case 3:
> > +	default:
> > +		data_type = OMAP_DMA_DATA_TYPE_S8;
> > +		frame = len;
> > +			break;
> 
>     The *break* is overindented.
Ok.

-Ajay
> 
> WBR, Sergei
