From: Mark Brown <broonie@kernel.org>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 22:59:47 +0000
Message-ID: <20180112225947.GL21458@sirena.org.uk>
References: <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112224959.GH4821@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 02:49:59PM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180112 22:11]:

> > Most devices have one regmap per device which can be retrieved with
> > dev_get_regmap(), it's the attempt to use that which I suspect is
> > broken.  Like I said snd_soc_codec_init_regmap() ought to fix things if
> > that's the issue.

> OK. Adding Peter to loop as it's his driver after all. Not sure
> how well mixing regmap register access to the same module with
> cached twl4030_read() would work :)

Yes, that local cache is not a super good idea any more and hopefully
redundant.

> Maybe there should also be some big warning happening if
> snd_soc_codec_init_regmap() is now needed and no regmap is
> found?

Some devices just plain don't have registers at all (perhaps GPIOs or
just stub drivers providing capability information).  However we should
be screaming loudly about the fact that the I/O we tried to do fails,
that clearly shouldn't be being ignored.

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZPeIACgkQJNaLcl1U
h9DNrAf/ZTs0wvQ8iNnbUtge8Hk5+1xR+Dh9TXdV59H9RvwcYrEE5T6ASWTCr+bS
yGFTCzttq7BJMmYkbHI/iI7PzzsFybfNy+AggOHpYW0xE4dhlKnYSmjwE7Owby0I
X0Zk2eouM/ojZETL5T0MUm27aIj9+RF1slL2QWcCY1jMfh5VHgKiEoYi+5l5unuf
F/fclbtEy3N2NoptyBTWXHvQ1WBVrhRmO8l7Rswz1cHsjAIN6OboaiZuQkCpAk7y
cstSKL/He5ahslWoWlTn5adfdlQzgOoYaM2OSlj4+F/4hAPqsMZMjyeicaEv8mFD
un7icyPCd6E/pugfOHsLWRKh6jLi3Q==
=FiTc
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
