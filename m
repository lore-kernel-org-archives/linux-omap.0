From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH] arm:omap:omap4: Remove hardcoded reg-offs for
 PWRSTCTRL & PWRSTST
Date: Sun, 8 Jan 2012 09:50:49 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A807547B@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
	<1324371451-2267-1-git-send-email-hvaibhav@ti.com> <87ehvc3a4g.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813Ab2AHJu6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jan 2012 04:50:58 -0500
In-Reply-To: <87ehvc3a4g.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Saturday, January 07, 2012 12:57 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Nayak, Rajendra; Tony
> Lindgren
> Subject: Re: [RFC PATCH] arm:omap:omap4: Remove hardcoded reg-offs for
> PWRSTCTRL & PWRSTST
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > PRM module in AM33XX is closer to OMAP4 PRM module, so it makes complete
> > sense to reuse all the code from existing OMAP4 implementation.
> > Having said that, ther is a catch here with respect to AM33XX device,
> >
> > The register offset in PRM module is not consistent
> > across (crazy IP integration), for example,
> >
> > PRM_XXX         PWRSTCTRL PWRSTST RSTCTRL RSTST
> > ===============================================
> > PRM_PER_MOD:    0x0C,     0x08,   0x00,   0x04
> > PRM_WKUP_MOD:   0x04,     0x08,   0x00,   0x0C
> > PRM_MPU_MOD:    0x00,     0x04,   0x08,   NA
> > PRM_DEVICE_MOD: NA,       NA,     0x00,   0x08
> >
> > So in order to reuse the existing OMAP4 code, we have to add
> > separate entry for register offsets, especially
> > PWRSTCTRL & PWRSTST.
> 
> > This patch removes the existing hard-coded way of providing
> > offset to omap4_prminst_xxx API's and instead use offsets
> > provided in powerdomainsxxxx_data.
> 
> Thanks, I think this is a much better approach.
> 
Kevin, Thanks a lot for review ...

> However, for ease of review, I think it should still be broken up a bit
> more.  First, create a patch that just changes the existing OMAP4 code
> to use the new fields without changing any functionality.
> powerdomain.h, pwerdomain44xx.c, powerdomains44xx_data.c
> 
> Then, the AM33x support should be added in a separate patch.
> 
Ok, point taken.
I will divide it into 3 logical patches.


> [...]
> 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> omap2/omap_hwmod.c
> > index 5192cab..4fd53d4 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -1288,14 +1288,14 @@ static int _assert_hardreset(struct omap_hwmod
> *oh, const char *name)
> >  	if (IS_ERR_VALUE(ret))
> >  		return ret;
> >
> > -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > -		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
> > -						  ohri.rst_shift);
> 
> Why are moving this OMAP2/3 code below?
> 
> I assume it is because cpu_is_omap34xx() is true for AM33xx?  If so, a
> comment is probably needed here so we don't mess with the ordering.
> 
Ok, will add comment in next version.

Thanks,
Vaibhav

> > -	else if (cpu_is_omap44xx())
> > +	if (cpu_is_omap44xx() || cpu_is_am33xx())
> >  		return omap4_prminst_assert_hardreset(ohri.rst_shift,
> >  				  oh->clkdm->pwrdm.ptr->prcm_partition,
> >  				  oh->clkdm->pwrdm.ptr->prcm_offs,
> >  				  oh->prcm.omap4.rstctrl_offs);
> > +	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > +		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
> > +						  ohri.rst_shift);
> >  	else
> >  		return -EINVAL;
> >  }
> > @@ -1322,11 +1322,7 @@ static int _deassert_hardreset(struct omap_hwmod
> *oh, const char *name)
> >  	if (IS_ERR_VALUE(ret))
> >  		return ret;
> >
> > -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> > -		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
> > -						   ohri.rst_shift,
> > -						   ohri.st_shift);
> > -	} else if (cpu_is_omap44xx()) {
> > +	if (cpu_is_omap44xx() || cpu_is_am33xx()) {
> >  		if (ohri.st_shift)
> >  			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does
> not support st_shift\n",
> >  			       oh->name, name);
> > @@ -1334,6 +1330,10 @@ static int _deassert_hardreset(struct omap_hwmod
> *oh, const char *name)
> >  				  oh->clkdm->pwrdm.ptr->prcm_partition,
> >  				  oh->clkdm->pwrdm.ptr->prcm_offs,
> >  				  oh->prcm.omap4.rstctrl_offs);
> > +	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> > +		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
> > +						   ohri.rst_shift,
> > +						   ohri.st_shift);
> 
> same comment as above.
> 
> Kevin
