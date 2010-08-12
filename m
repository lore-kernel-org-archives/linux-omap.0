From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM debugfs removing OMAP3 hardcodings.
Date: Thu, 12 Aug 2010 07:17:13 -0700
Message-ID: <878w4bvrti.fsf@deeprootsystems.com>
References: <1281601345-4599-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47893 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab0HLORP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 10:17:15 -0400
Received: by pxi10 with SMTP id 10so444412pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 07:17:15 -0700 (PDT)
In-Reply-To: <1281601345-4599-1-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Thu, 12 Aug 2010 13:52:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

Thara Gopinath <thara@ti.com> writes:

> This patch removes omap3 hardcodings from pm-debug.c
> so that enabling PM debugfs support does break compilation
> for other OMAP's. This is a preparatory patch for supporting
> OMAP4 pm entries through PM debugfs.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Looks good.  Queuing to pm-fixes for 2.6.36-rc series.

Kevin

> ---
>  arch/arm/mach-omap2/pm-debug.c |   21 ++++++++++++++++-----
>  arch/arm/mach-omap2/pm34xx.c   |    5 -----
>  2 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 723b44e..056ff17 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -37,6 +37,10 @@
>  #include "pm.h"
>  
>  int omap2_pm_debug;
> +u32 enable_off_mode;
> +u32 sleep_while_idle;
> +u32 wakeup_timer_seconds;
> +u32 wakeup_timer_milliseconds;
>  
>  #define DUMP_PRM_MOD_REG(mod, reg)    \
>  	regs[reg_count].name = #mod "." #reg; \
> @@ -494,8 +498,10 @@ int pm_dbg_regset_init(int reg_set)
>  
>  static int pwrdm_suspend_get(void *data, u64 *val)
>  {
> -	int ret;
> -	ret = omap3_pm_get_suspend_state((struct powerdomain *)data);
> +	int ret = -EINVAL;
> +
> +	if (cpu_is_omap34xx())
> +		ret = omap3_pm_get_suspend_state((struct powerdomain *)data);
>  	*val = ret;
>  
>  	if (ret >= 0)
> @@ -505,7 +511,10 @@ static int pwrdm_suspend_get(void *data, u64 *val)
>  
>  static int pwrdm_suspend_set(void *data, u64 val)
>  {
> -	return omap3_pm_set_suspend_state((struct powerdomain *)data, (int)val);
> +	if (cpu_is_omap34xx())
> +		return omap3_pm_set_suspend_state(
> +			(struct powerdomain *)data, (int)val);
> +	return -EINVAL;
>  }
>  
>  DEFINE_SIMPLE_ATTRIBUTE(pwrdm_suspend_fops, pwrdm_suspend_get,
> @@ -553,8 +562,10 @@ static int option_set(void *data, u64 val)
>  
>  	*option = val;
>  
> -	if (option == &enable_off_mode)
> -		omap3_pm_off_mode_enable(val);
> +	if (option == &enable_off_mode) {
> +		if (cpu_is_omap34xx())
> +			omap3_pm_off_mode_enable(val);
> +	}
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index fb4994a..9c0301b 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -55,11 +55,6 @@
>  #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
>  #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
>  
> -u32 enable_off_mode;
> -u32 sleep_while_idle;
> -u32 wakeup_timer_seconds;
> -u32 wakeup_timer_milliseconds;
> -
>  struct power_state {
>  	struct powerdomain *pwrdm;
>  	u32 next_state;
