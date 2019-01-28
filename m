From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm: dts: gta04: add gps support
Date: Mon, 28 Jan 2019 08:53:56 +0100
Message-ID: <20190128075356.GJ3691@localhost>
References: <20190125194310.11170-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125194310.11170-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 25, 2019 at 08:43:10PM +0100, Andreas Kemnade wrote:
> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> which one is mounted so use the compatibility entry for w2sg0004
> for all which will work for both.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> w2sg0004 bindings (together with the corresponding support is in
> https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next)
>  arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index e53d32691308..d58c117e429f 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -312,6 +312,12 @@
>  		>;
>         };
>  
> +	gps_pins: pinmux_gps_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* gpio145 */
> +		>;
> +	};
> +
>  	hdq_pins: hdq_pins {
>  		pinctrl-single,pins = <
>  			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
> @@ -644,6 +650,13 @@
>  &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart2_pins>;
> +	gps: gps {

The node should be named "gnss" as per the binding.

> +		compatible = "wi2wi,w2sg0004";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gps_pins>;
> +		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +		lna-supply = <&vsim>;

Also, the vcc-supply is a required property.

> +	};
>  };
>  
>  &uart3 {

Johan
