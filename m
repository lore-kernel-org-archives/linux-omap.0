From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH v4 1/1] extcon: usb-gpio: Introduce gpio usb extcon
 driver
Date: Mon, 16 Mar 2015 14:32:29 +0200
Message-ID: <1426509149.2330.5.camel@linaro.org>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
	 <1422274532-9488-2-git-send-email-rogerq@ti.com> <54C8D2F4.9050404@ti.com>
	 <54CF4FC7.2050309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CF4FC7.2050309@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, balbi@ti.com, tony@atomide.com, george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi, 

On Mon, 2015-02-02 at 12:21 +0200, Roger Quadros wrote:
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

I am sorry that I am getting a bit little late into this.

Isn't supposed that we have to use strings defined in 
const char extcon_cable_name[][]?


> +
> +/* List of detectable cables */
> +enum {
> +       EXTCON_CABLE_USB = 0,
> +       EXTCON_CABLE_USB_HOST,
> +

Same here: duplicated with enum extcon_cable_name

> +       EXTCON_CABLE_END,
> +};
> +
> +static const char *usb_extcon_cable[] = {
> +       [EXTCON_CABLE_USB] = "USB",
> +       [EXTCON_CABLE_USB_HOST] = "USB-HOST",
> +       NULL,
> +};
> 

<snip>

> +
> +static int usb_extcon_probe(struct platform_device *pdev)
> +{
> 

<snip>

> +
> +       ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
> +                                       usb_irq_handler,
> +                                       IRQF_TRIGGER_RISING |
> +                                       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

Shouldn't triggers be defined in DTS files?


Regards,
Ivan

> 
