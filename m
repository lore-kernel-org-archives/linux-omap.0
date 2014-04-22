From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Tue, 22 Apr 2014 11:18:02 +0530
Message-ID: <53560292.2080609@ti.com>
References: <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <20140409162327.GH27282@n2100.arm.linux.org.uk> <534686DF.7070207@ti.com> <20140410120348.GK27282@n2100.arm.linux.org.uk> <53468B8E.9040604@ti.com> <53469C29.8050906@ti.com> <20140410134028.GL27282@n2100.arm.linux.org.uk> <53477EC5.5080400@ti.com> <20140411112500.GM27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbaDVFsh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 01:48:37 -0400
In-Reply-To: <20140411112500.GM27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Friday 11 April 2014 04:55 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 11, 2014 at 11:03:57AM +0530, Sekhar Nori wrote:
>> Here is a revised patch which is just an extension of your patch 
>> with L2C-220 case handled. I dont really have L2C-220 hardware so even 
>> if you want to handle that at a later time, it would be perfectly okay 
>> with me.
> 
> This is what I came up with, which of course is very similar to yours.
> I think the only difference is that I'm allowing the state of the NS
> access bits to be preserved by the OMAP code, getting OMAP closer to
> the target of a ~0 mask.  The only bits which are clear in the mask
> passed into the L2 code by OMAP now are:
> 
> - L310_AUX_CTRL_INSTR_PREFETCH
> - L310_AUX_CTRL_DATA_PREFETCH
> - L310_AUX_CTRL_CACHE_REPLACE_RR
> - L2C_AUX_CTRL_SHARED_OVERRIDE
> - L2C_AUX_CTRL_PARITY_ENABLE
> 
> It sounds like we can kill L310_AUX_CTRL_CACHE_REPLACE_RR as well since
> that's already set for us (and fwir is the power-on-reset default too.)
> 
>  arch/arm/mach-omap2/omap4-common.c |  4 +---
>  arch/arm/mm/cache-l2x0.c           | 23 +++++++++++++++++++++--
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index c0f9a81a2d32..3b01c5223b11 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -213,8 +213,6 @@ static int __init omap_l2_cache_init(void)
>  
>  	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
>  	aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
> -		   L310_AUX_CTRL_NS_LOCKDOWN |
> -		   L310_AUX_CTRL_NS_INT_CTRL |
>  		   L2C_AUX_CTRL_SHARED_OVERRIDE |
>  		   L310_AUX_CTRL_DATA_PREFETCH |
>  		   L310_AUX_CTRL_INSTR_PREFETCH;
> @@ -223,7 +221,7 @@ static int __init omap_l2_cache_init(void)
>  	if (of_have_populated_dt())
>  		l2x0_of_init(aux_ctrl, 0xc19fffff);

Just noticed that the mask here too should have been changed to
0xcd9fffff. I will be making this change to the local version I am
committing to base my AM43x support series on.

>  	else
> -		l2x0_init(l2cache_base, aux_ctrl, 0xc19fffff);
> +		l2x0_init(l2cache_base, aux_ctrl, 0xcd9fffff);

Thanks,
Sekhar
