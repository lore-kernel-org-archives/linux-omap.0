From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: Re: [PATCH v9] ARM: dts: omap4-panda: Update the LED support for
 the panda DTS
Date: Fri, 31 May 2013 17:28:14 +0200
Message-ID: <51A8C18E.7020800@epfl.ch>
References: <1370013591-25957-1-git-send-email-dmurphy@ti.com>
Reply-To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370013591-25957-1-git-send-email-dmurphy-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello Dan,

On 05/31/2013 05:19 PM, Dan Murphy wrote:
> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
> are different.
>
> A1-A3 = gpio_wk7
> ES = gpio_110
>
> There is no change to LED D2
>
> Abstract away the pinmux and the LED definitions for the two boards into
> the respective DTS files.
>
> Signed-off-by: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
> ---
> v9 - Removed comments for mux config - https://patchwork.kernel.org/patch/2644391/
> v8 - Rebase to latest and use pinctrl macros - https://patchwork.kernel.org/patch/2629351/
> v7 - Update headline to add spaces - https://patchwork.kernel.org/patch/2583661/
> v6 - Review comments updated - https://patchwork.kernel.org/patch/2582771/
> v5 - Provide pincrtl phandle to the gpio-led driver - https://patchwork.kernel.org/patch/2573981/
>   arch/arm/boot/dts/omap4-panda-common.dtsi |   16 +++++++++++++++-
>   arch/arm/boot/dts/omap4-panda-es.dts      |   28 ++++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index d5d144a..800fa4e 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -16,8 +16,13 @@
>   		reg = <0x80000000 0x40000000>; /* 1 GB */
>   	};
>
> -	leds {
> +	leds: leds {
>   		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <
> +			&led_wkgpio_pins
> +		>;
> +
>   		heartbeat {
>   			label = "pandaboard::status1";
>   			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> @@ -157,6 +162,15 @@
>   	};
>   };
>
> +&omap4_pmx_wkup {
> +	led_wkgpio_pins: pinmux_leds_wkpins {
> +		pinctrl-single,pins = <
> +			0x1a (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk7 */
> +			0x1c (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
> +		>;
> +	};
> +};
> +
>   &i2c1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c1_pins>;
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
> index 5cfdf19..0a7812f 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -34,3 +34,31 @@
>   		0x5e (PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
>   		>;
>   };
> +
> +&omap4_pmx_core {
> +	led_gpio_pins: gpio_led_pmx {
> +		pinctrl-single,pins = <
> +			0xb6 (PIN_OUTPUT | MUX_MODE3)	/* gpio_110 */
> +		>;
> +	};
> +};
> +
> +&led_wkgpio_pins {
> +	pinctrl-single,pins = <
> +		0x1c (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
> +	>;
> +};
> +
> +&leds {
> +	pinctrl-0 = <
> +		&led_gpio_pins
> +		&led_wkgpio_pins
> +	>;
> +
> +	heartbeat {
> +		gpios = <&gpio4 14 0>;

And here you could use the GPIO defines:

		gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;

> +	};
> +	mmc {
> +		gpios = <&gpio1 8 0>;

Same here.

> +	};
> +};
>

Regards,

Florian
