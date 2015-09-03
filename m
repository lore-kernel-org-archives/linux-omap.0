From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/9] usb: dwc3: add dual-role support
Date: Thu, 3 Sep 2015 10:44:44 -0500
Message-ID: <20150903154444.GA4031@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-2-git-send-email-rogerq@ti.com>
 <20150902143149.GD8299@saruman.tx.rr.com>
 <55E83B5C.7050001@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E83B5C.7050001@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 03, 2015 at 03:21:48PM +0300, Roger Quadros wrote:
> >> +	dwc->fsm->id =3D id;
> >> +	dwc->fsm->b_sess_vld =3D vbus;
> >> +	usb_otg_sync_inputs(dwc->fsm);
> >> +}
> >> +
> >> +static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
> >> +{
> >> +	struct device *dev =3D usb_otg_fsm_to_dev(fsm);
> >> +	struct dwc3 *dwc =3D dev_get_drvdata(dev);
> >=20
> > how about adding a usb_otg_get_drvdata(fsm) ?
>=20
> You meant for otg core? That can be done.

yeah. BTW, I think otg core needs quite a few changes to become actually
useful. Currently it's just too much pointer ping-pong going back and
forth between phy, otg core, udc and hcd.

Also, I caught a ton of issues with it and suspend/resume. You might
want to fix them before adding more users to it.

It's also rather racy and that needs fixing too. On top of all that, I
think there's too much being added to UDC just to get Dual-Role, let's
see if we can improve that too.

> >> @@ -843,6 +998,16 @@ static int dwc3_probe(struct platform_device *pde=
v)
> >>  	hird_threshold =3D 12;
> >> =20
> >>  	if (node) {
> >> +		if (of_property_read_bool(node, "extcon"))
> >> +			dwc->edev =3D extcon_get_edev_by_phandle(dev, 0);
> >> +		else if (of_property_read_bool(dev->parent->of_node, "extcon"))
> >> +			dwc->edev =3D extcon_get_edev_by_phandle(dev->parent, 0);
> >=20
> > why do you need to check the parent ? Why isn't that done on the glue
> > layer ?
>=20
> On DRA7-evm, the extcon device is defined in the glue layer node. But
> we need the device both at the glue layer and at the core layer.

why do you need extcon here ? Glue updates core via UTMI about the
states, right ? So you should get proper VBUS and ID status via OTG IRQ.
Is that not working ?

> We do get the extcon device in dwc3-omap.c
>=20
> Any suggestion how to pass the extcon device from glue layer to core.c?
> Or should I add the extcon property to dwc3 USB node as well in the DT?

GPIO toggles
  dwc3-omap extcon event
    update status via UTMI STATUS register
      OTG IRQ on core
        Horray!

:-)

> >> +
> >> +		if (IS_ERR(dwc->edev)) {
> >> +			dev_vdbg(dev, "couldn't get extcon device\n");
> >=20
> > dev_err() ??
>=20
> Is it ok to print it even in EPROBE_DEFER case?

hmm, probably pointless, indeed.

--=20
balbi

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6GrsAAoJEIaOsuA1yqREzcgP/3udUq6ZRnHIg7BXFpr5JkEc
VgQWkY8lWIvizE8q+5tGyl96D152sinhbN6Tr3Jyj0FahxqTLpRazrDyc+TtHJ5u
OUsLGynsqq3hGhC6JAub1hK/ZsJtWcUvUBI2xW+BvBwFd1wEiILFL6po7G0JD7R2
ef4jMFhVbvlfY9yEOyuO0x/ByGUlkxW7uLz/x/LORoLe0k/4JKl990RcL50P2pzi
7cmUJw73mBrbrxhKAJvLcfFfz44lpA/NxSU7m9gu9aASI8zJ2HtJ68I7zKQs4IOL
OaQZl+mTGQvgXjSGfuciL283XH4kKG3VD64gHHD/B/bol25TLRVVJZGa02K8H+mH
egWd6fgRk5C/cC9E5gP9hlAvUsnhNBKqfEwPgJ4dGMOQus6zvBqY94RJoujH7Vdt
TNvjI8/sDgo6kpLcBF1mRXnjryJkc4oYc8X4gt7cJ6AxhnOhFa6D89yfpRVZG57p
yWmqxMmIrAJOcmzuJwuCE5ml4PfS/P5Fz5wSx9gpfz4f3Q54EGWfEzKYzwcFrqar
M/K3KmtAqA5uAqrqpcWm8nXXOd6ZclsXwHLM8+93BMgbJe82lTEMsedxhBICkBoM
yggBB6ImSffyCNBDPiMD4MMl/2JIlyTsNDH+jt1jC0w24DYpPB8PlRNaz2GgEzjJ
WhScDl2vSujddvwNd4Ad
=CSb/
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
