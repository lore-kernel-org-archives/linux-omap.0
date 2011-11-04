From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 11/11] omap4: use lp params for calculating pmic setup times
Date: Fri, 04 Nov 2011 13:49:31 -0700
Message-ID: <87ty6j8vfo.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:59015 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621Ab1KDUte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 16:49:34 -0400
Received: by mail-qw0-f51.google.com with SMTP id g24so2419352qab.10
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 13:49:33 -0700 (PDT)
In-Reply-To: <1317835031-8201-12-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 5 Oct 2011 20:17:11 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Missing descriptive changelog.

Why are the PMIC timings not relevant for OMAP3?

Kevin

> ---
>  arch/arm/mach-omap2/vc.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index ee0edf3..badf28b 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -381,6 +381,15 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
>  		OMAP4_DOWNTIME_MASK);
>  
>  	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
> +
> +	omap_pm_get_pmic_lp_time(&tstart, &tshut);
> +
> +	val = omap4_usec_to_val_scrm(tstart, OMAP4_WAKEUPTIME_SHIFT,
> +		OMAP4_WAKEUPTIME_MASK);
> +	val |= omap4_usec_to_val_scrm(tshut, OMAP4_SLEEPTIME_SHIFT,
> +		OMAP4_SLEEPTIME_MASK);
> +
> +	__raw_writel(val, OMAP4_SCRM_PMICSETUPTIME);
>  }
>  
>  /* OMAP4 specific voltage init functions */
