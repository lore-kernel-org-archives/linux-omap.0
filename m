From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Mon, 21 Jan 2013 12:30:20 +0000
Message-ID: <20130121123020.GI15707@e106331-lin.cambridge.arm.com>
References: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358634477-25868-3-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58941 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3AUMa3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 07:30:29 -0500
In-Reply-To: <1358634477-25868-3-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "martinez.javier@gmail.com" <martinez.javier@gmail.com>, "matthias.bgg@googlemail.com" <matthias.bgg@googlemail.com>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 01ce462..f7de9eb 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -39,6 +39,7 @@
>  #include "omap_device.h"
>  #include "gpmc.h"
>  #include "gpmc-nand.h"
> +#include "gpmc-onenand.h"
>  
>  #define	DEVICE_NAME		"omap-gpmc"
>  
> @@ -1259,6 +1260,43 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  }
>  #endif
>  
> +#ifdef CONFIG_MTD_ONENAND
> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
> +				 struct device_node *child)
> +{
> +	u32 val;
> +	struct omap_onenand_platform_data *gpmc_onenand_data;
> +
> +	if (of_property_read_u32(child, "reg", &val) < 0) {
> +		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	gpmc_onenand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_onenand_data),
> +					 GFP_KERNEL);
> +	if (!gpmc_onenand_data)
> +		return -ENOMEM;
> +
> +	gpmc_onenand_data->cs = val;
> +	gpmc_onenand_data->of_node = child;
> +	gpmc_onenand_data->dma_channel = -1;
> +
> +	if (!of_property_read_u32(child, "dma-channel", &val))
> +		gpmc_onenand_data->dma_channel = val;
> +
> +	gpmc_onenand_init(gpmc_onenand_data);
> +
> +	return 0;
> +}
> +#else
> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
> +				    struct device_node *child)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int gpmc_probe_dt(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -1276,6 +1314,12 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>  			return ret;
>  	}
>  

This doesn't look right to me:

> +	for_each_node_by_name(child, "onenand") {
> +		ret = gpmc_probe_onenand_child(pdev, child);
> +		of_node_put(child);
> +		if (ret < 0)
> +			return ret;
> +	}

for_each_node_by_name automatically calls of_node_put on each node once passed,
and as far as I can tell, gpmc_probe_onenand_child doesn't do anything that'd
increment a node's refcount.

As far as I can see, you only need the of_node_put in the error case:

for_each_node_by_name(child, "onenand") {
	ret = gpmc_probe_onenand_child(pdev, child);
	if (ret < 0) {
		of_node_put(child);
		return ret;
	}
}

Have I missed something here?

>  	return 0;
>  }
>  #else
> -- 
> 1.7.8.6
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 

Thanks,
Mark.

