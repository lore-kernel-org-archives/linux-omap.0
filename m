From: Mark Brown <broonie@kernel.org>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 31 Dec 2014 18:52:37 +0000
Message-ID: <20141231185237.GO11764@sirena.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk>
 <5491F0B6.4090904@ti.com>
 <20141218101618.GJ11502@n2100.arm.linux.org.uk>
 <20141218114949.GY11764@sirena.org.uk>
 <54A4016E.3000300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EF0uX7F5rLgxVc32"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57208 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaLaSwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Dec 2014 13:52:55 -0500
Content-Disposition: inline
In-Reply-To: <54A4016E.3000300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>


--EF0uX7F5rLgxVc32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 31, 2014 at 04:00:14PM +0200, Peter Ujfalusi wrote:
> On 12/18/2014 01:49 PM, Mark Brown wrote:

> > Right, spot on - I'll send a revert for that upstream.  Thanks for
> > tracking this down.

> Mark, can you send the e3b1e6a19e09877b91517dfe304a2b3f6b2138fc (found it in
> linux-next) for 3.19 if it not yet done? With that applied mainline boots up
> on my Blaze.

Already done.

--EF0uX7F5rLgxVc32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpEX1AAoJECTWi3JdVIfQ+UYH/0Ar7V262iZgAUSJX/+kWj0h
AVeG1HRen/3ihpRlsM9epj+pjECl58bhQWhqa4grG1p/YuWNBBseHWd9mZzSoPsC
Ygmehq3E72t/YI9gocsc6x7aL9cVkQpLPy8FUekZlGGTkrUWRW2M82u1CFZFRU3n
p7xBsFLA4Uzpcta5skAiU8E2tb1eOWPN1iHhwZDF38xaNUckebc0Z9FrUT9N74cJ
6UK1Hny+JfaeBmo4+aJF43+SQqWcCRUvqsFlEZJdMuv9Pt801XMQ5ofhmYZNHDaX
ga3DVsGHjqaKzPRMwfzMUX4AqW0ythwR4b8YGjcuCwB3qZe6CLmJ2nuyJWdXIPQ=
=JpsS
-----END PGP SIGNATURE-----

--EF0uX7F5rLgxVc32--
