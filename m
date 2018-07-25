From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 20/32] ARM: dts: omap3-gta04: add devconf0 setup for
 mcbsp1 clock pins
Date: Wed, 25 Jul 2018 10:12:51 +0200
Message-ID: <20180725081251.GC7467@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <5dbe024d9465eab668ba9aac3732ded225859e6f.1532501910.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5dbe024d9465eab668ba9aac3732ded225859e6f.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Marek Belisko <marek@goldelico.com>, =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 25, 2018 at 08:58:52AM +0200, H. Nikolaus Schaller wrote:
> McBSP1 needs sepcial "pinctrl" for the clocks.

Nit: "special" perhaps?

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 935a2a707737..f6abdef556c1 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -187,6 +187,24 @@
>  		reset-gpios = <&tca6507 0 GPIO_ACTIVE_LOW>;	/* W2CBW003 reset through tca6507 */
>  	};
>  
> +	/* devconf0 setup for mcbsp1 clock pins */
> +	pinmux_mcbsp1@48002274 {
> +		compatible = "pinctrl-single";
> +		reg = <0x48002274 4>;   /* CONTROL_DEVCONF0 */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-single,bit-per-mux;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0x7>;	/* MCBSP1 CLK pinmux */
> +		#pinctrl-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcbsp1_devconf0_pins>;
> +		mcbsp1_devconf0_pins: pinmux_mcbsp1_devconf0_pins {
> +			/*                   offset bits mask */
> +			pinctrl-single,bits = <0x00 0x08 0x1c>;	/* set MCBSP1_CLKR */
> +		};
> +	};
> +
>  	/* devconf1 setup for tvout pins */
>  	pinmux_tv_out@480022d8 {
>  		compatible = "pinctrl-single";
> -- 
> 2.12.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
