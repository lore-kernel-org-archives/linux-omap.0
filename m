From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: Fix compile error
Date: Tue, 25 Nov 2008 10:34:37 -0800
Message-ID: <878wr7psci.fsf@deeprootsystems.com>
References: <1227253118-32169-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:47626 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbYKYSep (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 13:34:45 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1163720ugf.37
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 10:34:43 -0800 (PST)
In-Reply-To: <1227253118-32169-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Fri\, 21 Nov 2008 13\:08\:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev,

Sanjeev Premi <premi@ti.com> writes:

> Function pm_dbg_update_time() is defined in within
> an #ifdef CONFIG_DEBUG_FS; leading to this error:
>
> arch/arm/mach-omap2/built-in.o: In function `_pwrdm_state_switch':
> /db/psp_git/users/a0756819/omap-kern-latest/arch/arm/mach-omap2/powerdomain.c:139: undefined reference to `pm_dbg_update_time'
>

Thanks. I have a similar fix for this already staged for the next PM branch.

Kevin

> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 0334609..081b3b6 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -136,7 +136,9 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>  	if (state != prev)
>  		pwrdm->state_counter[state]++;
>  
> +#ifdef CONFIG_DEBUG_FS
>  	pm_dbg_update_time(pwrdm, prev);
> +#endif
>  
>  	pwrdm->state = state;
>  
> -- 
> 1.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
