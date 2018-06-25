From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH V2] clk: ti: omap3: Fix am3517 mdio clock alias
Date: Mon, 25 Jun 2018 15:16:57 +0300
Message-ID: <60e56097-0c57-2352-d1f0-76740a5b75f1@ti.com>
References: <20180625105313.4201-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180625105313.4201-1-aford173@gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, adam.ford@logicpd.com
Cc: woods.technical@gmail.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 25/06/18 13:53, Adam Ford wrote:

Subject line should be: "ARM: dts: omap3:" etc.

-Tero

> A previous patch removed OMAP clock aliases that were perceived
> to be unnecessary.  Unfortunately, it broke the ethernet on the
> am3517-evm.  This patch enables the MDIO clock and EMAC clock.
> 
> Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
> Cc: stable@vger.kernel.org #4.16+
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Instead of modifying clk-3xxx.c, this patch modifie the device tree
>       to work like the original patch intended.
> 
> diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
> index ca294914bbb1..4b6062b631b1 100644
> --- a/arch/arm/boot/dts/am3517.dtsi
> +++ b/arch/arm/boot/dts/am3517.dtsi
> @@ -39,6 +39,8 @@
>   			ti,davinci-ctrl-ram-size = <0x2000>;
>   			ti,davinci-rmii-en = /bits/ 8 <1>;
>   			local-mac-address = [ 00 00 00 00 00 00 ];
> +			clocks = <&emac_ick>;
> +			clock-names = "ick";
>   		};
>   
>   		davinci_mdio: ethernet@5c030000 {
> @@ -49,6 +51,8 @@
>   			bus_freq = <1000000>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> +			clocks = <&emac_fck>;
> +			clock-names = "fck";
>   		};
>   
>   		uart4: serial@4809e000 {
> 
