From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Tue, 14 Sep 2010 15:48:52 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027843B8E7@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-8-git-send-email-manjugk@ti.com>
 <87lj7iv8zv.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41602 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab0INKTF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 06:19:05 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


Kevin,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G, 
> Manjunath Kondaiah
> Sent: Tuesday, September 07, 2010 5:17 PM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
> Subject: RE: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device 
> registration
> 
> 
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > Sent: Saturday, September 04, 2010 2:30 AM
> > To: G, Manjunath Kondaiah
> > Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
> > Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device 
> > registration
> > 
> > Manjunatha GK <manjugk@ti.com> writes:
> > 
> > > This patch converts omap2/3/4 dma driver into platform devices 
> > > through using omap hwmod, omap device and runtime pm frameworks.
> 
> [..]
> 
> > > +
> > > +#define dma_read(reg)					
> > 		\
> > > +({								
> > 	\
> > > +	u32 __val;						
> > 	\
> > > +	__val = __raw_readl(dma_base + OMAP_DMA4_##reg);	
> > 	\
> > > +	__val;							
> > 	\
> > > +})
> > > +
> > > +#define dma_write(val, reg)				
> > 		\
> > > +({								
> > 	\
> > > +	__raw_writel((val), dma_base + OMAP_DMA4_##reg);	
> > 	\
> > > +})
> > 
> > I know these are copy paste from the original code, but 
> please convert 
> > into static inline functions.
> 
> Ok.

How static inline functions are better than this? 

-Manjunath

