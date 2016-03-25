From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 11:17:57 +0000
Message-ID: <20160325111757.GC2566@sirena.org.uk>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BceBnVuwEyzVYMuN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--BceBnVuwEyzVYMuN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 09:22:36PM +0200, Ivaylo Dimitrov wrote:

> Assigning a device group to a regulator does not change its state. To
> change the state of a regulator a message over the powerbus is required.
> Also, the check for the current state of a regulator should not count on
> a device group being assigned, but on the current resource state.

How did this driver ever work then?  It sounds like there must be
something else going on here.

--BceBnVuwEyzVYMuN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9R5kAAoJECTWi3JdVIfQ2dgH/35Zl87OjSMC/HQWTuYddiEE
JxfUncD2AM8jJK2+9z5vpOztxtz1AB82KLWg8RwjUtsMaDr6WCdIs/LcjsRG6Slx
Q4s+uz0i5zU/sXGz/mwwvLq6Eq0C1xltj6lJ5n0F6ZOC4L4697bRNn5L6G51j3Vd
2AXX/9UqR72PVmzHGdE+xAVPOYzhLXPhSVtgLv+qEy5WmiF2/GBQHSKg0aVJ/v1Q
a9/Zv6b3q6YMKlhUjcBH374aR1CjpIB6Mh3AtUf+Mq191bLbv2uVxKLEKFgTqQj2
IxtZTtqLnv4OClJkQsklxzKqiYuT3+EE4+U8LiGt72Niai1S6m4sHmOuFwWZkyE=
=/Vos
-----END PGP SIGNATURE-----

--BceBnVuwEyzVYMuN--
