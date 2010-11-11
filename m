From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 06/14] OMAP: Voltage layer changes to support DVFS.
Date: Thu, 11 Nov 2010 15:34:03 -0800
Message-ID: <87wrojtoyc.fsf@deeprootsystems.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-7-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42374 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0KKXeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 18:34:09 -0500
Received: by yxt33 with SMTP id 33so86487yxt.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 15:34:08 -0800 (PST)
In-Reply-To: <1288366708-32302-7-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Fri, 29 Oct 2010 21:08:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch introduces an API to take in the voltage domain and the
> new voltage as parameter and to scale all the scalable devices
> associated with the the voltage domain to the rate corresponding to the
> new voltage and scale the voltage domain to the new voltage.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c             |   72 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/voltage.h |    7 +++
>  2 files changed, 79 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 6c2e4ef..458f8c1 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -27,9 +27,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/plist.h>
>  #include <linux/slab.h>
> +#include <linux/opp.h>
>  
>  #include <plat/common.h>
>  #include <plat/voltage.h>
> +#include <plat/omap_device.h>
>  
>  #include "prm-regbits-34xx.h"
>  #include "prm44xx.h"
> @@ -1678,6 +1680,76 @@ struct voltagedomain *omap_voltage_domain_lookup(char *name)
>  }
>  
>  /**
> + * omap_voltage_scale : API to scale the devices associated with a
> + *			voltage domain vdd voltage.
> + * @volt_domain : the voltage domain to be scaled
> + * @volt : the new voltage for the voltage domain
> + *
> + * This API runs through the list of devices associated with the
> + * voltage domain and scales the device rates to those corresponding
> + * to the new voltage of the voltage domain. This API also scales
> + * the voltage domain voltage to the new value. Returns 0 on success
> + * else the error value.
> + */
> +int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
> +{
> +	unsigned long curr_volt;
> +	int is_volt_scaled = 0;
> +	struct omap_vdd_info *vdd;
> +	struct omap_vdd_dev_list *temp_dev;
> +
> +	if (!voltdm || IS_ERR(voltdm)) {
> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
> +
> +	mutex_lock(&vdd->scaling_mutex);
> +
> +	curr_volt = omap_voltage_get_nom_volt(voltdm);
> +
> +	if (curr_volt == volt) {
> +		is_volt_scaled = 1;
> +	} else if (curr_volt < volt) {
> +		omap_voltage_scale_vdd(voltdm, volt);
> +		is_volt_scaled = 1;
> +	}
> +
> +	list_for_each_entry(temp_dev, &vdd->dev_list, node) {
> +		struct device *dev;
> +		struct opp *opp;
> +		unsigned long freq;
> +
> +		dev = temp_dev->dev;
> +
> +		opp = opp_find_voltage(dev, volt);
> +		if (IS_ERR(opp)) {
> +			dev_err(dev, "%s: Unable to find OPP for"
> +				"volt%ld\n", __func__, volt);
> +			continue;
> +		}
> +
> +		freq = opp_get_freq(opp);
> +
> +		if (freq == omap_device_get_rate(dev)) {
> +			dev_warn(dev, "%s: Already at the requested"
> +				"rate %ld\n", __func__, freq);

Does this need to be a warning?  This happens relatively often and is normal.
This should probably just be removed in favor of

		if (freq != omap_device_get_rate(dev)) 
                        omap_device_set_rate(dev, freq);

Kevin

> +			continue;
> +		}
> +
> +		omap_device_set_rate(dev, freq);
> +	}
> +
> +	if (!is_volt_scaled)
> +		omap_voltage_scale_vdd(voltdm, volt);
> +
> +	mutex_unlock(&vdd->scaling_mutex);
> +
> +	return 0;
> +}
> +
> +/**
>   * omap_voltage_init : Volatage init API which does VP and VC init.
>   */
>  static int __init omap_voltage_init(void)
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index dc64a9a..54d50e2 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -153,6 +153,7 @@ void omap_change_voltscale_method(int voltscale_method);
>  int omap_voltage_add_request(struct voltagedomain *voltdm, struct device *dev,
>  		unsigned long *volt);
>  int omap_voltage_add_dev(struct voltagedomain *voltdm, struct device *dev);
> +int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt);
>  #else
>  static inline void omap_voltage_register_pmic
>  			(struct omap_volt_pmic_info *pmic_info) {}
> @@ -169,6 +170,12 @@ static inline int omap_voltage_add_dev(struct voltagedomain *voltdm,
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int omap_voltage_scale(struct voltagedomain *voltdm,
> +		unsigned long volt)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif
