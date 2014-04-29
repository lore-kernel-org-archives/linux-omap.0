From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] arm: dts: am43x-clock: add tbclk data for ehrpwm.
Date: Tue, 29 Apr 2014 15:46:18 +0300
Message-ID: <535F9F1A.2090103@ti.com>
References: <1398760447-10504-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398760447-10504-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/29/2014 11:34 AM, Sourav Poddar wrote:
> We need "tbclk" clock data for the functioning of ehrpwm
> module. Hence, populating the required clock information
> in clock dts file.
>
> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> ---
> v1->v2:
> change compatible according to mainline.
>   arch/arm/boot/dts/am43xx-clocks.dtsi |   48 ++++++++++++++++++++++++++++++++++
>   drivers/clk/ti/clk-43xx.c            |    6 +++++
>   2 files changed, 54 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
> index 142009c..4044441 100644
> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> @@ -87,6 +87,54 @@
>   		clock-mult = <1>;
>   		clock-div = <1>;
>   	};
> +
> +	ehrpwm0_tbclk: ehrpwm0_tbclk@44e10664 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_m2_ck>;
> +		ti,bit-shift = <0>;
> +		reg = <0x0664>;
> +	};
> +
> +	ehrpwm1_tbclk: ehrpwm1_tbclk@44e10664 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_m2_ck>;
> +		ti,bit-shift = <1>;
> +		reg = <0x0664>;
> +	};
> +
> +	ehrpwm2_tbclk: ehrpwm2_tbclk@44e10664 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_m2_ck>;
> +		ti,bit-shift = <2>;
> +		reg = <0x0664>;
> +	};
> +
> +	ehrpwm3_tbclk: ehrpwm3_tbclk@44e10664 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_m2_ck>;
> +		ti,bit-shift = <3>;
> +		reg = <0x0664>;
> +	};
> +
> +	ehrpwm4_tbclk: ehrpwm4_tbclk@44e10664 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_m2_ck>;
> +		ti,bit-shift = <4>;
> +		reg = <0x0664>;
> +	};
> +
> +	ehrpwm5_tbclk: ehrpwm5_tbclk@44e10664 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_m2_ck>;
> +		ti,bit-shift = <5>;
> +		reg = <0x0664>;
> +	};

Looking at the TRM, I guess pwm3, pwm4 and pwm5 bit-shifts are wrong? 
Namely, bit 3 of the register is used for PWM_SYNCSEL instead of PWM3 
clock enable. Is this correct and these should be fixed?

-Tero

>   };
>   &prcm_clocks {
>   	clk_32768_ck: clk_32768_ck {
> diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
> index 67c8de5..527a43d 100644
> --- a/drivers/clk/ti/clk-43xx.c
> +++ b/drivers/clk/ti/clk-43xx.c
> @@ -105,6 +105,12 @@ static struct ti_dt_clk am43xx_clks[] = {
>   	DT_CLK(NULL, "func_12m_clk", "func_12m_clk"),
>   	DT_CLK(NULL, "vtp_clk_div", "vtp_clk_div"),
>   	DT_CLK(NULL, "usbphy_32khz_clkmux", "usbphy_32khz_clkmux"),
> +	DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
> +	DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
> +	DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
> +	DT_CLK("48306200.ehrpwm", "tbclk", "ehrpwm3_tbclk"),
> +	DT_CLK("48308200.ehrpwm", "tbclk", "ehrpwm4_tbclk"),
> +	DT_CLK("4830a200.ehrpwm", "tbclk", "ehrpwm5_tbclk"),
>   	{ .node_name = NULL },
>   };
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
