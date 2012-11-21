From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 10/16] mfd: omap-usb-host: Intialize all available ports
Date: Wed, 21 Nov 2012 21:48:59 +0200
Message-ID: <20121121194859.GD14290@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-11-git-send-email-rogerq@ti.com>
 <20121121135246.GL10216@arwen.pp.htv.fi>
 <50ACF77A.9060308@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48449 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab2KUTza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 14:55:30 -0500
Content-Disposition: inline
In-Reply-To: <50ACF77A.9060308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Wed, Nov 21, 2012 at 05:47:06PM +0200, Roger Quadros wrote:
> On 11/21/2012 03:52 PM, Felipe Balbi wrote:
> > On Thu, Nov 15, 2012 at 04:34:08PM +0200, Roger Quadros wrote:
> >> OMAPs till date can have upto 3 ports. We need to initialize
> >=20
> > s/upto/up to/
> >=20
> >> the port mode in HOSTCONFIG register for all of them.
> >=20
> > why *all* of them ? Isn't it enough to initialize only the ones we're
> > going to use ? If not, why ?
>=20
> Right. I'll correct the $SUBJECT and comment.

good, thanks.

> >> @@ -403,21 +401,16 @@ static void omap_usbhs_init(struct device *dev)
> >>  				reg |=3D OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
> >>  		}
> >>  	} else if (is_omap_usbhs_rev2(omap)) {
> >> -		/* Clear port mode fields for PHY mode*/
> >> -		reg &=3D ~OMAP4_P1_MODE_CLEAR;
> >> -		reg &=3D ~OMAP4_P2_MODE_CLEAR;
> >> -
> >> -		if (is_ehci_tll_mode(pdata->port_mode[0]) ||
> >> -			(is_ohci_port(pdata->port_mode[0])))
> >> -			reg |=3D OMAP4_P1_MODE_TLL;
> >> -		else if (is_ehci_hsic_mode(pdata->port_mode[0]))
> >> -			reg |=3D OMAP4_P1_MODE_HSIC;
> >> -
> >> -		if (is_ehci_tll_mode(pdata->port_mode[1]) ||
> >> -			(is_ohci_port(pdata->port_mode[1])))
> >> -			reg |=3D OMAP4_P2_MODE_TLL;
> >> -		else if (is_ehci_hsic_mode(pdata->port_mode[1]))
> >> -			reg |=3D OMAP4_P2_MODE_HSIC;
> >> +		for (i =3D 0; i < omap->nports; i++) {
> >> +			/* Clear port mode fields for PHY mode*/
> >> +			reg &=3D ~(OMAP4_P1_MODE_MASK << 2*i);
> >=20
> > add spaces around '*' operator.
> >=20
> >> +			if (is_ehci_tll_mode(pdata->port_mode[i]) ||
> >> +				(is_ohci_port(pdata->port_mode[i])))
> >> +				reg |=3D OMAP4_P1_MODE_TLL << 2*i;
> >=20
> > ditto
> >=20
> >> +			else if (is_ehci_hsic_mode(pdata->port_mode[i]))
> >> +				reg |=3D OMAP4_P1_MODE_HSIC << 2*i;
> >=20
> > ditto
> >=20
> > in fact, I would convert this construct into a switch which would look
> > like:
> >=20
> > reg &=3D ~(OMAP4_P1_MODE_MASK << i * 2);
> >=20
> > switch (port_mode[i]) {
> > case OMAP4_P1_MODE_TLL:
> > 	reg |=3D OMAP4_P1_MODE_TLL << i * 2;
> > 	break;
> > case OMAP_P1_MODE_HSIC:
> > 	reg |=3D OMAP4_P1_MODE_HSIC << i * 2;
> > 	break;
> > }
> >=20
> > Also, it looks like the whoel for loop with port mode settings could be
> > re-factored to a separate function to aid readability.
> >=20
>=20
> To clarify, did you mean to use a function for the above code snippet
> where we set the HOSTCONFIG part?

correct. In fact the entire OMAP USB Host needs quite some love. By
quickly looking at the driver one can easily see many details which can
be greatly improved ;-)

thanks for starting this out ;-)

--=20
balbi

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrTArAAoJEIaOsuA1yqRE73UP/iHdyQu1lXsZtkhmAzIx4xl4
Um1nZifdJ81BaZH+9dfftug/fcd9AVgJtH+kmOwsZqsI5Wjhb/h7XQB9FPCIpDTi
I4sW4EWR60g5YXUoU0dkCbRXBnJeY0L7ZxQh93g2M79Y4rUpn4sYLthA0IY7+jKT
DO6rI84Y/xc8M1gSOdfRfXHHhHRg8MJIY+jFdBKLzAULPCSsQ6UNZJfxKw9sh22H
8koidh8HzzVJedKtFgFVFIPbF7SmtcjblJZoIw5O/khY/h/FpV6bP8ZqXvJt+JM6
5Ah0x6/kKu+g7zjz+eMPOzr2TmuX0KDszq4HO7MkD/OmLEa16P0eaqpAo1lGHuFf
MITaVYHc9ihR3Iw16qXd/5/6xmRuRKuTGjPZfYnZAaerTG+4WxFiKmxxdhVCXhT1
bju3gBoKYmLZk0BTnePzytioMxbLajy3AouzzWbl/jU7ZbTiNekyh6z1vje10WA1
zYLyn4k5koAMoZMGhBOeWxeHACXeqYb3dO4owCW9M8JVymCEnzG+wl4m4tecpOsM
QIkSZTk4pbJRCa7XqRcWK6WhQBW57MPnFb6AZ5a1VdpzYQLp6h5X3mDHvIZSMj5A
3qe2s2N/5nEZ5CkgL6aPJXWN5gOTwWp6jirmaZbcrtgqyp03mm5VTddqYZ2zEsPX
iLuq3SMsPGSt/qeutyk2
=C8r6
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
