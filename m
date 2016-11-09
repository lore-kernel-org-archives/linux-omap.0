From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 5/8] DT:omap3+tsc2007: use new common touchscreen
 bindings
Date: Wed, 9 Nov 2016 15:27:23 -0700
Message-ID: <20161109222723.GI2428@atomide.com>
References: <cover.1477557860.git.hns@goldelico.com>
 <72927a5b3d5b9f33dfd57a68ef1de9cb0a536407.1477557860.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72927a5b3d5b9f33dfd57a68ef1de9cb0a536407.1477557860.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@op
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [161027 01:47]:
> While we fix the GTA04 we add proper pinmux for the
> penirq gpio.
> 
> Tested on: GTA04A4 and Pyra-Handheld
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

This should be safe to merge along with the driver changes:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index b3a8b1f..64d6ee3 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -273,6 +273,13 @@
>  			OMAP3_CORE1_IOPAD(0x2134, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio112 */
>  		>;
>  	};
> +
> +	penirq_pins: pinmux_penirq_pins {
> +		pinctrl-single,pins = <
> +			/* here we could enable to wakeup the cpu from suspend by a pen touch */
> +			OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio160 */
> +		>;
> +	};
>  };
>  
>  &omap3_pmx_core2 {
> @@ -410,10 +417,24 @@
>  	tsc2007@48 {
>  		compatible = "ti,tsc2007";
>  		reg = <0x48>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&penirq_pins>;
>  		interrupt-parent = <&gpio6>;
>  		interrupts = <0 IRQ_TYPE_EDGE_FALLING>; /* GPIO_160 */
> -		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
> -		ti,x-plate-ohms = <600>;
> +		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;	/* GPIO_160 */
> +		touchscreen-size-x = <480>;
> +		touchscreen-size-y = <640>;
> +		touchscreen-max-pressure = <1000>;
> +		touchscreen-fuzz-x = <3>;
> +		touchscreen-fuzz-y = <8>;
> +		touchscreen-fuzz-pressure = <10>;
> +		touchscreen-inverted-y;
> +		ti,min-x = <0x100>;
> +		ti,max-x = <0xf00>;
> +		ti,min-y = <0x100>;
> +		ti,max-y = <0xf00>;
> +		ti,max-rt = <4096>;
> +		ti,x-plate-ohms = <550>;
>  	};
>  
>  	/* RFID EEPROM */
> -- 
> 2.7.3
> 
