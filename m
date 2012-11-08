From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Thu, 8 Nov 2012 14:41:50 -0600
Message-ID: <509C190E.8010001@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34312 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504Ab2KHUl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 15:41:57 -0500
In-Reply-To: <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com


On 11/02/2012 07:32 AM, Vaibhav Bedia wrote:
> AM33XX has only one usable timer in the WKUP domain.
> Currently the timer instance in WKUP domain is used
> as the clockevent and the timer in non-WKUP domain
> as the clocksource. The timer in WKUP domain can keep
> running in suspend from a 32K clock and hence serve
> as the persistent clock. To enable this, interchange
> the timers used as clocksource and clockevent for
> AM33XX. A subsequent patch will add suspend-resume
> support for the clockevent to ensure that there are
> no issues with timekeeping.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 565e575..6584ee0 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -460,7 +460,7 @@ OMAP_SYS_TIMER(3_secure)
>  #endif
>  
>  #ifdef CONFIG_SOC_AM33XX
> -OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
> +OMAP_SYS_TIMER_INIT(3_am33xx, 2, OMAP4_MPU_SOURCE, 1, OMAP4_MPU_SOURCE)
>  OMAP_SYS_TIMER(3_am33xx)
>  #endif

By the way, for v3.8 (assuming that timer DT patches go in, currently
queued in Tony's master), when booting with DT the clock-source and
clock-events will be selected by timer feature and not ID. So you may
wish to rebase on top of Tony's master.

Cheers
Jon
