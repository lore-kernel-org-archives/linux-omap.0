From: Mark Brown <broonie@kernel.org>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 17:19:17 +0000
Message-ID: <20180115171917.GB12018@sirena.org.uk>
References: <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115165050.GJ4821@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2018 at 08:50:51AM -0800, Tony Lindgren wrote:
> * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [180115 01:46]:

> > I hope your driver will be OK by using regmap.
> > In worst case, we can back .read/.write, but it will be component driver side.

> Well we have the merge window about to open in a week, so
> please just revert the known broken patches.

Did anyone actually try testing the fix I posted yet?

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpc4pQACgkQJNaLcl1U
h9BkcAf9Fe8qt2s9ioqJMRDWPnOpV1y3qh/xkGzRBS+uycYKw5uH27xZJRhDfC2X
Cn3ir3+px6iaZmB2NtSdNZrxJ4rDyKbtcopm/8EE3EiW/g4sccnZxCaHmNjmPbwd
2VMkBOl6621mRFgSuaMbi/X9dgLM0/AyeKHofYuel4kO7sZQ7Fozd+4+yYDaNjCv
mNZHW1vnEbXkc9WeLRqdHrrj1CKK4IWhvdtyTMnos0DrSPR7ck4m8qy9BHKdTbvI
Deh3z8a5RngL8NWfb8ckGVm2NKcSz81YiLbRg83fE4gBWVUnGoHb5oX1sMswrUhv
YlAB5x7GDBqiNo1lhBvfw0bIxp06ww==
=zMDt
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
