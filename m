From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/3] musb: adding qh in_list and out_list in struct hw_ep
Date: Fri, 31 Oct 2008 09:54:36 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5CA6CC8@dbde02.ent.ti.com>
References: <1225357971-10955-1-git-send-email-ajay.gupta@ti.com>
 <386072610810302044s480e9f7qeae02c1c22700d06@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E739403E5CA6CC2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E5CA6CC2-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "Subbrathnam, Swaminathan" <swami.iyer-l0cyMroinI0@public.gmane.org>, "Abraham, Thomas" <t-abraham-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> > >        if (qh->type == USB_ENDPOINT_XFER_CONTROL) {
> > > -               head = &musb->control;
> > >                hw_ep = musb->control_ep;
> > > +               head = &hw_ep->in_list;
> >
> > So we only support control in transfer and no hope for control out here?
> Control transfer requires only one list and we use in_list for it.
> 
Currently we use only control and bulk multiplexing but we can use them as qh 
list for other transfer types also if in future we plan to multiplex all
INT and ISO transfers on one endpoint.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
