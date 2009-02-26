From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] usb: musb: fix the possible panic while resuming
Date: Thu, 26 Feb 2009 12:50:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91C64@dbde02.ent.ti.com>
References: <4d34a0a70902252257lc8b3a1duc6cbd6de2cbd2840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4d34a0a70902252257lc8b3a1duc6cbd6de2cbd2840-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Kim Kyuwon [mailto:chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]=20
> Sent: Thursday, February 26, 2009 12:28 PM
> To: Gadiyar, Anand
> Cc: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; OMAP;=20
> David Brownell; q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; Minkyu Kang
> Subject: Re: [PATCH 1/2] usb: musb: fix the possible panic=20
> while resuming
>=20
> Hi,
>=20
> On Thu, Feb 26, 2009 at 3:37 PM, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> wrot=
e:
> > <snip>
> >
> >> Now I know that, in addition to HSUSB_MC_NINT disabled by the prev=
ious
> >> patch [ARM: OMAP: Disable USB interrupt in the musb_resume()
> >> function], USBTLL_SWAKEUP and USBHOST_SWAKEUP can be also wake-up
> >> source events to PRMC module. Sorry I didn't know that time. The
> >> remote wake uses these two SWAKEUP. David, is my previous patch is
> >> still NAK?
> >
> > USBTLL_SWAKEUP and =A0USBHOST_SWAKEUP are not for MUSB.
> >
>=20
> But they are used to wake up request. Can I ask what they are for?
>=20

I'm not the PRCM expert, but USBHOST refers to EHCI/OHCI and USBTLL is
needed for EHCI (except in PHY mode) and for OHCI (all modes). These
wakeup sources are meant for wakeups initiated by these modules.

MUSB is a different module altogether.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
