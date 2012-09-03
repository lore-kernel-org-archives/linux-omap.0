From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: c_can: Adopt pinctrl support
Date: Mon, 03 Sep 2012 22:42:04 +0200
Message-ID: <5045161C.4000100@pengutronix.de>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD26EC89AE912B203349FC18E"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1346673139-14540-2-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD26EC89AE912B203349FC18E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
> Adopt pinctrl support to c_can driver based on c_can device
> pointer, pinctrl driver configure SoC pins to d_can mode
> according to definitions provided in .dts file.
>=20
> In device specific device tree file 'pinctrl-names =3D "default";'
> and 'pinctrl-0 =3D <&d_can1_pins>;' needs to add to configure pins
> from c_can driver. d_can1_pins node contains the pinmux/config
> details of d_can L/H pins.

Looks good, is the pinctrl property documented in the dt bindings already=
?

Marc

>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/net/can/c_can/c_can_platform.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index 90801c4..c351975 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -33,6 +33,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
> =20
>  #include <linux/can/dev.h>
> =20
> @@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platform=
_device *pdev)
>  	struct c_can_priv *priv;
>  	const struct of_device_id *match;
>  	const struct platform_device_id *id;
> +	struct pinctrl *pinctrl;
>  	struct resource *mem;
>  	int irq;
>  	struct clk *clk;
> @@ -114,6 +116,11 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		id =3D platform_get_device_id(pdev);
>  	}
> =20
> +	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev,
> +			"failed to configure pins from driver\n");
> +
>  	/* get the appropriate clk */
>  	clk =3D clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk)) {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD26EC89AE912B203349FC18E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBFFhwACgkQjTAFq1RaXHNlSgCff/ftiJphR8hv71Udn+l7SDuG
vV0An1p/rJaq+jE7Ksom4F7gn7hBVCbV
=iLA6
-----END PGP SIGNATURE-----

--------------enigD26EC89AE912B203349FC18E--
