From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 30 Oct 2012 14:32:54 +0200
Message-ID: <20121030123254.GD29095@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43397 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab2J3MjA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 08:39:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 30, 2012 at 12:17:11PM +0000, Paul Walmsley wrote:
> On Mon, 29 Oct 2012, Felipe Balbi wrote:
>=20
> > that's too bad :-(
> >=20
> > Can you compile with:
> >=20
> > CONFIG_I2C_DEBUG_CORE=3Dy
> > CONFIG_I2C_DEBUG_ALGO=3Dy
> > CONFIG_I2C_DEBUG_BUS=3Dy
> > CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D9
> >=20
> > so that I can see all transfers ?
>=20
> Log is below.

that's working. It only helps to let me know we have a race somewhere,
and if it is what I'm thinking, the wmb() patch should help, but you
said it doesn't, right ?

without seeing debugging information on the failing case, it'll be very
difficult to sort this one out provided noone else seems to be able to
reproduce it.

--=20
balbi

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQj8j2AAoJEIaOsuA1yqREpFEQAKa5T/uC3MIfHR/vjXZza/mS
dUbKYOmdqGCLwQ5kHGMfBRP6YDIm+pFS8bJHpeONU6EmMyf875rhMjKR4Kogo0pd
5uHd2fM4cpKTRN7+kF/AfFV1BdkC/vmtJwnGfdadPaCo9xD40hvpd/fwFzztwkvz
3A+vTUprbtIqDepG3SbGcyS5HKHv25TxOt0v2mnTsACC8vD/GpPCGQfr+ZdE0TWy
9p7f5dXicqCBbY9DaaM5F6NpuP3q5nnBW45ilb6W0Xzx1o3tgl2mmaYalf/4FnU5
98vINFtfoHsqF53U01VWcEE834BmxsCun5joGNogT/z4dNSyjQoBGyGhhpbjF9Yn
ItEaNOVQRNzk+xvQI0sa5ScvGxOMcK76/nxmmEZCkhHkG8DubAelq7I8Y06zm24R
/M1yLGyrYFj5tEhAp2CQoWuJ3OIlI8sa4AZ7Lugp5QN0H+dFpMX66q77SvaFr5QE
aMjSzZaJwx7S0kjv81KUA6urLlxIUW6Imzfipj6xK82jS4JKE697aawvWAtd16sN
hZFbZ9zChsgqURnvze/HTQ8qHSsQWiyYGpu3XB92bxzUL9Pwp1sgIk647Z9sdRuU
3CgK8CI47cHU79jN6aqi0lmA2z3YrBXGI8yILTBhsQPLuHBW+gLdJDyAjHwLcWJD
Y5pdF2fruDbkoAPsON45
=TnZI
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
