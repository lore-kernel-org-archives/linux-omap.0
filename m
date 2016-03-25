From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 16:19:54 +0000
Message-ID: <20160325161954.GA5028@sirena.org.uk>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
 <56F562B7.10107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56F562B7.10107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 06:09:27PM +0200, Ivaylo Dimitrov wrote:

> Ok, so you say that regulator framework should call twl4030reg_set_mode(),
> but it doesn't. If that is the case, then the bug is in the regulator
> framework, a similar one to what you've fixed in "regulator: core: Always
> flag voltage constraints as appliable".

What makes you claim that this is a bug in the framework?  Does anything
in the machine configuration say that changing the modes is allowed?

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9WUkAAoJECTWi3JdVIfQM6IH/1sMk+Q0Bagk2cct/Yp1QFoN
P7w97DRJFsWuNShaCiq4kT2cfcXZl7U7i+KvO+tzc8tROyvH9MbGgZDhY03DuF7T
kK5uBRGbMh/kQ4i96X/q8z0rUzsQTJFTA4ITCHrFbq3zD0rErdhZLiSIUYUO2RPu
J7SF/KbC2x3XeMOB1oMxbqmf1Gcr4FRewt8fC+2z2WLfj+CTZ7nn9XfxIY9YYgqt
RDjBHay9x4YYYrsomWObEyf0UTODxkfNbVO29ymMLgDrAlYcqCPOOL7NiCA7UOhw
W69p9UuvWKx8eG4j++K1O03wjjt+sG6E+rSJleXfQqfGU5FoRSGiL2WqC1NjK6I=
=J0Mn
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
