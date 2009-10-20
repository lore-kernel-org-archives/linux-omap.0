From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][Patch] OMAP3 PM: sysfs vdd_opp change  to use Constraint Framework
Date: Tue, 20 Oct 2009 08:51:11 -0700
Message-ID: <87vdianjww.fsf@deeprootsystems.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA174C98@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:49686 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZJTPvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 11:51:09 -0400
Received: by pwj1 with SMTP id 1so738542pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 08:51:13 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA174C98@dbde02.ent.ti.com> (Vishwanath Sripathy's message of "Sat\, 17 Oct 2009 00\:56\:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Sripathy, Vishwanath" <vishwanath.bs@ti.com> writes:

> Sysfs entry vdd_opp currently does not use constraint framework. 
> Because of this, even if you set the opp via this entry, it has no effect 
> since it can be overridden by on demand governor any time.
> This patch has changes to make vdd_opp to use constraint framework. 
> vdd_lock variable has to be used when application wants to disable DVFS
> altogether. This will override any other constraints and will lock the
> OPP to given value.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

This raises an issue that I've been thinking about for awhile.

Basically, I'd like to drop all the /sys/power/vdd* options.

Since we can do the equivalent with CPUFreq using the userspace
governor, I don't see the point of having an additional interface.

Comments?

Kevin

> ---
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 13783f3..bcdc00d 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -47,6 +47,8 @@ static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
>  static ssize_t vdd_opp_show(struct kobject *, struct kobj_attribute *, char *);
>  static ssize_t vdd_opp_store(struct kobject *k, struct kobj_attribute *,
>  			  const char *buf, size_t n);
> +static ssize_t vdd_opp_lock_store(struct kobject *k, struct kobj_attribute *,
> +			  const char *buf, size_t n);
>  static struct kobj_attribute vdd1_opp_attr =
>  	__ATTR(vdd1_opp, 0644, vdd_opp_show, vdd_opp_store);
>  
> @@ -103,6 +105,41 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
>  			  const char *buf, size_t n)
>  {
>  	unsigned short value;
> +	struct omap_opp *opp_table;
> +
> +	if (sscanf(buf, "%hu", &value) != 1)
> +		return -EINVAL;
> +
> +	if (attr == &vdd1_opp_attr) {
> +		if (value < MIN_VDD1_OPP || value > MAX_VDD1_OPP) {
> +			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
> +			return -EINVAL;
> +		}
> +		opp_table = omap_get_mpu_rate_table();
> +		omap_pm_cpu_set_freq(&sysfs_cpufreq_dev,
> +					opp_table[value].rate);
> +	} else if (attr == &vdd2_opp_attr) {
> +		if (value < MIN_VDD2_OPP || (value > MAX_VDD2_OPP)) {
> +			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
> +			return -EINVAL;
> +		}
> +		if (value == VDD2_OPP2)
> +			omap_pm_set_min_bus_tput(&sysfs_cpufreq_dev,
> +					OCP_INITIATOR_AGENT, 83*1000*4);
> +		else if (value == VDD2_OPP3)
> +			omap_pm_set_min_bus_tput(&sysfs_cpufreq_dev,
> +					OCP_INITIATOR_AGENT, 166*1000*4);
> +
> +	} else {
> +		return -EINVAL;
> +	}
> +	return n;
> +}
> +
> +static ssize_t vdd_opp_lock_store(struct kobject *kobj,
> +	struct kobj_attribute *attr, const char *buf, size_t n)
> +{
> +	unsigned short value;
>  	int flags = 0;
>  
>  	if (sscanf(buf, "%hu", &value) != 1)
> @@ -121,6 +158,11 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		if (vdd1_locked == 0 && value != 0) {
>  			resource_lock_opp(VDD1_OPP);
>  			vdd1_locked = 1;
> +			if (value < MIN_VDD1_OPP || value > MAX_VDD1_OPP) {
> +				printk(KERN_ERR "vdd_opp_store: Invalid value\n");
> +				return -EINVAL;
> +				}
> +		resource_set_opp_level(VDD1_OPP, value, flags);
>  		}
>  	} else if (attr == &vdd2_lock_attr) {
>  		flags = OPP_IGNORE_LOCK;
> @@ -134,21 +176,12 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		if (vdd2_locked == 0 && value != 0) {
>  			resource_lock_opp(VDD2_OPP);
>  			vdd2_locked = 1;
> +			if (value < MIN_VDD2_OPP || value > MAX_VDD2_OPP) {
> +				printk(KERN_ERR "vdd_opp_store: Invalid value\n");
> +				return -EINVAL;
> +			}
> +			resource_set_opp_level(VDD2_OPP, value, flags);
>  		}
> -	}
> -
> -	if (attr == &vdd1_opp_attr) {
> -		if (value < 1 || value > 5) {
> -			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
> -			return -EINVAL;
> -		}
> -		resource_set_opp_level(VDD1_OPP, value, flags);
> -	} else if (attr == &vdd2_opp_attr) {
> -		if (value < 2 || value > 3) {
> -			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
> -			return -EINVAL;
> -		}
> -		resource_set_opp_level(VDD2_OPP, value, flags);
>  	} else {
>  		return -EINVAL;
>  	}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
