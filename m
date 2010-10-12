From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 2/8] OMAP: powerdomain: Infrastructure to put arch specific
 code
Date: Tue, 12 Oct 2010 01:36:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010120131560.16871@utopia.booyaka.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com> <1285245291-26442-2-git-send-email-rnayak@ti.com> <1285245291-26442-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53317 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab0JLHgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 03:36:05 -0400
In-Reply-To: <1285245291-26442-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com

On Thu, 23 Sep 2010, Rajendra Nayak wrote:

> Put infrastructure in place, so arch specific func pointers
> can be hooked up to the platform-independent part of the
> framework.

Hmm.  So if simply patches 1 and 2 of 8 are applied, I guess the system 
will panic on boot, now?  We should avoid that sort of thing, if possible.  
Ideally, the kernel should work correctly after each patch in a series is 
applied -- this makes it possible for 'git bisect' to work.

> ---
>  arch/arm/mach-omap2/io.c                      |    2 +-
>  arch/arm/plat-omap/include/plat/powerdomain.h |   22 +++++++++++++++++++++-
>  arch/arm/plat-omap/powerdomain.c              |   12 ++++++++++--
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index b9ea70b..6cb5a39 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -315,7 +315,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  {
>  	u8 skip_setup_idle = 0;
>  
> -	pwrdm_init(powerdomains_omap);
> +	pwrdm_init(powerdomains_omap, NULL);
>  	clkdm_init(clockdomains_omap, clkdm_autodeps);
>  	if (cpu_is_omap242x())
>  		omap2420_hwmod_init();
> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
> index 3ea7220..18b722d 100644
> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
> @@ -117,8 +117,28 @@ struct powerdomain {
>  #endif
>  };
>  
> +struct pwrdm_functions {
> +	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
> +	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_prev_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_set_logic_retst)(struct powerdomain *pwrdm, u8 pwrst);
> +	int	(*pwrdm_set_mem_onst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
> +	int	(*pwrdm_set_mem_retst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
> +	int	(*pwrdm_read_logic_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_prev_logic_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_logic_retst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
> +	int	(*pwrdm_read_prev_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
> +	int	(*pwrdm_read_mem_retst)(struct powerdomain *pwrdm, u8 bank);
> +	int	(*pwrdm_clear_all_prev_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_enable_hdwr_sar)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
> +};
>  
> -void pwrdm_init(struct powerdomain **pwrdm_list);
> +void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_functions *custom_funcs);
>  
>  struct powerdomain *pwrdm_lookup(const char *name);
>  
> diff --git a/arch/arm/plat-omap/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
> index 9204799..f90bfd3 100644
> --- a/arch/arm/plat-omap/powerdomain.c
> +++ b/arch/arm/plat-omap/powerdomain.c
> @@ -80,6 +80,8 @@ static u16 pwrstst_reg_offs;
>  /* pwrdm_list contains all registered struct powerdomains */
>  static LIST_HEAD(pwrdm_list);
>  
> +static struct pwrdm_functions *arch_pwrdm;
> +
>  /* Private functions */
>  
>  static struct powerdomain *_pwrdm_lookup(const char *name)
> @@ -218,7 +220,7 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
>   * registered.  No return value.  XXX pwrdm_list is not really a
>   * "list"; it is an array.  Rename appropriately.
>   */
> -void pwrdm_init(struct powerdomain **pwrdm_list)
> +void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_functions * custom_funcs)

There is a superfluous space here between the * and the variable 
name.

>  {
>  	struct powerdomain **p = NULL;
>  
> @@ -234,6 +236,13 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
>  		return;
>  	}
>  
> +	if (!custom_funcs) {
> +		printk(KERN_ERR "No custom pwrdm functions registered\n");
> +		BUG();
> +	}

Plesae convert this to be a WARN() + return, or something similar.  It 
doesn't seem necessary to crash the system here.

Also, just FYI, I've been trying to convert code in the style of

printk(KERN_ERR ...

into

pr_err(...

so it is best to use the shorter form initially.

> +
> +	arch_pwrdm = custom_funcs;
> +
>  	if (pwrdm_list) {
>  		for (p = pwrdm_list; *p; p++)
>  			_pwrdm_register(*p);
> @@ -1074,4 +1083,3 @@ int pwrdm_post_transition(void)
>  	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
>  	return 0;
>  }
> -
> -- 
> 1.7.0.4
> 


- Paul
