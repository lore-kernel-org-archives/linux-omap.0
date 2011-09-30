From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/9] regulator: make fixed regulator driver extract data
 from dt
Date: Thu, 29 Sep 2011 19:34:21 -0600
Message-ID: <20110930013421.GG12606@ponder.secretlab.ca>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62780 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab1I3FE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 01:04:59 -0400
Received: by yib18 with SMTP id 18so1197380yib.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 22:04:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317118372-17052-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 03:42:49PM +0530, Rajendra Nayak wrote:
> Modify the fixed regulator driver to extract fixed_voltage_config from
> device tree when passed, instead of getting it through platform_data
> structures (on non-DT builds)
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  drivers/regulator/fixed.c |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index c09f791..0a9a10d 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -140,10 +140,15 @@ static struct regulator_ops fixed_voltage_ops = {
>  
>  static int __devinit reg_fixed_voltage_probe(struct platform_device *pdev)
>  {
> -	struct fixed_voltage_config *config = pdev->dev.platform_data;
> +	struct fixed_voltage_config *config;

This line doesn't actually need to change; just override it below if
the of_node is present.

>  	struct fixed_voltage_data *drvdata;
>  	int ret;
>  
> +	if (pdev->dev.of_node)
> +		config = of_get_fixed_voltage_config(&pdev->dev);
> +	else
> +		config = pdev->dev.platform_data;
> +
>  	drvdata = kzalloc(sizeof(struct fixed_voltage_data), GFP_KERNEL);
>  	if (drvdata == NULL) {
>  		dev_err(&pdev->dev, "Failed to allocate device data\n");
> @@ -252,12 +257,23 @@ static int __devexit reg_fixed_voltage_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id fixed_of_match[] __devinitconst = {
> +	{ .compatible = "regulator-fixed", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fixed_of_match);
> +#else
> +#define fixed_of_match NULL
> +#endif
> +
>  static struct platform_driver regulator_fixed_voltage_driver = {
>  	.probe		= reg_fixed_voltage_probe,
>  	.remove		= __devexit_p(reg_fixed_voltage_remove),
>  	.driver		= {
>  		.name		= "reg-fixed-voltage",
>  		.owner		= THIS_MODULE,
> +		.of_match_table = fixed_of_match,


>  	},
>  };
>  
> -- 
> 1.7.1
> 
