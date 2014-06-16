From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] regulator: twl: Convert to use devm_kmemdup()
Date: Mon, 16 Jun 2014 07:59:22 -0500
Message-ID: <539EEA2A.2040207@ti.com>
References: <1402883060.4707.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46760 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbaFPM7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 08:59:40 -0400
In-Reply-To: <1402883060.4707.1.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Rajendra Nayak <rnayak@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

+linux-omap.

On 06/15/2014 08:44 PM, Axel Lin wrote:

Might be nice to have a commit message here.

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/twl-regulator.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index fed28ab..0b4f866 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -1128,7 +1128,7 @@ static int twlreg_probe(struct platform_device *pdev)
>  	if (!initdata)
>  		return -EINVAL;
>  
> -	info = kmemdup(template, sizeof(*info), GFP_KERNEL);
> +	info = devm_kmemdup(&pdev->dev, template, sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> @@ -1192,7 +1192,6 @@ static int twlreg_probe(struct platform_device *pdev)
>  	if (IS_ERR(rdev)) {
>  		dev_err(&pdev->dev, "can't register %s, %ld\n",
>  				info->desc.name, PTR_ERR(rdev));
> -		kfree(info);
>  		return PTR_ERR(rdev);
>  	}
>  	platform_set_drvdata(pdev, rdev);
> @@ -1212,20 +1211,10 @@ static int twlreg_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int twlreg_remove(struct platform_device *pdev)
> -{
> -	struct regulator_dev *rdev = platform_get_drvdata(pdev);
> -	struct twlreg_info *info = rdev->reg_data;
> -
> -	kfree(info);
> -	return 0;
> -}
> -
>  MODULE_ALIAS("platform:twl_reg");
>  
>  static struct platform_driver twlreg_driver = {
>  	.probe		= twlreg_probe,
> -	.remove		= twlreg_remove,
>  	/* NOTE: short name, to work around driver model truncation of
>  	 * "twl_regulator.12" (and friends) to "twl_regulator.1".
>  	 */
> 

otherwise, looks good to me.
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
