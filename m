From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: c_can: Add d_can raminit support
Date: Wed, 21 Nov 2012 09:48:56 +0100
Message-ID: <50AC9578.4030505@pengutronix.de>
References: <1353476650-24398-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB78550E7FCE19435E6F3D731"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1353476650-24398-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB78550E7FCE19435E6F3D731
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/21/2012 06:44 AM, AnilKumar Ch wrote:
> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
> which holds all the message objects during transmission or
> receiving of data. This initialization/de-initialization should
> be done in synchronous with D_CAN clock.
>=20
> In case of AM335X-EVM (current user of D_CAN driver) message RAM is
> controlled through control module register for both instances. So
> control module register details is required to initialization or
> de-initialization of message RAM according to instance number.
>=20
> Control module memory resource is obtained from D_CAN dt node and
> instance number obtained from device tree aliases node.
>=20
> This patch was tested on AM335x-EVM along with pinctrl data addition
> patch, d_can dt aliases addition and control module data addition.
> pinctrl data addition is not added to am335x-evm.dts (only supports
> CPLD profile#0) because d_can1 is supported under CPLD profile#1.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---

[...]

> @@ -178,6 +195,20 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
>  		priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>  		priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
> +
> +		if (pdev->dev.of_node)
> +			priv->instance =3D pdev->id < 0 ?
> +				of_alias_get_id(pdev->dev.of_node, "d_can") :
> +				pdev->id;

This wouldn't work with non DT kernels, what about:

if (pdev->dev.of_node)
	priv->instance =3D of_alias_get_id(pdev->dev.of_node, "d_can");
else
	priv->instance =3D pdev->id;

Marc
> +
> +		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		priv->raminit_ctrlreg =3D
> +				devm_request_and_ioremap(&pdev->dev, res);
> +		if (!priv->raminit_ctrlreg || priv->instance < 0) {
> +			dev_info(&pdev->dev, "control memory is not used for raminit\n");
> +			break;
> +		}
> +		priv->ram_init =3D c_can_hw_raminit;
>  		break;
>  	default:
>  		ret =3D -EINVAL;
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB78550E7FCE19435E6F3D731
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCslXgACgkQjTAFq1RaXHPBxACdF+vq5IV7C8x7BOxVskclLsft
CrMAn0nEJYycY50Om7TGWLCnvsXYS6sb
=wRWS
-----END PGP SIGNATURE-----

--------------enigB78550E7FCE19435E6F3D731--
