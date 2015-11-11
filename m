From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: dts: cm-t335: add basic support for I2C
Date: Wed, 11 Nov 2015 19:32:44 +0200
Message-ID: <56437BBC.3070108@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1445948100-16446-3-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445948100-16446-3-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, igor.grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Gentle ping

On 27/10/15 14:14, Uri Mashiach wrote:
> From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>
> Add pinmux configuration for I2C0 and I2C1 pins.
> Add description for I2C0 bus, set clock frequency to 400kHz.
> Add child nodes for 24c02 EEPROM and em3027 RTC on I2C0 bus.
>
> Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> ---
>   arch/arm/boot/dts/am335x-cm-t335.dts | 37 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
> index 197d5ce..39df3d2 100644
> --- a/arch/arm/boot/dts/am335x-cm-t335.dts
> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
> @@ -37,6 +37,24 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <>;
>
> +	i2c0_pins: pinmux_i2c0_pins {
> +		pinctrl-single,pins = <
> +			/* i2c0_sda.i2c0_sda */
> +			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* i2c0_scl.i2c0_scl */
> +			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)
> +		>;
> +	};
> +
> +	i2c1_pins: pinmux_i2c1_pins {
> +		pinctrl-single,pins = <
> +			/* uart0_ctsn.i2c1_sda */
> +			0x168 (PIN_INPUT_PULLUP | MUX_MODE2)
> +			/* uart0_rtsn.i2c1_scl */
> +			0x16c (PIN_INPUT_PULLUP | MUX_MODE2)
> +		>;
> +	};
> +
>   	gpio_led_pins: pinmux_gpio_led_pins {
>   		pinctrl-single,pins = <
>   			0x88 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
> @@ -60,3 +78,22 @@
>   	status = "okay";
>   };
>
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	eeprom: 24c02@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +
> +	ext_rtc: em3027@56 {
> +		compatible = "emmicro,em3027";
> +		reg = <0x56>;
> +	};
> +};
> +
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
