From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/6] ti814evm: Add support for musb interface
Date: Fri, 26 Aug 2011 15:34:04 +0400
Message-ID: <4E5784AC.5080509@ru.mvista.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com> <1314357108-2279-6-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314357108-2279-6-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 26-08-2011 15:11, Ajay Kumar Gupta wrote:

> From: Ravi B<ravibabu-l0cyMroinI0@public.gmane.org>

> Adding musb support in ti814 EVM board file.

> Signed-off-by: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ravi B<ravibabu-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/mach-omap2/board-ti8148evm.c |   15 +++++++++++++++
>   1 files changed, 15 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-ti8148evm.c b/arch/arm/mach-omap2/board-ti8148evm.c
> index 588d6b7..d9c8505 100644
> --- a/arch/arm/mach-omap2/board-ti8148evm.c
> +++ b/arch/arm/mach-omap2/board-ti8148evm.c
> @@ -23,6 +23,20 @@
>   #include<plat/irqs.h>
>   #include<plat/board.h>
>   #include<plat/common.h>
> +#include<plat/usb.h>
> +
> +static struct omap_musb_board_data musb_board_data = {
> +	.set_phy_power	= ti81xx_musb_phy_power,
> +	.interface_type	= MUSB_INTERFACE_ULPI,
> +#ifdef CONFIG_USB_MUSB_OTG
> +	.mode           = MUSB_OTG,
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> +	.mode           = MUSB_HOST,
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> +	.mode           = MUSB_PERIPHERAL,
> +#endif

    Same comments as in the previous patch.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
