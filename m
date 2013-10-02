From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 04/10] ARM: OMAP2+: usb-host: Adapt to USB phy-nop
 RESET line changes
Date: Wed, 2 Oct 2013 13:20:04 +0300
Message-ID: <524BF354.3000502@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com> <1380012836-29900-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380012836-29900-5-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, bcousson@baylibre.com, p.zabel@pengutronix.de, broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 09/24/2013 11:53 AM, Roger Quadros wrote:
> The USB phy-nop nop driver expects the RESET line information
> to be sent as a GPIO number via platform data. Adapt to that.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Need your Ack on this one as well.

cheers,
-roger

> ---
>  arch/arm/mach-omap2/usb-host.c |   11 +----------
>  1 files changed, 1 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index 78ac1c2..10855eb 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -460,8 +460,7 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
>  		memset(&nop_pdata, 0, sizeof(nop_pdata));
>  		if (gpio_is_valid(phy->vcc_gpio))
>  			nop_pdata.needs_vcc = true;
> -		if (gpio_is_valid(phy->reset_gpio))
> -			nop_pdata.needs_reset = true;
> +		nop_pdata.gpio_reset = phy->reset_gpio;
>  		nop_pdata.type = USB_PHY_TYPE_USB2;
>  
>  		/* create a NOP PHY device */
> @@ -483,14 +482,6 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
>  
>  		usb_bind_phy("ehci-omap.0", phy->port - 1, phy_id);
>  
> -		/* Do we need RESET regulator ? */
> -		if (gpio_is_valid(phy->reset_gpio)) {
> -			scnprintf(rail_name, MAX_STR,
> -					"hsusb%d_reset", phy->port);
> -			usbhs_add_regulator(rail_name, phy_id, "reset",
> -						phy->reset_gpio, 1);
> -		}
> -
>  		/* Do we need VCC regulator ? */
>  		if (gpio_is_valid(phy->vcc_gpio)) {
>  			scnprintf(rail_name, MAX_STR, "hsusb%d_vcc", phy->port);
> 
