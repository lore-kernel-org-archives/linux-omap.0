From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] doc: dt/bindings: input: introduce palmas power
 button description
Date: Mon, 18 Aug 2014 22:28:42 -0700
Message-ID: <20140819052842.GB21199@core.coreip.homeip.net>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
 <1408392810-16011-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408392810-16011-2-git-send-email-nm@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 18, 2014 at 03:13:29PM -0500, Nishanth Menon wrote:
> Many palmas family of PMICs have support for interrupt based power
> button. This allows the device to notify the processor of external
> push button events over the shared palmas interrupt.
> 
> Document the hardware support for the same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/input/ti,palmas-pwrbutton.txt         |   32 ++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
> new file mode 100644
> index 0000000..6a89bcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
> @@ -0,0 +1,32 @@
> +Texas Instruments Palmas family power button module
> +
> +This module is part of the Palmas family of PMICs. For more details
> +about the whole chip see:
> +Documentation/devicetree/bindings/mfd/palmas.txt.
> +
> +This module provides a simple power button event via an Interrupt.
> +
> +Required properties:
> +- compatible: should be one of the following
> +   - "ti,palmas-pwrbutton": For Palmas compatible power on button
> +- interrupt-parent: Parent interrupt device, must be handle of palmas node.
> +- interrupts: Interrupt number of power button submodule on device.
> +
> +Optional Properties:
> +
> +- ti,palmas-long-press-seconds: Duration in seconds which the power
> +  button should be kept pressed for Palmas to power off automatically.
> +  NOTE: This depends on OTP support and POWERHOLD signal configuration
> +  on platform.

Only a few values are valid for this property, I think you should mention that.

> +
> +Example:
> +
> +&palmas {
> +	palmas_pwr_button: pwrbutton {
> +		compatible = "ti,palmas-pwrbutton";
> +		interrupt-parent = <&tps659038>;
> +		interrupts = <1 IRQ_TYPE_NONE>;

Why none? Can we specify appropriate trigger here instead of hard-coding in the
driver?

> +		wakeup-source;

What handles this attribute? I do not see it handled in the driver.

> +		ti,palmas-long-press-seconds = <12>;
> +	};
> +};
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
