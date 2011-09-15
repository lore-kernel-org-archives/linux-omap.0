From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 06/11] DT: regulator: Helper routine to extract
 fixed_voltage_config
Date: Thu, 15 Sep 2011 16:19:12 -0600
Message-ID: <20110915221912.GO3523@ponder.secretlab.ca>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38980 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935100Ab1IOWTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 18:19:16 -0400
Received: by ywb5 with SMTP id 5so2541241ywb.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 15:19:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316085727-15023-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:52:02PM +0530, Rajendra Nayak wrote:
> The helper routine defined here (of_get_fixed_voltage_config) can
> be used to extract information about fixed regulators (which are not
> software controlable) from device tree.
> 
> Add documenation about additional bindings for fixed
> regulators that can be passed through DT.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  .../devicetree/bindings/regulator/regulator.txt    |   19 ++++++++++++
>  drivers/of/of_regulator.c                          |   31 ++++++++++++++++++++
>  include/linux/of_regulator.h                       |    7 ++++
>  3 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> index 001e5ce..f8c51d8 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> @@ -2,6 +2,8 @@ Voltage/Current Regulators
>  
>  Required properties:
>  - compatible: Must be "regulator";
> +or
> +- compatible: Must be "regulator-fixed"; /* For Fixed volatge regulator */

regulator-fixed should actually just be another driver binding that
uses the regulator binding.

>  
>  Optional properties:
>  - supply-regulator: Name of the parent regulator
> @@ -24,6 +26,13 @@ Optional properties:
>  - always-on: boolean, regulator should never be disabled
>  - boot-on: bootloader/firmware enabled regulator
>  - apply-uV: apply uV constraint if min == max
> +# For fixed voltage regulators
> +- supply-name: Name of the regulator supply
> +- microvolts: Output voltage of regulator
> +- gpio: gpio to use for enable control
> +- startup-delay: startup time in microseconds
> +- enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
> +- enabled-at-boot: 1 = yes, 0 = no
>  
>  Example:
>  
> @@ -35,3 +44,13 @@ Example:
>  		change-voltage;
>  		always-on;
>  	};
> +
> +	abc-fixedregulator {
> +		compatible = "regulator-fixed";
> +		supply-name = "fixed-supply";
> +		microvolts = <1800000>;
> +		gpio = <43>;
> +		startup-delay = <70000>;
> +		enable-high;
> +		enabled-at-boot;
> +	};
> diff --git a/drivers/of/of_regulator.c b/drivers/of/of_regulator.c
> index f01d275..4d7a49d 100644
> --- a/drivers/of/of_regulator.c
> +++ b/drivers/of/of_regulator.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
>  
>  static void of_get_regulation_constraints(struct device_node *np,
>  					struct regulator_init_data **init_data)
> @@ -83,3 +84,33 @@ struct regulator_init_data *of_get_regulator_init_data(struct device_node *np)
>  	return init_data;
>  }
>  EXPORT_SYMBOL(of_get_regulator_init_data);
> +
> +/**
> + * of_get_fixed_voltage_config - extract fixed_voltage_config structure info
> + * @np: Pointer to fixed-regulator device tree node
> + *
> + * Populates fixed_voltage_config structure by extracting data from device
> + * tree node, returns a pointer to the populated structure of NULL if memory
> + * alloc fails.
> + */
> +struct fixed_voltage_config *of_get_fixed_voltage_config(struct device_node *np)
> +{
> +	struct fixed_voltage_config *config;
> +
> +	config = kzalloc(sizeof(struct fixed_voltage_config), GFP_KERNEL);
> +	if (!config)
> +		return NULL;
> +
> +	config->supply_name = (char *)of_get_property(np, "supply-name", NULL);
> +	of_property_read_u32(np, "microvolts", &config->microvolts);
> +	of_property_read_u32(np, "gpio", &config->gpio);
> +	of_property_read_u32(np, "startup-delay", &config->startup_delay);
> +	if (of_find_property(np, "enable-high", NULL))
> +		config->enable_high = true;
> +	if (of_find_property(np, "enabled-at-boot", NULL))
> +		config->enabled_at_boot = true;
> +	config->init_data = of_get_regulator_init_data(np);
> +
> +	return config;
> +}
> +EXPORT_SYMBOL(of_get_fixed_voltage_config);
> diff --git a/include/linux/of_regulator.h b/include/linux/of_regulator.h
> index 5eb048c..39860c5 100644
> --- a/include/linux/of_regulator.h
> +++ b/include/linux/of_regulator.h
> @@ -11,12 +11,19 @@
>  #if defined(CONFIG_OF_REGULATOR)
>  extern struct regulator_init_data
>  	*of_get_regulator_init_data(struct device_node *np);
> +extern struct fixed_voltage_config
> +	*of_get_fixed_voltage_config(struct device_node *np);
>  #else
>  static inline struct regulator_init_data
>  	*of_get_regulator_init_data(struct device_node *np)
>  {
>  	return NULL;
>  }
> +static inline struct fixed_voltage_config
> +	*of_get_fixed_voltage_config(struct device_node *np)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_OF_REGULATOR */
>  
>  #endif /* __LINUX_OF_REG_H */
> -- 
> 1.7.1
> 
