From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 10/11] OMAP: DMA: Use DMA device attributes
Date: Tue, 7 Sep 2010 17:17:17 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8E@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-11-git-send-email-manjugk@ti.com>
 <874oe6wo77.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35337 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515Ab0IGLrW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:47:22 -0400
In-Reply-To: <874oe6wo77.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>




> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, September 04, 2010 2:16 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v2 10/11] OMAP: DMA: Use DMA device attributes
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > Existing DMA API's are using cpu_is_xxxx checks for differenciating
> > omap1 and omap2plus code.
> >
> > This patch replaces cpu_is_xxxx checks with DMA device 
> attributes and
> > also moves API's which are OMAP1 and OMAP2plus specific 
> into respective
> > mach-omap dma driver files.
> >
> > Signed-off-by: Manjunatha GK <manjugk@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> [...]
> 
> >  int omap_request_dma(int dev_id, const char *dev_name,
> >  		     void (*callback)(int lch, u16 ch_status, 
> void *data),
> >  		     void *data, int *dma_ch_out)
> > @@ -754,14 +459,12 @@ int omap_request_dma(int dev_id, 
> const char *dev_name,
> >  	chan = dma_chan + free_ch;
> >  	chan->dev_id = dev_id;
> >  
> > -	pm_runtime_get_sync(&ddev->dev);
> > -
> > -	if (cpu_class_is_omap1())
> > -		clear_lch_regs(free_ch);
> > -
> > -	if (cpu_class_is_omap2())
> > +	if (p->clear_lch_regs)
> > +		p->clear_lch_regs(free_ch);
> > +	else
> >  		omap_clear_dma(free_ch);
> 
> You access HW registers here.
> 
> > +	pm_runtime_get_sync(&ddev->dev);
> 
> But don't actually enable HW until here.  
> 
> IOW, you need to have the 'get' before you access the HW.

Thanks for pointing out this. I will take care of it.

-Manjunath