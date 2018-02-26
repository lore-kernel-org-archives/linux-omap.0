From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree
 based probing
Date: Mon, 26 Feb 2018 11:37:51 +0100
Message-ID: <5d37e6ff-9b89-b677-859e-6eeae5527276@intel.com>
References: <20180223210100.86732-1-tony@atomide.com>
 <20180223210100.86732-12-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223210100.86732-12-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 2/23/2018 10:00 PM, Tony Lindgren wrote:
> We are currently probing smartreflex with omap_device while we are
> already probing smartreflex related interconnect target module with
> ti-sysc driver and dts data.
>
> Before we can flip things on for ti-sysc, we need to prepare the
> smartreflex driver a bit:
>
> 1. The smartreflex clock is really for the whole interconnect target
>     module. So it may be configured at the parent device level with
>     ti-sysc
>
> 2. With ti-sysc, we have the child device manage interconnect target
>     module directly if pm_runtime_irq_safe() is set and there is only
>     one child. In that case nobody else is going to call pm_runtime_get
>     and put, so we need to add these calls to idle smartreflex properly
>     after probe if not fully configured
>
> 3. With ti-sysc, the parent driver may rebind. So we want to use
>     platform_driver_register() and don't want probe to be __init
>
> Note that this patch depends on the related changes to ti-sysc driver
> and omap_device probing to prevent both ti-sysc and omap_device to
> try to probe smartreflex.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

You need an ACK from Kevin Hilman on this anyway and if you receive one, 
please feel free to route it whatever way is convenient for you.

> ---
>   drivers/power/avs/smartreflex.c | 41 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -132,12 +132,16 @@ static void sr_set_clk_length(struct omap_sr *sr)
>   	struct clk *fck;
>   	u32 fclk_speed;
>   
> -	fck = clk_get(&sr->pdev->dev, "fck");
> -
> +	/* Try interconnect target module fck first if it already exists */
> +	fck = clk_get(sr->pdev->dev.parent, "fck");
>   	if (IS_ERR(fck)) {
> -		dev_err(&sr->pdev->dev, "%s: unable to get fck for device %s\n",
> -			__func__, dev_name(&sr->pdev->dev));
> -		return;
> +		fck = clk_get(&sr->pdev->dev, "fck");
> +		if (IS_ERR(fck)) {
> +			dev_err(&sr->pdev->dev,
> +				"%s: unable to get fck for device %s\n",
> +				__func__, dev_name(&sr->pdev->dev));
> +			return;
> +		}
>   	}
>   
>   	fclk_speed = clk_get_rate(fck);
> @@ -838,7 +842,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>   DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
>   			omap_sr_autocomp_store, "%llu\n");
>   
> -static int __init omap_sr_probe(struct platform_device *pdev)
> +static int omap_sr_probe(struct platform_device *pdev)
>   {
>   	struct omap_sr *sr_info;
>   	struct omap_sr_data *pdata = pdev->dev.platform_data;
> @@ -898,6 +902,12 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>   
>   	list_add(&sr_info->node, &sr_list);
>   
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		goto err_list_del;
> +	}
> +
>   	/*
>   	 * Call into late init to do initializations that require
>   	 * both sr driver and sr class driver to be initiallized.
> @@ -966,12 +976,17 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>   
>   	}
>   
> +	pm_runtime_put_sync(&pdev->dev);
> +
>   	return ret;
>   
>   err_debugfs:
>   	debugfs_remove_recursive(sr_info->dbg_dir);
>   err_list_del:
>   	list_del(&sr_info->node);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +
>   	return ret;
>   }
>   
> @@ -1025,11 +1040,23 @@ static void omap_sr_shutdown(struct platform_device *pdev)
>   	return;
>   }
>   
> +static const struct of_device_id omap_sr_match[] = {
> +	{ .compatible = "ti,omap3-smartreflex-core", },
> +	{ .compatible = "ti,omap3-smartreflex-mpu-iva", },
> +	{ .compatible = "ti,omap4-smartreflex-core", },
> +	{ .compatible = "ti,omap4-smartreflex-mpu", },
> +	{ .compatible = "ti,omap4-smartreflex-iva", },
> +	{  },
> +};
> +MODULE_DEVICE_TABLE(of, omap_sr_match);
> +
>   static struct platform_driver smartreflex_driver = {
> +	.probe		= omap_sr_probe,
>   	.remove         = omap_sr_remove,
>   	.shutdown	= omap_sr_shutdown,
>   	.driver		= {
>   		.name	= DRIVER_NAME,
> +		.of_match_table	= omap_sr_match,
>   	},
>   };
>   
> @@ -1048,7 +1075,7 @@ static int __init sr_init(void)
>   	else
>   		pr_warn("%s: No PMIC hook to init smartreflex\n", __func__);
>   
> -	ret = platform_driver_probe(&smartreflex_driver, omap_sr_probe);
> +	ret = platform_driver_register(&smartreflex_driver);
>   	if (ret) {
>   		pr_err("%s: platform driver register failed for SR\n",
>   		       __func__);
