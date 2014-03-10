From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
Date: Mon, 10 Mar 2014 18:01:31 +0000
Message-ID: <20140310180131.GZ28112@sirena.org.uk>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
 <20140224015826.GU25940@sirena.org.uk>
 <530B594F.2030500@ti.com>
 <20140303035426.GC2411@sirena.org.uk>
 <531DF250.5060100@ti.com>
 <20140310172221.GT28112@sirena.org.uk>
 <531DF931.1060108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I+BhFrIa1PqbPgjZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <531DF931.1060108@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mike Turquette <mturquette@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--I+BhFrIa1PqbPgjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 12:41:05PM -0500, Nishanth Menon wrote:

> The only other options are:
> a) Abstract it at a higher level at "user drivers", since they are
> aware of the sequencing needs - but this partially defeats the
> purpose, unless ofcourse, we do a tricky implementation such as:
> clk a, b, c -> prenotifiers in a, postnotifiers in c (which as you
> mentioned is a little trickier to get right).
> b) introduce a higher level generic dvfs function[1] which does not
> seem very attractive either.

> Any other suggestions other than limiting the usage(and documenting it
> so) and hoping for a future evolution to take this into consideration?

Something might be doable with telling the clock API about maintianing
ratios between clocks?  I do think we should have an idea where we'd go
with such requirements, even if we don't currently handle it, so that we
can hopefully avoid another round of refactoring everything but it
doesn't seem 100% essential, just very nice to have.

--I+BhFrIa1PqbPgjZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHf33AAoJELSic+t+oim9/6QP/2odPUWGIgXosNZfH2GNRbiQ
J6ulkJwzX7zPK+Cwy3lbBYQZNsH82jpSCurGxqafuh6bjtECt8YNzo4UfPdLYKsZ
qg+A/Atb9zc6nsoEpQKm8YSt0+4bStKRv0cPeLrs4rjQqwYFVA7mEkibruAGx+d0
wd98I5o6RQsGW+jQzoL1SNyjhfeKBcV3YVGafbst5tgQh9ZCDwd4n38Tz+8k+gV/
MymCEHtzwyQ7wckkFV0L745RcEhHlhE3qOz0bWrjajmpP+VFz91tdbp0y7OZRSig
I0oR8tIYgtR1T59HkQI/N/PUziKVyluzt4GnvGxU4pNLvnbh34h560YD+QLh8cSC
Ui9rdSz9GkU1Sg/d6KgOoSOLG6LE1uqckGjVj3oXbSOv++LxzoXt7OCLZpyPm8+e
5DMtaOPTX4K4+edhF/YWPJEp2pVvcMJRGL/rLsTV+kOWZbzXX4B+QOEoSPTReOTI
nX8tYfAisnrKNknFIrQEHVsE+qZs2kbcQdX3FtipB1qigyEFCZihbYYX1lSFMmZM
QkCj9QKFBUw5izkE9oJ0xnURL5Isp4zuIvFUOwMD11qpliEl813y224Uggf+pp8s
4xCKPHhliSub3SA7V8gHRbVYZdyRkxwXU4lqWFAsQ3tuHDXsdoj6xZ1/0ZxyUWXe
yWkXPF7zabNpvRgqbGDp
=kAS+
-----END PGP SIGNATURE-----

--I+BhFrIa1PqbPgjZ--
