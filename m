From: Mark Brown <broonie@kernel.org>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 18:13:52 +0000
Message-ID: <20180115181352.GD12018@sirena.org.uk>
References: <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
 <20180115175220.GK4821@atomide.com>
 <20180115175626.GC12018@sirena.org.uk>
 <20180115180626.GL4821@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115180626.GL4821@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2018 at 10:06:26AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180115 17:56]:

> > Sorry, I didn't actually post it - just suggested adding the
> > snd_soc_codec_set_regmap() call.

> Oh I see. Yeah that seems like a good long term solution after
> the regressions are fixed.

I would like to see us do that sooner rather than later assuming it
addresses the issue, it's quicker and simpler.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpc718ACgkQJNaLcl1U
h9BBUQf8DqezfwnGz8RETF0L1a0vvig6SDFC5wLwprQwXWZhKb1cr3z202ck34JP
FWWtKvaxiiO1bKdSjPcvOwj705ANXINL70SxsoAskQZkxPUf+JtSH46yJ2hTJcdy
eCMPBNL5iJMOImFQRulDJMbnojREvAdhBQmMweARaYWFJwAdRo/x501Gx7hVACRX
NDyb4iM4PVS0ToUwmSIHqzMMemHEYvBampnhYSQx0EeJdPwpZoAlIqYX1xtkfwTn
miGElfoyjJDJZEx9G7ltFRHK7iB61QJgIiWBnTqAu0ZRrpVkSQAaOcwbXHzG/Kg9
HqNna8ON/ALkzSekn8ZLMTB00uaNmw==
=ZdfI
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
