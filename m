From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/7] OMAP2+: powerdomain: add voltage domain lookup during
 register
Date: Tue, 22 Mar 2011 13:23:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103221313460.11798@utopia.booyaka.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-5-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37207 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab1CVTXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 15:23:40 -0400
In-Reply-To: <1300493932-17362-5-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Kevin,

a couple of comments, now that i have the chance to look this over 
closely.

Probably we should require every powerdomain to have a voltagedomain.  
This will avoid the problems we're having with the clocks, in which not 
every clock has a clockdomain pointer. 

So I'd suggest splitting this patch up into two patches -- one to make the 
changes the powerdomain structure, and the second to add the code into the 
powerdomain.c.  Between these two patches, we'd need patches to the 
powerdomain data to add the voltagedomain names in.

then...

On Fri, 18 Mar 2011, Kevin Hilman wrote:

> When a powerdomain is registered, lookup the voltage domain by name
> and keep a pointer to the containing voltagedomain in the powerdomain
> structure.
> 
> Modeled after similar method between powerdomain and clockdomain layers.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   26 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h |    8 ++++++++
>  arch/arm/mach-omap2/voltage.h     |    1 +
>  3 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 49c6513..da86c72 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -77,6 +77,7 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
>  static int _pwrdm_register(struct powerdomain *pwrdm)
>  {
>  	int i;
> +	struct voltagedomain *voltdm;
>  
>  	if (!pwrdm || !pwrdm->name)
>  		return -EINVAL;
> @@ -94,6 +95,16 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  	if (_pwrdm_lookup(pwrdm->name))
>  		return -EEXIST;
>  
> +	if (pwrdm->voltdm.name) {

we'd drop this

> +		voltdm = voltdm_lookup(pwrdm->voltdm.name);
> +		if (!voltdm) {
> +			pr_err("powerdomain: %s: voltagedomain %s does not exist\n",
> +			       pwrdm->name, pwrdm->voltdm.name);
> +			return -EINVAL;
> +		}
> +		pwrdm->voltdm.ptr = voltdm;
> +	}
> +
>  	list_add(&pwrdm->node, &pwrdm_list);
>  
>  	/* Initialize the powerdomain's state counter */
> @@ -383,6 +394,21 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
>  }
>  
>  /**
> + * pwrdm_get_voltdm - return a ptr to the voltdm that this pwrdm resides in
> + * @pwrdm: struct powerdomain *
> + *
> + * Return a pointer to the struct voltageomain that the specified powerdomain
> + * @pwrdm exists in, or returns NULL if @pwrdm is NULL.
> + */
> +struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm)
> +{
> +	if (!pwrdm)
> +		return NULL;

and this

> +
> +	return pwrdm->voltdm.ptr;
> +}
> +
> +/**
>   * pwrdm_get_mem_bank_count - get number of memory banks in this powerdomain
>   * @pwrdm: struct powerdomain *
>   *
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 027f40b..3a1ec37 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -24,6 +24,8 @@
>  
>  #include <plat/cpu.h>
>  
> +#include "voltage.h"
> +
>  /* Powerdomain basic power states */
>  #define PWRDM_POWER_OFF		0x0
>  #define PWRDM_POWER_RET		0x1
> @@ -78,6 +80,7 @@ struct powerdomain;
>  /**
>   * struct powerdomain - OMAP powerdomain
>   * @name: Powerdomain name
> + * @voltdm: voltagedomain containing this powerdomain
>   * @omap_chip: represents the OMAP chip types containing this pwrdm
>   * @prcm_offs: the address offset from CM_BASE/PRM_BASE
>   * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
> @@ -98,6 +101,10 @@ struct powerdomain;
>   */
>  struct powerdomain {
>  	const char *name;
> +	union {
> +		const char *name;
> +		struct voltagedomain *ptr;
> +	} voltdm;
>  	const struct omap_chip_id omap_chip;
>  	const s16 prcm_offs;
>  	const u8 pwrsts;
> @@ -176,6 +183,7 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
>  int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
>  			 int (*fn)(struct powerdomain *pwrdm,
>  				   struct clockdomain *clkdm));
> +struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
>  
>  int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
>  
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 122d8c1..13e5ed9 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -182,4 +182,5 @@ extern void omap44xx_voltagedomains_init(void);
>  
>  struct voltagedomain *voltdm_lookup(const char *name);
>  void voltdm_init(struct voltagedomain **voltdm_list);
> +int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
>  #endif
> -- 
> 1.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
