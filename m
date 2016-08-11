From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-wega: Add audio support
Date: Thu, 11 Aug 2016 12:25:53 +0300
Message-ID: <7109f6e5-e7fd-4b60-98b7-85b9d78ef690@ti.com>
References: <1470841935-14190-1-git-send-email-s.mueller-klieser@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470841935-14190-1-git-send-email-s.mueller-klieser-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Stefan_M=c3=bcller-Klieser?= <s.mueller-klieser-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/10/16 18:12, Stefan Müller-Klieser wrote:
> The wega board has a TLV320AIC3007 connected via McASP0. In the default
> configuration, no external crystal is mounted. We run a system clock of
> 25 MHz, so we use the audio codec PLL for audio clock generation.

It is great that the "ti,da830-evm-audio" works for you. I hope I will have
time soon to work on the McASP driver's CCF support in the near future.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

> Signed-off-by: Stefan Müller-Klieser <s.mueller-klieser-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-wega.dtsi | 62 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
> index 282f6d4..7f5f8ed 100644
> --- a/arch/arm/boot/dts/am335x-wega.dtsi
> +++ b/arch/arm/boot/dts/am335x-wega.dtsi
> @@ -11,6 +11,10 @@
>  	model = "Phytec AM335x phyBOARD-WEGA";
>  	compatible = "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti,am33xx";
>  
> +	sound: sound_iface {
> +		compatible = "ti,da830-evm-audio";
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  
> @@ -24,6 +28,58 @@
>  	};
>  };
>  
> +/* Audio */
> +&am33xx_pinmux {
> +	mcasp0_pins: pinmux_mcasp0 {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x9AC, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahclkx */
> +			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_aclkx.mcasp0_aclkx */
> +			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_fsx.mcasp0_fsx */
> +			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_axr0.mcasp0_axr0 */
> +			AM33XX_IOPAD(0x9A8, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr1.mcasp0_axr1 */
> +		>;
> +	};
> +};
> +
> +&i2c0 {
> +	tlv320aic3007: tlv320aic3007@18 {
> +		compatible = "ti,tlv320aic3007";
> +		reg = <0x18>;
> +		AVDD-supply = <&vcc3v3>;
> +		IOVDD-supply = <&vcc3v3>;
> +		DRVDD-supply = <&vcc3v3>;
> +		DVDD-supply = <&vdig1_reg>;
> +		status = "okay";
> +	};
> +};
> +
> +&mcasp0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcasp0_pins>;
> +	op-mode = <0>; /* DAVINCI_MCASP_IIS_MODE */
> +	tdm-slots = <2>;
> +	serial-dir = <
> +		2 1 0 0 /* # 0: INACTIVE, 1: TX, 2: RX */
> +	>;
> +	tx-num-evt = <16>;
> +	rt-num-evt = <16>;
> +	status = "okay";
> +};
> +
> +&sound {
> +	ti,model = "AM335x-Wega";
> +	ti,audio-codec = <&tlv320aic3007>;
> +	ti,mcasp-controller = <&mcasp0>;
> +	ti,audio-routing =
> +		"Line Out",		"LLOUT",
> +		"Line Out",		"RLOUT",
> +		"LINE1L",		"Line In",
> +		"LINE1R",		"Line In";
> +	clocks = <&mcasp0_fck>;
> +	clock-names = "mclk";
> +	status = "okay";
> +};
> +
>  /* CAN Busses */
>  &am33xx_pinmux {
>  	dcan1_pins: pinmux_dcan1 {
> @@ -99,6 +155,12 @@
>  	status = "okay";
>  };
>  
> +/* Power */
> +&vdig1_reg {
> +	regulator-boot-on;
> +	regulator-always-on;
> +};
> +
>  /* UARTs */
>  &am33xx_pinmux {
>  	uart0_pins: pinmux_uart0 {
> 


-- 
Péter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
