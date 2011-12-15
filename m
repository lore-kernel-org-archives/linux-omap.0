From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: musb: fix pm_runtime mismatches
Date: Thu, 15 Dec 2011 18:22:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1112151821360.1644-100000@iolanthe.rowland.org>
References: <1323990310-11905-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1323990310-11905-2-git-send-email-felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 16 Dec 2011, Felipe Contreras wrote:

> Properly call pm_runtime_put() afer pm_runttime_get() on errors.
> 
> Untested.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_gadget.c |    1 +
>  drivers/usb/musb/omap2430.c    |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 922148f..95bfd2d 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1960,6 +1960,7 @@ static int musb_gadget_start(struct usb_gadget *g,
>  err2:
>  	if (!is_otg_enabled(musb))
>  		musb_stop(musb);
> +	pm_runtime_put(musb->controller);
>  err0:
>  	return retval;
>  }
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index ba85f27..4edfb91 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -385,6 +385,7 @@ static void omap2430_musb_disable(struct musb *musb)
>  
>  static int omap2430_musb_exit(struct musb *musb)
>  {
> +	pm_runtime_put(musb->controller);
>  	del_timer_sync(&musb_idle_timer);
>  
>  	omap2430_low_level_exit(musb);

Should these calls be pm_runtime_put_sync() instead of 
pm_runtime_put()?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
