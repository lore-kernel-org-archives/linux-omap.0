From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 4/8] musb: Update setup_usb() call for all Davinci boards
Date: Tue, 17 Nov 2009 19:03:05 +0300
Message-ID: <4B02C939.30505@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com> <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258470596-24321-5-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ajay Kumar Gupta wrote:

> setup_usb() has been modified to pass board specific data so updating
> this function call from all Davinci based boards.

> Added "struct device;" to fix below compilation warning for Davinci boards.
> "musb.h: struct device, defined within parameter list"

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

[...]

> diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
> index 7acdfd8..e61d7d7 100644
> --- a/arch/arm/mach-davinci/board-sffsdr.c
> +++ b/arch/arm/mach-davinci/board-sffsdr.c
> @@ -38,6 +38,7 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/io.h>
> +#include <linux/usb/musb.h>
>  
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
> @@ -149,6 +150,12 @@ static struct davinci_uart_config uart_config __initdata = {
>  	.enabled_uarts = (1 << 0),
>  };
>  
> +/* musb board specific data */
> +static struct musb_hdrc_board_data musb_bdata __initdata = {
> +	.power = 0,	/* (power in mA)/2 */
> +	.potpgt = 0,	/* (potpgt in msec)/2 */

    You can leave the structure unixitialized here, it will default to all 
zeros anyway.

> +};
> +
>  static void __init davinci_sffsdr_map_io(void)
>  {
>  	dm644x_init();

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
