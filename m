From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] memory: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 07:47:02 +0200
Message-ID: <20170719054702.x6h2fkz6vplzyqg2@piout.net>
References: <20170718214339.7774-34-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-34-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 18/07/2017 at 16:43:14 -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

> ---
>  drivers/memory/atmel-ebi.c    | 17 ++++++++---------
>  drivers/memory/jz4780-nemc.c  | 12 ++++++------
>  drivers/memory/mvebu-devbus.c | 12 ++++++------
>  drivers/memory/omap-gpmc.c    | 18 +++++++++---------
>  4 files changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index 99e644cda4d1..597282e35c69 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -156,8 +156,8 @@ static int atmel_ebi_xslate_smc_timings(struct atmel_ebi_dev *ebid,
>  out:
>  	if (ret) {
>  		dev_err(ebid->ebi->dev,
> -			"missing or invalid timings definition in %s",
> -			np->full_name);
> +			"missing or invalid timings definition in %pOF",
> +			np);
>  		return ret;
>  	}
> 
> @@ -267,8 +267,8 @@ static int atmel_ebi_xslate_smc_config(struct atmel_ebi_dev *ebid,
>  		return -EINVAL;
> 
>  	if ((ret > 0 && !required) || (!ret && required)) {
> -		dev_err(ebid->ebi->dev, "missing atmel,smc- properties in %s",
> -			np->full_name);
> +		dev_err(ebid->ebi->dev, "missing atmel,smc- properties in %pOF",
> +			np);
>  		return -EINVAL;
>  	}
> 
> @@ -311,8 +311,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
> 
>  		if (cs >= AT91_MATRIX_EBI_NUM_CS ||
>  		    !(ebi->caps->available_cs & BIT(cs))) {
> -			dev_err(dev, "invalid reg property in %s\n",
> -				np->full_name);
> +			dev_err(dev, "invalid reg property in %pOF\n", np);
>  			return -EINVAL;
>  		}
> 
> @@ -321,7 +320,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
>  	}
> 
>  	if (!numcs) {
> -		dev_err(dev, "invalid reg property in %s\n", np->full_name);
> +		dev_err(dev, "invalid reg property in %pOF\n", np);
>  		return -EINVAL;
>  	}
> 
> @@ -569,8 +568,8 @@ static int atmel_ebi_probe(struct platform_device *pdev)
> 
>  		ret = atmel_ebi_dev_setup(ebi, child, reg_cells);
>  		if (ret) {
> -			dev_err(dev, "failed to configure EBI bus for %s, disabling the device",
> -				child->full_name);
> +			dev_err(dev, "failed to configure EBI bus for %pOF, disabling the device",
> +				child);
> 
>  			ret = atmel_ebi_dev_disable(ebi, child);
>  			if (ret)
> diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
> index 919d1925acb9..bcf06adefc96 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -322,8 +322,8 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
>  			bank = of_read_number(prop, 1);
>  			if (bank < 1 || bank >= JZ4780_NEMC_NUM_BANKS) {
>  				dev_err(nemc->dev,
> -					"%s requests invalid bank %u\n",
> -					child->full_name, bank);
> +					"%pOF requests invalid bank %u\n",
> +					child, bank);
> 
>  				/* Will continue the outer loop below. */
>  				referenced = 0;
> @@ -334,12 +334,12 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
>  		}
> 
>  		if (!referenced) {
> -			dev_err(nemc->dev, "%s has no addresses\n",
> -				child->full_name);
> +			dev_err(nemc->dev, "%pOF has no addresses\n",
> +				child);
>  			continue;
>  		} else if (nemc->banks_present & referenced) {
> -			dev_err(nemc->dev, "%s conflicts with another node\n",
> -				child->full_name);
> +			dev_err(nemc->dev, "%pOF conflicts with another node\n",
> +				child);
>  			continue;
>  		}
> 
> diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
> index 24852812fd44..981860879d02 100644
> --- a/drivers/memory/mvebu-devbus.c
> +++ b/drivers/memory/mvebu-devbus.c
> @@ -105,8 +105,8 @@ static int get_timing_param_ps(struct devbus *devbus,
> 
>  	err = of_property_read_u32(node, name, &time_ps);
>  	if (err < 0) {
> -		dev_err(devbus->dev, "%s has no '%s' property\n",
> -			name, node->full_name);
> +		dev_err(devbus->dev, "%pOF has no '%s' property\n",
> +			node, name);
>  		return err;
>  	}
> 
> @@ -127,8 +127,8 @@ static int devbus_get_timing_params(struct devbus *devbus,
>  	err = of_property_read_u32(node, "devbus,bus-width", &r->bus_width);
>  	if (err < 0) {
>  		dev_err(devbus->dev,
> -			"%s has no 'devbus,bus-width' property\n",
> -			node->full_name);
> +			"%pOF has no 'devbus,bus-width' property\n",
> +			node);
>  		return err;
>  	}
> 
> @@ -180,8 +180,8 @@ static int devbus_get_timing_params(struct devbus *devbus,
>  					   &w->sync_enable);
>  		if (err < 0) {
>  			dev_err(devbus->dev,
> -				"%s has no 'devbus,sync-enable' property\n",
> -				node->full_name);
> +				"%pOF has no 'devbus,sync-enable' property\n",
> +				node);
>  			return err;
>  		}
>  	}
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index a80e17de906d..f7f393541934 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -960,7 +960,7 @@ static int gpmc_cs_remap(int cs, u32 base)
>  	 * Make sure we ignore any device offsets from the GPMC partition
>  	 * allocated for the chip select and that the new base confirms
>  	 * to the GPMC 16MB minimum granularity.
> -	 */
> +	 */
>  	base &= ~(SZ_16M - 1);
> 
>  	gpmc_cs_get_memconf(cs, &old_base, &size);
> @@ -1930,8 +1930,8 @@ static int gpmc_probe_onenand_child(struct platform_device *pdev,
>  	struct omap_onenand_platform_data *gpmc_onenand_data;
> 
>  	if (of_property_read_u32(child, "reg", &val) < 0) {
> -		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> -			child->full_name);
> +		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> +			child);
>  		return -ENODEV;
>  	}
> 
> @@ -1979,14 +1979,14 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
> 
>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
> -		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> -			child->full_name);
> +		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> +			child);
>  		return -ENODEV;
>  	}
> 
>  	if (of_address_to_resource(child, 0, &res) < 0) {
> -		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
> -			child->full_name);
> +		dev_err(&pdev->dev, "%pOF has malformed 'reg' property\n",
> +			child);
>  		return -ENODEV;
>  	}
> 
> @@ -2084,8 +2084,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		ret = of_property_read_u32(child, "bank-width",
>  					   &gpmc_s.device_width);
>  		if (ret < 0) {
> -			dev_err(&pdev->dev, "%s has no 'bank-width' property\n",
> -				child->full_name);
> +			dev_err(&pdev->dev, "%pOF has no 'bank-width' property\n",
> +				child);
>  			goto err;
>  		}
>  	}
> --
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
