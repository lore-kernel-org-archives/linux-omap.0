From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Mon, 06 Dec 2010 13:37:37 +0300
Message-ID: <4CFCBCF1.9010902@ru.mvista.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291623211-959-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 06-12-2010 11:13, Ajay Kumar Gupta wrote:

> As the control.h have been moved to new location and it's
> uses are not allowed to drivers directly so moving the phy
> control, interrupt clear and reset functionality to board
> files.

    I'm not fond of the whole approach. I'm not sure why accesses to the 
control registers are such a no-no, taking into account that one needs to 
access such regisyter to clear the interrupt...

> Signed-off-by: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
[...]

> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 7260558..8c1d121 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -30,9 +30,102 @@
>   #include<mach/irqs.h>
>   #include<mach/am35xx.h>
>   #include<plat/usb.h>
> +#include "control.h"
>
>   #ifdef CONFIG_USB_MUSB_SOC
>
> +static void am35x_musb_reset(void)
> +{
> +	u32	regval;
> +
> +	/* Reset the musb interface */
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
> +
> +	regval |= AM35XX_USBOTGSS_SW_RST;
> +	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
> +
> +	regval&= ~AM35XX_USBOTGSS_SW_RST;
> +	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
> +
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);

    Why read it and ignore the result?

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
