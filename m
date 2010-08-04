From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
Date: Wed, 4 Aug 2010 06:05:19 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402708B48E3@dbde02.ent.ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
	<1280397545-27323-5-git-send-email-manjugk@ti.com>
 <87eiefnyvs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39849 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab0HDAf3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 20:35:29 -0400
In-Reply-To: <87eiefnyvs.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, August 04, 2010 3:27 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Paul 
> Walmsley; Tony Lindgren; Sawant, Anand; Shilimkar, Santosh; 
> Nayak, Rajendra; Basak, Partha; Varadarajan, Charulatha
> Subject: Re: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod data 
> structures
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > This patch adds OMAP3 DMA hwmod structures.
> >
> > Signed-off-by: Manjunatha GK <manjugk@ti.com>
> 
> [...]
> 
> > +static struct omap_hwmod omap3xxx_dma_system_hwmod = {
> > +	.name		= "dma",
> > +	.class		= &omap3xxx_dma_hwmod_class,
> > +	.mpu_irqs	= omap3xxx_dma_system_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
> > +	.main_clk	= "l3_div_ck",
> > +	.prcm = {
> > +		.omap2 = {
> > +			/* .clkctrl_reg = NULL, */
> > +		},
> > +	},
> 
> Has this been tested?  Without valid fields here the hwmod 
> will never be
> enabled.

This patch series has been tested on both omap3 and omap4. I didn't find
any entries for DMA module in prcm-common.h(for assigning .module_bit etc)
hence I commented this for clarification.

However, all omap3 applicable dma tests used to pass with these changes.

I can include and test it again if these entries are available at some other 
place or I can define if it is applicable for DMA.

-Manjunath

