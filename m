From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] OMAP: PM: Add new sysfs option for disabling
	clocks when entering idle
Date: Thu, 3 Jul 2008 13:41:15 +0300
Message-ID: <20080703104113.GQ14276@atomide.com>
References: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com> <1214815968-23157-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56501 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbYGCMSG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:18:06 -0400
Content-Disposition: inline
In-Reply-To: <1214815968-23157-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [080630 11:53]:
> There are drivers that are not disabling their clocks (gpio &
> uart). These clocks need to be disabled if retention/off state is
> wanted when idling. Before disabling them in idle loop this option
> needs to be checked.

Pushing today.

Tony

> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm.c |   37 +++++++++++++++++++++++++++++++------
>  arch/arm/mach-omap2/pm.h |    1 +
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index bef58d7..b7434df 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -31,30 +31,51 @@
>  #include "pm.h"
>  
>  unsigned short enable_dyn_sleep;
> +unsigned short clocks_off_while_idle;
>  atomic_t sleep_block = ATOMIC_INIT(0);
>  
> +static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
> +static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
> +			  const char *buf, size_t n);
> +
> +static struct kobj_attribute sleep_while_idle_attr =
> +	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
> +
> +static struct kobj_attribute clocks_off_while_idle_attr =
> +	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
> +
>  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> -	return sprintf(buf, "%hu\n", enable_dyn_sleep);
> +	if (attr == &sleep_while_idle_attr)
> +		return sprintf(buf, "%hu\n", enable_dyn_sleep);
> +	else if (attr == &clocks_off_while_idle_attr)
> +		return sprintf(buf, "%hu\n", clocks_off_while_idle);
> +	else
> +		return -EINVAL;
>  }
>  
>  static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
>  			  const char *buf, size_t n)
>  {
>  	unsigned short value;
> +
>  	if (sscanf(buf, "%hu", &value) != 1 ||
>  	    (value != 0 && value != 1)) {
> -		printk(KERN_ERR "idle_sleep_store: Invalid value\n");
> +		printk(KERN_ERR "idle_store: Invalid value\n");
>  		return -EINVAL;
>  	}
> -	enable_dyn_sleep = value;
> +
> +	if (attr == &sleep_while_idle_attr)
> +		enable_dyn_sleep = value;
> +	else if (attr == &clocks_off_while_idle_attr)
> +		clocks_off_while_idle = value;
> +	else
> +		return -EINVAL;
> +
>  	return n;
>  }
>  
> -static struct kobj_attribute sleep_while_idle_attr =
> -	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
> -
>  void omap2_block_sleep(void)
>  {
>  	atomic_inc(&sleep_block);
> @@ -86,6 +107,10 @@ int __init omap_pm_init(void)
>  	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
>  	if (error)
>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> +	error = sysfs_create_file(power_kobj,
> +				  &clocks_off_while_idle_attr.attr);
> +	if (error)
> +		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
>  
>  	return error;
>  }
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 351456e..0aeb461 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -17,6 +17,7 @@ extern int omap2_pm_init(void);
>  extern int omap3_pm_init(void);
>  
>  extern unsigned short enable_dyn_sleep;
> +extern unsigned short clocks_off_while_idle;
>  extern atomic_t sleep_block;
>  
>  #ifdef CONFIG_PM_DEBUG
> -- 
> 1.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
