From: Mark Brown <broonie@kernel.org>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 22:11:26 +0000
Message-ID: <20180112221126.GK21458@sirena.org.uk>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112215010.GG4821@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 01:50:10PM -0800, Tony Lindgren wrote:

> > I rather suspect someone would've noticed by now TBH - I suspect this is
> > more likely to be an issue with the rather baroque code that the TWL
> > drivers have possibly coupled with the whole multiple I2C devices issue.

> Hmm these calls are in sound/soc/soc-core.c though? But yeah, sure
> it could be some legacy code issue somewhere..

Most devices have one regmap per device which can be retrieved with
dev_get_regmap(), it's the attempt to use that which I suspect is
broken.  Like I said snd_soc_codec_init_regmap() ought to fix things if
that's the issue.

> sound/soc/codecs/cx20442.c
> sound/soc/codecs/tlv320dac33.c
> sound/soc/codecs/twl4030.c
> sound/soc/codecs/twl6040.c
> sound/soc/codecs/uda1380.c
> sound/soc/fsl/fsl_ssi.c

> Can you confirm that some of these are still working?

Most of the non-TWL ones have no active users I'm aware of but fsl_ssi.c
is under active development at the minute, one series was getting some
successful testing earlier today so if it's broken I'd hope someone
would have noticed although since it doesn't use DAPM or anything
snd_soc_read()/write() will never get used.  cx20442 was only in a
single archaic consumer product, uda1380 has been legacy since before I
was ever involved in ASoC.

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZMo4ACgkQJNaLcl1U
h9B60wf9F8Ya1rKVRZh7aP5fg1Su4XhnY4Uz39adyxEuyLLQUxW+59dRrsLWqToz
cLwUzhwTaip8MCDHBbjg5SWNCss0/Gi1Yw2Y+PW5PjUOcgC1YbbFvSnmVRKu0vm1
Tzh0sLAJAoGNoB3jxWoO7/VxzFjASuTX5ExMiUcFJX/ft1a/lzgwzPZNe2gxiC4v
cXj0cVsYb6DxzTMF5U2FotYdhF2EEE8wsMY40mEu3Xg2tHa/qr4+bO98BpmQ2Zwz
6GSx/znDqEfVmM+1SuZrLPeB844GaQAyRJ32Ylh53Co8w4eru8GV3jTAq46iYW/s
1p4ORxnCY2Iz8+qwLBJdMKPDY1NBmQ==
=gJxE
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
