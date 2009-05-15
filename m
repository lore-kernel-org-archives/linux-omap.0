From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix Smartreflex when used with PM_NOOP layer
Date: Fri, 15 May 2009 07:54:50 -0700
Message-ID: <87eiuq2z7p.fsf@deeprootsystems.com>
References: <1242388547-4241-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:62541 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbZEOOy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 10:54:58 -0400
Received: by pzk13 with SMTP id 13so1097403pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 07:54:59 -0700 (PDT)
In-Reply-To: <1242388547-4241-1-git-send-email-ext-roger.quadros@nokia.com> (Roger Quadros's message of "Fri\, 15 May 2009 14\:55\:47 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org, ext-phil.2.carmody@nokia.com

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> omap_pm_vddX_get_opp() returns 0 if PM layer is PM_NOOP or PM_NONE.
> This is not a valid OPP so we must sanity check this correctly before using.
>
> This patch fixes system lockup when we enable smartreflex
> "echo 1 > /sys/power/sr_vdd1_autocomp"
>
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Oops, this looks like a side effect of my merge of Rajendra's and Phil's
patches.   

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 42e16a6..b032366 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -787,8 +787,10 @@ static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
>  		sr_stop_vddautocomap(SR1);
>  	} else {
>  		u32 current_vdd1opp_no = omap_pm_vdd1_get_opp();
> -		if (IS_ERR_VALUE(current_vdd1opp_no))
> -			return -ENODEV;
> +		if (!current_vdd1opp_no) {
> +			pr_err("sr_vdd1_autocomp: Current VDD1 opp unknown\n");
> +			return -EINVAL;
> +		}
>  		sr_start_vddautocomap(SR1, current_vdd1opp_no);
>  	}
>  	return n;
> @@ -825,8 +827,10 @@ static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
>  		sr_stop_vddautocomap(SR2);
>  	} else {
>  		u32 current_vdd2opp_no = omap_pm_vdd2_get_opp();
> -		if (IS_ERR_VALUE(current_vdd2opp_no))
> -			return -ENODEV;
> +		if (!current_vdd2opp_no) {
> +			pr_err("sr_vdd2_autocomp: Current VDD2 opp unknown\n");
> +			return -EINVAL;
> +		}
>  		sr_start_vddautocomap(SR2, current_vdd2opp_no);
>  	}
>  	return n;
> -- 
> 1.6.0.4
