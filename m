From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: Add system-clock-id DT parameter
 to dai nodes
Date: Tue, 24 Jun 2014 11:20:47 +0100
Message-ID: <20140624102047.GF23300@sirena.org.uk>
References: <cover.1402653217.git.jsarha@ti.com>
 <c0281e720e9ef2056d3460047cf5bc5e75684abf.1402653217.git.jsarha@ti.com>
 <20140621100959.GC5099@sirena.org.uk>
 <53A94BF8.4090808@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55470 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbaFXKVG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 06:21:06 -0400
Content-Disposition: inline
In-Reply-To: <53A94BF8.4090808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@TI.COM>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, peter.ujfalusi@TI.COM, liam.r.girdwood@linux.intel.com, detheridge@TI.COM


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2014 at 12:59:20PM +0300, Jyri Sarha wrote:

> I see, actually this is not something I would need anytime soon, but
> how about the previous "Add system-clock-direction DT parameter to dai
> nodes" patch?

> There is a clear common definitions for clock direction, so this should be
> ok, right?

> If the clock direction patch would go in I would not need to add more stuff
> to already quite messy davinci-evm driver.

Yeah, I'm still thinking about that one.  One thing I was wondering was
if we should agree a definition that's generic with the clock API but
then have an ASoC specific implementation for now until the clock API
gets further along.

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqVD8AAoJELSic+t+oim95UwP+wVcA9XTUk4whD3liAAJ5HkN
rWhvXSje+Whw3Nt+w0pCA8wCTIEPct4GvnFTTBQVnNLmVXyxzMWHhWuJjjk+Gt10
Mz84onZFbst2xo5max36E/QuTwrklMCksIUIFGLUXIEjk8lZeE81LHJ9eJcp0R3D
smbbHh7G5KSpRIHdczaZzV0U8XnJaAk4c0xA+QSh8Alm1VDJhDwPYVQBnro1QfhG
DEJACQdXt/g6Vi9RylR//61OLXo6JDK5RmjrkZybciMB3JRdCD8M384Tx+8Setr1
S0fGm7L5dsBtdfilkZAAz1DAkFZ+7lZnqbteyjS7FrUkn1vWMmVxsyxqXvM4XLUs
T7fCIGmaeL4PT7RJGG1IJk+iZIwPYW1S5Y+/wz934dpSjaZp6Ed9p2KUAcf15Ilp
DszRl5hqo0QjAwXiLQWcEyf7to14LCu/RhWLgxBhTYOfP5xLDRl8PfPa75dn+2fl
upTrA9HkIV3h6iwsalVob9H9DjwwmIigWq01ZwERf/OjzGS6Fx7PUAPbPF4wZpq4
BXC+vAnK0edLXKWVfsm+HOan+8WUkTu8QdJcluy8PtK9aqVcWqlTm8cdWVUj/Ksm
9WNIx/1mYxYHGjwJ7sPg0J2fWwNP3AVn2WTUuyPAaK6fIb18+CYJS7H5fxpy2f99
Q/0DqRCJut6cYXzDsgp5
=Bzkl
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
