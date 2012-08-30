From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 5/5] arm: omap: n8x0: enable retu
Date: Thu, 30 Aug 2012 18:39:04 +0300
Message-ID: <20120830153903.GI1754@arwen.pp.htv.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-6-git-send-email-aaro.koskinen@iki.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:38759 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab2H3PnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 11:43:16 -0400
Received: by lbbgj3 with SMTP id gj3so597938lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 08:43:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346189667-32330-6-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2012 at 12:34:27AM +0300, Aaro Koskinen wrote:
> Add Retu configuration.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/board-n8x0.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board=
-n8x0.c
> index 8ea0dea..6ac8cd9 100644
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -58,8 +58,16 @@ static struct platform_device n8x0_cbus_device =3D {
>  	},
>  };
> =20
> +static struct i2c_board_info n8x0_i2c_board_info_3[] __initdata =3D {
> +	{
> +		I2C_BOARD_INFO("retu-mfd", 0x01),
> +	},
> +};
> +
>  static void __init n8x0_cbus_init(void)
>  {
> +	i2c_register_board_info(3, n8x0_i2c_board_info_3,
> +				ARRAY_SIZE(n8x0_i2c_board_info_3));
>  	platform_device_register(&n8x0_cbus_device);
>  }
>  #else /* CONFIG_I2C_CBUS */
> --=20
> 1.7.2.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQP4kXAAoJEIaOsuA1yqREW6sQAI8BtE2K74ItfDFEXyQn/XaS
3CTI/W+aWNk4kqH9+4lHUVo2MwnIvcrc3n/PGnqSd8AwdZiZZLWmeQFtk2QKjX1r
jhJmb3HLkB8Dfo0285A3bwIKLF7RVl07r03kreV6o4umj1n8v4FkD9dBN+/kNmiw
+5eGOXIr1HaycXsKD1teV0Y5pv1JJDTdvcu318QDXgQqLyOAbm1X7xbdezUHbuxw
0tb1MQcH7odib08EW6clcGTJV/Uu4kONVb+n7ilQhJsgpCQzsjypAN9yXtwKXImH
A6W2eEC1Vz80AbJCIfKA2zMvZWopKLpuNepi3sMR1/piohbyy2tN8b6lRkpsOfF/
KkcjkTs1jnBDWk0rnLTHdLAY84IbZYwH6UABw2r0bN62wpfpuDOWFHHn/RADCXLD
rNC1y4w7joFFGp29xEmEVwA7v7XBcX6tJsvGqF+vk6H7kBh742aoHj+eUzn0ybdl
1VGfBaQ6YufmST98RP5JAHNZ3kkUhvTTxDcRgRYLZ9IqCsb0l/ag2aNuXSYp2cki
tqni4jEyCF/IJlCJVJoGr5t0dNwbAn8f6vLklZZCqztBLdnP0nVHph+6twz+1D1g
Gck3d1zTxlUaU1Ej2IR+wliazNu98Jg7CJV7J3hvn1+wUjbPrqYxqqDN7jkK4yks
fs8uHvzB+2GLYjc9s9DG
=DdWW
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--
