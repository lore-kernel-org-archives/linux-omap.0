From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 05/11] TWL: regulator: Make twl-regulator driver
 extract data from DT
Date: Thu, 15 Sep 2011 16:18:11 -0600
Message-ID: <20110915221811.GN3523@ponder.secretlab.ca>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41795 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935167Ab1IOWSQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 18:18:16 -0400
Received: by gxk6 with SMTP id 6so1784621gxk.5
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 15:18:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316085727-15023-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:52:01PM +0530, Rajendra Nayak wrote:
> Modify the twl regulator driver to extract the regulator_init_data from
> device tree when passed, instead of getting it through platform_data
> structures (on non-DT builds)
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  drivers/regulator/twl-regulator.c |   28 +++++++++++++++++++++++++---
>  1 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index ee8747f..df1b95a 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -17,6 +17,8 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c/twl.h>
> +#include <linux/of.h>
> +#include <linux/of_regulator.h>
>  
>  
>  /*
> @@ -1011,6 +1013,9 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
>  	struct regulation_constraints	*c;
>  	struct regulator_dev		*rdev;
>  
> +	if (pdev->dev.of_node)
> +		of_property_read_u32(pdev->dev.of_node, "ti,reg-id", &pdev->id);
> +

Don't do this.  As much as possible, don't reply on plaform_device->id
when using DT.  Plus it is illegal to modify pdev->id after the device
is registered.

>  	for (i = 0, info = NULL; i < ARRAY_SIZE(twl_regs); i++) {
>  		if (twl_regs[i].desc.id != pdev->id)
>  			continue;
> @@ -1020,7 +1025,11 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -ENODEV;
>  
> -	initdata = pdev->dev.platform_data;
> +	if (pdev->dev.of_node)
> +		initdata = of_get_regulator_init_data(pdev->dev.of_node);
> +	else
> +		initdata = pdev->dev.platform_data;
> +
>  	if (!initdata)
>  		return -EINVAL;
>  
> @@ -1101,14 +1110,27 @@ static int __devexit twlreg_remove(struct platform_device *pdev)
>  
>  MODULE_ALIAS("platform:twl_reg");
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id twl_of_match[] __devinitconst = {
> +	{ .compatible = "ti,twl-reg", },

This looks rather generic.  Is this a specific chip?  It should be.

g.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, twl_of_match);
> +#else
> +#define twl_of_match NULL
> +#endif
> +
>  static struct platform_driver twlreg_driver = {
>  	.probe		= twlreg_probe,
>  	.remove		= __devexit_p(twlreg_remove),
>  	/* NOTE: short name, to work around driver model truncation of
>  	 * "twl_regulator.12" (and friends) to "twl_regulator.1".
>  	 */
> -	.driver.name	= "twl_reg",
> -	.driver.owner	= THIS_MODULE,
> +	.driver  = {
> +		.name  = "twl_reg",
> +		.owner = THIS_MODULE,
> +		.of_match_table = twl_of_match,
> +	},
>  };
>  
>  static int __init twlreg_init(void)
> -- 
> 1.7.1
> 
