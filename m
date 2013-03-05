From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP: RX-51: add missing USB phy binding
Date: Tue, 5 Mar 2013 13:36:18 +0200
Message-ID: <20130305113618.GB19290@arwen.pp.htv.fi>
References: <1362481780-11018-1-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44206 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab3CELgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 06:36:46 -0500
Content-Disposition: inline
In-Reply-To: <1362481780-11018-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2013 at 01:09:40PM +0200, Aaro Koskinen wrote:
> Commit 51482be9 (ARM: OMAP: USB: Add phy binding information) forgot to
> add phy binding for RX-51, and as a result USB does not work anymore on
> 3.9-rc1. Add the missing binding.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/board-rx51.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board=
-rx51.c
> index f7c4616..d2ea68e 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
> +#include <linux/usb/phy.h>
>  #include <linux/usb/musb.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> =20
> @@ -98,6 +99,7 @@ static void __init rx51_init(void)
>  	sdrc_params =3D nokia_get_sdram_timings();
>  	omap_sdrc_init(sdrc_params, sdrc_params);
> =20
> +	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
>  	usb_musb_init(&musb_board_data);
>  	rx51_peripherals_init();
> =20
> --=20
> 1.7.10.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNdiyAAoJEIaOsuA1yqREY/AQALLMeDU13aqRY1A91UBYwOWA
lHn/4ITLiozK80iMDPtLBUM5c7HllsswOKdniYMkMX3in3VxDs3wajQ7jcoqSwZv
YO0tAG92bNtF2SuMWdfpxKpBf0lj1Fsnt7xKWiZczPLJ8JLEEz0c6hvBmzju54k4
GMhTYcD+sSepaf7LxNOxA9AKl8PMbsi1uoQM922wTrNOLdvPwr5G3A1Y+eJ5v6iS
P3e01pmkOtqhYZO5oVJuTQqT9RNBwCXUnu5UZC8AVN8V1mDWws8zCro4gkHkV13z
+U8tD1CqirxTqgV4HYbyWpk3m2XtaK4QiLQ++/C0VgwwwvJiY0JOOLnb3D6AVCrJ
BPJfofUDMVw8jpJyNgmGwuPzxqcIRI4jPUOy7+6k5fZz2Bi16oVcxbA6C8lzeiCP
FkgeA5HoEDOsg6jQ5lBf9/VqGXDVLbKMSXDzOPuLWL/pMvNDV8QiylxvPI+k5Pro
q25hUZxTSfR3mJyrS6Lv2kVbWpchNTll5mX5BMYgg2W+OFM2lxv7OzjMJDubLdgZ
y8+LzMvnp1TvZ7rKKgUNKw/I9JH+epwsYcEHwy16ozXqXq1kYhUqd7BhI16pjLGR
6bSpKzF14e537+thrHD+bNLI1PhpdJ58+1ienGDTiGlIF7OOHWIAW6SUQxNbXRFp
LkHXvT3UMuCi3gNcMrJJ
=oxcl
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
