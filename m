From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix the pwrdm_enable/disable_hdwr_sar funcs
Date: Fri, 05 Jun 2009 15:10:35 -0700
Message-ID: <87hbyu72n8.fsf@deeprootsystems.com>
References: <1244206853-4426-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:45770 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZFEWKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 18:10:36 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1120404pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 15:10:39 -0700 (PDT)
In-Reply-To: <1244206853-4426-1-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Fri\,  5 Jun 2009 18\:30\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> The pwrdm_enable_hdwr_sar/pwrdm_disable_hdwr_sar do not
> actually set/reset the SAVEANDRESTORE bit in the PWSTCTRL
> register but modify some other bit instead.
> This happens due to the OMAP3430ES2_SAVEANDRESTORE_SHIFT
> being defined as (1 << 4) instead of just 4.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, pushing to PM branch.

I'll wait to hear from Kalle if we can revert his previous patch
for this.

Kevin

> ---
>  arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index 06fee29..d4ea370 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -411,7 +411,7 @@
>  /* PM_PREPWSTST_CAM specific bits */
>  
>  /* PM_PWSTCTRL_USBHOST specific bits */
> -#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
> +#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
>  
>  /* RM_RSTST_PER specific bits */
>  
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
