From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Setting OMAP DSS fck
Date: Fri, 02 Dec 2011 09:39:01 +0200
Message-ID: <1322811541.1867.29.camel@deskari>
References: <1322727382.16429.4.camel@deskari>
	 <alpine.DEB.2.00.1112011121220.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-+dY6nC0CJ0LXAuyl5ecU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45143 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745Ab1LBHjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 02:39:07 -0500
Received: by lagv3 with SMTP id v3so1118928lag.7
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 23:39:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112011121220.6289@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-+dY6nC0CJ0LXAuyl5ecU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-12-01 at 11:23 -0700, Paul Walmsley wrote:
> On Thu, 1 Dec 2011, Tomi Valkeinen wrote:
>=20
> > Why is it that the rate of DSS functional clock (dss_dss_clk on OMAP4)
> > cannot be set, but we need to get the parent of the fck, and set the
> > rate of that? The same is on OMAP3.
> >=20
> > From driver's perspective I think this only makes things more complex,
> > as the driver is not interested in the parent, only about the dss fck.
>=20
> Yeah, I agree.  We've talked about implementing rate changes that=20
> percolate up to some higher point in the clock tree, but have never gotte=
n=20
> around to it due to other, higher priorities.  And now the common clock=
=20
> discussion has reduced the desire to do much OMAP-specific implementation=
=20
> of this stuff.
>=20
> Another (related) problem is that the driver probably needs to know the=
=20
> ranges of the possible values that can be set.

That's true. The DSS driver has knowledge of the possible divider ranges
that the parent clock can use. Not very neat.

And note that the DSS driver needs to know about the possible dividers,
not the clock freq range. We need to get quite exact pixel clocks,
derived via some dividers, and we iterate through the dividers trying to
find a divider set that produces a pixel clock that is close to the
required one.

 Tomi


--=-+dY6nC0CJ0LXAuyl5ecU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO2ICVAAoJEPo9qoy8lh71s1UQALI8HZxC+9acYTBHzwhGgwyY
UZmib3ojdZCMhhDmaRspJe1ydcjdxYbylqF9wyk4wdMZbhHP3DQm1fUHHbrOxasi
43dNPdX0wChB+Q2zCdTBVCE8pXq5XRziytlEYdETQWYGbPHKXFUOl81gHl8zgMgs
5wWLS9m/Bd4t7+Fx4aBG8vYIaZ4pwMcYV2qL/6EhMa4wehrsv+aj/8FKEoJFg/Fu
zK4L/gGQ6miKg6jeeOlhkva3hGmTpoCOPeSerGkV7QkxNMxfIH7pzyYNYGebtm7w
rzSWPYYM9/CZYfn7mvFx86Sl81Hsro36Jh+G4iMy7uMSyFN/3HkWE9Zy2XHcY5ri
WFA0kRjhEkjFxsi7Q4imL7H19o2CssAQxmXOzkV5Ej0/GD2JHRRkq2I9Qk4vWi9J
S5Q2m6THX9a1ydyfM7uhYIYzY5LpKDC5jrTqpVj+bZTDWX1ShiAbR6vW/pHGtVDN
Dc6DDVSwtzyMK+bjXo1WnGtLqyIADMeSST7f+hjen+o7w9+JqZL5KB/YzGdGKYKb
VrES5IKU+9l6Dz75G3KzSardteQPqKMT9YPKehTYt4CPoBN7FMUMm7pMsWJbKFC9
MFKEw/i6Dzvl+QVyUEShZMzAsaUznMJOtWTEchn3cp0Ff4e0nHMU/r6NtRa6ZrHP
NLhkWrmPi810hFY9XqAX
=YcwH
-----END PGP SIGNATURE-----

--=-+dY6nC0CJ0LXAuyl5ecU--

