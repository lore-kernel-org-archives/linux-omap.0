From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Tue, 7 Sep 2010 17:17:27 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-8-git-send-email-manjugk@ti.com>
 <87lj7iv8zv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35339 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515Ab0IGLrc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:47:32 -0400
In-Reply-To: <87lj7iv8zv.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, September 04, 2010 2:30 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device 
> registration
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > This patch converts omap2/3/4 dma driver into platform
> > devices through using omap hwmod, omap device and runtime pm
> > frameworks.

[..]

> > +
> > +#define dma_read(reg)					
> 		\
> > +({								
> 	\
> > +	u32 __val;						
> 	\
> > +	__val = __raw_readl(dma_base + OMAP_DMA4_##reg);	
> 	\
> > +	__val;							
> 	\
> > +})
> > +
> > +#define dma_write(val, reg)				
> 		\
> > +({								
> 	\
> > +	__raw_writel((val), dma_base + OMAP_DMA4_##reg);	
> 	\
> > +})
> 
> I know these are copy paste from the original code, but please convert
> into static inline functions.

Ok.

> 
> Also, I don't see dma_write() used in this patch.

This is initial patch for splitting mach-omap1 and mach-omap2 contents.
dma_write is used in later patches. Please refer to Patch #11

-Manjunath

