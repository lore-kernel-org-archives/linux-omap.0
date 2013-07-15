From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ASoC: omap: Enable COMPILE_TEST build for DT platforms
Date: Mon, 15 Jul 2013 19:00:45 +0300
Message-ID: <20130715160045.GG32035@arwen.pp.htv.fi>
References: <1373903876-26370-1-git-send-email-broonie@kernel.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932635Ab3GOQBY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 12:01:24 -0400
Content-Disposition: inline
In-Reply-To: <1373903876-26370-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@linaro.org>

--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 15, 2013 at 04:57:56PM +0100, Mark Brown wrote:
> @@ -26,7 +26,7 @@ config SND_OMAP_SOC_N810
> =20
>  config SND_OMAP_SOC_RX51
>  	tristate "SoC Audio support for Nokia RX-51"
> -	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
> +	depends on SND_OMAP_SOC && (MACH_NOKIA_RX51 || COMPILE_TEST)

RX51 is OMAP3, and that's DT at all. This is likely just a case of
updating commit log.

--=20
balbi

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5BytAAoJEIaOsuA1yqRERxgP/RpQ2lMx9Fks5iFVQ88ZKjK1
Il58eFN5ez62STSSMXGYLVaSzbpSVUmrlHyPENwgGX9oUXI6i+5AiXvgv1Z0gA9X
V0PR3ClmkuP9PFZmY+wbcAkQTwDN4uwkojnzz9ow7M705SgDUZCxi32pkd+L23v3
vG+PwPju92AGf0vi2IVZGJLJ/4lif7uXfArcn3UQ8T/oaFdSMG1T90j37OhMaS3y
oLuxBCTqQJeRtn4voWVFr6qrQPIfEiDLXCGT9k6FXT8Xq8TAzB9Ib9hqM8Y4zG2c
H+Ru7sNZEqeqVrU2mwSWCnnajYYyYeHDLWCjjscs91SAAyZcGQpfzajzriTVJ9Fr
+0KuEcFNV3VdDAb8SJxCAOsoujyejcCPN4Z7NuaqB012Upr40HoDf8OJw1ku0Kvk
kIMyxpJ7yoaLrBQ3CH1lUHPALpl+VSHPrSwvNih3oKnsUiWgVIVLYF5zr+x+ERQz
PwhIuUlQ9NmS2ecxljC4Vx071nGfxM3pQEc36h1MW+2pQp2G60+3zONLC+CDTSW5
xXqN0XHF3peYzMDHqpnTam+tTBv74e10qP0pChmza9Uh5tr/93X3y9UJDBr/orO+
qtDVdpV3B4pQNsPmHy5NTumTFJKI3MQfWz493KJ2xU06Sc7xa9cmVxVdMyEK4SWF
+s0omzdhjrJJqC6/9tYh
=v5xT
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
