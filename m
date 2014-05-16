From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/19] OMAPDSS: Kconfig: Add depencies and help section
 to OMAP4_DSS_HDMI_AUDIO
Date: Fri, 16 May 2014 13:52:55 +0300
Message-ID: <5375EE07.4090802@ti.com>
References: <cover.1399884780.git.jsarha@ti.com> <198496d6220a13b0e8910361d969b8f978ee1398.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="v37FiRuuIllofris9W3FC9QsoifXNHGRA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50673 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932327AbaEPKxG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 06:53:06 -0400
In-Reply-To: <198496d6220a13b0e8910361d969b8f978ee1398.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

--v37FiRuuIllofris9W3FC9QsoifXNHGRA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/05/14 12:12, Jyri Sarha wrote:
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/Kconfig |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbde=
v/omap2/dss/Kconfig
> index 8921a7a..ecc2f50 100644
> --- a/drivers/video/fbdev/omap2/dss/Kconfig
> +++ b/drivers/video/fbdev/omap2/dss/Kconfig
> @@ -70,7 +70,15 @@ config OMAP4_DSS_HDMI
>  	  HDMI support for OMAP4 based SoCs.
> =20
>  config OMAP4_DSS_HDMI_AUDIO
> -	bool
> +	bool "HDMI audio support for OMAP4"
> +	depends on OMAP4_DSS_HDMI
> +	depends on SND_OMAP_SOC=3Dy || OMAP2_DSS =3D SND_OMAP_SOC
> +	default y
> +	help
> +	  HDMI audio support for OMAP4 based SoCs. Adds integrated
> +	  ASoC Digital Audio Interface component driver into OMAPDSS
> +	  module. Select SND_SOC_HDMI_CODEC and SND_SIMPLE_CARD with
> +	  devicetree description for full HDMI audio support.

What does "for full HDMI audio support" mean? What's the partial support?=
 =3D)

 Tomi



--v37FiRuuIllofris9W3FC9QsoifXNHGRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTde4HAAoJEPo9qoy8lh71M3kP/3RwAPy6cradgWXXBhgSdDmD
a6t6dDuqPp0ANfQuZkdbP/j1/k0B2g3wfCdepkQkYoU6lOre8bD1uABLrHn9LM8E
N0S981tIGFssuuJaAUnivWvcvpfqGuAOB6+enUT2xDHVNqyrn1M64WjQXHZPczgG
8Qj2arEAcIruLjI7AYkAMrJjG+tEmfvVtO2sB9fS4AFMu1ba4XAXr3+Bo5/SvVMj
4wWo6DI3DVjLQwBozPxEXi8+bi7L2xScHIPBX4byT/6pjWvowUOlEzdMLpAdAD4D
v+oZwpoPHbHJ2Fo+HLtQIu72shGphn/CMKxxv0q7W1+zNHSgK8zxAaLTAg6gcr3M
vmT4dntQhNlrYfu/wOAfHW7OsAvBSyFAJ6OywgwXO2kb7bRpffIr4yPNvSrA7nHW
BxTR3i35iokfZmbpH5qh3nZ5Q0Mgy4fUVH4nDmGbmvV7Bpx1mTpjM1f7i8YwOD28
W8Gnq9wHivx8F74HSlLbH4bUhDlWn8Hvt5f9HarnO7HGVwCJNoUSDSAcMAaBno8p
K5sM6IDLqcgRvcFrFAAI4ppL3/XNYD2BQd5h6IkghDuyfLw8retYym0/bTmXdHI5
24S7CRkpSAPhMdS5mO3iAno7/raw2UQGoO9u+BSSmGmPBFadyGKdlJzaE7BEeYH/
2iwEMn4VgOqZIKZt6C4f
=q7Qx
-----END PGP SIGNATURE-----

--v37FiRuuIllofris9W3FC9QsoifXNHGRA--
