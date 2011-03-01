From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: PM: Warn users of sleep_while_idle if !CONFIG_CPU_IDLE
Date: Tue, 01 Mar 2011 13:54:17 -0800
Message-ID: <87sjv6h5h2.fsf@ti.com>
References: <1297857860-3713-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35258 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753068Ab1CAVyU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 16:54:20 -0500
Received: by mail-iy0-f176.google.com with SMTP id 12so5146144iyj.7
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 13:54:20 -0800 (PST)
In-Reply-To: <1297857860-3713-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Wed, 16 Feb 2011 17:34:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> This should help users who do a
> 'echo 1 > /debug/pm_debug/sleep_while_idle' with a
> config which has !CONFIG_CPU_IDLE and wonder
> why OMAP is'nt sleeping in idle.

This isn't quite right, as 'sleep_while_idle' is actually a flag for
whether or not to call omap_sram_idle() at all.

Even without CPUidle, WFI will still be attempted.

Kevin

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 125f565..1e722a0 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -569,6 +569,10 @@ static int option_get(void *data, u64 *val)
>  
>  	*val = *option;
>  
> +#ifndef CONFIG_CPU_IDLE
> +	if (option == &sleep_while_idle)
> +		pr_warn("CONFIG_CPU_IDLE is not enabled\n");
> +#endif
>  	return 0;
>  }
>  
> @@ -581,6 +585,11 @@ static int option_set(void *data, u64 val)
>  
>  	*option = val;
>  
> +#ifndef CONFIG_CPU_IDLE
> +	if (option == &sleep_while_idle)
> +		pr_warn("CONFIG_CPU_IDLE is not enabled\n");
> +#endif
> +
>  	if (option == &enable_off_mode) {
>  		if (val)
>  			omap_pm_enable_off_mode();
