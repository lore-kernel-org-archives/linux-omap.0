From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 2/9 v3] usb: musb: Remove board_data parameter from musb_platform_init()
Date: Wed, 29 Sep 2010 07:41:01 -0700
Message-ID: <871v8c629u.fsf@deeprootsystems.com>
References: <1285201660-26309-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285201660-26309-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org> (Hema HK's
	message of "Wed, 22 Sep 2010 20:27:40 -0400")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hema HK <hemahk-l0cyMroinI0@public.gmane.org> writes:

> Removed the board_data parameter being passed to musb_platform_init function
> as board data can be extracted from device structure which is already member of
> musb structure.
>
> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

For the davinci changes:

Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

Kevin

> ---
>  drivers/usb/musb/blackfin.c  |    2 +-
>  drivers/usb/musb/davinci.c   |    2 +-
>  drivers/usb/musb/musb_core.c |    2 +-
>  drivers/usb/musb/musb_core.h |    2 +-
>  drivers/usb/musb/omap2430.c  |    6 ++++--
>  drivers/usb/musb/tusb6010.c  |    2 +-
>  6 files changed, 9 insertions(+), 7 deletions(-)
>
> Index: linux-omap-pm/drivers/usb/musb/blackfin.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/blackfin.c
> +++ linux-omap-pm/drivers/usb/musb/blackfin.c
> @@ -323,7 +323,7 @@ int musb_platform_set_mode(struct musb *
>  	return -EIO;
>  }
>  
> -int __init musb_platform_init(struct musb *musb, void *board_data)
> +int __init musb_platform_init(struct musb *musb)
>  {
>  
>  	/*
> Index: linux-omap-pm/drivers/usb/musb/davinci.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/davinci.c
> +++ linux-omap-pm/drivers/usb/musb/davinci.c
> @@ -376,7 +376,7 @@ int musb_platform_set_mode(struct musb *
>  	return -EIO;
>  }
>  
> -int __init musb_platform_init(struct musb *musb, void *board_data)
> +int __init musb_platform_init(struct musb *musb)
>  {
>  	void __iomem	*tibase = musb->ctrl_base;
>  	u32		revision;
> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
> +++ linux-omap-pm/drivers/usb/musb/musb_core.c
> @@ -2022,7 +2022,7 @@ bad_config:
>  	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
>  	 */
>  	musb->isr = generic_interrupt;
> -	status = musb_platform_init(musb, plat->board_data);
> +	status = musb_platform_init(musb);
>  	if (status < 0)
>  		goto fail2;
>  
> Index: linux-omap-pm/drivers/usb/musb/musb_core.h
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.h
> +++ linux-omap-pm/drivers/usb/musb/musb_core.h
> @@ -612,7 +612,7 @@ extern int musb_platform_get_vbus_status
>  #define musb_platform_get_vbus_status(x)	0
>  #endif
>  
> -extern int __init musb_platform_init(struct musb *musb, void *board_data);
> +extern int __init musb_platform_init(struct musb *musb);
>  extern int musb_platform_exit(struct musb *musb);
>  
>  #endif	/* __MUSB_CORE_H__ */
> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
> +++ linux-omap-pm/drivers/usb/musb/omap2430.c
> @@ -187,10 +187,12 @@ int musb_platform_set_mode(struct musb *
>  	return 0;
>  }
>  
> -int __init musb_platform_init(struct musb *musb, void *board_data)
> +int __init musb_platform_init(struct musb *musb)
>  {
>  	u32 l;
> -	struct omap_musb_board_data *data = board_data;
> +	struct device *dev = musb->controller;
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
> +	struct omap_musb_board_data *data = plat->board_data;
>  
>  	/* We require some kind of external transceiver, hooked
>  	 * up through ULPI.  TWL4030-family PMICs include one,
> Index: linux-omap-pm/drivers/usb/musb/tusb6010.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/tusb6010.c
> +++ linux-omap-pm/drivers/usb/musb/tusb6010.c
> @@ -1091,7 +1091,7 @@ err:
>  	return -ENODEV;
>  }
>  
> -int __init musb_platform_init(struct musb *musb, void *board_data)
> +int __init musb_platform_init(struct musb *musb)
>  {
>  	struct platform_device	*pdev;
>  	struct resource		*mem;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
