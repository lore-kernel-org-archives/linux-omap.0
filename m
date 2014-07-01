From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Tue, 1 Jul 2014 14:47:04 -0500
Message-ID: <20140701194704.GG13396@saruman.home>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
 <20140617131935.GB9070@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51790 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757412AbaGATrl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2014 15:47:41 -0400
Content-Disposition: inline
In-Reply-To: <20140617131935.GB9070@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 08:19:35AM -0500, Felipe Balbi wrote:
> On Tue, Jun 17, 2014 at 04:04:51PM +0530, Sekhar Nori wrote:
> > ROM code on AM437x does not support writing to L2C-310 power control
> > register. The L2C driver, however, tries writing to this register for
> > all revisions >=3D r3p0.
> >=20
> > This leads to a warning dump on boot which leads most users to believe
> > that L2 cache is non-functional.
> >=20
> > Since the problem is understood, and cannot be addressed through softwa=
re,
> > replace the warning with a pr_info() while maintaining the WARN_ON() for
> > other truly unexpected scenarios.
> >=20
> > Reported-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>=20
> Tested with today's linux-next
> (5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) with am437x-sk, I can see
> that the WARNING goes away.
>=20
> Tested-by: Felipe Balbi <balbi@ti.com>

ping here, I can't see this patch onl linus/master or next/master yet.

--=20
balbi

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTsxA4AAoJEIaOsuA1yqRERtYQAIRZeuqCOIslgPUDTqszjr72
2wSOqLWPDpAYwiY4xeZXohT4HFE4xYean6jamRMTmAfSQZxgsLv87wVxb/NY6f6d
7KHvxdmP3cj5TwDTXEfPdvyttEm9KCVBUOqHxmQErOysSVvBZXAQEUomhoB7PRKW
VTRbLmN6zx22rdNGvf1CPwt1Dgj4clK7CUpBo7KkFCoOhCF5UiJCHoVqbEtlWamI
QOtx9v9gdhO0pwdLkZxFBBAUGHBBvCiQmkC9n4tmhjcCIHOYXgaKoYdefk0/p/jT
BoManc+hr9KmjJdWbOef2jhbLGlF7aBLdce4FgihAFzd0KM4liLKY2ZrbruGNOLR
IyWcYYS5muMGi7XA51nSOE6RWrMqd4Nbe67JcA24WAUbaktrBLQLzNexfVyXR3DG
WBktxtcP7SDbZZ81PYzeS+QhlOunU1wnmrGuoEt/H9oUsXnoHWaIwjfISrmSIRbg
ngFuMcS9Ya/QMCNxukY4oUKI3N7vFKkMeJW5p9zy4KNjUUsmwU9oyvRCLYmL+Hz8
jpOgGwa1+qkV0RUcNwslbjyx5qyHG7TlyffLYdEwzWBA6uj4tLJs7o9hNvVN9/oR
D8GB77WSiE7iIIyR282EjOENgyq5v+hP17cgO2bVLeX35zZ+pPZJAlQ3VHb0HdpR
xBhTt1Nfi7bxwGJ43TqO
=tUjO
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
