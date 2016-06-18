From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: tpa6130a2: Add support for multiple instances
Date: Sat, 18 Jun 2016 12:40:38 +0200
Message-ID: <20160618104038.GB31665@earth>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1466218805.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com
List-Id: linux-omap@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 18, 2016 at 12:26:27AM -0300, Helen Koike wrote:
> The current tpa6130a2 driver supports only a single instance.
> This patch series add support for multiple instances by removing
> the global variable that holds the instance. This is performed by
> using the component API, regmap, the snd_soc_{info,put,get}_volsw
> API and DAPM.

yay! *stroking cleanup of the driver from my todo list*

> This patch series also touches code from the Nokia RX51 which I
> didn't tested (as I am testing the tpa6130a2 in another board, that
> is not upstream). I would appreciate is if someone who possesses
> the Nokia RX51 (n900) could please test the code.

I had a look at the rx51 parts and will test later/tomorrow.
=46rom looking at the source code: You can also remove the
"../codecs/tpa6130a2.h" include from rx51.c.

> This patch series is based on git://git.kernel.org/pub/scm/linux/kernel/g=
it/broonie/sound.git for-next
> Available at https://git.collabora.com/cgit/user/koike/linux.git/log/?h=
=3Dsound/review/tpa6130a2
>=20
> Helen Koike (4):
>   ASoC: tpa6130a2: Register component
>   ASoC: tap6130a2: Use regmap
>   ASoC: tpa6130a2: Use snd soc volsw functions
>   ASoC: tpa6130a2: Add DAPM support
>=20
>  sound/soc/codecs/tpa6130a2.c | 382 ++++++++++++-------------------------=
------
>  sound/soc/codecs/tpa6130a2.h |  14 +-
>  sound/soc/omap/rx51.c        |  45 ++---
>  3 files changed, 130 insertions(+), 311 deletions(-)

nice stats :)

-- Sebastian

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZSUjAAoJENju1/PIO/qam3IP/1m/wVEaBe2E0FQQibN9ytaV
aJlo1vcyC+1p2hKRg+arNHTEBTAQkls3yAzKurhN3YUfvrvpCgw5YInUZgWi/btc
mhvZsTjgs6iMrq1gmWOh3LmvLNbXCbmz1E20gFYVMlEfC3zKAb8bvZ/qgiiAN65N
WnN07pw08o8tGTbTlw77Aktj/9vYjtMQMSqCnrUNFFTKsltZGBS1jFwx5vY2yQJN
0yZg09l9Jac2t4R0xGJ4r3dSfnxQozydji7zM6DX00uUX4hvCsllVOx0qdwNtnKq
BSMQUWcVtfvspOVMhz0j7kaoZGOWNrLYNjTMNCGZi52BCHRkuWRsHg5MX7oxIjab
ahTG+EFMgMM0VfK4mhjaG7VWAaBSEn+D2fXZ0hpdlpZ9bcYgiQjlr+X7qGCwNs0t
Ubiq/2b8NnPxhQ+5p4kp2N4mOJsMOsarzzTUKeW46x3FoEe00EePVH8L2xhDzRxx
VNIshJ9ecHdESCmzIwJFmOkS6HJpXWPWIgn8FxsW0YveWGjHa4MGLIvCh8SdU/VX
2f9Hg241wDildf3pfhMkIuwnV1LI9CmtdaSuGcAH4xLwGGC6nPfHzvVUEehG/ewO
4CZQye8kDSKven4s5yp6/4bbTx+EMaITDp7m9NRjKKtq0e6cGXCjBhG7q5Vmxjco
hp0W9aGydvqMatH4Fwg/
=z4RN
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
