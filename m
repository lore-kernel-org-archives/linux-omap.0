From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] OMAP:MUSB: Corrects urb unlink function path
Date: Fri, 22 Aug 2008 21:03:08 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD5D4D70@dbde02.ent.ti.com>
References: <1219386656-31072-1-git-send-email-ajay.gupta@ti.com>,<Pine.LNX.4.44L0.0808221038330.30309-100000@netrider.rowland.org>,<19F8576C6E063C45BE387C64729E739403CD5D4D6F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD5D4D6F-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



________________________________________
From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Gupta, Ajay Kumar [ajay.gupta-l0cyMroinI0@public.gmane.org]
Sent: Friday, August 22, 2008 8:44 PM
To: Alan Stern
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; ajaykuee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: RE: [PATCH] OMAP:MUSB: Corrects urb unlink function path

On Fri, 22 Aug 2008 ajay.gupta-l0cyMroinI0@public.gmane.org wrote:

> From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>
> Fixes kernel panic while ISO IN transfer is aborted.Replaced usb_hcd_unlink_urb_from_ep() from musb_giveback() to __musb_giveback() to make sure urb is unlinked before giveback when __musb_giveback() is called from musb_urb_dequeue().
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/musb_host.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 93b0678..a889ac4 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -292,6 +292,7 @@ __acquires(musb->lock)
>                       );
>
>       spin_unlock(&musb->lock);
> +     usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
>       usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
>       spin_lock(&musb->lock);

>This is wrong.  You must call usb_hcd_unlink_urb_from_ep() while
>holding musb->lock.
>
>You are correct. the unlink function should be moved above spin_unlock().  as,
>
>+       usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
>         spin_unlock(&musb->lock);
>         usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
>         spin_lock(&musb->lock);

>Simiar locking issue is also in enqueue path where unlink is being done
>without holding musb->lock.
I will resend the patch with other lock fixes.

Ajay

>Alan Stern--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
