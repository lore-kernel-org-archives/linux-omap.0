From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 1/7] ASoC: omap: Introduce the
 generic_dmaengine_pcm based sdma-pcm
Date: Mon, 30 Apr 2018 12:55:15 +0200
Message-ID: <20180430105515.qkxs5zousf5llveb@earth.universe>
References: <20180430065748.3393-1-peter.ujfalusi@ti.com>
 <20180430065748.3393-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1092327200113253135=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430065748.3393-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org


--===============1092327200113253135==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="teoqndw5wfuboffv"
Content-Disposition: inline


--teoqndw5wfuboffv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Apr 30, 2018 at 09:57:42AM +0300, Peter Ujfalusi wrote:
> [...]
> diff --git a/sound/soc/omap/sdma-pcm.h b/sound/soc/omap/sdma-pcm.h
> new file mode 100644
> index 000000000000..ce13edfc52d8
> --- /dev/null
> +++ b/sound/soc/omap/sdma-pcm.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +
> +#ifndef __SDMA_PCM_H__
> +#define __SDMA_PCM_H__
> +
> +#if IS_ENABLED(CONFIG_SND_SDMA_SOC)
> +int sdma_pcm_platform_register(struct device *dev,
> +			       char *txdmachan, char *rxdmachan);
> +#else
> +static inline int sdma_pcm_platform_register(struct device *dev,
> +					     char *txdmachan, char *rxdmachan)
> +{
> +	return 0;

I would expect some error code instead?

> +}
> +#endif /* CONFIG_SND_SDMA_SOC */
> +
> +#endif /* __SDMA_PCM_H__ */

-- Sebastian

--teoqndw5wfuboffv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrm9hAACgkQ2O7X88g7
+poJeRAAm7+xR99I8dkelJcvAoNThn7/hwn4z8DlQ6Jo9tyh5IEcGV1OQ0uqOn4I
2bdtZga07jCKLF48I5U7Y3CvwKPZOB2l+5SNnXLV3cTqmOLC/ePHHIcoZhslNEL5
TfeGNCj/smdqLggSBszi0p5LMVcZSpbE8Of/wNnsfyc9P3P/m+vRZ1rAw+I/Kn9a
Cp1wcu3RLXHIetLtpxAKQgjXcGxwQ89qKQQtAAC0Iw03z+UqcbB+SnIZOmh9b3+J
l35JeiMhIHgxhV1TSx/uRh76/IBRMjUqTqteOyXRsXuJV8/WjnuNkhWYvPZSsWLX
m/qzJs3C1F2p9CUXUZrLyd0Mjf0/DQP/ThWtrVfbDfSazpPaZw2XafuHvn+ePUas
bxneKIZhe6bkL0jOpmpjQuj9z8iVADE/rZpwtm3MSq2rwOa+12Jv+6akDXSoLIW8
rdyEJZZGW4C3UJ7ynyNVteDGG8cMxMQrR+PqjTpFSLsF5RwmRemLsv8zYYKPjYQ5
CZSMkzdGnAem+hiq0iNMzW/KxzQ8TY4vp47dLXX6emlyqufBcLKfwOF4T0OIolJe
3bHCeiyuapHfCePcXZ4mKssy+DaoRBdSNEr7pHuuyex+umy3gaFVsHIPf1UlV2BB
cb2gD9HPsDr9Cl12q4HENL/uurseLffyhgwFoQJ3Q5PMJjqOdtU=
=l+QJ
-----END PGP SIGNATURE-----

--teoqndw5wfuboffv--

--===============1092327200113253135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1092327200113253135==--
