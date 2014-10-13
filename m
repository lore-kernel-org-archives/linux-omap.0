From: Anton Tikhomirov <av.tikhomirov@samsung.com>
Subject: RE: [PATCH v2 1/4] dwc3: exynos: Add support for SCLK present on
 Exynos7
Date: Mon, 13 Oct 2014 13:54:59 +0900
Message-ID: <00f101cfe6a1$d772c5a0$865850e0$%tikhomirov@samsung.com>
References: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com>
 <1412677176-3850-2-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28185 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaJMEzC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2014 00:55:02 -0400
In-reply-to: <1412677176-3850-2-git-send-email-gautam.vivek@samsung.com>
Content-language: en-us
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Vivek Gautam' <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, kgene.kim@samsung.com, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, kishon@ti.com

Hi Vivek,

> Exynos7 also has a separate special gate clock going to the IP
> apart from the usual AHB clock. So add support for the same.

As we discussed before, Exynos7 SoCs have 7 clocks to be controlled
by the driver. Adding only sclk is not enough. 

> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-
> exynos.c
> index 3951a65..7dc6a98 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -35,6 +35,7 @@ struct dwc3_exynos {
>  	struct device		*dev;
> 
>  	struct clk		*clk;

The clock "clk" in Exynos5 just gated all that above 7 clocks, which
we should control separately now in Exynos7.

> +	struct clk		*sclk;
>  	struct regulator	*vdd33;
>  	struct regulator	*vdd10;
>  };
> @@ -139,10 +140,21 @@ static int dwc3_exynos_probe(struct
> platform_device *pdev)
>  		return -EINVAL;
>  	}
> 
> +	/*
> +	 * Exynos7 has a special gate clock going to this IP,
> +	 * which in earlier SoCs was probably concealed.
> +	 */
> +	exynos->sclk = devm_clk_get(dev, "usbdrd30_sclk");
> +	if (IS_ERR(exynos->sclk)) {
> +		dev_info(dev, "no sclk specified\n");
> +		exynos->sclk = NULL;
> +	}
> +
>  	exynos->dev	= dev;
>  	exynos->clk	= clk;
> 
>  	clk_prepare_enable(exynos->clk);
> +	clk_prepare_enable(exynos->sclk);
> 
>  	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
>  	if (IS_ERR(exynos->vdd33)) {
> @@ -185,6 +197,7 @@ err4:
>  err3:
>  	regulator_disable(exynos->vdd33);
>  err2:
> +	clk_disable_unprepare(exynos->sclk);
>  	clk_disable_unprepare(clk);
>  	return ret;
>  }
> @@ -197,6 +210,7 @@ static int dwc3_exynos_remove(struct
> platform_device *pdev)
>  	platform_device_unregister(exynos->usb2_phy);
>  	platform_device_unregister(exynos->usb3_phy);
> 
> +	clk_disable_unprepare(exynos->sclk);
>  	clk_disable_unprepare(exynos->clk);
> 
>  	regulator_disable(exynos->vdd33);
> @@ -218,6 +232,7 @@ static int dwc3_exynos_suspend(struct device *dev)
>  {
>  	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> 
> +	clk_disable(exynos->sclk);
>  	clk_disable(exynos->clk);
> 
>  	regulator_disable(exynos->vdd33);
> @@ -243,6 +258,7 @@ static int dwc3_exynos_resume(struct device *dev)
>  	}
> 
>  	clk_enable(exynos->clk);
> +	clk_enable(exynos->sclk);
> 
>  	/* runtime set active to reflect active state. */
>  	pm_runtime_disable(dev);
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

