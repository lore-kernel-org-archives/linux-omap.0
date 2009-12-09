From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Smartreflex: Avoid unnecessary spam
Date: Wed, 09 Dec 2009 15:15:26 -0800
Message-ID: <87y6lbsprl.fsf@deeprootsystems.com>
References: <1260281775-30361-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55956 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616AbZLIXPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 18:15:23 -0500
Received: by yxe17 with SMTP id 17so6434683yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 15:15:30 -0800 (PST)
In-Reply-To: <1260281775-30361-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Tue\,  8 Dec 2009 16\:16\:15 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Current warning messages will be constantly printed out during normal operation
> if smartreflex autocompensation is disabled.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Agreed that these warnings are spam, but I think they should be
replaced by some one-time warning so at least there's a hint someplace
that SR is not actually being done on a platfrom.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   10 +---------
>  1 files changed, 1 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index be3a1da..db228b2 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -675,13 +675,8 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
>  		sr_configure(sr);
>  	}
>  
> -	if (sr->is_autocomp_active == 1)
> -		pr_warning("SR%d: VDD autocomp is already active\n",
> -									srid);
> -
>  	sr->is_autocomp_active = 1;
>  	if (!sr_enable(sr, target_opp_no)) {
> -		pr_warning("SR%d: VDD autocomp not activated\n", srid);
>  		sr->is_autocomp_active = 0;
>  		if (sr->is_sr_reset == 1)
>  			sr_clk_disable(sr);
> @@ -707,11 +702,8 @@ int sr_stop_vddautocomap(int srid)
>  		/* Reset the volatage for current OPP */
>  		sr_reset_voltage(srid);
>  		return true;
> -	} else {
> -		pr_warning("SR%d: VDD autocomp is not active\n",
> -								srid);
> +	} else
>  		return false;
> -	}
>  
>  }
>  EXPORT_SYMBOL(sr_stop_vddautocomap);
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
