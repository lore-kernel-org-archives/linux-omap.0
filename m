From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] USB: DWC3: Shutdown usb_phy when removing the device
Date: Mon, 15 Oct 2012 16:24:12 +0300
Message-ID: <20121015132412.GS24333@arwen.pp.htv.fi>
References: <1350136218-25678-1-git-send-email-gautam.vivek@samsung.com>
 <20121015121403.GK24333@arwen.pp.htv.fi>
 <CAFp+6iGCRop0Q0M4q5Za1F819Wk7cqnBGfgnnnWBkUNcBPyjpg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VpY0yS1BYpNZumir"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35709 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479Ab2JON3o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 09:29:44 -0400
Content-Disposition: inline
In-Reply-To: <CAFp+6iGCRop0Q0M4q5Za1F819Wk7cqnBGfgnnnWBkUNcBPyjpg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vivek Gautam <gautamvivek1987@gmail.com>
Cc: balbi@ti.com, Vivek Gautam <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, rob.herring@calxeda.com

--VpY0yS1BYpNZumir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2012 at 06:56:13PM +0530, Vivek Gautam wrote:
> Hi Felipe,
>=20
> On Mon, Oct 15, 2012 at 5:44 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Sat, Oct 13, 2012 at 07:20:18PM +0530, Vivek Gautam wrote:
> >> We do usb_phy_init() while doing core_init() in probe,
> >> so adding usb_phy_shutdown() when we do core_exit()
> >> while removing the device.
> >>
> >> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> >
> > I believe this needs to be sent to stable too for v3.6, right ?
> >
> As i can see, 51e1e7b usb: dwc3: add basic PHY support, is yet to be
> merged in stable. Then only it will be possible to merge this in
> stable, right ?

oh indeed. that was added on v3.7 merge window. My bad. No need to Cc
stable, I'll apply this as a fix.

cheers

--=20
balbi

--VpY0yS1BYpNZumir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfA58AAoJEIaOsuA1yqREgdUP/iGdPGbySqLftmuUjEsk+u39
AbrjAnGw6cHSOK5PQZWg9TtBsNKrbXlH0jkfcGVrFhSFW2RxdgxQdBxMHscn10wk
A0Gubz3FHqVjEsM7dD2sV3BL0NcsDZmNYSr72VZfIX+aJ1nVAEi/kMDE4PUyDaE3
SJeV2vH70BHbS4AQrRHy9fq/oM0zUhusqMQQK1POdt+ygUvha01VKFfLfqnegDdk
IW48IfKDRmSe3gIeMEpQR7sjF3A7g/3ADSVDe62a8zADo80xpBsi76BazyCkS/5k
soCZi4Pn8xak+NzjyvW6USzi3xaHgmHzyDzQfqVQMxSNYH8beeRtk+nklye9T9wU
U9OpFE4Il9w6CGQqLbB4T3VUOPvm1CWVXhuXD/+4ibjaW4M3W/zDdt64oYmMAM3j
Qd0hSaQSC7H65atznvC5ap7bu/w2A/O+CL3l2ovctAggkNdU5j+NaVOb9cdZnEcN
s20HhEn/Hi76jdpQ5qUKbWBLFa9vK3cRBffv5thRdGd2t1nrcgGJIPKqRNv9P53K
wJPNk6fV2xOXTPUtG02AO8kGNGTMwJMmKmRvGlC9iLTmLXiydOOCs6HpKx8aDz2x
HACqFlKHJByt/ivXxT52du4Jwo7NDiMDHtNnJtnrfo9FlRWw63JD6VigOWLEj+iG
D47nZekJ2cIMKrO7uZn0
=WpAT
-----END PGP SIGNATURE-----

--VpY0yS1BYpNZumir--
