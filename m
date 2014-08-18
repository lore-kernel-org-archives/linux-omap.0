From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Mon, 18 Aug 2014 09:03:06 +0200
Message-ID: <20140818070306.GB12930@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <20140816165316.GB2858@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34670 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaHRHDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2014 03:03:18 -0400
Content-Disposition: inline
In-Reply-To: <20140816165316.GB2858@katana>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2014 at 11:53:18AM -0500, Wolfram Sang wrote:
>=20
> > +	mac_addr[5] =3D (macid_lo >> 8) & 0xff;
> > +	mac_addr[4] =3D macid_lo & 0xff;
> > +	mac_addr[3] =3D (macid_hi >> 24) & 0xff;
> > +	mac_addr[2] =3D (macid_hi >> 16) & 0xff;
> > +	mac_addr[1] =3D (macid_hi >> 8) & 0xff;
> > +	mac_addr[0] =3D macid_hi & 0xff;
>=20
> That looks twisted, but I assume that you tested it is correct.

The registers are twisted that way.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT8aUqAAoJEEpcgKtcEGQQum8P/0shPeXGElZV83hbjRl9PqXQ
wxkw8kLl+ciaXsg2onlUdyHIpa/f5+JWuRpALw9IzhXUmdjZg1AvuRRGBfS5LHeg
Yzom1UeymKwmmXvTiLr/kw/Hf18Qts6NEagJdGze3tjNDIHZ5pj2tUVTpbflzW+f
P9ZRr3+q/toOkcVwRXbmAae8rMAPlvmGlrGhgI7y0zK7dL2GoCEBFJsO0Ba2fify
Anvf385HCf5wc+CQkxVKadtnEkvgCFklqWATE5QLUH8syT/BwNMPw0kZmgiSKzpm
1TUbwdVbiJdfKalMW5npojD/ArkSVmrgBBbjT8/XEVwTaQgTZJldrB6NeDSc+ppR
7TuAUOOGBzMCGunB6orjrLtKPst0VS5tJ23fS69Mj2i1NlZ/ZGGAqXZeppdmsiIv
dC44z/grz98gB9FUeeDPyFKDxEbeeE5gKe+9UuBZ+YMhSDrwiwI3AggYyQLkrvO9
iRwvqjtsXXzJykQNZ9LVvIc8EQIyD8dmTZjZSmnh5836b2iia+SlbeEztzEXGmNu
xt1scd6VzicIt0tqWe4BGpWPbNAR8qeAfq0R4TwTHSKgStI1fHad7ogFpghGSMei
jpzAjiFRxath+PrFQ/78qHo8TJvOo3/h+2Bq28RXTyjEi5Rcdput07nPC7Nwgfbg
ohoZRjfWPU08RUFA3e50
=R6De
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
