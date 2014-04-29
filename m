From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2] arm: dts: am33xx-clock: Fix ehrpwm tbclk data.
Date: Tue, 29 Apr 2014 15:48:20 +0300
Message-ID: <535F9F94.3060209@ti.com>
References: <1398760460-10539-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49295 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbaD2MsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 08:48:10 -0400
In-Reply-To: <1398760460-10539-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>, mturquette@linaro.org, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com

On 04/29/2014 11:34 AM, Sourav Poddar wrote:
> tbclk does not need to be a composite clock, we can simply
> use gate clock for this purpose.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Looks good to me so:

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
> v1->v2:
> change compatible string according to mainline.
>   arch/arm/boot/dts/am33xx-clocks.dtsi |   30 ++++++------------------------
>   1 file changed, 6 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
> index 9ccfe50..712edce 100644
> --- a/arch/arm/boot/dts/am33xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
> @@ -96,47 +96,29 @@
>   		clock-div = <1>;
>   	};
>
> -	ehrpwm0_gate_tbclk: ehrpwm0_gate_tbclk {
> +	ehrpwm0_tbclk: ehrpwm0_tbclk@44e10664 {
>   		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> +		compatible = "ti,gate-clock";
>   		clocks = <&dpll_per_m2_ck>;
>   		ti,bit-shift = <0>;
>   		reg = <0x0664>;
>   	};
>
> -	ehrpwm0_tbclk: ehrpwm0_tbclk {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&ehrpwm0_gate_tbclk>;
> -	};
> -
> -	ehrpwm1_gate_tbclk: ehrpwm1_gate_tbclk {
> +	ehrpwm1_tbclk: ehrpwm1_tbclk@44e10664 {
>   		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> +		compatible = "ti,gate-clock";
>   		clocks = <&dpll_per_m2_ck>;
>   		ti,bit-shift = <1>;
>   		reg = <0x0664>;
>   	};
>
> -	ehrpwm1_tbclk: ehrpwm1_tbclk {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&ehrpwm1_gate_tbclk>;
> -	};
> -
> -	ehrpwm2_gate_tbclk: ehrpwm2_gate_tbclk {
> +	ehrpwm2_tbclk: ehrpwm2_tbclk@44e10664 {
>   		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> +		compatible = "ti,gate-clock";
>   		clocks = <&dpll_per_m2_ck>;
>   		ti,bit-shift = <2>;
>   		reg = <0x0664>;
>   	};
> -
> -	ehrpwm2_tbclk: ehrpwm2_tbclk {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&ehrpwm2_gate_tbclk>;
> -	};
>   };
>   &prcm_clocks {
>   	clk_32768_ck: clk_32768_ck {
>

