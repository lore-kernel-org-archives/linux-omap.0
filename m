From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/13] OMAP2+: PM: provide the next timer event API to
 PM modules
Date: Thu, 19 May 2011 13:29:23 +0530
Message-ID: <4DD4CDDB.5040607@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com> <1305739950-11695-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35411 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755454Ab1ESH72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 03:59:28 -0400
Received: by mail-gw0-f48.google.com with SMTP id 22so1105036gwj.21
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 00:59:28 -0700 (PDT)
In-Reply-To: <1305739950-11695-9-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org

Jean,

On 5/18/2011 11:02 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Provide omap_pm_tick_nohz_get_sleep_length_us so that the code
> from the OMAP PM modules can use it.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/pm-debug.c |    7 ++++---
>   arch/arm/mach-omap2/pm.c       |   15 +++++++++++++++
>   arch/arm/mach-omap2/pm.h       |   12 ++++++++----
>   3 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 0b896d4..24e5c31 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -141,9 +141,10 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
>   	if (!resume)
>   #ifdef CONFIG_NO_HZ
>   		printk(KERN_INFO
> -		       "--- Going to %s %s (next timer after %u ms)\n", s1, s2,
> -		       jiffies_to_msecs(get_next_timer_interrupt(jiffies) -
> -					jiffies));
> +		       "--- Going to %s %s (next timer after %lu ms)\n", s1, s2,
> +		       DIV_ROUND_UP(omap_pm_tick_nohz_get_sleep_length_us(),
> +				    1000)
> +		      );
>   #else
>   		printk(KERN_INFO "--- Going to %s %s\n", s1, s2);
>   #endif
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 37a4801..0c451e3 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -14,6 +14,8 @@
>   #include<linux/io.h>
>   #include<linux/err.h>
>   #include<linux/opp.h>
> +#include<linux/hrtimer.h>
> +#include<linux/tick.h>
>
>   #include<plat/omap-pm.h>
>   #include<plat/omap_device.h>
> @@ -30,6 +32,7 @@ static struct omap_device_pm_latency *pm_lats;
>   struct cpuidle_params *cpuidle_params_override_table;
>   #endif
>
> +#ifdef CONFIG_PM_DEBUG
>   u32 enable_off_mode;
>   EXPORT_SYMBOL(enable_off_mode);
>
> @@ -37,6 +40,7 @@ int omap2_pm_debug;
>   u32 sleep_while_idle;
>   u32 wakeup_timer_seconds;
>   u32 wakeup_timer_milliseconds;
> +#endif
>
>   static struct device *mpu_dev;
>   static struct device *iva_dev;
> @@ -292,6 +296,7 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
>   }
>   #endif
>
> +#ifdef CONFIG_PM_DEBUG
>   void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
>   {
>   	u32 tick_rate, cycles;
> @@ -308,4 +313,14 @@ void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
>   		" (%d ticks at %d ticks/sec.)\n",
>   		seconds, milliseconds, cycles, tick_rate);
>   }
> +EXPORT_SYMBOL(omap2_pm_wakeup_on_timer);
> +#endif
> +
> +#ifdef CONFIG_NO_HZ
> +unsigned long omap_pm_tick_nohz_get_sleep_length_us(void)
> +{
> +	return ktime_to_us(tick_nohz_get_sleep_length());
> +}
> +EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
This wrapper seems to be un-necesssary. You can directly use
"ktime_to_us(tick_nohz_get_sleep_length())" instead.

Regards
Santosh
