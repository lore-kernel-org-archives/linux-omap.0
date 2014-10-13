From: Anton Tikhomirov <av.tikhomirov@samsung.com>
Subject: RE: [PATCH v2 3/4] phy: exynos5-usbdrd: Add facility for VBUS-BOOST-5V
 supply
Date: Mon, 13 Oct 2014 14:06:39 +0900
Message-ID: <00f301cfe6a3$78e90ab0$6abb2010$%tikhomirov@samsung.com>
References: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com>
 <1412677176-3850-4-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30772 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbaJMFGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2014 01:06:43 -0400
In-reply-to: <1412677176-3850-4-git-send-email-gautam.vivek@samsung.com>
Content-language: en-us
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Vivek Gautam' <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, kgene.kim@samsung.com, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, kishon@ti.com

Hi Vivek,

> Some Exynos SoCs have a separate regulator controlling a

I guess you meant the Exynos based *boards* instead of SoCs,
since Exynos SoCs don't have any boost regulators.

> Boost 5V supply which goes as input for VBUS regulator.
> So adding a control for the same in driver, to enable
> vbus supply on the port.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  drivers/phy/phy-exynos5-usbdrd.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-
> exynos5-usbdrd.c
> index 013ee84..57e8a0a 100644
> --- a/drivers/phy/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/phy-exynos5-usbdrd.c
> @@ -176,6 +176,7 @@ struct exynos5_usbdrd_phy {
>  	u32 extrefclk;
>  	struct clk *ref_clk;
>  	struct regulator *vbus;
> +	struct regulator *vbus_boost;
>  };
> 
>  static inline
> @@ -455,11 +456,20 @@ static int exynos5_usbdrd_phy_power_on(struct phy
> *phy)
>  	clk_prepare_enable(phy_drd->ref_clk);
> 
>  	/* Enable VBUS supply */
> +	if (phy_drd->vbus_boost) {
> +		ret = regulator_enable(phy_drd->vbus_boost);
> +		if (ret) {
> +			dev_err(phy_drd->dev,
> +				"Failed to enable VBUS boost supply\n");
> +			goto fail_vbus;
> +		}
> +	}
> +
>  	if (phy_drd->vbus) {
>  		ret = regulator_enable(phy_drd->vbus);
>  		if (ret) {
>  			dev_err(phy_drd->dev, "Failed to enable VBUS
> supply\n");
> -			goto fail_vbus;
> +			goto fail_vbus_boost;
>  		}
>  	}
> 
> @@ -468,6 +478,10 @@ static int exynos5_usbdrd_phy_power_on(struct phy
> *phy)
> 
>  	return 0;
> 
> +fail_vbus_boost:
> +	if (phy_drd->vbus_boost)
> +		regulator_disable(phy_drd->vbus_boost);
> +
>  fail_vbus:
>  	clk_disable_unprepare(phy_drd->ref_clk);
>  	clk_disable_unprepare(phy_drd->pipeclk);
> @@ -489,6 +503,8 @@ static int exynos5_usbdrd_phy_power_off(struct phy
> *phy)
>  	/* Disable VBUS supply */
>  	if (phy_drd->vbus)
>  		regulator_disable(phy_drd->vbus);
> +	if (phy_drd->vbus_boost)
> +		regulator_disable(phy_drd->vbus_boost);
> 
>  	clk_disable_unprepare(phy_drd->ref_clk);
>  	clk_disable_unprepare(phy_drd->pipeclk);
> @@ -644,7 +660,7 @@ static int exynos5_usbdrd_phy_probe(struct
> platform_device *pdev)
>  		break;
>  	}
> 
> -	/* Get Vbus regulator */
> +	/* Get Vbus regulators */
>  	phy_drd->vbus = devm_regulator_get(dev, "vbus");
>  	if (IS_ERR(phy_drd->vbus)) {
>  		ret = PTR_ERR(phy_drd->vbus);
> @@ -655,6 +671,16 @@ static int exynos5_usbdrd_phy_probe(struct
> platform_device *pdev)
>  		phy_drd->vbus = NULL;
>  	}
> 
> +	phy_drd->vbus_boost = devm_regulator_get(dev, "vbus-boost");
> +	if (IS_ERR(phy_drd->vbus_boost)) {
> +		ret = PTR_ERR(phy_drd->vbus_boost);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_warn(dev, "Failed to get VBUS boost supply
> regulator\n");
> +		phy_drd->vbus_boost = NULL;
> +	}
> +
>  	dev_vdbg(dev, "Creating usbdrd_phy phy\n");
> 
>  	for (i = 0; i < EXYNOS5_DRDPHYS_NUM; i++) {
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

