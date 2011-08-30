From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Tue, 30 Aug 2011 22:02:35 +0800
Message-ID: <CACVXFVPDuq5tDsFVaGo5gWJVJ+g3MqK1O5+bUD7_d086_1xKZw@mail.gmail.com>
References: <CACVXFVNFXh33tsvkM=jdnc8OocVhjkzpt6LK59zKa9L2F7HxpQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1108291218040.2525-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1108291218040.2525-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Alan,

Thanks for your comment.

On Tue, Aug 30, 2011 at 12:33 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org=
> wrote:
> Nevertheless, it remains true that you want to add a memory barrier
> instruction simply in order to speed up a cache writeback, not to for=
ce
> any sort of ordering. =A0This needs to be explained carefully in the =
code
> (not just in the patch description!) and it needs to be done in a way
> that won't affect other architectures.

OK, will do it.

> Also, as you mentioned before, you may want to do the same thing in
> qh_link_async() just after the
>
> =A0 =A0 =A0 =A0head->hw->hw_next =3D dma;
>
> line. =A0Delays in flushing that write would also slow down performan=
ce.

Will do it too.


thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
