From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/17] OMAP2/3: GPTIMER: Clear pending interrupts when entering suspend
Date: Tue, 20 Oct 2009 10:36:49 -0700
Message-ID: <87skdej7bi.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:55365 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZJTRgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:36:46 -0400
Received: by pzk26 with SMTP id 26so4249946pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 10:36:50 -0700 (PDT)
In-Reply-To: <1255690150-16853-9-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 16 Oct 2009 13\:49\:01 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> OMAP GP timers keep running for a few cycles after they are stopped,
> which can cause the timer to expire and generate an interrupt. The pending
> interrupt will prevent OMAP from entering suspend, thus we ack it manually.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
> ---
>  arch/arm/mach-omap2/timer-gp.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
> index 9c056ff..c9d47bb 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -92,9 +92,21 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>  	case CLOCK_EVT_MODE_ONESHOT:
>  		break;
>  	case CLOCK_EVT_MODE_UNUSED:
> -	case CLOCK_EVT_MODE_SHUTDOWN:
>  	case CLOCK_EVT_MODE_RESUME:
>  		break;
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		/*
> +		 * Wait for min period x 2 to make sure that timer is
> +		 * stopped
> +		 */
> +		udelay(evt->min_delta_ns / 500);
> +		/*
> +		 * Clear possibly pending interrupt, this will occasionally
> +		 * generate spurious timer IRQs during suspend but this
> +		 * is okay, as another option is not to enter suspend at all
> +		 */
> +		omap_dm_timer_write_status(gptimer, OMAP_TIMER_INT_OVERFLOW);
> +		break;

Seems to me that this fix should just be done in omap_dm_timer_stop()
since it could also result in extra interrupts in when using oneshot
mode under dyntick.

Kevin

