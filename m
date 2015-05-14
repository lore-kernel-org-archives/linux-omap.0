From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: dts: Beaglebone i2c definitions
Date: Thu, 14 May 2015 08:38:22 -0700
Message-ID: <20150514153822.GJ15563@atomide.com>
References: <1431504274-32084-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431504274-32084-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> [150513 01:05]:
> The beaglebone family of boards contain two I2C busses enabled.
> The first one with a baseboard identification EEPROM and a
> cape I2C bus.

This seems safe to apply as the i2c2 pins are listed in the cape
specification.

These pins could be used for other devices too.. But in that case
the cape would not follow the cape standard.

Regards,

Tony
 
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 66 +++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index c3255e0..236b7db 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -81,6 +81,13 @@
>  		>;
>  	};
>  
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins = <
> +			0x178 (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
> +			0x17c (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
> +		>;
> +	};
> +
>  	uart0_pins: pinmux_uart0_pins {
>  		pinctrl-single,pins = <
>  			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
> @@ -218,8 +225,67 @@
>  		reg = <0x24>;
>  	};
>  
> +	baseboard_eeprom: baseboard_eeprom@50 {
> +		compatible = "at,24c256";
> +		reg = <0x50>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		baseboard_data: baseboard_data@0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	cape_eeprom0: cape_eeprom0@54 {
> +		compatible = "at,24c256";
> +		reg = <0x54>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape0_data: cape_data@0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +
> +	cape_eeprom1: cape_eeprom1@55 {
> +		compatible = "at,24c256";
> +		reg = <0x55>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape1_data: cape_data@0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +
> +	cape_eeprom2: cape_eeprom2@56 {
> +		compatible = "at,24c256";
> +		reg = <0x56>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape2_data: cape_data@0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +
> +	cape_eeprom3: cape_eeprom3@57 {
> +		compatible = "at,24c256";
> +		reg = <0x57>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape3_data: cape_data@0 {
> +			reg = <0 0x100>;
> +		};
> +	};
>  };
>  
> +
>  /include/ "tps65217.dtsi"
>  
>  &tps {
> -- 
> 1.7.12
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
