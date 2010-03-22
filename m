From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: [PATCH] OMAP3: PM: Modify suspend wakeup timer to use
	milliseconds instead of seconds
Date: Mon, 22 Mar 2010 19:10:26 +0200
Message-ID: <20100322171026.GP5610@pcarmody-desktop>
References: <1269245454-24254-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47947 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab0CVRJi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 13:09:38 -0400
Content-Disposition: inline
In-Reply-To: <1269245454-24254-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

On 22/03/10 09:10 +0100, Kauppi Ari (EXT-Ixonos/Oulu) wrote:
> Millisecond resolution is possible and there are use cases for it
> (automatic testing).
> 
> Seconds-based interface is preserved for compatibility.
> 
> Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
> ---
...
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 3868c76..cd55968 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
...
> @@ -640,20 +640,20 @@ out:
>  }
>  
>  #ifdef CONFIG_SUSPEND
> -static void omap2_pm_wakeup_on_timer(u32 seconds)
> +static void omap2_pm_wakeup_on_timer(u32 milliseconds)
>  {
>  	u32 tick_rate, cycles;
>  
> -	if (!seconds)
> +	if (!milliseconds)
>  		return;
>  
>  	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
> -	cycles = tick_rate * seconds;
> +	cycles = tick_rate * milliseconds / 1000;

Ari has pointed me here regarding clarification of whether the above
is an overflow risk? At 32768 Hz, the above intermediate will overflow 
a u32 if milliseconds >= 131072, e.g. 2 minutes 10+ seconds. 

If there is an overflow risk, then something like the following would
work around it:

	u32 seconds = milliseconds / 1000;
	milliseconds -= seconds * 1000;
	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;

(Alternatively, a u64 could be used for the intermediate, and we could
just let gcc manage the 64 bit / constant 32 bit division.)

Unfortunately, as tick_rate is not a constant, there's no trivial fast-path 
check for overflow before it happens. Then again, this looks like it's
only used in debug code, so hopefully that's not an issue.

Phil
