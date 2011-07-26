From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 01/19] OMAP3: hwmod: add SmartReflex IRQs
Date: Tue, 26 Jul 2011 16:11:40 +0300
Message-ID: <20110726131139.GN32582@legolas.emea.dhcp.ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
 <1299338962-5602-2-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="muT+E17Lr9urPYYJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50779 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab1GZNLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jul 2011 09:11:44 -0400
Received: by mail-ew0-f48.google.com with SMTP id 22so642862ewy.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jul 2011 06:11:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1299338962-5602-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>


--muT+E17Lr9urPYYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 05, 2011 at 08:59:04PM +0530, Nishanth Menon wrote:
> OMAP3 SmartReflex IRQs in hwmod structures with the same naming as
> present in OMAP4. Without these IRQs being registered, SmartReflex
> driver will be unable to get the IRQ numbers to handle notifications
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Acked-by: Felipe Balbi <balbi@ti.com>

According to 36xx TRM page 383, the IRQ numbers are correct.

> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index 196a834..2d464bc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -378,6 +378,15 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 =
=3D {
>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +
> +static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] =3D {
> +	{.name =3D "sr1_irq", .irq =3D 18},
> +};
> +
> +static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] =3D {
> +	{.name =3D "sr2_irq", .irq =3D 19},
> +};
> +
>  /* L4 CORE -> SR1 interface */
>  static struct omap_hwmod_addr_space omap3_sr1_addr_space[] =3D {
>  	{
> @@ -2925,6 +2934,8 @@ static struct omap_hwmod omap34xx_sr1_hwmod =3D {
>  	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
> +	.mpu_irqs	=3D omap3_smartreflex_mpu_irqs,
> +	.mpu_irqs_cnt	=3D ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
>  	.flags		=3D HWMOD_SET_DEFAULT_CLOCKACT,
>  };
> =20
> @@ -2945,6 +2956,8 @@ static struct omap_hwmod omap36xx_sr1_hwmod =3D {
>  	.slaves		=3D omap3_sr1_slaves,
>  	.slaves_cnt	=3D ARRAY_SIZE(omap3_sr1_slaves),
>  	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.mpu_irqs	=3D omap3_smartreflex_mpu_irqs,
> +	.mpu_irqs_cnt	=3D ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
>  };
> =20
>  /* SR2 */
> @@ -2971,6 +2984,8 @@ static struct omap_hwmod omap34xx_sr2_hwmod =3D {
>  	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
> +	.mpu_irqs	=3D omap3_smartreflex_core_irqs,
> +	.mpu_irqs_cnt	=3D ARRAY_SIZE(omap3_smartreflex_core_irqs),
>  	.flags		=3D HWMOD_SET_DEFAULT_CLOCKACT,
>  };
> =20
> @@ -2991,6 +3006,8 @@ static struct omap_hwmod omap36xx_sr2_hwmod =3D {
>  	.slaves		=3D omap3_sr2_slaves,
>  	.slaves_cnt	=3D ARRAY_SIZE(omap3_sr2_slaves),
>  	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.mpu_irqs	=3D omap3_smartreflex_core_irqs,
> +	.mpu_irqs_cnt	=3D ARRAY_SIZE(omap3_smartreflex_core_irqs),
>  };
> =20
>  /*
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--muT+E17Lr9urPYYJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLr0LAAoJEAv8Txj19kN1lyMIAKX04fUAEz63xTkhtFU+LQDk
9JjFkL3/Jaf5kYclpnIFCw2ZuERo0d5+kVw94CPoqikXOjtqI7WytqBG6fbqmcMZ
ykf3cJ0tnqjeEQ2O5Gd+sZytGcmnOMdmCipNy+9VFXaVQJ80iEQHUYzU5UvsuU/J
5q0RZDzOopAemrF5zF8dSTK7krE+3pJJGBp2vFKt+r260wLp9Uwd6jGKTPfyqQZQ
Nenr01PoUVyuBY9Z0oaZJIvPRF+OIorjf7Yd3O/W33h10KIA+ZQSDh8tacI1yq99
AbER3vj93nDdbaQmWAw6X0/Whv7wLWNa0ZSVJ5dgxdq9GSkqktMv8NvhUxk98dk=
=zbdH
-----END PGP SIGNATURE-----

--muT+E17Lr9urPYYJ--
