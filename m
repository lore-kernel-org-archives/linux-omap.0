From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH/RFC 1/2] OMAP2+: powerdomain: add API to get context loss
 count
Date: Tue, 14 Dec 2010 20:23:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142015240.15971@utopia.booyaka.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39793 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0LODXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 22:23:40 -0500
In-Reply-To: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

working my way through these...

On Thu, 9 Dec 2010, Kevin Hilman wrote:

> Add new powerdomain API
> 
>     int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
> 
> for checking how many times the powerdomain has lost context.  The
> loss count is the sum sum of the powerdomain off-mode counter, the
> logic off counter and the per-bank memory off counter.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   23 +++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h |    1 +
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 06ef60e..78e7d22 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -909,3 +909,26 @@ int pwrdm_post_transition(void)
>  	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
>  	return 0;
>  }
> +
> +/**
> + * pwrdm_get_context_loss_count - get powerdomain's context loss count
> + * @pwrdm: struct powerdomain * to wait for
> + *
> + * Context loss count is a sum of powerdomain off-mode counter,
> + * the logic off counter and the per-bank memory off counter.
> + */
> +int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
> +{
> +	int i, count;

There should be a test here to prevent a null pointer deref if pwrdm is 
NULL.

> +
> +	count = pwrdm->state_counter[PWRDM_POWER_OFF];
> +	count += pwrdm->ret_logic_off_counter;
> +
> +	for (i = 0; i < pwrdm->banks; i++)
> +		count += pwrdm->ret_mem_off_counter[i];

Looks like these state counters are unsigned ints.  So they could easily 
overflow count when they are summed.  This is probably not a major problem 
as far as this function is concerned, but the next patch can return 
-ENODEV upon error, which, if this function were really unlucky, it could 
effectively return -ENODEV.

It would be good to constrain the minimum successful return value of this 
function to 0.  This will require some creativity since the function 
shouldn't just return 0 for all sums that wrap around and wind up 
negative; the return value should still continue to differ from the value 
when it was called previously.  Otherwise devices might not restore their 
context when they should.

> +
> +	pr_debug("powerdomain: %s: context loss count = %u\n",
> +		 pwrdm->name, count);
> +
> +	return count;
> +}
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 35b5b48..d269eff 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -211,6 +211,7 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
>  int pwrdm_pre_transition(void);
>  int pwrdm_post_transition(void);
>  int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
> +int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
>  
>  extern void omap2xxx_powerdomains_init(void);
>  extern void omap3xxx_powerdomains_init(void);

Also, as we discussed privately, there is at least one bug in the counters 
where the logic-off and membank-off counters don't increment correctly 
when the entire powerdomain is off.  But that problem does not have to be 
dealt with as part of this series...


- Paul
