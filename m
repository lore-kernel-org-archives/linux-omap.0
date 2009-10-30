From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] PM: Skip PER previous state register read
Date: Fri, 30 Oct 2009 09:31:38 -0700
Message-ID: <87k4ycrggl.fsf@deeprootsystems.com>
References: <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:40833 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbZJ3Qbf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 12:31:35 -0400
Received: by pwj9 with SMTP id 9so739338pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 09:31:40 -0700 (PDT)
In-Reply-To: <1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Wed\, 21 Oct 2009 14\:51\:20 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> According to measurements, reading the previous state of PER
> domain after wfi takes ~11us on OPP2.
>
> Removed this unneccessary latency from cases where we know
> PER power domain did not try to enter off mode.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Looks good, pulling into PM branch.

But still amazed at such a *huge* latency to read that register.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 237c819..b70ea19 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -489,12 +489,19 @@ void omap_sram_idle(void)
>  
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
> -		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> -		if (per_prev_state == PWRDM_POWER_OFF) {
> -			omap3_per_restore_context();
> -			omap3_gpio_restore_pad_context(0);
> -		} else if (per_next_state == PWRDM_POWER_OFF)
> -			omap3_gpio_restore_pad_context(1);
> +		if (per_next_state == PWRDM_POWER_OFF) {
> +			/*
> +			 * Reading the prev-state takes long time (11us@OPP2),
> +			 * only do it, if we really tried to put PER in OFF
> +			 */
> +			per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> +			if (per_prev_state == PWRDM_POWER_OFF) {
> +				omap3_per_restore_context();
> +				omap3_gpio_restore_pad_context(0);
> +			} else if (per_next_state == PWRDM_POWER_OFF) {
> +				omap3_gpio_restore_pad_context(1);
> +			}
> +		}
>  		omap2_gpio_resume_after_idle();
>  		omap_uart_resume_idle(2);
>  		if (per_state_modified)
> -- 
> 1.5.4.3
