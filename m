From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/13] OMAP2+: PM: move the powerdomains time stats to powerdomain code
Date: Thu, 26 May 2011 13:45:01 -0700
Message-ID: <87boypb38y.fsf@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47107 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753693Ab1EZUpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 16:45:07 -0400
Received: by mail-px0-f177.google.com with SMTP id 10so748519pxi.8
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 13:45:05 -0700 (PDT)
In-Reply-To: <1305739950-11695-8-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 18 May 2011 19:32:24 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Move the powerdomains time accounting code from in pm-debug to the
> powerdomain code. The pm-debug code only displays the information on
> request.
>
> This also cleans up the core PM code, in order to allow it to be used
> as a module.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

This make sense to me, and probably can be merged separately from this
series, if Paul is OK with it.

Kevin

> ---
>  arch/arm/mach-omap2/pm-debug.c    |   26 +-------------------------
>  arch/arm/mach-omap2/pm.h          |    2 --
>  arch/arm/mach-omap2/powerdomain.c |   25 ++++++++++++++++++++++++-
>  arch/arm/mach-omap2/powerdomain.h |    3 +++
>  4 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 98cc9ee..0b896d4 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -333,21 +333,6 @@ static const char pwrdm_state_names[][PWRDM_MAX_PWRSTS] = {
>  	"ON"
>  };
>  
> -void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
> -{
> -	s64 t;
> -
> -	if (!pm_dbg_init_done)
> -		return ;
> -
> -	/* Update timer for previous state */
> -	t = sched_clock();
> -
> -	pwrdm->state_timer[prev] += t - pwrdm->timer;
> -
> -	pwrdm->timer = t;
> -}
> -
>  static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
>  {
>  	struct seq_file *s = (struct seq_file *)user;
> @@ -410,7 +395,7 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
>  	seq_printf(s, "%s (%s)", pwrdm->name,
>  		pwrdm_state_names[pwrdm->state]);
>  
> -	for (i = 0; i < 4; i++)
> +	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
>  		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
>  			pwrdm->state_timer[i]);
>  
> @@ -517,17 +502,8 @@ DEFINE_SIMPLE_ATTRIBUTE(pwrdm_suspend_fops, pwrdm_suspend_get,
>  
>  static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
>  {
> -	int i;
> -	s64 t;
>  	struct dentry *d;
>  
> -	t = sched_clock();
> -
> -	for (i = 0; i < 4; i++)
> -		pwrdm->state_timer[i] = 0;
> -
> -	pwrdm->timer = t;
> -
>  	if (strncmp(pwrdm->name, "dpll", 4) == 0)
>  		return 0;
>  
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index f36f79c..03da7f8 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -76,11 +76,9 @@ extern u32 sleep_while_idle;
>  #endif
>  
>  #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> -extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
>  extern int pm_dbg_regset_save(int reg_set);
>  extern int pm_dbg_regset_init(int reg_set);
>  #else
> -#define pm_dbg_update_time(pwrdm, prev) do {} while (0);
>  #define pm_dbg_regset_save(reg_set) do {} while (0);
>  #define pm_dbg_regset_init(reg_set) do {} while (0);
>  #endif /* CONFIG_PM_DEBUG */
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9af0847..93a17c8 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,6 +19,7 @@
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <linux/sched.h>
>  #include <trace/events/power.h>
>  
>  #include "cm2xxx_3xxx.h"
> @@ -77,6 +78,7 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
>  static int _pwrdm_register(struct powerdomain *pwrdm)
>  {
>  	int i;
> +	s64 t;
>  
>  	if (!pwrdm || !pwrdm->name)
>  		return -EINVAL;
> @@ -100,6 +102,12 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
>  		pwrdm->state_counter[i] = 0;
>  
> +	/* Initialize the powerdomain's state timing stats */
> +	t = sched_clock();
> +	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
> +		pwrdm->state_timer[i] = 0;
> +	pwrdm->timer = t;
> +
>  	pwrdm->ret_logic_off_counter = 0;
>  	for (i = 0; i < pwrdm->banks; i++)
>  		pwrdm->ret_mem_off_counter[i] = 0;
> @@ -171,7 +179,9 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>  	if (state != prev)
>  		pwrdm->state_counter[state]++;
>  
> -	pm_dbg_update_time(pwrdm, prev);
> +#ifdef CONFIG_PM_DEBUG
> +	pwrdm_update_state_timer(pwrdm, prev);
> +#endif
>  
>  	pwrdm->state = state;
>  
> @@ -999,3 +1009,16 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
>  
>  	return 0;
>  }
> +
> +#ifdef CONFIG_PM_DEBUG
> +void pwrdm_update_state_timer(struct powerdomain *pwrdm, int prev)
> +{
> +	s64 t;
> +
> +	/* Update timer for previous state */
> +	t = sched_clock();
> +	pwrdm->state_timer[prev] += t - pwrdm->timer;
> +	pwrdm->timer = t;
> +}
> +#endif
> +
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index d23d979..abda68d 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -209,6 +209,9 @@ int pwrdm_post_transition(void);
>  int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
>  u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
>  bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
> +#ifdef CONFIG_PM_DEBUG
> +void pwrdm_update_state_timer(struct powerdomain *pwrdm, int prev);
> +#endif
>  
>  extern void omap2xxx_powerdomains_init(void);
>  extern void omap3xxx_powerdomains_init(void);
