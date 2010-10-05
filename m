From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: omap: fix the warning return type defaults to 'int'
Date: Tue, 5 Oct 2010 14:52:19 +0530
Message-ID: <a2b7b7dd7fd68202414410aa835e982f@mail.gmail.com>
References: <1286225393-22472-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286225393-22472-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nishant Kamat <nskamat-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Keshava Munegowda wrote:
>
> This patch fix the follwing warning when compiling usb code
> for OMAP defconfigs.
> arch/arm/plat-omap/include/plat/usb.h:109: warning: return type defaults
> to 'int'
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Already posted by me:

http://marc.info/?l=linux-omap&m=128212353619711&w=2

> ---
>  arch/arm/plat-omap/include/plat/usb.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
> +++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> @@ -105,7 +105,7 @@ static inline void omap1_usb_init(struct
>  #if defined(CONFIG_ARCH_OMAP_OTG) ||
defined(CONFIG_ARCH_OMAP_OTG_MODULE)
>  void omap2_usbfs_init(struct omap_usb_config *pdata);
>  #else
> -static inline omap2_usbfs_init(struct omap_usb_config *pdata)
> +static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
>  {
>  }
>  #endif
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
