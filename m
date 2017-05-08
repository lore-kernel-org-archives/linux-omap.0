From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv3 1/2] Input: pwm-vibra: new driver
Date: Mon, 8 May 2017 12:31:21 -0500
Message-ID: <20170508173121.v45f76tyihk2x5xq@rob-hp-laptop>
References: <20170505092823.26009-1-sebastian.reichel@collabora.co.uk>
 <20170505092823.26009-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170505092823.26009-2-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 05, 2017 at 11:28:22AM +0200, Sebastian Reichel wrote:
> Provide a simple driver for PWM controllable vibrators. It
> will be used by Motorola Droid 4.
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> Changes since PATCHv1:
>  - move driver removal code to input->close function
>  - mark PM functions __maybe_unused and drop #ifdef CONFIG_PM_SLEEP
>  - remove duplicate NULL check for vibrator in probe function
>  - cancel work in suspend function
> Changes since PATCHv2:
>  - Add Kconfig dependency on INPUT_FF_MEMLESS
>  - Add Tested-by from Tiny Lindgren
> ---
>  .../devicetree/bindings/input/pwm-vibrator.txt     |  60 ++++
>  drivers/input/misc/Kconfig                         |  12 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/pwm-vibra.c                     | 343 +++++++++++++++++++++
>  4 files changed, 416 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
>  create mode 100644 drivers/input/misc/pwm-vibra.c
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> new file mode 100644
> index 000000000000..c35be4691366
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> @@ -0,0 +1,60 @@
> +* PWM vibrator device tree bindings
> +
> +Registers a PWM device as vibrator.
> +
> +Required properties:
> +- compatible: should be
> +  * "pwm-vibrator"
> +    For vibrators controlled using the PWM channel's duty cycle (higher duty means
> +    the vibrator becomes stronger).
> +  * "motorola,mapphone-pwm-vibrator"
> +     For vibrator found in Motorola Droid 4. This vibrator generates a pulse for
> +     every rising edge, so its controlled using a duty cycle of 50% and changing

s/its/it's/

> +     the period time.

What does "controlled" mean? strength? Shorter period is stronger?

> +- pwm-names: Should contain "enable" and optionally "direction"

What does direction mean? Does that apply to both compatibles.

> +- pwms: Should contain a PWM handle for each entry in pwm-names
> +
> +Example from Motorola Droid 4:
> +
> +&omap4_pmx_core {
> +	vibrator_direction_pin: pinmux_vibrator_direction_pin {
> +		pinctrl-single,pins = <
> +		OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE1) /* dmtimer8_pwm_evt (gpio_27) */
> +		>;
> +	};
> +
> +	vibrator_enable_pin: pinmux_vibrator_enable_pin {
> +		pinctrl-single,pins = <
> +		OMAP4_IOPAD(0X1d0, PIN_OUTPUT | MUX_MODE1) /* dmtimer9_pwm_evt (gpio_28) */
> +		>;
> +	};
> +};
> +
> +/ {
> +	pwm8: dmtimer-pwm {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vibrator_direction_pin>;
> +
> +		compatible = "ti,omap-dmtimer-pwm";
> +		#pwm-cells = <3>;
> +		ti,timers = <&timer8>;
> +		ti,clock-source = <0x01>;
> +	};
> +
> +	pwm9: dmtimer-pwm {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vibrator_enable_pin>;
> +
> +		compatible = "ti,omap-dmtimer-pwm";
> +		#pwm-cells = <3>;
> +		ti,timers = <&timer9>;
> +		ti,clock-source = <0x01>;
> +	};
> +
> +	vibrator {
> +		compatible = "pwm-vibrator";
> +		pwms = <&pwm8 0 1000000000 0>,
> +		       <&pwm9 0 1000000000 0>;
> +		pwm-names = "enable", "direction";
> +	};
> +};
