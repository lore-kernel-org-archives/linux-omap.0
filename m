From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP3: RX51: Define TWL4030 USB transceiver in board
 file
Date: Mon, 6 Jul 2009 12:51:40 +0300
Message-ID: <20090706095140.GR8461@nokia.com>
References: <1246868531-5023-1-git-send-email-ext-roger.quadros@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65373 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbZGFJwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 05:52:30 -0400
Content-Disposition: inline
In-Reply-To: <1246868531-5023-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (EXT-Teleca/Helsinki)" <ext-roger.quadros@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jul 06, 2009 at 10:22:11AM +0200, Quadros Roger (EXT-Teleca/Helsinki) wrote:

please put some description here. Other than that:

> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 9a0bf67..56d931a 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -278,6 +278,10 @@ static struct twl4030_gpio_platform_data rx51_gpio_data = {
>  	.setup			= rx51_twlgpio_setup,
>  };
>  
> +static struct twl4030_usb_data rx51_usb_data = {
> +	.usb_mode		= T2_USB_MODE_ULPI,
> +};
> +
>  static struct twl4030_platform_data rx51_twldata = {
>  	.irq_base		= TWL4030_IRQ_BASE,
>  	.irq_end		= TWL4030_IRQ_END,
> @@ -286,6 +290,7 @@ static struct twl4030_platform_data rx51_twldata = {
>  	.gpio			= &rx51_gpio_data,
>  	.keypad			= &rx51_kp_data,
>  	.madc			= &rx51_madc_data,
> +	.usb			= &rx51_usb_data,
>  
>  	.vaux1			= &rx51_vaux1,
>  	.vaux2			= &rx51_vaux2,
> -- 
> 1.6.0.4

-- 
balbi
