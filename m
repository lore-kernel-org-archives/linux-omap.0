From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 5/8] ARM: dts: Drop bogus ahclkr clocks for dra7 mcasp 3
 to 8
Date: Tue, 23 Jul 2019 16:01:42 -0500
Message-ID: <2c750847-700e-c835-ee53-a656b363c36c@ti.com>
References: <20190723112811.44381-1-tony@atomide.com>
 <20190723112811.44381-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723112811.44381-6-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 7/23/19 6:28 AM, Tony Lindgren wrote:
> The ahclkr clkctrl clock bit 28 only exists for mcasp 1 and 2 on dra7.
> Otherwise we get the following warning on beagle-x15:
> 
> ti-sysc 48468000.target-module: could not add child clock ahclkr: -19
> 
> Fixes: 5241ccbf2819 ("ARM: dts: Add missing ranges for dra7 mcasp l3 ports")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/dra7-l4.dtsi | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
> --- a/arch/arm/boot/dts/dra7-l4.dtsi
> +++ b/arch/arm/boot/dts/dra7-l4.dtsi
> @@ -2818,9 +2818,8 @@
>  					<SYSC_IDLE_SMART>;
>  			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
>  			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 0>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 24>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 28>;
> -			clock-names = "fck", "ahclkx", "ahclkr";
> +				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 24>;
> +			clock-names = "fck", "ahclkx";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x0 0x68000 0x2000>,
> @@ -2854,9 +2853,8 @@
>  					<SYSC_IDLE_SMART>;
>  			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
>  			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 0>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 24>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 28>;
> -			clock-names = "fck", "ahclkx", "ahclkr";
> +				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 24>;
> +			clock-names = "fck", "ahclkx";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x0 0x6c000 0x2000>,
> @@ -2890,9 +2888,8 @@
>  					<SYSC_IDLE_SMART>;
>  			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
>  			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 0>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 24>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 28>;
> -			clock-names = "fck", "ahclkx", "ahclkr";
> +				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 24>;
> +			clock-names = "fck", "ahclkx";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x0 0x70000 0x2000>,
> @@ -2926,9 +2923,8 @@
>  					<SYSC_IDLE_SMART>;
>  			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
>  			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 0>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 24>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 28>;
> -			clock-names = "fck", "ahclkx", "ahclkr";
> +				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 24>;
> +			clock-names = "fck", "ahclkx";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x0 0x74000 0x2000>,
> @@ -2962,9 +2958,8 @@
>  					<SYSC_IDLE_SMART>;
>  			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
>  			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 0>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>,
> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 28>;
> -			clock-names = "fck", "ahclkx", "ahclkr";
> +				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>;
> +			clock-names = "fck", "ahclkx";

The equivalent change to MCASP8 is missing.

regards
Suman

>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x0 0x78000 0x2000>,
> 
