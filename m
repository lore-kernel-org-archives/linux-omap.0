From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH v2 2/5] OMAP3: hwmod: add I2C hwmods for OMAP3430
Date: Tue, 21 Sep 2010 12:56:05 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EE0ED@dbde02.ent.ti.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com>
 <1284734229-16281-2-git-send-email-rnayak@ti.com>
 <1284734229-16281-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1009210115320.17727@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36862 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab0IUH0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 03:26:12 -0400
In-Reply-To: <alpine.DEB.2.00.1009210115320.17727@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, September 21, 2010 12:47 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Kevin Hilman
> Subject: Re: [PATCH v2 2/5] OMAP3: hwmod: add I2C hwmods for OMAP3430
> 
> On Fri, 17 Sep 2010, Rajendra Nayak wrote:
> 
> > Add hwmod structures for I2C controllers on OMAP3430.
> 
> Also in this patch:
> 
> > +static struct omap_hwmod omap3xxx_i2c1_hwmod = {
> > +	.name		= "i2c1",
> > +	.mpu_irqs	= i2c1_mpu_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> > +	.sdma_reqs	= i2c1_sdma_reqs,
> > +	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
> > +	.main_clk	= "i2c1_fck",
> > +	.prcm		= {
> > +		.omap2 = {
> > +			.prcm_reg_id = 1,
> > +			.module_bit = OMAP3430_GRPSEL_I2C1_SHIFT,
> > +			.idlest_reg_id = 1,
> > +			.idlest_idle_bit = OMAP3430_GRPSEL_I2C1_SHIFT,
> 
> This should be OMAP3430_ST_I2C1_SHIFT; likewise for the rest of the I2C
> hwmods.

Thanks. Will fix this too.

> 
> > +		},
> > +	},
> > +	.slaves		= omap3xxx_i2c1_slaves,
> > +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c1_slaves),
> > +	.class		= &i2c_class,
> > +	.dev_attr	= &i2c1_dev_attr,
> > +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> > +};
> 
> 
> - Paul
