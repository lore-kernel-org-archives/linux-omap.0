From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Mon, 26 Nov 2012 10:52:31 +0200
Message-ID: <20121126085231.GC15766@arwen.pp.htv.fi>
References: <20121123103817.GC29585@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1211231125350.1734-100000@iolanthe.rowland.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43121 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab2KZI7M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 03:59:12 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1211231125350.1734-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 23, 2012 at 11:27:34AM -0500, Alan Stern wrote:
> On Fri, 23 Nov 2012, Felipe Balbi wrote:
>=20
> > > And maybe the same sort of scheme could be used for clocks, although =
I=20
> > > don't know how to do it in a generic way that will work on all=20
> > > platforms.
> >=20
> > perhaps making use of pm_clk_add() and letting PM layer do the rest for
> > us ? If that doesn't work then it means PM layer's clk handling could be
> > improved, I suppose.
>=20
> Is the clock framework sufficiently generic at this point that it can
> be used by core code (like the PM layer)?

It already is :-) See drivers/base/power/clock_ops.c

--=20
balbi

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQsy3PAAoJEIaOsuA1yqREgG8P/2PPQXMRjp1B68CzfUBdAjx0
TYaXmXkYs9NjmRiIp0axQwTFf04ffob4Gq7E5LEdLyc0Ae/kn3sII47c0sdBWTIV
hNDbM2RSsbqLsILXpQ250FnD0egR4ZGD1UJuys1Jp/l1u7Db1mxEAkmSAixAUCuy
xHNpOcaaSMBD5cch/5vqX3ICUtKrjVtLftMrnU7AkRVGS4qY9gJi8wWsMlW9GmqM
qqhwISP5q6FVtQWfEs5gsFmmj+byN8y1EJJKImnGglHuaR76UKuldv8XpxNqWGqZ
Hyrcqz/z5EawDjVJN6cs+odDVmhTZadWtK/tCVDnFYSvS7zfvQP+xFkNMI35uKmY
vLezg3AYSNb4U0m+t17xlxbaIMTHaZDzlavsHAR4RbPuSuscYp8KEx/sWLOcaFby
2YKdjuih9LE4GLJDB7oJBM6mP1XjOIyrcq7+d/toNoUh82QaMao1ivCBcnh40tGQ
PyKHLxmf+ZtYquknbnwwubACwdzbdgQm2rVHWwRG7L7Y6ntKZBz6ZuMqmE1KYruD
s8ePG3hsV1SnrAjRac7pX8ABi23zeEgX/jjMz4WmYA0XXJXjqQItHNqz2Oa5AdUN
op02EBQx8QgkFFZF7Ob4nJ/Ayr5aCVzbrC07DImSiM0Lj8H4lEvucYgmgZ0kME6S
cD1Huah2eFCfAPrEkbOg
=dCzQ
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
