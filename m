From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 1/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420,
 2430
Date: Tue, 21 Sep 2010 01:39:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009210126260.17727@utopia.booyaka.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com> <1284734229-16281-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009210101560.17727@utopia.booyaka.com> <0680EC522D0CC943BC586913CF3768C003C21EE0E9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46461 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab0IUHjb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 03:39:31 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C21EE0E9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Rajendra,

On Tue, 21 Sep 2010, Nayak, Rajendra wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, September 21, 2010 12:39 PM
> > To: Nayak, Rajendra
> > Cc: linux-omap@vger.kernel.org; Kevin Hilman
> > Subject: Re: [PATCH v2 1/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420,
> > 2430
> > 
> > On Fri, 17 Sep 2010, Rajendra Nayak wrote:
> > 
> > > From: Paul Walmsley <paul@pwsan.com>
> > >
> > > Add hwmod structures for I2C controllers on OMAP2420/2430.
> > >
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > 
> > 
> > > +static struct omap_hwmod omap2430_i2c1_hwmod = {
> > > +	.name		= "i2c1",
> > > +	.mpu_irqs	= i2c1_mpu_irqs,
> > > +	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> > > +	.sdma_reqs	= i2c1_sdma_reqs,
> > > +	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
> > > +	.main_clk	= "i2c1_fck",
> > > +	.prcm		= {
> > > +		.omap2 = {
> > > +			.prcm_reg_id = 1,
> > > +			.module_bit = OMAP2430_EN_I2CHS1_SHIFT,
> > > +			.idlest_reg_id = 1,
> > 
> > This is wrong - the idlest_reg_id for the 2430 I2CHS blocks is different.
> > Were these patches tested on 2430?
> 
> I did boot test on a 2430SDP after hacking around a lot with configs and commenting
> out a bunch of stuff.
> 
> And I looked for this in the boot log and assumed I2C was fine
> "i2c_omap i2c_omap.1: bus 1 rev3.7 at 100 kHz
>  i2c_omap i2c_omap.2: bus 2 rev3.7 at 2600 kHz"
> 
> I will certainly have a relook again.

My original comment was somewhat inaccurate.  Looking again at the 2430 
TRM, it looks like the idlest_reg_id is correct, but that the prcm_reg_id 
is not quite correct, at least for the FCLKEN register - not currently 
used by hwmod.  We may have to add a workaround flag for the 2430 I2CHS 
case.

I can see why this didn't cause a problem in your testing.  The clock 
framework writes to the correct FCLKEN bit, and the hwmod code currently 
doesn't touch the FCLKEN bit.  And then the hwmod code checks the 
correct IDLEST bit.

It may be that the clock framework is also buggy for the 2430 I2CHS case - 
that code will probably write to CM_ICLKEN2_CORE for 2430 I2CHS, but it 
should write to CM_ICLKEN1_CORE.  sigh...


- Paul
