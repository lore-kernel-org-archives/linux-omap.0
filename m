From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: Re: [PATCH V3] ARM: dts: omap3: Fix am3517 mdio and emac clock
 references
Date: Mon, 25 Jun 2018 08:19:56 -0500
Message-ID: <20180625131955.GA25402@ethiopia>
References: <20180625124133.21839-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180625124133.21839-1-aford173@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: adam.ford@logicpd.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 25, 2018 at 07:41:33AM -0500, Adam Ford wrote:
> A previous patch removed OMAP clock aliases that were perceived
> to be unnecessary.  Unfortunately, it broke the ethernet on the
> am3517-evm.  This patch enables the MDIO clock and EMAC clock.
> 

Tested-by: Derald D. Woods <woods.technical@gmail.com>

> Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
> Cc: stable@vger.kernel.org #4.16+
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Fix subject heading since we're no longer modifying the clk driver
> 
> V2:  Instead of modifying clk-3xxx.c, this patch modifie the device tree
>      to work like the original patch intended.
>      
> diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
> index ca294914bbb1..4b6062b631b1 100644
> --- a/arch/arm/boot/dts/am3517.dtsi
> +++ b/arch/arm/boot/dts/am3517.dtsi
> @@ -39,6 +39,8 @@
>  			ti,davinci-ctrl-ram-size = <0x2000>;
>  			ti,davinci-rmii-en = /bits/ 8 <1>;
>  			local-mac-address = [ 00 00 00 00 00 00 ];
> +			clocks = <&emac_ick>;
> +			clock-names = "ick";
>  		};
>  
>  		davinci_mdio: ethernet@5c030000 {
> @@ -49,6 +51,8 @@
>  			bus_freq = <1000000>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +			clocks = <&emac_fck>;
> +			clock-names = "fck";
>  		};
>  
>  		uart4: serial@4809e000 {
> -- 
> 2.17.1
> 
