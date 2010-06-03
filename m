From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] OMAP3: Adding Smartreflex and Voltage driver support
Date: Thu, 03 Jun 2010 16:27:00 -0700
Message-ID: <877hmfk88r.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
	<87zkzd3sc2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45770 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654Ab0FCX1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 19:27:03 -0400
Received: by pwj2 with SMTP id 2so315928pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 16:27:03 -0700 (PDT)
In-Reply-To: <87zkzd3sc2.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 02 Jun 2010 16\:52\:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Thara Gopinath <thara@ti.com> writes:
>
>> This patch series introduces smartreflex and voltage driver support
>> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
>> control for real-time voltage adjustments.
>>
>> Originally all the functionalities introduced in this patch
>> were present in arch/arm/mach-omap2/smartreflex.c file in Kevin's
>> pm tree. This patch series does a major rewrite of this file
>> and introduces a separate voltage driver. Major contributors
>> to the original driver are
>
> This is excellent, thanks for the rebase/reorg/compress.
>
> While not yet get getting to a full review of this series, I'd like it
> to get some broader testing.  To that end, I've replaced the pm-sr
> branch in my pm tree with this series, and rebuilt a new PM branch
> using it.
>
> Note that it is also based on top of a new pm-opp branch which is
> Nishanth's condensed version which is also upstream bound for the next
> merge window.
>
> I had to do a couple minor fixes to apply against v2.6.35-rc1 (mainly
> fixing usage of #defines that were renamed to have a _MASK suffix.)
>
> It currently boots fine on OMAP3EVM (no efuse values, so no SR) but
> when I try it on Zoom3, I get repeated errors:
>
>   Wake up daisy chain activation failed. 
>
> I haven't fully isolated the root cause yet, but it looks like it
> might be because omap3_enable_io_chain() seems confused about whether
> it should be writing PM_WKEN or PM_WKST reg.
>
> The patch below (on top of new PM branch) seems to have fixed that
> problem for Zoom3.

FYI... I've posted this patch below and it is now in my pm-fixes
branch which is part of the PM branch.

Kevin

>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e531621..207905d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -115,7 +115,7 @@ static void omap3_enable_io_chain(void)
>  		/* Do a readback to assure write has been done */
>  		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>  
> -		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
> +		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
>  			 OMAP3430_ST_IO_CHAIN_MASK)) {
>  			timeout++;
>  			if (timeout > 1000) {
> @@ -124,7 +124,7 @@ static void omap3_enable_io_chain(void)
>  				return;
>  			}
>  			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> -					     WKUP_MOD, PM_WKST);
> +					     WKUP_MOD, PM_WKEN);
>  		}
>  	}
>  }
