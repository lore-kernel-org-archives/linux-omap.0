From: Felipe Balbi <balbi@ti.com>
Subject: Re: Crash in omap2430_musb_init()
Date: Wed, 18 Apr 2012 15:48:46 +0300
Message-ID: <20120418124842.GR13842@arwen.pp.htv.fi>
References: <1334751449.2027.18.camel@deskari>
 <20120418123108.GO13842@arwen.pp.htv.fi>
 <1334752778.2027.24.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8so8ZvRz607RvwFp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52440 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752021Ab2DRMts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 08:49:48 -0400
Received: by lagr15 with SMTP id r15so10802932lag.16
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 05:49:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334752778.2027.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org


--8so8ZvRz607RvwFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 03:39:38PM +0300, Tomi Valkeinen wrote:
> On Wed, 2012-04-18 at 15:31 +0300, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Wed, Apr 18, 2012 at 03:17:29PM +0300, Tomi Valkeinen wrote:
> > > Hi,
> > >=20
> > > I was updating my tree to latest rc from Linus, and noticed that ther=
e's
> > > a crash related to USB on omap4 blaze board. It happens on both Linus=
's
> > > master branch and v3.4-rc3.
>=20
> > please merge my fixes branch from my k.org tree
> > git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git and see if
> > you still have the same problem.
> >=20
> > There are a few fixes to musb which might solve this problem.
>=20
> I merged your master branch, and did a few boots. Seems to work fine,
> thanks.
>=20
> Are those headed for the next merge window or -rc?

those are for next -rc. They've already been merged by Greg into his
usb-linus branch so should be fixed on -rc4.

--=20
balbi

--8so8ZvRz607RvwFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjrgpAAoJEIaOsuA1yqREJxoP/ixrZ61v7fUDOFgckPJUxjYB
M8bbJue8fxVJ/+hQ7aAmJBxdrE18fqEDsJwyLJ/mg+O+HEOyolPLhUgYR8E03gvM
igfgoUFtieiN3IBIDFJ9HlqImzuFMamQ8hhY5DzZD5Vm4jFhtTbcOP4alg4YQZ5q
ayxgD0H/hqvAr4AxO5D/w/dli54v7Qgw+nwaI6rcP2dOikDZPP1UmAmFpa62K8Fx
a40DbrZI4O/29+14X04ytdum5rSyKqgOq254iclua3VplbSbodxavDGL3xlUhBAr
TGrVj7ypVGXFhnn/NNMQvOmZyqi+e/c3QHyr82yRVIJ5ZILdMtct3LvxfLzd7cRi
c1wtko+P9Lkg8EYWcka5YS/QEH0ZUuMIXnBj6h1xaQz54YeNe3jZkF4klF14O4lz
F1kDdT6x6/LCatjH7bxH3b9zzjwYKRWsZBD4gLsdizcBU6gwifzQi+4hLkmGJJ+S
mVDfFcZpe8nyseyVVk7bHqNzwSqtUNJPRVoJ4RuGfbCaVW++mZB2a8zA5I5YLx+9
K0T4icRmFJIU3XpHHDDYZXjEcifjGYuEDDwMWbV4/pLfABx43LPeJ0uSqUIB5fNu
WIzdrs2A8N+nGvk3jYz8b6H2N90HzRcgb/L7kprzhe1XNdEIKiJEKmFpoJk/aDNL
767FEUShBbXfIR42HU4g
=kPuT
-----END PGP SIGNATURE-----

--8so8ZvRz607RvwFp--
