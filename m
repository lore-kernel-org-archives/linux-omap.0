From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/10] ARM: OMAP: Fix DMA CCR programming for request
	line > 63
Date: Mon, 12 Jan 2009 17:35:28 +0200
Message-ID: <20090112153526.GN9373@atomide.com>
References: <20090112144453.24205.18451.stgit@localhost> <5A47E75E594F054BAF48C5E4FC4B92AB02E678260F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56890 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbZALPfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 10:35:33 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E678260F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [090112 17:02]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Monday, January 12, 2009 8:15 PM
> > To: linux-arm-kernel@lists.arm.linux.org.uk
> > Cc: linux-omap@vger.kernel.org; Gadiyar, Anand
> > Subject: [PATCH 06/10] ARM: OMAP: Fix DMA CCR programming for request line > 63
> > 
> > From: Anand Gadiyar <gadiyar@ti.com>
> > 
> > Bug in existing code causes synchro control to be set +32 if request
> > line greater than 63 is used.
> > 
> > Reported by Wenbiao Wang
> > 
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/dma.c |    5 +----
> >  1 files changed, 1 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index 692d2b4..6152586 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -279,10 +279,7 @@ void omap_set_dma_transfer_params(int 
> > lch, int data_type, int elem_count,
> >  
> >  		val = dma_read(CCR(lch));
> >  		val &= ~(3 << 19);
> > -		if (dma_trigger > 63)
> > -			val |= 1 << 20;
> > -		if (dma_trigger > 31)
> > -			val |= 1 << 19;
> > +		val |= ((dma_trigger & ~(0x1f)) << 14);
> >  
> >  		val &= ~(0x1f);
> >  		val |= (dma_trigger & 0x1f);
> > 
> > 
> > 
> 
> Reviewing my own patch. Is it better to use
> 		val |= ((dma_trigger & 0x60) << 14) instead?
> 
> Or is this fine, as is?

Well at least you could remove some parens.
How about (dma_trigger / 32) << 19 instead?

Regards,

Tony
