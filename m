From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 22:28:18 +0000
Message-ID: <20160325222818.GF5028@sirena.org.uk>
References: <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
 <56F562B7.10107@gmail.com>
 <20160325161954.GA5028@sirena.org.uk>
 <56F56C4A.7070502@gmail.com>
 <20160325170558.GB5028@sirena.org.uk>
 <56F573E5.6030408@gmail.com>
 <20160325182017.GE5028@sirena.org.uk>
 <20160325201911.GA25471@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160325201911.GA25471@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 09:19:12PM +0100, Sebastian Reichel wrote:
> On Fri, Mar 25, 2016 at 06:20:17PM +0000, Mark Brown wrote:

> > Then there is a constraint that the regulators must be in normal mode
> > and this needs to be expressed in the machine constraints.

> As in adding "regulator-initial-mode = <TWL4030_OPMODE_NORMAL>;" to
> the regulator's DT node (and providing an of_map_mode method in the
> twl-regulator driver)?

Yes, that sounds like a sensible way to do it.

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9buBAAoJECTWi3JdVIfQny4H/3kpIpFvlhTYvWG4q+YT/3fB
BC0v7thsUCCjf5eYu2UbuaIi9Z+SdKctSaq1QpOkdJi2dYLSnwZfBm9w4UN+MYqb
U7WwZTO6Ma4s55hmN6btj64s8JUtQ51LMfThvZ5kV+9wRGwZOwszO6s2gpkHL/Ku
FQhd9e+2m4+9wtesP7PLdzKzqhkU4k0UQKNVVFxQDJV9GgxwIU+UR9sLp8c2FrnJ
jxz/YwVcSM5YzFxlNE3ZiiDJBIh1+Cgd+LRLaN8Q5aB9qLSZqegO52Ekd1R7YFqo
zOt2ke+7prmQfsQxLeNf69XnTcW2HF5wlP1mo1Thv0zmRYDDe6P46ZmrGhuG15w=
=W6OM
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
