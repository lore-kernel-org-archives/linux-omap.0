From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] Clockdomains: connect clockdomain code to
	powerdomain code
Date: Wed, 16 Apr 2008 14:41:39 -0700
Message-ID: <20080416214136.GN17055@atomide.com>
References: <20080410162532.097381890@pwsan.com> <20080410163626.045491105@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50424 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209AbYDPVll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 17:41:41 -0400
Content-Disposition: inline
In-Reply-To: <20080410163626.045491105@pwsan.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080410 10:18]:
> Thie patch adds code to the powerdomain layer to track the
> clockdomains associated with each powerdomain.
> 
> It also modifies the clockdomain code to register clockdomains
> with their corresponding powerdomain when the clockdomain is registered.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/mach-omap2/clockdomain.c       |    4 +
>  arch/arm/mach-omap2/powerdomain.c       |  128 ++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/powerdomain.h |   17 +++-
>  3 files changed, 147 insertions(+), 2 deletions(-)
> 
> Index: linux-omap/arch/arm/mach-omap2/clockdomain.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/clockdomain.c	2008-04-10 08:04:34.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/clockdomain.c	2008-04-10 08:07:08.000000000 -0600
> @@ -195,6 +195,8 @@
>  	list_add(&clkdm->node, &clkdm_list);
>  	mutex_unlock(&clkdm_mutex);
>  
> +	pwrdm_add_clkdm(pwrdm, clkdm);
> +
>  	pr_debug("clockdomain: registered %s\n", clkdm->name);
>  
>  	return 0;
> @@ -213,6 +215,8 @@
>  	if (!clkdm)
>  		return -EINVAL;
>  
> +	pwrdm_del_clkdm(clkdm->pwrdm, clkdm);
> +
>  	mutex_lock(&clkdm_mutex);
>  	list_del(&clkdm->node);
>  	mutex_unlock(&clkdm_mutex);
> Index: linux-omap/arch/arm/mach-omap2/powerdomain.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/powerdomain.c	2008-04-10 08:01:43.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/powerdomain.c	2008-04-10 08:05:40.000000000 -0600
> @@ -32,6 +32,7 @@
>  
>  #include <asm/arch/cpu.h>
>  #include <asm/arch/powerdomain.h>
> +#include <asm/arch/clockdomain.h>
>  
>  /* pwrdm_list contains all registered struct powerdomains */
>  static LIST_HEAD(pwrdm_list);
> @@ -208,6 +209,133 @@
>  EXPORT_SYMBOL(pwrdm_for_each);
>  
>  /**
> + * pwrdm_add_clkdm - add a clockdomain to a powerdomain
> + * @pwrdm: struct powerdomain * to add the clockdomain to
> + * @clkdm: struct clockdomain * to associate with a powerdomain
> + *
> + * Associate the clockdomain 'clkdm' with a powerdomain 'pwrdm'.  This
> + * enables the use of pwrdm_for_each_clkdm().  Returns -EINVAL if
> + * presented with invalid pointers; -ENOMEM if memory could not be allocated;
> + * or 0 upon success.
> + */
> +int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
> +{
> +	int i;
> +	int ret = 0;
> +
> +	if (!pwrdm || !clkdm)
> +		return -EINVAL;
> +
> +	pr_debug("powerdomain: associating clockdomain %s with powerdomain "
> +		 "%s\n", clkdm->name, pwrdm->name);
> +
> +	mutex_lock(&pwrdm_mutex);
> +
> +	for (i = 0; i < PWRDM_MAX_CLKDMS; i++) {
> +		if (!pwrdm->pwrdm_clkdms[i])
> +			break;
> +#ifdef DEBUG
> +		if (pwrdm->pwrdm_clkdms[i] == clkdm) {
> +			ret = -EINVAL;
> +			goto pac_exit;
> +		}
> +#endif
> +	}
> +
> +	if (i == PWRDM_MAX_CLKDMS) {
> +		pr_debug("powerdomain: increase PWRDM_MAX_CLKDMS for "
> +			 "pwrdm %s clkdm %s\n", pwrdm->name, clkdm->name);
> +		WARN_ON(1);
> +		ret = -ENOMEM;
> +		goto pac_exit;
> +	}
> +
> +	pwrdm->pwrdm_clkdms[i] = clkdm;
> +
> +pac_exit:
> +	mutex_unlock(&pwrdm_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * pwrdm_del_clkdm - remove a clockdomain to a powerdomain
> + * @pwrdm: struct powerdomain * to add the clockdomain to
> + * @clkdm: struct clockdomain * to associate with a powerdomain
> + *
> + * Dissociate the clockdomain 'clkdm' from the powerdomain
> + * 'pwrdm'. Returns -EINVAL if presented with invalid pointers;
> + * -ENOENT if the clkdm was not associated with the powerdomain, or 0
> + * upon success.
> + */
> +int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
> +{
> +	int ret = 0;
> +	int i;
> +
> +	if (!pwrdm || !clkdm)
> +		return -EINVAL;
> +
> +	pr_debug("powerdomain: dissociating clockdomain %s from powerdomain "
> +		 "%s\n", clkdm->name, pwrdm->name);
> +
> +	mutex_lock(&pwrdm_mutex);
> +
> +	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
> +		if (pwrdm->pwrdm_clkdms[i] == clkdm)
> +			break;
> +
> +	if (i == PWRDM_MAX_CLKDMS) {
> +		pr_debug("powerdomain: clkdm %s not associated with pwrdm "
> +			 "%s ?!\n", clkdm->name, pwrdm->name);
> +		ret = -ENOENT;
> +		goto pdc_exit;
> +	}
> +
> +	pwrdm->pwrdm_clkdms[i] = NULL;
> +
> +pdc_exit:
> +	mutex_unlock(&pwrdm_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * pwrdm_for_each_clkdm - call function on each clkdm in a pwrdm
> + * @pwrdm: struct powerdomain * to iterate over
> + * @fn: callback function *
> + *
> + * Call the supplied function for each clockdomain in the powerdomain
> + * 'pwrdm'.  The callback function can return anything but 0 to bail
> + * out early from the iterator.	 The callback function is called with
> + * the pwrdm_mutex held, so no powerdomain structure manipulation
> + * functions should be called from the callback, although hardware
> + * powerdomain control functions are fine.  Returns -EINVAL if
> + * presented with invalid pointers; or passes along the last return
> + * value of the callback function, which should be 0 for success or
> + * anything else to indicate failure.
> + */

Tabs here too in comments.


> +int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
> +			 int (*fn)(struct powerdomain *pwrdm,
> +				   struct clockdomain *clkdm))
> +{
> +	int ret = 0;
> +	int i;
> +
> +	if (!fn)
> +		return -EINVAL;
> +
> +	mutex_lock(&pwrdm_mutex);
> +
> +	for (i = 0; i < PWRDM_MAX_CLKDMS && !ret; i++)
> +		ret = (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
> +
> +	mutex_unlock(&pwrdm_mutex);
> +
> +	return ret;
> +}
> +
> +/**
>   * pwrdm_add_wkdep - add a wakeup dependency from pwrdm2 to pwrdm1
>   * @pwrdm1: wake this struct powerdomain * up (dependent)
>   * @pwrdm2: when this struct powerdomain * wakes up (source)
> Index: linux-omap/include/asm-arm/arch-omap/powerdomain.h
> ===================================================================
> --- linux-omap.orig/include/asm-arm/arch-omap/powerdomain.h	2008-04-10 08:01:43.000000000 -0600
> +++ linux-omap/include/asm-arm/arch-omap/powerdomain.h	2008-04-10 08:05:40.000000000 -0600
> @@ -44,9 +44,16 @@
>   */
>  #define PWRDM_MAX_MEM_BANKS	4
>  
> +/*
> + * Maximum number of clockdomains that can be associated with a powerdomain.
> + * CORE powerdomain is probably the worst case.
> + */
> +#define PWRDM_MAX_CLKDMS	3
> +
>  /* XXX A completely arbitrary number. What is reasonable here? */
>  #define PWRDM_TRANSITION_BAILOUT 100000
>  
> +struct clockdomain;
>  struct powerdomain;
>  
>  /* Encodes dependencies between powerdomains - statically defined */
> @@ -94,8 +101,8 @@
>  	/* Possible memory bank pwrstates when pwrdm is ON */
>  	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
>  
> -	/* List of clockdomains in this powerdomain */
> -	struct list_head pwrdm_clkdms;
> +	/* Clockdomains in this powerdomain */
> +	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
>  
>  	struct kobject *kobj;
>  	struct list_head node;
> @@ -111,6 +118,12 @@
>  
>  int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
>  
> +int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
> +int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
> +int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
> +			 int (*fn)(struct powerdomain *pwrdm,
> +				   struct clockdomain *clkdm));
> +
>  int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
>  int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
>  int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
> 
> -- 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
