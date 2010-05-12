From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Wed, 12 May 2010 19:25:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E405072@dbde02.ent.ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
 <4BEAAA8A.1000003@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60175 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab0ELNzc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 09:55:32 -0400
In-Reply-To: <4BEAAA8A.1000003@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> >  	if (channel->status == MUSB_DMA_STATUS_BUSY) {
> >  		if (musb_channel->transmit) {
> > +			if (musb_channel->sysdma_channel != -1)
> > +				omap_stop_dma(musb_channel->sysdma_channel);
> > +
> >
> 
>    Have you thought about e.g. Blackfin? How this is going to compile
> there, without omap_*() functions even existing? Or did you think that
> OMAP is the only user of this driver?
Thanks for pointing this. It would require adding wrapper functions for
Blckfin's.

-Ajay
> 
> WBR, Sergei

