From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: dra72-evm: Enable I2C1 node
Date: Mon, 28 Jul 2014 14:54:06 +0530
Message-ID: <53D616B6.3030806@ti.com>
References: <1406528334-4415-1-git-send-email-j-keerthy@ti.com> <1406528334-4415-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406528334-4415-2-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 28 July 2014 11:48 AM, Keerthy wrote:
> From: Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>
>
> I2C1 bus is used for the following peripherals
> 	P8 connector (MLB)
> 	TLV320AIC3106 Audio codec
> 	J15 LCD header
> 	24WC256 eeprom
> 	TMP102AIDRLT temperature sensor
> 	PCF8575 GPIO expander
> 	PCA9306 i2c voltage translator -> Goes to P9 for comm interface
> 	P2 expansion connector
> 	TPS65917 PMIC
>
> The slowest speed of all the peripherals seems to be 400KHz.

Correcting the 'to' list.

>
> Tested-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/dra72-evm.dts |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
> index 5147023..1e12862 100644
> --- a/arch/arm/boot/dts/dra72-evm.dts
> +++ b/arch/arm/boot/dts/dra72-evm.dts
> @@ -19,6 +19,22 @@
>   	};
>   };
>   
> +&dra7_pmx_core {
> +	i2c1_pins: pinmux_i2c1_pins {
> +		pinctrl-single,pins = <
> +			0x400 (PIN_INPUT | MUX_MODE0) /* i2c1_sda.i2c1_sda */
> +			0x404 (PIN_INPUT | MUX_MODE0) /* i2c1_scl.i2c1_scl */
> +		>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	clock-frequency = <400000>;
> +};
> +
>   &uart1 {
>   	status = "okay";
>   };

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
