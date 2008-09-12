From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] omap: usb: ehci: fix use of hcd->regs
Date: Fri, 12 Sep 2008 16:54:00 -0700
Message-ID: <20080912235400.GL10675@atomide.com>
References: <20080912121024.GG759@gandalf.research.nokia.com> <200809120932.57016.david-b@pacbell.net> <20080912175033.GB7132@frodo> <20080912182255.GD7132@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54940 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186AbYILXyG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 19:54:06 -0400
Content-Disposition: inline
In-Reply-To: <20080912182255.GD7132@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <me@felipebalbi.com> [080912 11:23]:
> On Fri, Sep 12, 2008 at 08:50:33PM +0300, Felipe Balbi wrote:
> > On Fri, Sep 12, 2008 at 09:32:56AM -0700, David Brownell wrote:
> > > On Friday 12 September 2008, Felipe Balbi wrote:
> > > > - =A0 =A0 =A0 hcd->regs =3D (void __iomem *) (int) IO_ADDRESS(h=
cd->rsrc_start);
> > > > + =A0 =A0 =A0 hcd->regs =3D ioremap(hcd->rsrc_start, hcd->rsrc_=
len);
> > >=20
> > > This is missing its sibling iounmap() ...
> >=20
> > God... thanks Dave. Good catch. Patch coming soonish.
>=20
> Here's the updated version. While at it, I'll send another patch gett=
ing
> rid of some other mistakes during probe.
>=20
> =3D=3D=3D=3D=3D cut here =3D=3D=3D=3D
>=20
> From 818dc8ebd261cdc59670fe1580248ad47f18a1de Mon Sep 17 00:00:00 200=
1
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Fri, 12 Sep 2008 21:07:09 +0300
> Subject: [PATCH] omap: usb: ehci: fix usb of hcd->regs
>=20
> hcd->regs should be initialized by ioremaping hcd->rsrc_start and
> hcd->rsrc_len. Fix it for ehci-omap.c.

Pushing this today.

Tony

>=20
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/host/ehci-omap.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-oma=
p.c
> index 8f122e5..fff4195 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -438,7 +438,11 @@ static int ehci_hcd_omap_drv_probe(struct platfo=
rm_device *dev)
>  	hcd->rsrc_start =3D dev->resource[0].start;
>  	hcd->rsrc_len =3D dev->resource[0].end - dev->resource[0].start + 1=
;
> =20
> -	hcd->regs =3D (void __iomem *) (int) IO_ADDRESS(hcd->rsrc_start);
> +	hcd->regs =3D ioremap(hcd->rsrc_start, hcd->rsrc_len);
> +	if (!hcd->regs) {
> +		dev_err(&dev->dev, "ioremap failed\n");
> +		return -ENOMEM;
> +	}
> =20
>  	ehci =3D hcd_to_ehci(hcd);
>  	ehci->caps =3D hcd->regs;
> @@ -457,8 +461,9 @@ static int ehci_hcd_omap_drv_probe(struct platfor=
m_device *dev)
> =20
>  	dev_dbg(hcd->self.controller, "ERR: add_hcd");
>  	omap_stop_ehc(dev, hcd);
> -
> +	iounmap(hcd->regs);
>  	usb_put_hcd(hcd);
> +
>  	return retval;
>  }
> =20
> @@ -483,6 +488,7 @@ static int ehci_hcd_omap_drv_remove(struct platfo=
rm_device *dev)
> =20
>  	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_remove()");
> =20
> +	iounmap(hcd->regs);
>  	usb_remove_hcd(hcd);
>  	usb_put_hcd(hcd);
>  	omap_stop_ehc(dev, hcd);
> --=20
> 1.6.0.1.196.g01914
>=20
> --=20
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
