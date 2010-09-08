From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
Date: Wed, 8 Sep 2010 07:22:06 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8D29@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-5-git-send-email-manjugk@ti.com>
 <871v9awnwy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab0IHBwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 21:52:14 -0400
In-Reply-To: <871v9awnwy.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, September 04, 2010 2:22 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v2 04/11] OMAP3: DMA: HWMOD: Add hwmod 
> data structures
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > This patch adds OMAP3 DMA hwmod structures.
> 

[..]

> > +
> > +static struct omap_hwmod omap3xxx_dma_system_hwmod = {
> > +	.name		= "dma",
> > +	.class		= &omap3xxx_dma_hwmod_class,
> > +	.mpu_irqs	= omap3xxx_dma_system_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
> > +	.main_clk	= "l3_div_ck",
> > +	.slaves		= omap3xxx_dma_system_slaves,
> > +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dma_system_slaves),
> > +	.masters	= omap3xxx_dma_system_masters,
> > +	.masters_cnt	= ARRAY_SIZE(omap3xxx_dma_system_masters),
> > +	.dev_attr	= &dma_dev_attr,
> > +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> > +	.flags		= HWMOD_NO_IDLEST,
> 
> hmm, I see an ST_DMA bit in CM_IDLEST1_CORE for DMA.
> 
> Having this also masks the fact that you haven't filled out the
> .prcm.omap2 fields of the hwmod, at least the idlest ones are needed
> here.

Ok. I will introduce .prcm entries as:
	.prcm = {
		.omap2 = {
			.prcm_reg_id		= 1,
			.module_bit		= OMAP3430_ST_SDMA_SHIFT,
			.module_offs		= CORE_MOD,
			.idlest_reg_id		= 1,
			.idlest_idle_bit	= OMAP3430_ST_SDMA_SHIFT,
		},
	}
	.flags = HWMOD_SET_DEFAULT_CLOCKACT,

-Manjunath

