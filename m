From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 4/5] arm: omap: n8x0: add i2c-cbus platform data
Date: Thu, 30 Aug 2012 18:38:32 +0300
Message-ID: <20120830153831.GH1754@arwen.pp.htv.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-5-git-send-email-aaro.koskinen@iki.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:53745 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751297Ab2H3Pmo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 11:42:44 -0400
Received: by lbbgj3 with SMTP id gj3so597531lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 08:42:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346189667-32330-5-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2012 at 12:34:26AM +0300, Aaro Koskinen wrote:
> Add platform data to enable i2c-cbus on N8x0. It will be I2C bus #3.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/board-n8x0.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board=
-n8x0.c
> index 677357f..8ea0dea 100644
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/stddef.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c-cbus.h>
>  #include <linux/spi/spi.h>
>  #include <linux/usb/musb.h>
>  #include <sound/tlv320aic3x.h>
> @@ -42,6 +43,31 @@
>  #define TUSB6010_GPIO_ENABLE	0
>  #define TUSB6010_DMACHAN	0x3f
> =20
> +#if defined(CONFIG_I2C_CBUS) || defined(CONFIG_I2C_CBUS_MODULE)
> +static struct i2c_cbus_platform_data n8x0_cbus_data =3D {
> +	.clk_gpio =3D 66,
> +	.dat_gpio =3D 65,
> +	.sel_gpio =3D 64,
> +};
> +
> +static struct platform_device n8x0_cbus_device =3D {
> +	.name	=3D "i2c-cbus",
> +	.id	=3D 3,
> +	.dev	=3D {
> +		.platform_data =3D &n8x0_cbus_data,
> +	},
> +};
> +
> +static void __init n8x0_cbus_init(void)
> +{
> +	platform_device_register(&n8x0_cbus_device);
> +}
> +#else /* CONFIG_I2C_CBUS */
> +static void __init n8x0_cbus_init(void)
> +{
> +}
> +#endif /* CONFIG_I2C_CBUS */
> +
>  #if defined(CONFIG_USB_MUSB_TUSB6010) || defined(CONFIG_USB_MUSB_TUSB601=
0_MODULE)
>  /*
>   * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
> @@ -681,6 +707,7 @@ static void __init n8x0_init_machine(void)
>  	gpmc_onenand_init(board_onenand_data);
>  	n8x0_mmc_init();
>  	n8x0_usb_init();
> +	n8x0_cbus_init();
>  }
> =20
>  MACHINE_START(NOKIA_N800, "Nokia N800")
> --=20
> 1.7.2.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQP4j2AAoJEIaOsuA1yqREHPwQAI3U58YJHJzgbadtdsZq8qIu
UDVsJOp/HwTrM5vdH5O5rx2YB4eoDQQzAAe4oODzEBrfBlJqYyEloc2uLIg+LtSW
hoWHWezz90hYRR0l2bZSzpaie24kBJcK3mrbno8PhpYXHt/NXmaInmxVf9JT/QUk
g7cr63ulcBdLgB6/R3K5XbV6vOk9rytfZwYgxHZw0KbzDz2UiknGPdJHMDuZUgOX
UBZLvheddvGLL0QuStRCCFdoM1m2rCF4gYeKjTyfVGwnTjfvFu7RlMTqU9iH5I+A
d1LKdo2r4/HALqvLZwQ5RCbvGHfrxoildD398+0Aw30Avl7LmeyIgB2PP34knd3+
ET2FckQdReQNRovZAIuf6ClTv6qoW2lOTkOOAjEN0t7jfrTUnEs9prryFTTV+eG0
2UYJyW0DyW2KvVr2akPhAcbqq5Kmt4UFVBhjuTwlNm/d/FREuQzXvlPF+d1zBrQk
b2MVHfzvEgLV0Pwx7uWg8a0OB4OFsallV/UsAS4pYkH7HvA5vRbCqvU32vtqGlO6
yrSxWWgeFt8SrpgPL88LiFKQLO8aPMCkkvrLQul1rLcDWHbc1e61MJY92iGdyFfp
iyH+IffPaPWZwBXlP9OpeHkDF8haXuOtrzeAsWL4J9QopjnwBwxqGQSTIWX/VJZH
UYmSEOFFH8CbKj1aWaD/
=gWg4
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
