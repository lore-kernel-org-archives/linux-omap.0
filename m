From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 2/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
Date: Wed, 25 Aug 2010 14:12:12 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B39A3EB9@dbde02.ent.ti.com>
References: <1281364586-26323-1-git-send-email-rnayak@ti.com>
	<1281364586-26323-2-git-send-email-rnayak@ti.com>
 <87mxsdvupw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab0HYImS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 04:42:18 -0400
In-Reply-To: <87mxsdvupw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 24, 2010 3:49 AM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Paul Walmsley
> Subject: Re: [PATCH 2/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
> 
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> > From: Paul Walmsley <paul@pwsan.com>
> >
> > Add hwmod structures for I2C controllers on OMAP2420/2430.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  134
> ++++++++++++++++++++++++++-
> >  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  140
> +++++++++++++++++++++++++++-
> >  2 files changed, 270 insertions(+), 4 deletions(-)
> >
> 
> [...]
> 
> > +static struct omap_hwmod omap2420_i2c1_hwmod = {
> > +	.name		= "i2c1",
> > +	.mpu_irqs	= i2c1_mpu_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> > +	.sdma_chs	= i2c1_sdma_chs,
> > +	.sdma_chs_cnt	= ARRAY_SIZE(i2c1_sdma_chs),
> > +	.main_clk	= "i2c1_fck",
> > +	.prcm		= {
> > +		.omap2 = {
> > +			.prcm_reg_id = 1,
> > +			.module_bit = OMAP2420_EN_I2C1_SHIFT,
> > +		},
> > +	},
> 
> This needs to be validated on OMAP2.
> 
> I think the enable will fail without the .idlest* fields filled out.

Hi Kevin,

I'll make sure I boot test on a N800 before I post the next version
of this series.

Thanks,
Rajendra


> 
> Kevin
> 
> 
> > +
