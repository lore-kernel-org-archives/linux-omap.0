From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Tue, 28 Mar 2017 17:49:11 +0100
Message-ID: <20170328164911.xwwl3kdy6j2y7hfq@sirena.org.uk>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-2-tony@atomide.com>
 <20170327174952.jsfleql654m2h45i@sirena.org.uk>
 <20170328003648.GS10760@atomide.com>
 <20170328151849.uvj2ljkbts4cwksq@sirena.org.uk>
 <20170328154740.GW10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="233epqgljhaie6c2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328154740.GW10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--233epqgljhaie6c2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 28, 2017 at 08:47:41AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [170328 08:21]:

> > Right, my thinking here is that by pushing into genirq we minimise the
> > need even further since it'll also be available to drivers not using
> > regmap-irq.

> > > like, handle until we get IRQ_NONE? :)

> > Well, that's what the per driver emulation does so...  yeah.  Probably
> > with an upper limit on the number of times we do that.

> OK let's first see how that would work. I'll send a patch
> for that.

Thanks.  Can you keep me on the CC please?  It's something I keep
thinking about looking at myself.

--233epqgljhaie6c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljalAcACgkQJNaLcl1U
h9CX+Af7BAFnKCEit4OGgQjoud0mpjEoXb2u9Z4AWz/kSHb3dDiGGI8O2XFRnNRi
rIINAqqv7sTNtrsdSmV78dRtM3PfTODys1tnrufXNVHBWfy3up9iqM68Cx15xte/
7JGjhtWdk2yZlW2Nq8IGurmh8TwERkynMLZ9zPgHC0OnlROfyPf2GbR2eAbNtbKP
N+f0tghHSksXg3z3885ownmlLhaHYkBv48pAxmJYyVqI6hYvWdJf4kxbkDJl7/wA
7RIwsFGnvTlVhzmI/IwX1X88iNlVS503D556fE++uz+XRrQBWsBBlJGBZCVZcldr
8FHdq67GWiR+2rRub4zKq8bd43RPyQ==
=nAgO
-----END PGP SIGNATURE-----

--233epqgljhaie6c2--
