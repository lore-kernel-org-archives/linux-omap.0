From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 09/11] OMAP: DMA: Implement generic errata handling
Date: Sat, 18 Sep 2010 06:45:07 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402784DCD79@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
 <1282647866-6918-10-git-send-email-manjugk@ti.com> <4C938D0C.9000801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40450 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab0IRBPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 21:15:14 -0400
In-Reply-To: <4C938D0C.9000801@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>




> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Friday, September 17, 2010 9:15 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Shilimkar, Santosh
> Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic 
> errata handling
> 
> On 8/24/2010 1:04 PM, G, Manjunath Kondaiah wrote:
> > This patch introduces generic way of handling all OMAP DMA errata's 
> > which are applicable for OMAP1 and OMAP2PLUS processors.
> 
> <...>
> 
> > diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c 
> > index f369bee..8832bd1 100644
> > --- a/arch/arm/mach-omap2/dma.c
> > +++ b/arch/arm/mach-omap2/dma.c
> > @@ -80,6 +80,40 @@ static int __init 
> omap2_system_dma_init_dev(struct 
> > omap_hwmod *oh, void *user)
> >
> >   	pdata->dma_attr		= (struct omap_dma_dev_attr 
> *)oh->dev_attr;
> >
> > +	/* Handling Errata's for all OMAP2PLUS processors */
> > +	pdata->errata			= 0;
> > +
> > +	if (cpu_is_omap242x() ||
> > +		(cpu_is_omap243x()&&   omap_type()<= 
> OMAP2430_REV_ES1_0))
> > +		pdata->errata		= DMA_CHAINING_ERRATA;
> > +
> > +	/*
> > +	 * Errata: On ES2.0 BUFFERING disable must be set.
> > +	 * This will always fail on ES1.0
> > +	 */
> > +	if (cpu_is_omap24xx())
> > +		pdata->errata		|= DMA_BUFF_DISABLE_ERRATA;
> > +
> > +	/*
> > +	 * Errata: OMAP2: sDMA Channel is not disabled
> > +	 * after a transaction error. So we explicitely
> > +	 * disable the channel
> > +	 */
> > +	if (cpu_class_is_omap2())
> > +		pdata->errata		|= DMA_CH_DISABLE_ERRATA;
> > +
> > +	/* Errata: OMAP3 :
> > +	 * A bug in ROM code leaves IRQ status for channels 0 
> and 1 uncleared
> > +	 * after secure sram context save and restore. Hence we need to
> > +	 * manually clear those IRQs to avoid spurious interrupts. This
> > +	 * affects only secure devices.
> > +	 */
> > +	if (cpu_is_omap34xx()&&  (omap_type() != OMAP2_DEVICE_TYPE_GP))
> > +		pdata->errata		|= DMA_IRQ_STATUS_ERRATA;
> > +
> > +	/* Errata3.3: Applicable for all omap2 plus */
> > +	pdata->errata			|= OMAP3_3_ERRATUM;
> > +
> 
> The DMA_SYSCONFIG_ERRATA does not seems to be initialized 
> there. How are you enabling that errata?

Thanks. I have already identified this and taken care in my internal version. It 
will be enabled in next version.

-Manjunath

