From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: USB: fix the pointer type mismatch compilation
 warning
Date: Mon, 05 Mar 2012 15:43:34 +0400
Message-ID: <4F54A6E6.6070409@mvista.com>
References: <1330946376-17672-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1330946376-17672-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 05-03-2012 15:19, Keshava Munegowda wrote:

> From: Keshava Munegowda<Keshava_mgowda-l0cyMroinI0@public.gmane.org>

> The compilation of usb-host.c file was resulting compilation warning
> due to pointer type mismatch in assignment of return pointer type
> of the function omap_device_build_ss to local pointer type.
> This warning is fixed.

> Signed-off-by: Keshava Munegowda<keshava_mgowda-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/mach-omap2/usb-host.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index 771dc78..88d4a19 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -486,7 +486,7 @@ static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>   void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
>   {
>   	struct omap_hwmod	*oh[2];
> -	struct omap_device	*od;
> +	struct platform_device	*od;

    Makes sense to rename variable to 'pd' then.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
