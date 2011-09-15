From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 10/11] regulator: Implement consumer regulator
 mapping from device tree
Date: Thu, 15 Sep 2011 14:59:39 +0100
Message-ID: <20110915135939.GO7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
 <1316085727-15023-9-git-send-email-rnayak@ti.com>
 <1316085727-15023-10-git-send-email-rnayak@ti.com>
 <1316085727-15023-11-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38146 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933376Ab1ION7l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 09:59:41 -0400
Content-Disposition: inline
In-Reply-To: <1316085727-15023-11-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:52:06PM +0530, Rajendra Nayak wrote:

> +#ifdef CONFIG_OF
> +	struct device_node *node;
> +	node = of_get_regulator(dev, id);
> +	if (!node)
> +		goto out;
> +	list_for_each_entry(rdev, &regulator_list, list)
> +		if (node == rdev->node)
> +			goto found;
> +#else
>  	list_for_each_entry(map, &regulator_map_list, list) {
>  		/* If the mapping has a device set up it must match */
>  		if (map->dev_name &&
> @@ -1178,6 +1189,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
>  			goto found;
>  		}
>  	}
> +#endif

This forces all machines to use device tree when CONFIG_OF is enabled.
I'd expect to see both mechanisms supported simultaneously, for example
by falling back to the current code if the device tree lookup fails.

> @@ -1216,6 +1228,15 @@ found:
>  	if (!try_module_get(rdev->owner))
>  		goto out;
>  
> +#ifdef CONFIG_OF
> +	ret = set_consumer_device_supply(rdev, dev, devname, id);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set supply %d\n", ret);
> +		unset_regulator_supplies(rdev);
> +		goto out;
> +	}
> +#endif
> +

This seems wrong, why are we adding things to the regulator_map which is
really only there for lookups when we already did the lookup using the
device tree?

> @@ -2619,6 +2640,8 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
>  	rdev->reg_data = driver_data;
>  	rdev->owner = regulator_desc->owner;
>  	rdev->desc = regulator_desc;
> +	if (dev && dev->of_node)
> +		rdev->node = dev->of_node;

dev is mandatory.
