From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/3] usb: xhci: Add the suspend/resume functionality
Date: Thu, 18 Oct 2012 20:30:01 +0300
Message-ID: <20121018173001.GC7823@arwen.pp.htv.fi>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
 <1350380738-32473-3-git-send-email-vikas.sajjan@linaro.org>
 <20121016095932.GA17416@arwen.pp.htv.fi>
 <20121018145956.GS5378@xanatos>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48975 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125Ab2JRRfm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:35:42 -0400
Content-Disposition: inline
In-Reply-To: <20121018145956.GS5378@xanatos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 07:59:56AM -0700, Sarah Sharp wrote:
> On Tue, Oct 16, 2012 at 12:59:33PM +0300, Felipe Balbi wrote:
> > Hi,
> >=20
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int xhci_plat_suspend(struct device *dev)
> > > +{
> > > +	struct usb_hcd	*hcd	=3D dev_get_drvdata(dev);
> > > +	struct xhci_hcd	*xhci	=3D hcd_to_xhci(hcd);
> > > +
> > > +	/* Make sure that the HCD Core has set state to HC_STATE_SUSPENDED =
*/
> > > +	if (hcd->state !=3D HC_STATE_SUSPENDED ||
> > > +		xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
> > > +		return -EINVAL;
> > > +
> > > +	return xhci_suspend(xhci);
> >=20
> > this is pretty much what xhci_pci_suspend() is doing. Sarah, would you
> > be ok with a patch such as:
>=20
> Yes, that patch looks fine.
>=20
> > usb: host: xhci: move HC_STATE_SUSPENDED check to xhci_suspend()
> >=20
> > [ STILL NEED TO WRITE A PROPER COMMIT LOG ]
> >=20
> > NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index 8345d7c..aeb3973 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -218,15 +218,8 @@ static void xhci_pci_remove(struct pci_dev *dev)
> >  static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
> >  {
> >  	struct xhci_hcd	*xhci =3D hcd_to_xhci(hcd);
> > -	int	retval =3D 0;
> > =20
> > -	if (hcd->state !=3D HC_STATE_SUSPENDED ||
> > -			xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
> > -		return -EINVAL;
> > -
> > -	retval =3D xhci_suspend(xhci);
> > -
> > -	return retval;
> > +	return xhci_suspend(xhci);
> >  }
> > =20
> >  static int xhci_pci_resume(struct usb_hcd *hcd, bool hibernated)
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 8d7fcbb..b85029e 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -879,6 +879,10 @@ int xhci_suspend(struct xhci_hcd *xhci)
> >  	struct usb_hcd		*hcd =3D xhci_to_hcd(xhci);
> >  	u32			command;
> > =20
> > +	if (hcd->state !=3D HC_STATE_SUSPENDED ||
> > +			xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
> > +		return -EINVAL;
> > +
> >  	spin_lock_irq(&xhci->lock);
> >  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> >  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
> >=20
> > do you think there is any reason to keep replicating the
> > HC_STATE_SUSPENDED test all over the place ?
>=20
> Nope, no reason I can see.  I'm pretty sure I only check the suspended
> state in case the code in the USB core to handle the host controller
> suspend ever breaks for the corner case of the host hardware needing two
> roothubs (USB 2.0 and USB 3.0 in this case).  It doesn't matter if we
> check that in the PCI/platform suspend or in xhci_suspend, as long as it
> gets checked.

cool, I'll send a proper patch tomorrow ;-)

cheers

--=20
balbi

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgDyZAAoJEIaOsuA1yqRE+C4QAIa/IW3p0vHTQQ0ug/dOo1tx
JXmMSVq6y27TILTiE11P5IQUVQ7MnD47WIMTg1UF+8KWr//wpOXY43M7SU9vthxu
nUwgVbFtb3vaOn3UM0cWkO7mHT+uETIWcS7O1Wjcsw4yjDmwdJW+22YOQMnuJ6Es
I0zeFLEPyR3ILtNktjUPMtP78au6pOshKgRnN23dOwFMYnD5N/roJJMAfaaZg650
XcxD7Bg0QHhYznzd5f//ojwV4c5pPoZ1oQxvGZaVDRldwmb9rxF1LbuK6J3bJzXZ
YkikkOnmcTn0fS3z67sYTMWPn+KhOebAPWS+Q8Ko0Z3IkKI00cwWzfthAlWC4tKc
2o2h0mGsAWtzk3npfAov7b829u54Q8i8Zk1Ihd8lKQ19LrZMi6Q9BaUn6GxciNl7
a17zS98ZqNGAOycNJywSXUXG0i8DQxW+fhLJo5PTmTnXSTZXCOjwZVlQSRJdSbpW
0wAOrwa7vJBU6kq+pgCSgfVOcqoq5zb1QAS2KxuGvervSzW9OJFGU3Iz4nRCFwG9
+TDb7LzbvsNWjlknokMuYRVwtFmRkl75d8D+xjEEX/LGwtNO9BQgw6MIhTn5kJp0
SUc7hOQlgbAhhoF1Q8jkEhXwmeIlb33XZHoQct6+1gLJKJtny5aXM5sRy+i0IRjd
ht07M3PkMbXbZ7sBbpb4
=FHDy
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
