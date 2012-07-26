From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Thu, 26 Jul 2012 11:29:11 +0300
Message-ID: <20120726082911.GR29029@arwen.pp.htv.fi>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-5-git-send-email-ajay.gupta@ti.com>
 <20120726073621.GG29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF6F7@DBDE01.ent.ti.com>
 <20120726082402.GO29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF849@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EguBBKnZWdUQS9Kz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:32859 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237Ab2GZIcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 04:32:25 -0400
Received: by lahm15 with SMTP id m15so1147244lah.9
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 01:32:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EAEF849@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>


--EguBBKnZWdUQS9Kz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2012 at 08:29:06AM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> > On Thu, Jul 26, 2012 at 08:22:35AM +0000, Gupta, Ajay Kumar wrote:
> > > > > @@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
> > > > >  		data->set_phy_power(0);
> > > > >
> > > > >  	usb_put_phy(musb->xceiv);
> > > > > -	usb_nop_xceiv_unregister();
> > > > > +	usb_nop_xceiv_unregister(musb->xceiv);
> > > >
> > > > Dude, this is so wrong... You don't know if there are other users of
> > > > the nop xceiv in the system. If there are other users which already
> > > > have claimed id 0, you will try to create duplicated directories un=
der
> > sysfs.
> > > > MUSB's ID has nothing to do with NOP's ID.
> > >
> > > I could not understood this comment as I am not using id. Please clar=
ify.
> >=20
> > sorry, my bad. I put the comment on the wrong hunk:
> >=20
> > > > > @@ -364,7 +364,7 @@ static int am35x_musb_init(struct musb *musb)
> > > > >  	if (!rev)
> > > > >  		return -ENODEV;
> > > > >
> > > > > -	usb_nop_xceiv_register();
> > > > > +	usb_nop_xceiv_register(musb->id);
> > > > >  	musb->xceiv =3D usb_get_phy(USB_PHY_TYPE_USB2);
> > > > >  	if (IS_ERR_OR_NULL(musb->xceiv))
> > > > >  		return -ENODEV;
> >=20
> > here. You pass musb->id to become NOP's ID.
>=20
> Got this, so something like musb_ida is needed even for NOP. Right?

that's correct. But I guess you can avoid nop_get_id() and build that
into nop_register and nop_unregister() calls, so that the changes are
local to nop xceiv only.

--=20
balbi

--EguBBKnZWdUQS9Kz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEP/XAAoJEIaOsuA1yqREkyYP/iPxtrjDv2ISzf/CLNGME3/r
xiXGDlZXut8PO/TzrmOCHkEn5p4M0P35ruOQqBRCBEEyqmYosBwvP5uOn7CaPjqm
B68mA8lxjEp/DkB0wAzQk/kjCNzmQS1j9ZEAEGrrHYZ8wsF0euFkVuTd1RiDtXY+
JMEvml+q4+OrJ+0bJNXjKOLhKaxudWsAp9truGzTvW5xNH5heZvX10C0btIlHh2W
Eb6kBw9RE8SbQHX2E66QvYIE8WWVLK9hxhmvNptojAa61BJVxprc2+QoK5gPHYtL
L7ozmfhaFdP1r7fkkN4TZCiUhHgcNO516FJfITJ/uq6/VrCC5jEPkp+N2/5e7qRX
0XzRf7MxSDXDMMq67o4bXYUxIPFTBxsT+/KTq5oiOG0u9vLSbVmHbC3+jduOX89J
W/BVTA4g9Rrck66u4OhZlam+5z+HwKWAfhC8i0XTKesG4sVxaa1GZy42ainZoe3x
X/o5gL0Zmci7drKKnVfR/5kjGxkztkVOyehRTLIJPsUgrFDSEN9QJB8cy9gKux2x
VQsC2J0+NuGgf/V1aroy1ITIJYUyiFtzQfrM1prmEYgrbmbiVsTsfwOXEo0PUsgy
H4oH02+n3wVkq7g9iMSFj0SzgKWzt/MOh6jPeJ/7UWzBa0T0EuoQaoDEfSeSqaKo
DwNtu45NxBp2la0sUpr6
=xiOH
-----END PGP SIGNATURE-----

--EguBBKnZWdUQS9Kz--
