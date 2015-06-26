From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] arm: dts: am43xx-clock: Add qspi clock node.
Date: Fri, 26 Jun 2015 11:50:30 +0530
Message-ID: <558CEF2E.3050202@ti.com>
References: <1435167933-5249-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435167933-5249-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 24 June 2015 11:15 PM, Mugunthan V N wrote:
> From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
>
> Add clock node for qspi controller driver on am437x.
>
> Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/am4372.dtsi        | 2 ++
>   arch/arm/boot/dts/am43xx-clocks.dtsi | 8 ++++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 649e7b9..8ab7831 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -903,6 +903,8 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			ti,hwmods = "qspi";
> +			clocks = <&qspi_fclk>;
> +			clock-names = "fck";
>   			interrupts = <0 138 0x4>;
>   			num-cs = <4>;
>   			status = "disabled";
> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
> index cc88728..1506585 100644
> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> @@ -763,4 +763,12 @@
>   		ti,bit-shift = <8>;
>   		reg = <0x8a68>;
>   	};
> +
> +	qspi_fclk: qspi_fclk {
> +		#clock-cells = <0>;
> +		compatible = "ti,fixed-factor-clock";
> +		clocks = <&dpll_per_m2_div4_ck>;

 From the clock tree this does not seem to be sourced from dpll_per_m2.
I guess this needs to be changed.

-Keerthy

> +		clock-mult = <1>;
> +		clock-div = <1>;
> +	};
>   };
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
