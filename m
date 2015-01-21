From: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/5] xhci: Platform: Set Synopsis device disconnection
 quirk based on platform data
Date: Wed, 21 Jan 2015 16:55:47 +0800
Message-ID: <CAJ1gpc33-BH1e=VpJ0ocjNRJk6CGswCuQ8UYrO=Pkanqhv+xLg@mail.gmail.com>
References: <1421654209-6486-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	<1421654209-6486-5-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	<20150119145147.GG20386@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150119145147.GG20386@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

hi,

2015-01-19 22:51 GMT+08:00 Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>:
>
> On Mon, Jan 19, 2015 at 03:56:48PM +0800, Sneeker Yeh wrote:
> > If an xhci platform has Synopsis device disconnection errata then enable
> > XHCI_DISCONNECT_QUIRK quirk flag.
> >
> > Signed-off-by: Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
> > ---
> >  drivers/usb/host/xhci-plat.c     |    3 +++
> >  include/linux/usb/xhci_pdriver.h |    4 ++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 08d402b..40beb95 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -147,6 +147,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >       if ((node && of_property_read_bool(node, "usb3-lpm-capable")) ||
> >                       (pdata && pdata->usb3_lpm_capable))
> >               xhci->quirks |= XHCI_LPM_SUPPORT;
> > +
> > +     if (pdata && pdata->delay_portcsc_clear)
> > +             xhci->quirks |= XHCI_DISCONNECT_QUIRK;
> >       /*
> >        * Set the xHCI pointer before xhci_plat_setup() (aka hcd_driver.reset)
> >        * is called by usb_add_hcd().
> > diff --git a/include/linux/usb/xhci_pdriver.h b/include/linux/usb/xhci_pdriver.h
> > index 376654b..a37a3a5 100644
> > --- a/include/linux/usb/xhci_pdriver.h
> > +++ b/include/linux/usb/xhci_pdriver.h
> > @@ -18,10 +18,14 @@
> >   *
> >   * @usb3_lpm_capable:        determines if this xhci platform supports USB3
> >   *                   LPM capability
> > + * @delay_portcsc_clear:     determines if Synopsis USB3 core has errata in
> > + *                           "DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1" hardware
> > + *                           configuration.
> >   *
> >   */
> >  struct usb_xhci_pdata {
> >       unsigned        usb3_lpm_capable:1;
> > +     unsigned        delay_portcsc_clear:1;
>
> previous patch won't build before this is applied. That's a problem.
> Please shuffle things around so that each and every patch builds and
> works on its own.
>
> We cannot break bisectability ;-)

Ah...sorry I seem to make a mess here,
i'll re-arrange all patches next round.

Much appreciate,
Sneeker

>
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
