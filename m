From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: [PATCH v2] OMAP3: PM: Add milliseconds interface to suspend
	wakeup timer
Date: Tue, 23 Mar 2010 10:32:49 +0200
Message-ID: <20100323083248.GA18857@pcarmody-desktop>
References: <1269245454-24254-1-git-send-email-Ext-Ari.Kauppi@nokia.com> <1269327899-22541-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40459 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0CWIcB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 04:32:01 -0400
Content-Disposition: inline
In-Reply-To: <1269327899-22541-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

On 23/03/10 08:04 +0100, Kauppi Ari (EXT-Ixonos/Oulu) wrote:
> Millisecond resolution is possible and there are use cases for it
> (automatic testing).
> 
> Seconds-based interface is preserved for compatibility.
> 
> Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
>
> ---
> v2: Keep seconds and milliseconds interfaces strictly separate:
>  - Consistent interface, setting/getting seconds and milliseconds
>    is always accurate
>  - Fixes potential overflow issues in omap2_pm_wakeup_on_timer
>  - Cleaner patch

Nice one. Just what we need, nothing more, nothing less.

Reviewed-by: Phil Carmody <ext-phil.2.carmody@nokia.com>

Phil

> ---
>  arch/arm/mach-omap2/pm-debug.c |    7 +++++++
>  arch/arm/mach-omap2/pm.h       |    1 +
>  arch/arm/mach-omap2/pm34xx.c   |   17 ++++++++++-------
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 8aafd71..83acaa2 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -548,6 +548,9 @@ static int option_set(void *data, u64 val)
>  {
>  	u32 *option = data;
>  
> +	if (option == &wakeup_timer_milliseconds && val >= 1000)
> +		return -EINVAL;
> +
>  	*option = val;
>  
>  	if (option == &enable_off_mode)
> @@ -605,6 +608,10 @@ static int __init pm_dbg_init(void)
>  				   &sleep_while_idle, &pm_dbg_option_fops);
>  	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
>  				   &wakeup_timer_seconds, &pm_dbg_option_fops);
> +	(void) debugfs_create_file("wakeup_timer_milliseconds",
> +				   S_IRUGO | S_IWUGO, d,
> +				   &wakeup_timer_milliseconds,
> +				   &pm_dbg_option_fops);
>  
>  	/* Only enable for >= ES2.1 . Going to 0V on anything under
>  	 * ES2.1 will eventually cause a crash */
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index b761be5..b3594a9 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -69,6 +69,7 @@ extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>  
>  extern u32 wakeup_timer_seconds;
> +extern u32 wakeup_timer_milliseconds;
>  extern struct omap_dm_timer *gptimer_wakeup;
>  
>  #ifdef CONFIG_PM_DEBUG
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 3868c76..d7922a5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -74,6 +74,7 @@ static inline bool is_suspending(void)
>  u32 enable_off_mode;
>  u32 sleep_while_idle;
>  u32 wakeup_timer_seconds;
> +u32 wakeup_timer_milliseconds;
>  u32 voltage_off_while_idle;
>  
>  struct power_state {
> @@ -640,20 +641,21 @@ out:
>  }
>  
>  #ifdef CONFIG_SUSPEND
> -static void omap2_pm_wakeup_on_timer(u32 seconds)
> +static void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
>  {
>  	u32 tick_rate, cycles;
>  
> -	if (!seconds)
> +	if (!seconds && !milliseconds)
>  		return;
>  
>  	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
> -	cycles = tick_rate * seconds;
> +	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
>  	omap_dm_timer_stop(gptimer_wakeup);
>  	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
>  
> -	pr_info("PM: Resume timer in %d secs (%d ticks at %d ticks/sec.)\n",
> -		seconds, cycles, tick_rate);
> +	pr_info("PM: Resume timer in %u.%03u secs"
> +		" (%d ticks at %d ticks/sec.)\n",
> +		seconds, milliseconds, cycles, tick_rate);
>  }
>  
>  static int omap3_pm_prepare(void)
> @@ -667,8 +669,9 @@ static int omap3_pm_suspend(void)
>  	struct power_state *pwrst;
>  	int state, ret = 0;
>  
> -	if (wakeup_timer_seconds)
> -		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
> +	if (wakeup_timer_seconds || wakeup_timer_milliseconds)
> +		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
> +					 wakeup_timer_milliseconds);
>  
>  	/* Read current next_pwrsts */
>  	list_for_each_entry(pwrst, &pwrst_list, node)
> -- 
> 1.6.4.2
