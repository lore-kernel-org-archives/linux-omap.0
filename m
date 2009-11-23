From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK
 position
Date: Mon, 23 Nov 2009 07:39:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911230738170.29834@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE89444BE28394@dlee02.ent.ti.com> <1251444297-13577-1-git-send-email-thara@ti.com> <alpine.DEB.2.00.0910141536210.23283@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A46CFE7@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0910160214200.32618@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A46D3B4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55647 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbZKWOjG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 09:39:06 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A46D3B4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hello Thara,

On Fri, 16 Oct 2009, Gopinath, Thara wrote:

> Yes sounds definitely reasonable :-). I agree,we should try to do away with the strcmp if possible.
> I will implement the same and repost this fix.

Had a chance to work on this yet?  It would be good to get this fix in at 
some point.  
.

- Paul

> 
> Regards
> Thara
> 
> >>-----Original Message-----
> >>From: Paul Walmsley [mailto:paul@pwsan.com]
> >>Sent: Friday, October 16, 2009 1:51 PM
> >>To: Gopinath, Thara
> >>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com
> >>Subject: RE: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
> >>
> >>Hi Thara,
> >>
> >>On Thu, 15 Oct 2009, Gopinath, Thara wrote:
> >>
> >>> Thanks Paul. The bit positions are goofed up only in PWRSTS and
> >>> PREPWRSTS not in PWSTCTRL register. As per the approach you have
> >>> suggested below, if we change the mem bank number from 0 to 1 , we will
> >>> have to change the logic for read/write into PWSTCTRL for mpu pwr
> >>> domain.
> >>
> >>Okay.  Here's what I'd propose: rather than testing for the
> >>powerdomain name in the function, or testing for the MPU PRCM module
> >>offset, let's add a new powerdomain flag into powerdomain.h,
> >>
> >>#define PWRDM_OMAP3_MPU_QUIRK	 (1 << 1) /* MPU bit pos quirk */
> >>
> >>or something similar.  Then let's set that for the mpu_pwrdm in
> >>powerdomains34xx.h and test for that flag in powerdomain.c.
> >>
> >>I prefer this since RMK has previously NAK'ed strcmp()s for this sort of
> >>thing, for good reason, and testing the PRCM internal module offset has
> >>many of the same problems.
> >>
> >>Sound reasonable?
> >>
> >>
> >>- Paul
> >>
> >>
> >>>
> >>> Regards
> >>> Thara
> >>>
> >>> >>-----Original Message-----
> >>> >>From: Paul Walmsley [mailto:paul@pwsan.com]
> >>> >>Sent: Thursday, October 15, 2009 4:51 AM
> >>> >>To: Gopinath, Thara
> >>> >>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com
> >>> >>Subject: Re: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
> >>> >>
> >>> >>Hi Thara,
> >>> >>
> >>> >>I regret the delay.  A comment:
> >>> >>
> >>> >>On Fri, 28 Aug 2009, Thara Gopinath wrote:
> >>> >>
> >>> >>> MPU power domain bank 0 bits are displayed in position of bank 1
> >>> >>> in PWRSTS and PREPWRSTS registers. So read them from correct
> >>> >>> position
> >>> >>
> >>> >>Indeed.  What do you think about a slightly different approach: changing
> >>> >>powerdomains34xx.h to be correct?  In other words, instead of
> >>> >>
> >>> >>	.pwrsts_mem_ret	  = {
> >>> >>		[0] = PWRSTS_OFF_RET,
> >>> >>	},
> >>> >>	.pwrsts_mem_on	  = {
> >>> >>		[0] = PWRSTS_OFF_ON,
> >>> >>	},
> >>> >>
> >>> >>we would use:
> >>> >>
> >>> >>	.pwrsts_mem_ret	  = {
> >>> >>		[1] = PWRSTS_OFF_RET,
> >>> >>	},
> >>> >>	.pwrsts_mem_on	  = {
> >>> >>		[1] = PWRSTS_OFF_ON,
> >>> >>	},
> >>> >>
> >>> >>We have to deal with the bank count field in struct powerdomain - we could
> >>> >>just convert it into a bitmap representing available banks.  So instead
> >>> >>of:
> >>> >>
> >>> >>        .banks = 1,
> >>> >>
> >>> >>use maybe:
> >>> >>
> >>> >>	.banks = PWRDM_BANK_1,  /* | PWRDM_BANK_0, etc */
> >>> >>
> >>> >>
> >>> >>Can you foresee any problems with the above approach?
> >>> >>
> >>> >>- Paul
> >>> >>
> >>> >>> Patch refresh issue.
> >>> >>>
> >>> >>>  arch/arm/mach-omap2/powerdomain.c |   19 +++++++++++++++++++
> >>> >>>  1 files changed, 19 insertions(+), 0 deletions(-)
> >>> >>>
> >>> >>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> >>> >>> index 2594cbf..6c5fee9 100644
> >>> >>> --- a/arch/arm/mach-omap2/powerdomain.c
> >>> >>> +++ b/arch/arm/mach-omap2/powerdomain.c
> >>> >>> @@ -971,6 +971,16 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
> >>> >>>  		return -EEXIST;
> >>> >>>
> >>> >>>  	/*
> >>> >>> +	 * In 3430, for MPU domain bank 0 status bits
> >>> >>> +	 * are displayed in the position of bank1 status bits
> >>> >>> +	 * in PWST  . So the hack. Think of a cleaner
> >>> >>> +	 * way of doing this
> >>> >>> +	 */
> >>> >>> +	if (cpu_is_omap34xx())
> >>> >>> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
> >>> >>> +			bank = 1;
> >>> >>> +
> >>> >>> +	/*
> >>> >>>  	 * The register bit names below may not correspond to the
> >>> >>>  	 * actual names of the bits in each powerdomain's register,
> >>> >>>  	 * but the type of value returned is the same for each
> >>> >>> @@ -1018,6 +1028,15 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
> >>> >>>  		return -EEXIST;
> >>> >>>
> >>> >>>  	/*
> >>> >>> +	 * In 3430, for MPU domain bank 0 status bits
> >>> >>> +	 * are displayed in the position of bank1 status bits
> >>> >>> +	 * in PREPWST  . So the hack. Think of a cleaner
> >>> >>> +	 * way of doing this
> >>> >>> +	 */
> >>> >>> +	if (cpu_is_omap34xx())
> >>> >>> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
> >>> >>> +			bank = 1;
> >>> >>> +	/*
> >>> >>>  	 * The register bit names below may not correspond to the
> >>> >>>  	 * actual names of the bits in each powerdomain's register,
> >>> >>>  	 * but the type of value returned is the same for each
> >>> >>> --
> >>> >>> 1.5.4.7
> >>> >>>
> >>> >>> --
> >>> >>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >>> >>> the body of a message to majordomo@vger.kernel.org
> >>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> >>>
> >>> >>
> >>> >>
> >>> >>- Paul
> >>>
> >>
> >>
> >>- Paul
> 


- Paul
