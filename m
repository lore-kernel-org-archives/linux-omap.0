From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host only and OTG roles.
Date: Thu, 20 May 2010 08:48:39 -0700 (PDT)
Message-ID: <602675.31449.qm@web180309.mail.gq1.yahoo.com>
References: <1274360966-9974-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274360966-9974-1-git-send-email-x0082077-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


> +#ifdef CONFIG_USB_MUSB_OTG
> +=A0=A0=A0 .mode=A0=A0=A0
> =A0=A0=A0 =A0=A0=A0 =3D MUSB_OTG,
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> +=A0=A0=A0 .mode=A0=A0=A0
> =A0=A0=A0 =A0=A0=A0 =3D MUSB_HOST,
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>  =A0=A0=A0 .mode=A0=A0=A0
> =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
> +#endif

> =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
> +#endif

By the way ... the #ifdeffery should indeed vanish from all board
configs except the Davinci DM6446 EVM.  That board is kind of quirky
in terms of USB support, and needs jumpering to get host or peripheral
mode (and can't do OTG).  I suspect some of the other boards did a bad
thing and tried emulating what that board did.

But the description for such a patch would emphasize removing bogus
ifdeffery, to match the board hardware (which is not conditional but
is instead fixed).

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
