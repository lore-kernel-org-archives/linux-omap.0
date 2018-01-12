From: Mark Brown <broonie@kernel.org>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 21:38:45 +0000
Message-ID: <20180112213845.GJ21458@sirena.org.uk>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112210706.GE4821@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 01:07:06PM -0800, Tony Lindgren wrote:

> Tturns out just adding back .read = twl4030_read fixes it..
> I added a dummy function for read and am now seeing a bunch
> of reads that now don't happen:

What's supposed to happen here is that you end up with a
component->regmap set and snd_soc_component_read() uses that to do the
read.  That normally gets retrieved via dev_get_regmap() but it looks
like this is broken here by the rather novel chip design confusing the
assumptions that code makes.  I *think* that setting the regmap to
twl_get_regmap(TWL4030_MODULE_AUDIO_VOICE) using
snd_soc_codec_init_regmap() in twl4030_soc_probe ought to do the trick
(assuming my guesses about what's going on are right) but can't test.

I'd check twl6040 too, I bet it's got the same issue.

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZKuQACgkQJNaLcl1U
h9D4lAf/cYMwmOYd4r9YlB1Q6+2IX5bDKu8oiy4GcFafUU2Qti7H/bnKiz5HxNBU
rIGaQlpN91h2t1XM+hchOx9PthoPQwv5S9OUWtOW9xxwWwlQcBxbZC/b8XB2sbch
JQwMXIe8nuK2U2gqu/GdB0bEhtIdGKamxJM0+PCzKYYCLcrEnjl3jpM/XZx4Bico
zBklJ9pR9/8CncQZEKU5aenmlaTMxwkcehoyOMEtAriBLdSL5ztElEcN//x9Vh+y
bTqjc4RSQI4/+wrvJrbi6uajimSrx6tLQvpxQsMiCWfFgkRUiWLflqEwlPio+Md3
JfLBxbwicV/xEO3eBnUGqqiCluUodw==
=YEIJ
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
