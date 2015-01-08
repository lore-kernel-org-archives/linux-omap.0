From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] arm: boot: dts: am437x-idk: add gpio-based power key
Date: Wed, 7 Jan 2015 16:12:31 -0800
Message-ID: <20150108001231.GP13010@atomide.com>
References: <1419626116-12833-1-git-send-email-balbi@ti.com>
 <1419627193-20838-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419627193-20838-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [141226 12:56]:
> AM437x IDK board has a User Switch which we can
> program to whatever we want. Because this board
> doesn't have a PMIC which can give us power button
> presses, let's use this user switch as a gpio-keys
> power button.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v3.20/dt thanks.

Tony

> ---
> 
> Changes since v1:
> 	- Add explicit pinctrl data.
> 	  (note that ball reset state is already MUX_MODE7, and even
> 	   though it was already working before, as can be seen from
> 	   v1's boot logs, it's best that we cope with possibly broken
> 	   bootloaders)
> 
> depends on [1]. Boot logs at [2]. Note that this can rather easily
> be folded into the original patch if so desired.
> 
> [1] http://marc.info/?l=linux-omap&m=141928747902983&w=2
> [2] http://hastebin.com/qezicehunu
> 
>  arch/arm/boot/dts/am437x-idk-evm.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
> index b52dd0a..f9a17e2 100644
> --- a/arch/arm/boot/dts/am437x-idk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-idk-evm.dts
> @@ -96,9 +96,29 @@
>  		regulator-boot-on;
>  		vin-supply = <&v1_5dreg>;
>  	};
> +
> +	gpio_keys: gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_pins_default>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		switch@0 {
> +			label = "power-button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
>  };
>  
>  &am43xx_pinmux {
> +	gpio_keys_pins_default: gpio_keys_pins_default {
> +		pinctrl-single,pins = <
> +			0x1b8 (PIN_INPUT | MUX_MODE7)	/* cam0_field.gpio4_2 */
> +		>;
> +	};
> +
>  	i2c0_pins_default: i2c0_pins_default {
>  		pinctrl-single,pins = <
>  			0x188 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_sda.i2c0_sda */
> @@ -282,6 +302,10 @@
>  	status = "okay";
>  };
>  
> +&gpio4 {
> +	status = "okay";
> +};
> +
>  &gpio5 {
>  	status = "okay";
>  };
> -- 
> 2.2.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
