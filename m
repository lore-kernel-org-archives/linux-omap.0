From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP3: CPUidle: Fixed timer resolution
Date: Wed, 11 Nov 2009 16:30:13 -0800
Message-ID: <87eio4wpnu.fsf@deeprootsystems.com>
References: <1256562640-15242-1-git-send-email-tero.kristo@nokia.com>
	<1256562640-15242-2-git-send-email-tero.kristo@nokia.com>
	<1256562640-15242-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:50804 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759685AbZKLAaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 19:30:10 -0500
Received: by pzk1 with SMTP id 1so137086pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 16:30:15 -0800 (PST)
In-Reply-To: <1256562640-15242-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Mon\, 26 Oct 2009 15\:10\:40 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Previously used u32 as temporary data storage that wraps around at 4.294s.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, applying to PM branch, queing for pm-fixes.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index a0d9f56..0ac3b63 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -137,7 +137,7 @@ return_sleep_time:
>  	local_irq_enable();
>  	local_fiq_enable();
>  
> -	return (u32)timespec_to_ns(&ts_idle)/1000;
> +	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
>  }
>  
>  /**
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
