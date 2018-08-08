From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: ethernet: cpsw-phy-sel: prefer phandle for phy sel
 and update binding
Date: Wed, 8 Aug 2018 13:58:38 +0200
Message-ID: <20180808115838.GA18314@lunn.ch>
References: <20180808080354.100146-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808080354.100146-1-tony@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -19,6 +19,9 @@ Required properties:
>  - slaves		: Specifies number for slaves
>  - active_slave		: Specifies the slave to use for time stamping,
>  			  ethtool and SIOCGMIIPHY
> +- cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
> +			  device. Note that in legacy cases cpsw-phy-sel may be
> +			  a child device instead of a phandle.

Hi Tony

It would be good to reference cpsw-phy-sel.txt.

>  Optional properties:
>  - ti,hwmods		: Must be "cpgmac0"
> @@ -75,6 +78,7 @@ Examples:
>  		cpts_clock_mult = <0x80000000>;
>  		cpts_clock_shift = <29>;
>  		syscon = <&cm>;
> +		cpsw-phy-sel = <&phy_sel>;
>  		cpsw_emac0: slave@0 {
>  			phy_id = <&davinci_mdio>, <0>;
>  			phy-mode = "rgmii-txid";
> @@ -103,6 +107,7 @@ Examples:
>  		cpts_clock_mult = <0x80000000>;
>  		cpts_clock_shift = <29>;
>  		syscon = <&cm>;
> +		cpsw-phy-sel = <&phy_sel>;
>  		cpsw_emac0: slave@0 {
>  			phy_id = <&davinci_mdio>, <0>;
>  			phy-mode = "rgmii-txid";
> diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
> --- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
> +++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
> @@ -170,10 +170,13 @@ void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
>  	struct device_node *node;
>  	struct cpsw_phy_sel_priv *priv;
>  
> -	node = of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
> +	node = of_parse_phandle(dev->of_node, "cpsw-phy-sel", 0);
>  	if (!node) {

Do you need to handle EPROBE_DEFER here? The phandle points to a
device which has not yet been loaded? I'm not sure exactly where it
will be returned, maybe it is bus_find_device(), but i expect to see
some handling of it somewhere in this function.

> -		dev_err(dev, "Phy mode driver DT not found\n");
> -		return;
> +		node = of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
> +		if (!node) {
> +			dev_err(dev, "Phy mode driver DT not found\n");
> +			return;
> +		}
>  	}

	Andrew
