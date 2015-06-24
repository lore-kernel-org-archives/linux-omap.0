From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 03/17] phy: ti-pipe3: use *syscon* framework to set PCS
 value of the PHY
Date: Wed, 24 Jun 2015 13:34:43 +0300
Message-ID: <20150624133443.6ad1262fcf174c755e9ad7b2@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
	<1435060743-5511-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435060743-5511-4-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 23 Jun 2015 17:28:48 +0530
Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:

> Deprecate using phy-omap-control driver to set PCS value of the PHY
> and start using *syscon* framework to do the same.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |    2 ++
>  drivers/phy/phy-ti-pipe3.c                       |   32 +++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index d3ad3bf..52c7a92 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -83,6 +83,8 @@ Optional properties:
>   - syscon-pllreset: Handle to system control region that contains the
>     CTRL_CORE_SMA_SW_0 register and register offset to the CTRL_CORE_SMA_SW_0
>     register that contains the SATA_PLL_SOFT_RESET bit. Only valid for sata_phy.
> + - syscon-pcs : phandle/offset pair. Phandle to the system control module and the
> +   register offset to write the PCS delay value.

What is PCS?
Is this valid only for PCIe? If yes we could mention it here.

>  
>  Deprecated properties:
>   - ctrl-module : phandle of the control module used by PHY driver to power on
> diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
> index 78bac00..e2f9ad7 100644
> --- a/drivers/phy/phy-ti-pipe3.c
> +++ b/drivers/phy/phy-ti-pipe3.c
> @@ -65,6 +65,9 @@
>  #define PIPE3_PHY_TX_RX_POWERON		0x3
>  #define PIPE3_PHY_TX_RX_POWEROFF	0x0
>  
> +#define PCIE_PCS_MASK			0xFF0000
> +#define PCIE_PCS_DELAY_COUNT_SHIFT	0x10
> +
>  /*
>   * This is an Empirical value that works, need to confirm the actual
>   * value required for the PIPE3PHY_PLL_CONFIGURATION2.PLL_IDLE status
> @@ -96,9 +99,11 @@ struct ti_pipe3 {
>  	struct clk		*div_clk;
>  	struct pipe3_dpll_map	*dpll_map;
>  	struct regmap		*phy_power_syscon; /* ctrl. reg. acces */
> +	struct regmap		*pcs_syscon; /* ctrl. reg. acces */
>  	struct regmap		*dpll_reset_syscon; /* ctrl. reg. acces */
>  	unsigned int		dpll_reset_reg; /* reg. index within syscon */
>  	unsigned int		power_reg; /* power reg. index within syscon */
> +	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
>  	bool			sata_refclk_enabled;
>  };
>  
> @@ -271,7 +276,16 @@ static int ti_pipe3_init(struct phy *x)
>  	 * 18-1804.
>  	 */
>  	if (of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
> -		omap_control_pcie_pcs(phy->control_dev, 0x96);
> +		if (phy->pcs_syscon) {
> +			val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
> +			ret = regmap_update_bits(phy->pcs_syscon,
> +						 phy->pcie_pcs_reg,
> +						 PCIE_PCS_MASK, val);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			omap_control_pcie_pcs(phy->control_dev, 0x96);
> +		}
>  		return 0;
>  	}
>  
> @@ -455,6 +469,22 @@ static int ti_pipe3_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "unable to get div-clk\n");
>  			return PTR_ERR(phy->div_clk);
>  		}
> +
> +		phy->pcs_syscon = syscon_regmap_lookup_by_phandle(node,
> +								  "syscon-pcs");
> +		if (IS_ERR(phy->pcs_syscon)) {
> +			dev_dbg(&pdev->dev,
> +				 "can't get syscon-pcs, using omap control\n");
> +			phy->pcs_syscon = NULL;
> +		} else {
> +			if (of_property_read_u32_index(node,
> +						       "syscon-pcs", 1,
> +						       &phy->pcie_pcs_reg)) {
> +				dev_err(&pdev->dev,
> +					"couldn't get pcie pcs reg. offset\n");
> +				return -EINVAL;
> +			}
> +		}
>  	} else {
>  		phy->div_clk = ERR_PTR(-ENODEV);
>  	}
> -- 
> 1.7.9.5
> 

Other than that,

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
