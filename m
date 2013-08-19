From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] extcon: extcon-dra7xx: Add extcon driver for USB
 ID detection
Date: Mon, 19 Aug 2013 13:31:16 -0600
Message-ID: <52127284.6030506@wwwdotorg.org>
References: <1376648029-30659-1-git-send-email-george.cherian@ti.com> <1376648029-30659-2-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1376648029-30659-2-git-send-email-george.cherian@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: balbi@ti.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 08/16/2013 04:13 AM, George Cherian wrote:
> Adding extcon driver for USB ID detection to dynamically
> configure USB Host/Peripheral mode.

> diff --git a/Documentation/devicetree/bindings/extcon/extcon-dra7xx.txt b/Documentation/devicetree/bindings/extcon/extcon-dra7xx.txt

> +EXTCON FOR DRA7xx
> +
> +Required Properties:

Please at lest explain what a DRA7xxx is, and the purpose of the HW
module this binding describes.

> + - compatible : Should be "ti,dra7xx-usb"

If this is a USB VID detector rather than a full USB host controller,
then "usb" in the binding is a bit over-reaching. Perhaps "-usb-vid" or
"-usb-vid-detector" would be more accurate.

> + - gpios : phandle to ID pin and interrupt gpio.

This isn't just a phandle; it's phandle+args, or a GPIO specifier. Some
reference should be made to ../gpio/gpio.txt for the format.

Why does the interrupt line need to be included in a list of GPIOs?

If the DRA7xxx is a VID detector, why does it even need/have any GPIOs
associated with it; surely it has a dedicated VID input pin. Can you
provide more details re: how the HW is structured.

> +Optional Properties:
> +  - interrupt-parent : interrupt controller phandle
> +  - interrupts : interrupt number
> +
> +

It's typical insert the following between those two blank lines:

Example:

... or delete one of the blank lines.

> +dra7x_extcon1 {
> +		compatible = "ti,dra7xx-usb";
> +		gpios = <&pcf_usb 1 0>,
> +			<&gpio6 11 2>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <11>;
> +	};
> +

No need for that trailing blank line.

