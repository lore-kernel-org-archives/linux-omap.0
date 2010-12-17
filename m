From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Patch v4] AM35xx: Craneboard: Add USB EHCI support
Date: Fri, 17 Dec 2010 15:45:28 +0300
Message-ID: <4D0B5B68.5040706@ru.mvista.com>
References: <[PATCH] AM35xx-Craneboard-Add-USB-EHCI-support> <1292513112-12471-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:40368 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0LQMqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 07:46:33 -0500
In-Reply-To: <1292513112-12471-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: srinath@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, jdk@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, nm@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com, sshtylyov@mvista.com, manjugk@ti.com

Hello.

On 16-12-2010 18:25, srinath@mistralsolutions.com wrote:

> From: Srinath <srinath@mistralsolutions.com>

> AM3517/05 Craneboard has one EHCI interface on board using port1.

> GPIO35 is used as power enable.
> GPIO38 is used as port1 PHY reset.

> History:
> http://marc.info/?l=linux-omap&w=2&r=1&s=Craneboard%3A+Add+USB+EHCI+support&q=t

> Signed-off-by: Srinath <srinath@mistralsolutions.com>
> ---
>   arch/arm/mach-omap2/board-am3517crane.c |   53 +++++++++++++++++++++++++++++++
>   1 files changed, 53 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
> index 8ba4047..1a80175 100644
> --- a/arch/arm/mach-omap2/board-am3517crane.c
> +++ b/arch/arm/mach-omap2/board-am3517crane.c
[...]
> @@ -51,10 +58,56 @@ static void __init am3517_crane_init_irq(void)
[...]
>   static void __init am3517_crane_init(void)
>   {
> +	int ret;
> +
>   	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>   	omap_serial_init();
> +
> +	/* Configure GPIO for EHCI port */
> +	if (omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT)) {
> +		pr_err("Can not cofigure mux for GPIO_USB_NRESET %d\n",
> +			GPIO_USB_NRESET);
> +		return;
> +	}
> +
> +	if (omap_mux_init_gpio(GPIO_USB_POWER, OMAP_PIN_OUTPUT)) {
> +		pr_err("Can not cofigure mux for GPIO_USB_POWER %d\n",
> +

    Empty line not needed here...

> +			GPIO_USB_POWER);
> +		return;
> +	}
> +
> +	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
> +	if (ret < 0) {
> +		pr_err("Cannot request GPIO %d\n", GPIO_USB_POWER);
> +		return;
> +	}
> +
> +	ret = gpio_direction_output(GPIO_USB_POWER, 1);
> +	if (ret < 0)
> +		goto err;
> +
> +

    Too  many empty lines here...

> +	usb_ehci_init(&ehci_pdata);
> +	return;
> +
> +err:

    There's no need for *goto* and label.

> +	gpio_free(GPIO_USB_POWER);
> +	pr_err("Unable to initialize EHCI power\n");
> +	return;
>   }

WBR, Sergei
