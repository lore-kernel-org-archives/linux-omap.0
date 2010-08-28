From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/13] OMAP: Introduce API to return a device list associated with a voltage domain
Date: Fri, 27 Aug 2010 17:52:40 -0700
Message-ID: <87y6brblt3.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48984 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0H1Awm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 20:52:42 -0400
Received: by pxi10 with SMTP id 10so1272798pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 17:52:42 -0700 (PDT)
In-Reply-To: <1282130412-12027-5-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 18 Aug 2010 16:50:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds an API in the opp layer that
> can be used by the voltage layer to get a list of all the
> scalable devices belonging to a particular voltage domain.
> This API is to be typically called only once by the voltage
> layer per voltage domain instance and the device list should
> be stored. This approach makes it easy during dvfs to scale
> all the devices associated with a voltage domain and then
> scale the voltage domain.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

I think this should be done in two steps.

During init, each OPP

> ---
>  arch/arm/plat-omap/include/plat/opp.h |    9 +++++++++
>  arch/arm/plat-omap/opp.c              |   28 ++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> index 0e580ed..a4c1669 100644
> --- a/arch/arm/plat-omap/include/plat/opp.h
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -18,6 +18,7 @@
>  #include <linux/cpufreq.h>
>  
>  #include <plat/common.h>
> +#include <plat/voltage.h>
>  
>  /**
>   * struct omap_opp_def - OMAP OPP Definition
> @@ -86,6 +87,9 @@ int opp_disable(struct omap_opp *opp);
>  
>  void opp_init_cpufreq_table(struct device *dev,
>  			    struct cpufreq_frequency_table **table);
> +
> +struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
> +					int *dev_count);
>  #else
>  static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
>  {
> @@ -149,5 +153,10 @@ void opp_init_cpufreq_table(struct omap_opp *opps,
>  {
>  }
>  
> +static inline struct device **opp_init_voltage_params(
> +			struct voltagedomain *voltdm, int *dev_count)
> +{
> +}
> +
>  #endif		/* CONFIG_PM */
>  #endif		/* __ASM_ARM_OMAP_OPP_H */
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index a3dea82..72dd62a 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -502,3 +502,31 @@ void opp_init_cpufreq_table(struct device *dev,
>  
>  	*table = &freq_table[0];
>  }
> +
> +struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
> +					int *dev_count)
> +{
> +	struct device_opp *dev_opp;
> +	struct device **dev_list;
> +	int count = 0, i = 0;
> +
> +	list_for_each_entry(dev_opp, &dev_opp_list, node) {
> +		if (!dev_opp->oh->vdd_name)
> +			continue;
> +
> +		if (!strcmp(dev_opp->oh->vdd_name, voltdm->name)) {
> +			dev_opp->oh->voltdm = voltdm;

Couldn't we assign the voltdm at opp_add() time since you added it as
part of the hwmod?

> +			count++;
> +		}
> +	}

So the above could be done at opp_add() time, leaving only the rest
for this function.

> +	dev_list = kzalloc(sizeof(struct device *) * count, GFP_KERNEL);
> +
> +	list_for_each_entry(dev_opp, &dev_opp_list, node) {
> +		if (dev_opp->oh->voltdm == voltdm)
> +			dev_list[i++] = dev_opp->dev;
> +	}
> +
> +	*dev_count = count;
> +	return dev_list;
> +}

Kevin
