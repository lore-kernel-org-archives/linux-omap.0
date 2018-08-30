From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: cpsw: Document cpsw-phy-sel usage
 but prefer phandle
Date: Wed, 29 Aug 2018 19:08:45 -0500
Message-ID: <90e0f25f-45f5-b2c0-59d9-cdf25eb06c0c@ti.com>
References: <20180829150024.43210-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180829150024.43210-1-tony@atomide.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 08/29/2018 10:00 AM, Tony Lindgren wrote:
> The current cpsw usage for cpsw-phy-sel is undocumented but is used for
> all the boards using cpsw. And cpsw-phy-sel is not really a child of
> the cpsw device, it lives in the system control module instead.
> 
> Let's document the existing usage, and improve it a bit where we prefer
> to use a phandle instead of a child device for it. That way we can
> properly describe the hardware in dts files for things like genpd.

I'm ok with this series, but I really don't like cpsw-phy-sel in general.

It was introduced long time back and now I'm thinking about possibility to replace it with
one of current generic interfaces - for example mux-controller. 
Each port will control up to 3 muxes (port mode, idmode and rmii_ext_clk) and  
transform phy-mode => mux states.
What do you think?

Another option is to use phy, but it'd be complicated.

> 
> Cc: devicetree@vger.kernel.org
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   Documentation/devicetree/bindings/net/cpsw.txt | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -19,6 +19,10 @@ Required properties:
>   - slaves		: Specifies number for slaves
>   - active_slave		: Specifies the slave to use for time stamping,
>   			  ethtool and SIOCGMIIPHY
> +- cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
> +			  device. See also cpsw-phy-sel.txt for it's binding.
> +			  Note that in legacy cases cpsw-phy-sel may be
> +			  a child device instead of a phandle.
>   
>   Optional properties:
>   - ti,hwmods		: Must be "cpgmac0"
> @@ -75,6 +79,7 @@ Examples:
>   		cpts_clock_mult = <0x80000000>;
>   		cpts_clock_shift = <29>;
>   		syscon = <&cm>;
> +		cpsw-phy-sel = <&phy_sel>;
>   		cpsw_emac0: slave@0 {
>   			phy_id = <&davinci_mdio>, <0>;
>   			phy-mode = "rgmii-txid";
> @@ -103,6 +108,7 @@ Examples:
>   		cpts_clock_mult = <0x80000000>;
>   		cpts_clock_shift = <29>;
>   		syscon = <&cm>;
> +		cpsw-phy-sel = <&phy_sel>;
>   		cpsw_emac0: slave@0 {
>   			phy_id = <&davinci_mdio>, <0>;
>   			phy-mode = "rgmii-txid";
> 

-- 
regards,
-grygorii
