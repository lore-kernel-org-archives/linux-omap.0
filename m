From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq
Date: Mon, 18 Nov 2013 18:11:08 -0500
Message-ID: <528A9E8C.9040903@ti.com>
References: <20131118215855.GW10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52117 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3KRXLg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 18:11:36 -0500
In-Reply-To: <20131118215855.GW10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Monday 18 November 2013 04:58 PM, Tony Lindgren wrote:
> If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
> or dra7xx, we can get the following error:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
> :(.text+0x7ab0): undefined reference to `set_cntfreq'
> 
> Fix the issue by not trying to initalize the realtime counter
> unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
How about a dummy inline function of set_cntfreq() ?
Having #ifdef in middle of the code looks pretty ugly.

> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -65,12 +65,14 @@ static void omap4_secondary_init(unsigned int cpu)
>  		omap_secure_dispatcher(OMAP4_PPA_CPU_ACTRL_SMP_INDEX,
>  							4, 0, 0, 0, 0, 0);
>  
> +#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
>  	/*
>  	 * Configure the CNTFRQ register for the secondary cpu's which
>  	 * indicates the frequency of the cpu local timers.
>  	 */
>  	if (soc_is_omap54xx() || soc_is_dra7xx())
>  		set_cntfreq();
> +#endif
>  
>  	/*
>  	 * Synchronise with the boot thread.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

