From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: Disable usb host HW save and restore
Date: Thu, 14 May 2009 10:10:21 -0700
Message-ID: <87zldftxtu.fsf@deeprootsystems.com>
References: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:45972 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760888AbZENRKX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:10:23 -0400
Received: by wf-out-1314.google.com with SMTP id 26so869710wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 10:10:24 -0700 (PDT)
In-Reply-To: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Thu\, 23 Apr 2009 13\:58\:51 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, nm@ti.com, r-woodruff2@ti.com, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> The hardware SAVEANDRESTORE mechanism seems to leave
> USB HOST power domain permanently into active state
> after one transition from off to active state.
> Disabling for now.
>
> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Thanks, pushing to PM branch.

Paul, will you incoporate this into your upstream queue as well?

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/powerdomains34xx.h |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
> index 4dcf94b..aa557b2 100644
> --- a/arch/arm/mach-omap2/powerdomains34xx.h
> +++ b/arch/arm/mach-omap2/powerdomains34xx.h
> @@ -338,7 +338,13 @@ static struct powerdomain usbhost_pwrdm = {
>  	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
> -	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBHOST ctrlr only */
> +	/*
> +	 * REVISIT: Enabling usb host save and restore mechanism seems to
> +	 * leave the usb host domain permanently in ACTIVE mode after
> +	 * changing the usb host power domain state from OFF to active once.
> +	 * Disabling for now.
> +	 */
> +	/*.flags	  = PWRDM_HAS_HDWR_SAR,*/ /* for USBHOST ctrlr only */
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	  = {
>  		[0] = PWRDM_POWER_RET, /* MEMRETSTATE */
> -- 
> 1.5.4.3
