From: Anton Tikhomirov <av.tikhomirov@samsung.com>
Subject: RE: [PATCH v2 2/4] phy: exynos5-usbdrd: Add pipe-clk and utmi-clk
 support
Date: Mon, 13 Oct 2014 14:02:27 +0900
Message-ID: <00f201cfe6a2$e2e829b0$a8b87d10$%tikhomirov@samsung.com>
References: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com>
 <1412677176-3850-3-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1412677176-3850-3-git-send-email-gautam.vivek@samsung.com>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Vivek Gautam' <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, kgene.kim@samsung.com, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Vivek,

> Exynos7 SoC has now separate gate control for 125MHz pipe3 phy
> clock, as well as 60MHz utmi phy clock.
> So get the same and control in the phy-exynos5-usbdrd driver.

In case of the PHY the situation is pretty much the same as with
DWC3 core. Here we should control 6 clocks to make Exynos7 USB DRD
PHY working.

By the way, the driver name phy-exynos5-usbdrd.c doesn't imply it
supports Exynos7 :)

> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt        |    4 ++++
>  drivers/phy/phy-exynos5-usbdrd.c                   |   22
> ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt
> b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> index 15e0f2c..c2bc9dc 100644
> --- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> @@ -138,6 +138,10 @@ Required properties:
>  	       PHY operations, associated by phy name. It is used to
>  	       determine bit values for clock settings register.
>  	       For Exynos5420 this is given as 'sclk_usbphy30' in CMU.
> +	- optional clocks: Exynos7 SoC has now following additional
> +			   gate clocks available:
> +			   - phy_pipe: for PIPE3 phy
> +			   - phy_utmi: for UTMI+ phy
>  - samsung,pmu-syscon: phandle for PMU system controller interface,
> used to
>  		      control pmu registers for power isolation.
>  - #phy-cells : from the generic PHY bindings, must be 1;
> diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-
> exynos5-usbdrd.c
> index f756aca..013ee84 100644
> --- a/drivers/phy/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/phy-exynos5-usbdrd.c
> @@ -148,6 +148,8 @@ struct exynos5_usbdrd_phy_drvdata {
>   * @dev: pointer to device instance of this platform device
>   * @reg_phy: usb phy controller register memory base
>   * @clk: phy clock for register access
> + * @pipeclk: clock for pipe3 phy
> + * @utmiclk: clock for utmi+ phy
>   * @drv_data: pointer to SoC level driver data structure
>   * @phys[]: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
>   *	    instances each with its 'phy' and 'phy_cfg'.
> @@ -161,6 +163,8 @@ struct exynos5_usbdrd_phy {
>  	struct device *dev;
>  	void __iomem *reg_phy;
>  	struct clk *clk;
> +	struct clk *pipeclk;
> +	struct clk *utmiclk;
>  	const struct exynos5_usbdrd_phy_drvdata *drv_data;
>  	struct phy_usb_instance {
>  		struct phy *phy;
> @@ -446,6 +450,8 @@ static int exynos5_usbdrd_phy_power_on(struct phy
> *phy)
> 
>  	dev_dbg(phy_drd->dev, "Request to power_on usbdrd_phy phy\n");
> 
> +	clk_prepare_enable(phy_drd->utmiclk);
> +	clk_prepare_enable(phy_drd->pipeclk);
>  	clk_prepare_enable(phy_drd->ref_clk);
> 
>  	/* Enable VBUS supply */
> @@ -464,6 +470,8 @@ static int exynos5_usbdrd_phy_power_on(struct phy
> *phy)
> 
>  fail_vbus:
>  	clk_disable_unprepare(phy_drd->ref_clk);
> +	clk_disable_unprepare(phy_drd->pipeclk);
> +	clk_disable_unprepare(phy_drd->utmiclk);
> 
>  	return ret;
>  }
> @@ -483,6 +491,8 @@ static int exynos5_usbdrd_phy_power_off(struct phy
> *phy)
>  		regulator_disable(phy_drd->vbus);
> 
>  	clk_disable_unprepare(phy_drd->ref_clk);
> +	clk_disable_unprepare(phy_drd->pipeclk);
> +	clk_disable_unprepare(phy_drd->utmiclk);
> 
>  	return 0;
>  }
> @@ -582,6 +592,18 @@ static int exynos5_usbdrd_phy_probe(struct
> platform_device *pdev)
>  		return PTR_ERR(phy_drd->clk);
>  	}
> 
> +	phy_drd->pipeclk = devm_clk_get(dev, "phy_pipe");
> +	if (IS_ERR(phy_drd->pipeclk)) {
> +		dev_info(dev, "PIPE3 phy operational clock not
> specified\n");
> +		phy_drd->pipeclk = NULL;
> +	}
> +
> +	phy_drd->utmiclk = devm_clk_get(dev, "phy_utmi");
> +	if (IS_ERR(phy_drd->utmiclk)) {
> +		dev_info(dev, "UTMI phy operational clock not specified\n");
> +		phy_drd->utmiclk = NULL;
> +	}
> +
>  	phy_drd->ref_clk = devm_clk_get(dev, "ref");
>  	if (IS_ERR(phy_drd->ref_clk)) {
>  		dev_err(dev, "Failed to get reference clock of usbdrd
> phy\n");
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
