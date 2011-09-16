From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC PATCH 1/6] usb: musb: omap: Configure OTG_INTERFSEL for
 proper charger detection
Date: Fri, 16 Sep 2011 16:13:39 +0200
Message-ID: <20110916141339.GA31093@suse.de>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
 <1316096403-6013-2-git-send-email-kishon@ti.com>
 <4E731B6D.2040007@ru.mvista.com>
 <CAAe_U6KaFJGM61=Pkm2q-EBQeEtSAOBuC2jgFRd7DV4xKOjJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAe_U6KaFJGM61=Pkm2q-EBQeEtSAOBuC2jgFRd7DV4xKOjJdg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, x0153364-l0cyMroinI0@public.gmane.org, m-sonasath-l0cyMroinI0@public.gmane.org, vishp-l0cyMroinI0@public.gmane.org, hemahk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 16, 2011 at 07:21:41PM +0530, ABRAHAM, KISHON VIJAY wrote:
> Sergei,
>=20
> Thanks for your comments.
>=20
> On Fri, Sep 16, 2011 at 3:18 PM, Sergei Shtylyov <sshtylyov-Igf4POYTYCBhl2p70BpVqQ@public.gmane.org=
m> wrote:
> > Hello.
> >
> > On 15-09-2011 18:19, Kishon Vijay Abraham I wrote:
> >
> >> Setting OTG_INTERFSEL to UTMI interferes with charger detection re=
sulting
> >> in incorrect detection of charger type. Hence OTG_INTERFSEL is con=
figured
> >> to
> >> ULPI initially and changed to UTMI only after receiving USB_EVENT_=
ID or
> >> USB_EVENT_VBUS notification.
> >
> >> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Balaji T K<balajitk-l0cyMroinI0@public.gmane.org>
> >
> > =A0 AFAIK, full name is needed here.
>=20
> is it not the prerogative of the person giving his signed-off by??

Not really.

> >> [sandesh.gowda-l0cyMroinI0@public.gmane.org: The interface selection has to be done befo=
re the
> >> PHY
> >> is activated and is not allowed to change when the PHY clock is al=
ready
> >> running]
> >
> > =A0 No signoff from him?
>=20
> ok. will add his signoff.

You can NOT add someone else's sign-off to a patch, please go re-read
Documentation/SubmittingPatches as to what this really means.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
