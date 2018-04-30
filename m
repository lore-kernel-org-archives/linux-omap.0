From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 1/7] ASoC: omap: Introduce the
 generic_dmaengine_pcm based sdma-pcm
Date: Mon, 30 Apr 2018 13:39:00 +0200
Message-ID: <20180430113900.3vdarclqfvkm66ym@earth.universe>
References: <20180430065748.3393-1-peter.ujfalusi@ti.com>
 <20180430065748.3393-2-peter.ujfalusi@ti.com>
 <20180430105515.qkxs5zousf5llveb@earth.universe>
 <e2368ce9-9bbc-15c7-1a62-94ce505cdbe6@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0499866082994130632=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <e2368ce9-9bbc-15c7-1a62-94ce505cdbe6@ti.com>
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


--===============0499866082994130632==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxbgjxn32ze75abq"
Content-Disposition: inline


--uxbgjxn32ze75abq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 30, 2018 at 02:05:06PM +0300, Peter Ujfalusi wrote:
> On 2018-04-30 13:55, Sebastian Reichel wrote:
> > On Mon, Apr 30, 2018 at 09:57:42AM +0300, Peter Ujfalusi wrote:
> >> [...]
> >> diff --git a/sound/soc/omap/sdma-pcm.h b/sound/soc/omap/sdma-pcm.h
> >> new file mode 100644
> >> index 000000000000..ce13edfc52d8
> >> --- /dev/null
> >> +++ b/sound/soc/omap/sdma-pcm.h
> >> @@ -0,0 +1,21 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti=
=2Ecom
> >> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> + */
> >> +
> >> +#ifndef __SDMA_PCM_H__
> >> +#define __SDMA_PCM_H__
> >> +
> >> +#if IS_ENABLED(CONFIG_SND_SDMA_SOC)
> >> +int sdma_pcm_platform_register(struct device *dev,
> >> +			       char *txdmachan, char *rxdmachan);
> >> +#else
> >> +static inline int sdma_pcm_platform_register(struct device *dev,
> >> +					     char *txdmachan, char *rxdmachan)
> >> +{
> >> +	return 0;
> >=20
> > I would expect some error code instead?
>=20
> Yeah, it could return -ENODEV.

I think it should. Returning success without providing the intended
functionality is bad API design.

> It is there so the McASP can be compiled for daVinci/am335x/am43xx where
> we do not have sDMA, only EDMA.

Are you sure, that you need the stub at all? Looking at the next
patch the call is guarded with #if IS_BUILTIN(CONFIG_SND_SDMA_SOC)
|| IS_MODULE(CONFIG_SND_SDMA_SOC). I don't think it is called with
CONFIG_SND_SDMA_SOC being disabled.

-- Sebastian

--uxbgjxn32ze75abq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrnAFEACgkQ2O7X88g7
+prazg/5Aca4x58JOcZmZDGrSt006yLXO3U1fXCvOZVw0JgFY4WXmjG9Dxs8IyKm
qYp7oFJ/em0ikIhm2Evj3qwdd0epxOjj9ypq8esKWBXm4R3QXQuhrJWiWg2i/FVt
0LCV58Ox7sDR4jMCwbSHAQHrf0CkURoDazXbPm+k4N1focnV9QJuyaBF1rcfdJIV
4ks1QYO4ZxSP4j8DUrYOtsc8CUzfJTDv6gjH5es/rLDmafyrKZO3AjQgy+loNYYi
VrLwpRwlavU3KInd1sRy6BMHku73wpLBrV7l92/biH+OwOMPxu4wBtjmyIO6wx0P
L6PR2C6ws6AeLqlMdMk6Ds9qgEstbeQjhWo5+cI4O6Bs0flbSAasZ7qZ+Sb6KsB1
bEGhB32aWhaS91gxvtO+vxof5btQ1sD7xdZUInGmxFG4p5uRch9T+C+5sR6uh3ua
oirn9ggzusuyONiR4N5I4d/3wbrJ9kuD0lk0HUFV3rrknsdIvRxuw+zYsKGyJuM4
cbruRfp2JvT2aVgGUcIT+f4R1ylG1zOjEfvXOgZW8oNXwAJYs8Mb8VSVfe0RGsa+
QV0zfY9S9dCmcjkk2DJDsjQT6RGWHELouX732u4eXQ5qjweSKjmFKVPN/h7fpeNC
uRAVcOKwx+RT3dbwtgG6tjFYmXHXC4P6no6tyRez4ymK1yaPnhQ=
=Fj8I
-----END PGP SIGNATURE-----

--uxbgjxn32ze75abq--

--===============0499866082994130632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0499866082994130632==--
