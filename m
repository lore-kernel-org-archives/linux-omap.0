From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: constify regulator_ops structures
Date: Thu, 26 Jan 2017 12:37:46 +0000
Message-ID: <20170126123746.r5rzt6tcvktei4ti@sirena.org.uk>
References: <1485427668-2816-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kpzb76ib22gwzhvp"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485427668-2816-1-git-send-email-bhumirks@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, lgirdwood@gmail.com, michael.hennerich@analog.com, wens@csie.org, cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com, javier@osg.samsung.com, tony@atomide.com, sbkim73@samsung.com, liviu.dudau@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--kpzb76ib22gwzhvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2017 at 04:17:48PM +0530, Bhumika Goyal wrote:
> Declare regulator_ops structures as const as they are only stored in the
> ops field of a regulator_desc structure. This field is of type const, so
> regulator_ops structures having this property can be made const too.

Please split this up into a series of per driver changes, it'll be much
easier to both review and apply.  Right now the patch is very big and as
the 0day bot found it's going to be very prone to conflicts.

--kpzb76ib22gwzhvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliJ7ZkACgkQJNaLcl1U
h9BxKwf/Yd5ZcYhzTvUSICF8mSktQRFuhS74bdyznpFQBWMC3CGj9GiFcjxkkS4j
zbuWH3fMDlFI6lC0hVtTl6PgciGMv9OdvR3vJWubOc1vyfc7JQqurQ6URrnYpTdU
THK+ycdfZopx5U0FE6+AZHurxUwdk7lOyuOxqNpcVSmYy52O4GDWnAnDCVgXtOYG
Y0cACTd5mDiiWvNkxAjXvJKf/gKKLt8lJVugkf94Cpt/n3KOj9EE+M3+vp42OLx5
0DA0RZ/BBCXzQHQCbRZy0kWdh4c1aeyP9l4sMmmFPAXVGvZsKdJSjNeEZUJaImrS
QUKj4K15u2f7p4ytBVMeV+jnP6DJHQ==
=udfA
-----END PGP SIGNATURE-----

--kpzb76ib22gwzhvp--
