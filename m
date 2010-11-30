From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 00/12] usb: ehci-omap: add OMAP4 support
Date: Tue, 30 Nov 2010 10:30:07 -0800
Message-ID: <20101130183007.GA27476@suse.de>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <20101130174406.GB19977@kroah.com>
 <AANLkTi=hr3bz6xS8DB+ShE0E_HzFGhtCqi+1NqsWQQa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=hr3bz6xS8DB+ShE0E_HzFGhtCqi+1NqsWQQa5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 11:53:11PM +0530, Gadiyar, Anand wrote:
> On Tue, Nov 30, 2010 at 11:14 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > On Mon, Nov 22, 2010 at 12:10:03AM +0530, Anand Gadiyar wrote:
> >> This series adds support for the EHCI controller on
> >> OMAP4 chips. (This enables the ethernet controller
> >> on the Pandaboard - finally!).
> >>
> >> I'm sorry for the really long delay - I know this has
> >> been in the works for a while.
> >>
> >> I've tested the series on an OMAP4 SDP and a Pandaboard.
> >> I'll be testing OMAP3 tomorrow.
> >>
> >> Dependencies:
> >> One patch depends on the mux framework patches by Benoit
> >> - which are already in linux-next; however the series
> >> compiles cleanly against current Linus' tree.
> >>
> >> What's pending:
> >> - OHCI support
> >> - Support for TLL and HSIC modes
> >> - Factoring out code common to ehci-omap and ohci-omap3
> >> - Conversion to use omap_device and the hwmod database
> >> - Runtime PM support
> >
> > Do you want these to go in through the USB or OMAP tree? =A0Either =
is fine
> > with me.
> >
> > thanks,
> >
> > greg k-h
> >
>=20
> I reposted a v2 series splitting them up into two parts - one that co=
uld
> potentially go via the USB tree [1], and the other that is platform c=
hanges
> that touches only mach-omap2/* files and could go via the OMAP tree [=
2].
>=20
> The only other change is I added back patch descriptions to a couple
> of patches that I missed out on in v1.
>=20
> I'm okay with either option. Both series could also go via your tree =
if
> it's okay with Tony.

Ah, sorry, I see that now.

Tony, it's up to you, what is easier for you?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
