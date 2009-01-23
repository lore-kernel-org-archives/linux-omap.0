From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] usb: musb: fix compilation error in
	musb_platform_init
Date: Fri, 23 Jan 2009 12:16:30 +0200
Message-ID: <20090123101630.GN9233@scadufax.research.nokia.com>
References: <1231326846-22691-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1231326846-22691-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 07, 2009 at 04:44:06PM +0530, Ajay Kumar Gupta wrote:
> Fixes the compilation error while musb is selected for OMAP35x EVM and
> twl4030 phy is not selected and thus USB_OTG_UTILS is also not defined.
> This causes below compilation error,
> 
> drivers/built-in.o: In function `musb_platform_init':
> hid-quirks.c:(.init.text+0x4244): undefined reference to `otg_get_transceiver'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/usb/musb/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 669acbe..764e362 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
>  	depends on (USB || USB_GADGET) && HAVE_CLK
>  	depends on !SUPERH
>  	select TWL4030_USB if MACH_OMAP_3430SDP
> +	select USB_OTG_UTILS if ARCH_OMAP34XX
>  	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
>  	help
>  	  Say Y here if your system has a dual role high speed USB
> -- 
> 1.5.6

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
