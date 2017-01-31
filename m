From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: palmas-regulator: constify regulator_ops
 structure
Date: Tue, 31 Jan 2017 20:56:44 +0000
Message-ID: <20170131205644.mu7f5mbtfyzlurs6@sirena.org.uk>
References: <1485615235-30571-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="datpzud4tfhb5wsy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485615235-30571-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--datpzud4tfhb5wsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 28, 2017 at 08:23:55PM +0530, Bhumika Goyal wrote:
> Declare regulator_ops structure as const as it is only stored in the ops
> field of a regulator_desc structure. This field is of type const, so
> regulator_ops structures having this property can be made const too.

Please submit patches using subject lines reflecting the style for the
subsystem (this applies to a large proportion of the patches you've
sent here).  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--datpzud4tfhb5wsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliQ+gwACgkQJNaLcl1U
h9CagQf/WoYfc/tzu2EltU+B+Sn1FGappGOG8xyAZ23Y58oUkPauRoE536eM9rvL
oElf7SwksnBZpzCSL9uBDR4T44DimrMy6y/C8dTLlsxyesCmE4SWlz457yr+NLkJ
CdtJ4EIU2IL4uLDUsoEl1yKSlY3PWKVx4RHbo/AY7rjCbIdBKHF8AwZIno5HVVRb
/rLeucs9EU5s76g3VAhmI28wmVdylUOW/QgA3iyFoQ1EAYZdbVAJU8V0D80ZF7rF
/sjYbIrOkYdxj45/zuZ2ANhUKZEy2mockC6mPjhn2QtedrS1MyYiidPnZGD8dRRg
Z3nicWMH1xOD2anL84enTbKYXjq2QQ==
=ah69
-----END PGP SIGNATURE-----

--datpzud4tfhb5wsy--
