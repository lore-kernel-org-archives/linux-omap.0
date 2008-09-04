From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] power off on state counter infrastructure
Date: Thu, 4 Sep 2008 10:54:30 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809041048220.10597@utopia.booyaka.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com> <1216904434-7545-2-git-send-email-peter.de-schrijver@nokia.com> <1216904434-7545-3-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41929 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbYIDQyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 12:54:32 -0400
In-Reply-To: <1216904434-7545-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Peter,

a few minor comments:

On Thu, 24 Jul 2008, Peter 'p2' De Schrijver wrote:

> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c       |   48 +++++++++++++++++++++++++++++-
>  include/asm-arm/arch-omap/powerdomain.h |    9 +++++-
>  2 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 7615f9d..721f73c 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -102,6 +102,27 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
>  	return pd->pwrdm;
>  }
>  
> +static int pwr_domain_save_state_cb(struct powerdomain *pwrdm, void *user)

For functions that operate on powerdomain power state, it is probably best 
to use the "pwrst" abbreviation, rather than "state", to clarify what type 
of state we are saving.

Also, for these two static functions, let's prepend an underscore 
to the name to indicate an internal function, e.g., 
"_pwrdm_save_pwrst_cb"

> +{
> +	pwrdm_save_state(pwrdm);
> +
> +	return 0;
> +}
> +
> +static int pwr_domain_count_off_mode_cb(struct powerdomain *pwrdm, void *user)

Same two notes as above.

> +{
> +	int prev;
> +
> +	prev = pwrdm_read_prev_pwrst(pwrdm);
> +
> +	if (prev != PWRDM_POWER_OFF && pwrdm->state != prev)
> +		 pwrdm->offstate_count++;
> +
> +	pwrdm->state = pwrdm_read_pwrst(pwrdm);
> +
> +	return 0;
> +}
> +
>  
>  /* Public functions */
>  
> @@ -217,7 +238,7 @@ struct powerdomain *pwrdm_lookup(const char *name)
>   * anything else to indicate failure; or -EINVAL if the function
>   * pointer is null.
>   */
> -int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
> +int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user), void *user)
>  {
>  	struct powerdomain *temp_pwrdm;
>  	unsigned long flags;
> @@ -228,7 +249,7 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
>  
>  	read_lock_irqsave(&pwrdm_rwlock, flags);
>  	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
> -		ret = (*fn)(temp_pwrdm);
> +		ret = (*fn)(temp_pwrdm, user);
>  		if (ret)
>  			break;
>  	}
> @@ -1110,4 +1131,27 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
>  	return 0;
>  }
>  
> +void pwrdm_save_state(struct powerdomain *pwrdm)

This should be "pwrdm_save_pwrst"

> +{
> +	pwrdm->state = pwrdm_read_pwrst(pwrdm);
> +}
> +
> +void pwrdm_check_off_mode(struct powerdomain *pwrdm)
> +{
> +	int state;
> +
> +	state = pwrdm_read_pwrst(pwrdm);
> +	if (pwrdm->state == PWRDM_POWER_OFF && state == PWRDM_POWER_ON)
> +		pwrdm->offstate_count++;
> +}
> +
> +void pwrdm_save_state_all(void)

This should be "pwrdm_save_pwrst_all"

> +{
> +	pwrdm_for_each(pwr_domain_save_state_cb, NULL);
> +}
> +
> +void pwrdm_count_off_mode(void)
> +{
> +	pwrdm_for_each(pwr_domain_count_off_mode_cb, NULL);
> +}
>  
> diff --git a/include/asm-arm/arch-omap/powerdomain.h b/include/asm-arm/arch-omap/powerdomain.h
> index 1cd8942..19ad6fd 100644
> --- a/include/asm-arm/arch-omap/powerdomain.h
> +++ b/include/asm-arm/arch-omap/powerdomain.h
> @@ -117,6 +117,8 @@ struct powerdomain {
>  
>  	struct list_head node;
>  
> +	int state;
> +	u32 offstate_count;
>  };
>  
>  
> @@ -126,7 +128,8 @@ int pwrdm_register(struct powerdomain *pwrdm);
>  int pwrdm_unregister(struct powerdomain *pwrdm);
>  struct powerdomain *pwrdm_lookup(const char *name);
>  
> -int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
> +int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
> +			void *user);
>  
>  int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
>  int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
> @@ -165,4 +168,8 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
>  
>  int pwrdm_wait_transition(struct powerdomain *pwrdm);
>  
> +void pwrdm_save_state(struct powerdomain *pwrdm);
> +void pwrdm_check_off_mode(struct powerdomain *pwrdm);
> +void pwrdm_save_state_all(void);
> +void pwrdm_count_off_mode(void);
>  #endif

The rest of these three patches looks fine.


- Paul
