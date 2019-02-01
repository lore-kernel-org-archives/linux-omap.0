From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 2/2] arm: dts: gta04: add gps support
Date: Fri, 1 Feb 2019 11:04:16 +0100
Message-ID: <20190201100416.GD3691@localhost>
References: <20190131180640.14480-1-andreas@kemnade.info>
 <20190131180640.14480-3-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131180640.14480-3-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Johan Hovold <johan@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> which one is mounted so use the compatibility entry for w2sg0004
> for all which will work for both.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v3:
> - converted to a patchset
> - added vcc-supply
> 
> Changes in v2:
> - some s/gps/gnss/
> - not added vcc-supply because the regulator is not modelled
>   in dts at all
> 
> w2sg0004 bindings are in next-20190129
> 
>  arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 02d8274a2f47..4ea0f7dc37c6 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -320,6 +320,12 @@
>  		>;
>         };
>  
> +	gps_pins: pinmux_gps_pins {

s/gps/gnss/ would be more consistent, but whatever.

> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* gpio145 */
> +		>;
> +	};
> +
>  	hdq_pins: hdq_pins {
>  		pinctrl-single,pins = <
>  			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
> @@ -652,6 +658,14 @@
>  &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart2_pins>;
> +	gnss: gnss {
> +		compatible = "wi2wi,w2sg0004";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gps_pins>;
> +		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +		lna-supply = <&vsim>;
> +		vcc-supply = <&ldo_3v3>;
> +	};

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
