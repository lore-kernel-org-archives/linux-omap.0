From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv4 09/10] dt-bindings: mfd: ti-lmu: update for backlight
Date: Mon, 9 Apr 2018 16:06:38 -0500
Message-ID: <20180409210638.hugfap4ega3bwgou@rob-hp-laptop>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-10-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330172414.26575-10-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 30, 2018 at 07:24:13PM +0200, Sebastian Reichel wrote:
> Update binding to integrate the backlight feature directly into
> the main node, as suggested by Rob Herring.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/mfd/ti-lmu.txt | 119 ++++++++++++-----------
>  1 file changed, 60 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> index c885cf89b8ce..b3433e95dfa5 100644
> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -28,10 +28,9 @@ Required properties:
>  
>  Optional property:
>    - enable-gpios: A GPIO specifier for hardware enable pin.
> -
> -Required node:
> -  - backlight: All LMU devices have backlight child nodes.
> -               For the properties, please refer to [1].
> +  - pwm-names: Should be either "lmu-backlight" or unset
> +  - pwm: This should be a PWM specifier following ../pwm/pwm.txt and must
> +         only be specified, if the backlight should be used in PWM mode.
>  
>  Optional nodes:
>    - fault-monitor: Hardware fault monitoring driver for LM3633 and LM3697.
> @@ -42,8 +41,31 @@ Optional nodes:
>    - leds: LED properties for LM3633. Please refer to [2].
>    - regulators: Regulator properties for LM3631 and LM3632.
>                  Please refer to [3].
> +  - bank0, bank1, bank2: This contains the backlight configuration
> +                         for each backlight control bank.
> +
> +Required properties in the bank subnodes:
> +  - label: A string describing the backlight. Should contain "keyboard"
> +           for a keyboard backlight and "lcd" for LCD panel backlights.
> +  - ti,led-sources: A list of channels, that should be driven. Each channel
> +                    should only be driven by one bank.
> +
> +Optional properties in the bank subnodes:
> +  - default-brightness-level: Backlight initial brightness value.
> +                              Type is <u32>. It is set as soon as backlight
> +			      device is created.
> +			      0 ~ 2047 = LM3631, LM3632, LM3633, LM3695 and
> +					 LM3697
> +			      0 ~ 255  = LM3532
> +  - ti,ramp-up-ms, ti,ramp-down-ms: Light dimming effect properties.
> +				    Type is <u32>. Unit is millisecond.
> +					0 ~ 65 ms    = LM3532
> +					0 ~ 4000 ms  = LM3631
> +					0 ~ 16000 ms = LM3633 and LM3697
> +  - pwm-period: PWM period. Only valid in PWM brightness mode.
> +                Type is <u32>. If this property is missing, then control
> +		mode is set to I2C by default.
>  
> -[1] ../leds/backlight/ti-lmu-backlight.txt
>  [2] ../leds/leds-lm3633.txt
>  [3] ../regulator/lm363x-regulator.txt
>  
> @@ -53,14 +75,11 @@ lm3532@38 {
>  
>  	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>  
> -	backlight {
> -		compatible = "ti,lm3532-backlight";
> -
> -		lcd {
> -			led-sources = <0 1 2>;
> -			ramp-up-msec = <30>;
> -			ramp-down-msec = <0>;
> -		};
> +	bank0 {
> +		label = "lcd";
> +		led-sources = <0 1 2>;
> +		ramp-up-msec = <30>;
> +		ramp-down-msec = <0>;

Looks like it was already wrong, but these are missing the vendor 
prefixes.

>  	};
>  };
>  
> @@ -105,13 +124,10 @@ lm3631@29 {

Are so many examples really needed? Examples aren't supposed to 
enumerate all possible options...

Rob
