From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Wed, 9 Oct 2013 09:00:13 +0300
Message-ID: <5254F0ED.5030800@ti.com>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="WewQkmCPxunAwHPAoElh5gpbmhRF3GggU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44213 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab3JIGAZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 02:00:25 -0400
In-Reply-To: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

--WewQkmCPxunAwHPAoElh5gpbmhRF3GggU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/10/13 05:51, Javier Martinez Canillas wrote:
> IGEPv2 board has both an DVI and TFP410 video interfaces but
> DSS support for DeviceTree has not yet landed in mainline so
> is necessary to init the displays using legacy platform code.
>=20
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.u=
k>
> ---
>  arch/arm/mach-omap2/dss-common.c   | 37 ++++++++++++++++++++++++++++++=
+++++++
>  arch/arm/mach-omap2/dss-common.h   |  1 +
>  arch/arm/mach-omap2/pdata-quirks.c |  7 +++++++
>  3 files changed, 45 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss=
-common.c
> index bf89eff..0c1cf2e 100644
> --- a/arch/arm/mach-omap2/dss-common.c
> +++ b/arch/arm/mach-omap2/dss-common.c
> @@ -39,6 +39,7 @@
>  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
> =20
>  #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
> +#define IGEP2_DVI_TFP410_POWER_DOWN_GPIO	170
> =20
>  /* DVI Connector */
>  static struct connector_dvi_platform_data omap4_panda_dvi_connector_pd=
ata =3D {
> @@ -53,6 +54,18 @@ static struct platform_device omap4_panda_dvi_connec=
tor_device =3D {
>  	.dev.platform_data      =3D &omap4_panda_dvi_connector_pdata,
>  };
> =20
> +static struct connector_dvi_platform_data omap3_igep2_dvi_connector_pd=
ata =3D {
> +	.name                   =3D "dvi",
> +	.source                 =3D "tfp410.0",
> +	.i2c_bus_num            =3D 3,
> +};
> +
> +static struct platform_device omap3_igep2_dvi_connector_device =3D {
> +	.name                   =3D "connector-dvi",
> +	.id                     =3D 0,
> +	.dev.platform_data      =3D &omap3_igep2_dvi_connector_pdata,
> +};
> +
>  /* TFP410 DPI-to-DVI chip */
>  static struct encoder_tfp410_platform_data omap4_panda_tfp410_pdata =3D=
 {
>  	.name                   =3D "tfp410.0",
> @@ -67,6 +80,19 @@ static struct platform_device omap4_panda_tfp410_dev=
ice =3D {
>  	.dev.platform_data      =3D &omap4_panda_tfp410_pdata,
>  };
> =20
> +static struct encoder_tfp410_platform_data omap3_igep2_tfp410_pdata =3D=
 {
> +	.name                   =3D "tfp410.0",
> +	.source                 =3D "dpi.0",
> +	.data_lines             =3D 24,
> +	.power_down_gpio        =3D IGEP2_DVI_TFP410_POWER_DOWN_GPIO,
> +};
> +
> +static struct platform_device omap3_igep2_tfp410_device =3D {
> +	.name                   =3D "tfp410",
> +	.id                     =3D 0,
> +	.dev.platform_data      =3D &omap3_igep2_tfp410_pdata,
> +};
> +

I think it would be better to organize the file in sections based on
boards. Not mixing the display devices for different boards like above.

>  /* HDMI Connector */
>  static struct connector_hdmi_platform_data omap4_panda_hdmi_connector_=
pdata =3D {
>  	.name                   =3D "hdmi",
> @@ -99,6 +125,10 @@ static struct omap_dss_board_info omap4_panda_dss_d=
ata =3D {
>  	.default_display_name =3D "dvi",
>  };
> =20
> +static struct omap_dss_board_info igep2_dss_data =3D {
> +	.default_display_name =3D "dvi",
> +};
> +
>  void __init omap4_panda_display_init_of(void)
>  {
>  	omap_display_init(&omap4_panda_dss_data);
> @@ -110,6 +140,13 @@ void __init omap4_panda_display_init_of(void)
>  	platform_device_register(&omap4_panda_hdmi_connector_device);
>  }
> =20
> +void __init omap3_igep2_display_init_of(void)
> +{
> +	omap_display_init(&igep2_dss_data);
> +
> +	platform_device_register(&omap3_igep2_tfp410_device);
> +	platform_device_register(&omap3_igep2_dvi_connector_device);
> +}

Wouldn't it be better to remove the display setup from the board file at
the same time as it's added here? Otherwise we'll end up with the same
display setup being in two different files.

> @@ -103,6 +108,8 @@ static struct pdata_init pdata_quirks[] __initdata =
=3D {
>  #ifdef CONFIG_ARCH_OMAP3
>  	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
>  	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
> +	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },

The above is extra.

 Tomi



--WewQkmCPxunAwHPAoElh5gpbmhRF3GggU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVPDtAAoJEPo9qoy8lh71by0P/3pCg2Bp5jEn/7guYr0Xf1Rb
Fot/aV/AJIqzyJF+o83ztoMAWkbKqQO2NubMzKslw5DnnQAnUG0jKTvf4acFMtwX
Mgf7+VwQCLUG01xawPRSSvhFTExXAr8gDR96VJffxNHV2jasWG7BFiJrakQ4FAKE
W1WoYvUSYveB9bDJuKLaSiRSmozY7P83OoqYw9+YwalxFDvooR3PKzTpjAOFVdO0
R9S6+yq1AAnxIKKvZ296IeTURKUN4peuiL0WbtS3SN3Eja4rEX3dLYycutbDGle0
TzRaszXuYuPPnD51kn58UOZROe07psuZeg4F7S0tFAzHnK0ceWTBeRczGXgmvMEt
8EbBmAWKzjCvztghrqx3GfwJgLOwikAQJPd1koQGXCpfMzFxcO6SqOpbFXpA++TG
U/ZiTFCj3fTNWfu99i1vQwCllkvo9OCHId2SgQV9w7dE7XtQUrY9Wfuhn3WUQf5S
U4rbThe5L2RYC4eqSv4tBIzZQ+DXJn5qkmu/JlbckDC7ImkqQAgokwS99bBTZBdy
jOgsXt0RDWh8ed08YUpt/wpJ1uKA3D0/EVMmDXDl34IPdAygEBk860O9tQxeGek7
uw2zUdtDPuEtqMz6XtCyR+0wnbkAtZkOHM6OHLaSSJXdB8I8pkMNBIemUG/0HRRX
oofTVwvQQYn4xk1ATdip
=5TKW
-----END PGP SIGNATURE-----

--WewQkmCPxunAwHPAoElh5gpbmhRF3GggU--
