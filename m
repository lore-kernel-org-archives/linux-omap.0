From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040
 dependency, again
Date: Wed, 20 May 2015 19:06:36 +0100
Message-ID: <20150520180636.GK21577@sirena.org.uk>
References: <3413182.qcoNiOhonF@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3413182.qcoNiOhonF@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2015 at 02:47:32PM +0200, Arnd Bergmann wrote:
> I tried to fix this before and submitted a working patch, but after
> some discussion we came up with what seemed to be a nicer solution,
> resulting in commit 3d4cf65e2d ("ASoC: omap: fix up
> SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency"). Unfortunately, that
> version was incomplete, and we still get this build error:

Applied, thanks.

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXM0sAAoJECTWi3JdVIfQNNUH/1rskV4DSNYxSAmBID6bYuSg
SP08jIS1KN3Z3KW8rvTjw03DWl6SI40dySKZa+1gMJ8omn7Jpsa9VorfjBMQgRnZ
LjeoGuJVCa1x647sglYqpIgWxnRcGsVqzECBOcmIQnEiYIWwFcBVV4Jmeh218NgF
n/3/cwNC12fO+YIkhtoraxvBgcVjNWk60d2JaLUR/h0FGlyw+6fZTHr2PUxuDJAe
HcoBXQzdoahj8+63VrelM6RpUS+O7pX0Ivu+ILHEy8rDqr8zitRuz7n6SoDcz30i
xIhGUmAoet8QCIhFjFjH3nhXNDthlJpCqWVVUnJjeb9X24CrCER91kOAGVACLhQ=
=mhao
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
