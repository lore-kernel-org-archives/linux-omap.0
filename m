From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 4/9] usb: dwc3: core: Adapt to named interrupts
Date: Thu, 3 Sep 2015 10:48:49 -0500
Message-ID: <20150903154849.GB4031@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-5-git-send-email-rogerq@ti.com>
 <20150902143457.GF8299@saruman.tx.rr.com>
 <55E84133.9070704@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E84133.9070704@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 03, 2015 at 03:46:43PM +0300, Roger Quadros wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> On 02/09/15 17:34, Felipe Balbi wrote:
> > On Wed, Sep 02, 2015 at 05:24:19PM +0300, Roger Quadros wrote:
> >> From: Felipe Balbi <balbi@ti.com>
> >>
> >> Add support to use interrupt names,
> >>
> >> Following are the interrupt names
> >>
> >> Peripheral Interrupt - peripheral
> >> HOST Interrupt - host
> >> OTG Interrupt - otg
> >>
> >> [Roger Q]
> >> - If any of these are missing we use the
> >> first available IRQ resource so that we don't
> >> break with older DTBs.
> >=20
> > this is what original commit did:
> >=20
> > commit ecd5f71cfd663bcd4efd2f29824acd8b2ba9715d
> > Author: Felipe Balbi <balbi@ti.com>
> > Date:   Fri Jan 3 13:49:38 2014 -0600
> >=20
> >     usb: dwc3: cleanup IRQ resources
> >    =20
> >     In order to make it easier for the driver to
> >     figure out which modes of operation it has,
> >     and because some dwc3 integrations have rather
> >     fuzzy IRQ routing, we now require three different
> >     IRQ numbers (peripheral, host, otg).
> >    =20
> >     In order to do that and maintain backwards compatibility,
> >     we still maintain support for the old IRQ resource name,
> >     but if you *really* want to have proper peripheral/host/otg
> >     support, you should make sure your resources are correct.
> >    =20
> >     Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> This is better since we request the resource only if needed and bail out
> if it is not present.
>=20
> >=20
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 60580a01cdd2..1f01031873b7 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -556,10 +556,22 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
> >  static int dwc3_core_init_mode(struct dwc3 *dwc)
> >  {
> >  	struct device *dev =3D dwc->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> >  	int ret;
> > =20
> >  	switch (dwc->dr_mode) {
> >  	case USB_DR_MODE_PERIPHERAL:
> > +		dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc3_peripheral");
>=20
> Shall we just name it just "peripheral"?

sure, why not :-)

> > +		if (dwc->gadget_irq < 0) {
> > +			dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc_usb3");
>=20
> How will this work? Currently we don't have a name for the IRQ in the DT.

we can just add interrupt-names, right ? Or, the fallback could be what
is already done today: just fetch it by index.

>=20
> > +			if (dwc->gadget_irq < 0) {
> > +				dev_err(dev, "missing IRQ\n");
> > +				return dwc->gadget_irq;
> > +			} else {
> > +				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
>=20
> Do we want to warn about legacy nodes?

Sure :-)

Now, do you want me to update it, or will you do it ? BTW, if you decide
to do it, we need to patch all users :-)

> > @@ -576,6 +604,28 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
> >  		}
> >  		break;
> >  	case USB_DR_MODE_OTG:
> > +		dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc3_peripheral");
> > +		if (dwc->gadget_irq < 0) {
> > +			dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc_usb3");
> > +			if (dwc->gadget_irq < 0) {
> > +				dev_err(dev, "missing IRQ\n");
> > +				return dwc->gadget_irq;
> > +			} else {
> > +				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
> > +			}
> > +
> > +			dwc->xhci_irq =3D dwc->gadget_irq;
> > +			dwc->otg_irq =3D dwc->gadget_irq;
> > +		} else {
> > +			dwc->xhci_irq =3D platform_get_irq_byname(pdev, "dwc3_host");
> > +			if (dwc->xhci_irq < 0) {
> > +				dev_err(dev, "missing Host IRQ\n");
> > +				return dwc->xhci_irq;
> > +			}
> > +
> > +			dwc->otg_irq =3D platform_get_irq_byname(pdev, "dwc3_otg");
>=20
> need to check if error?

right

> > +		}
>=20
> Need to setup xhci_resource[1]?

isn't it done above ?

--=20
balbi

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6GvhAAoJEIaOsuA1yqREqBsQAIxi7KUdZaillBJdTTAAr049
IvdiVI685vfFVwrnZQWpK1+/sFJYUxDp72WOYDYEFLPQT9erd5OoMOx/qjOB7gmT
uK9IDIM6dvMM24RQF7EOA7n4gUtzIjRM2/mh7kKIQCTYwlJQKRo90ySwrTmT5KLi
lsY8mnnMpPplXengiIINuwBdJNIHQoritG0gO+IyW+lC7aSqsEksjEgXKDp8OOXS
3vhgM7i+gX1Nafznr+IOMJlfxzkGiDW5EECCYmhVyUtdFc1U5ce4BQhN1bF7eL6Y
6mECQvUBmLRgkybKkn4BbjXV2PTUVSckB5LjIHWM3uEBKzC3tV0VHZqIY4IVTpg2
Gm5xv8e5ElRX8Fo7fe9FMiJAHDlHujd3XVc1bSzRitRpzkV3sDLjB1YQ5cz8Ny3y
GrHg3ubBVBg+fQ4IVlWod7IIRVbfQeCWpYGu5QQr6yYqtBRr+RUR8XCF7839yDMm
cOqbNfpXN4SD70HxQLNIk+x9MBJSuiUIy6a4KzUzxnP4DS525M38DXHB3jrLaWwc
cqoleQHBpAj5LuChaIgDdgTs495dEZ20boDQ/ffkMkQMbFlI7ntSsdtKkwPVqLtY
yUdRouQMKIqCLp6ZVBgAbH8UnXS55w/oi/PbXeB/UmLkUwnVerakg9f7MnyIbw2y
Ek5wioU/gMJ/5VRT/Yv/
=daZk
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
