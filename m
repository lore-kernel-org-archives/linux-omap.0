From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 1/1] extcon: usb-gpio: Introduce gpio usb extcon driver
Date: Tue, 03 Feb 2015 10:13:55 +0900
Message-ID: <54D020D3.2030403@samsung.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
 <1422274532-9488-2-git-send-email-rogerq@ti.com> <54C8D2F4.9050404@ti.com>
 <54CF4FC7.2050309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <54CF4FC7.2050309@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: myungjoo.ham@samsung.com, balbi@ti.com, tony@atomide.com, george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

Looks good to me. Applied it on v3.21 queue.

Thanks,
Chanwoo Choi

On 02/02/2015 07:21 PM, Roger Quadros wrote:
> This driver observes the USB ID pin connected over a GPIO and
> updates the USB cable extcon states accordingly.
> 
> The existing GPIO extcon driver is not suitable for this purpose
> as it needs to be taught to understand USB cable states and it
> can't handle more than one cable per instance.
> 
> For the USB case we need to handle 2 cable states.
> 1) USB (attach/detach)
> 2) USB-HOST (attach/detach)
> 
> This driver can be easily updated in the future to handle VBUS
> events in case it happens to be available on GPIO for any platform.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> v4:
> - got rid of id_irqwake flag. Fail if enable/disable_irq_wake() fails
> - changed host cable name to "USB-HOST"
> - use 'depends on' instead of 'select' GPIOLIB
> 
>  .../devicetree/bindings/extcon/extcon-usb-gpio.txt |  18 ++
>  drivers/extcon/Kconfig                             |   7 +
>  drivers/extcon/Makefile                            |   1 +
>  drivers/extcon/extcon-usb-gpio.c                   | 237 +++++++++++++++++++++
>  4 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>  create mode 100644 drivers/extcon/extcon-usb-gpio.c
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> new file mode 100644
> index 0000000..85fe6b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> @@ -0,0 +1,18 @@
> +USB GPIO Extcon device
> +
> +This is a virtual device used to generate USB cable states from the USB ID pin
> +connected to a GPIO pin.
> +
> +Required properties:
> +- compatible: Should be "linux,extcon-usb-gpio"
> +- id-gpio: gpio for USB ID pin. See gpio binding.
> +
> +Example:

I add some description for example as following:

+Example: Examples of extcon-usb-gpio node in dra7-evm.dts as listed below:

> +	extcon_usb1 {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
> +	}
> +
> +	&omap_dwc3_1 {
> +		extcon = <&extcon_usb1>;
> +	};

[snip]

Thanks,
Chanwoo Choi
