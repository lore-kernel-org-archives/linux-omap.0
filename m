From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: adding nop usb transceiver
Date: Thu, 29 Jan 2009 12:41:18 -0800
Message-ID: <200901291241.19602.david-b@pacbell.net>
References: <1231411988-7330-1-git-send-email-ajay.gupta@ti.com> <200901222329.07689.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403FA790059@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403FA790059-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 29 January 2009, Gupta, Ajay Kumar wrote:
> > We'll need something like this, yes.
> > This one looks to need a bit of tweaking yet though ...
> > probably that could be done after merge. =A0
>=20
> > The state can need changing after one of the drivers is unregistere=
d;
>=20
> I didn't get this comment.

Basically, that almost all of the OTG state machine must be
handled outside of this code.  It's a bit of a puzzle how to
partition that state machine between the drivers that need
to collaborate on it.  At this point I don't think there can
be a single model that applies everywhere ... but maybe one
could evolve over time.


> done. Added this nop_xceiv_register() which can be called from
> board-init files to register NOP.
>=20
> Please review the modified patch version below.

Well, I count *two* patches.  :)

I'll tweak this one a bit.  It's pretty close.  That
registration function should have a usb_*() prefix
and not be declared in an MUSB-only header, since it
could potentially be used with other OTG hardware.

Thanks.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
