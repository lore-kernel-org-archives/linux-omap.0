From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Tue, 4 Apr 2017 16:28:52 +0100
Message-ID: <20170404152852.4c7fkgtisrlqim7h@sirena.org.uk>
References: <20170322171052.7006-2-tony@atomide.com>
 <20170327174952.jsfleql654m2h45i@sirena.org.uk>
 <20170328003648.GS10760@atomide.com>
 <20170328151849.uvj2ljkbts4cwksq@sirena.org.uk>
 <20170328154740.GW10760@atomide.com>
 <20170328164911.xwwl3kdy6j2y7hfq@sirena.org.uk>
 <20170328171022.GZ10760@atomide.com>
 <20170404030300.GK10760@atomide.com>
 <20170404121957.v64jcx2k4w3mwtje@sirena.org.uk>
 <20170404135629.GN10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljkcuklux2fic2lb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404135629.GN10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--ljkcuklux2fic2lb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2017 at 06:56:30AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [170404 05:22]:

> > It is sadly far too common for people to implement interrupt controllers
> > that only do edge triggers, I've no idea why even on what are supposed
> > to be relatively high end SoCs.  It seems to be a hardware designer
> > thing, AFAICT they think for something to be useful it needs to be a bit
> > more complicated.

> For edge only GPIO controllers handling level interrupts might be
> somewhat fixable in software. The GPIO controller could have a loop
> reading of the GPIO line status in the interrupt handler and comparing
> it to the configured triggering.

Yeah, it's doable if annoying.

--ljkcuklux2fic2lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljju7QACgkQJNaLcl1U
h9BjCQf+NQ/G8K3gF8Ka5PasBac09duTow4czwHISDeawqBBeOh/ZV3CB8zt2f4a
pnJIzfoLsx1ktlI8aIw/2+HCe+7OmiIBmh0DgipFRZA2Bbmc4plplyrcCj7CsqXU
S0NA/TH/4yXPbxZsXSKxUctBmU/C+xwHY6tSgAy6/fqs0ztV8TZxf/26XOifcEpC
toV+/08jkJ0ahPTwPat1/xNMwAkW7MM6YH7GFBi89mQwoq1wFt2p8AvmIAqZZpNl
lSnq0XhBv7hsVpE7kfrPuDrrsqhOyIH1x/0ekdFKPMS5BchmI7OGG4Rf2f/DK5el
C3eB1c4G5JVvbRssmbWDYz5pQlb/Hg==
=Qqm8
-----END PGP SIGNATURE-----

--ljkcuklux2fic2lb--
