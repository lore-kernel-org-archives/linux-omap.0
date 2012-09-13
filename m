From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: Move pm_runtime_enable/disable calls to common
 code
Date: Thu, 13 Sep 2012 09:48:07 +0200
Message-ID: <50518FB7.7090300@pengutronix.de>
References: <1347521292-28751-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE3DFDFECD0E799487D15F836"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1347521292-28751-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, khilman@deeprootsystems.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3DFDFECD0E799487D15F836
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/13/2012 09:28 AM, AnilKumar Ch wrote:
> Move pm_runtime_enable/disable calls to c_can.c driver. Current
> implementation is such that platform driver is doing pm_runtime
> enable/disable and core driver is doing put_sync/get_sync.
>=20
> PM runtime calls should be invoked if there is a valid device
> pointer from platform driver so moving enable/disable calls
> to core driver.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> Incorporated Kevin's comments on "can: c_can: Add runtime PM
> support to Bosch C_CAN/D_CAN controller" patch.
>=20
> This patch is tested on AM335x-EVM and cleanly applies on
> linux-can master

I'll squash this into "can: c_can: Add runtime PM support to Bosch
C_CAN/D_CAN controller".
>=20
>  drivers/net/can/c_can/c_can.c          |   18 +++++++++++++++++-
>  drivers/net/can/c_can/c_can_platform.c |    5 -----
>  2 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index aa6c5eb..e472975 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -1155,10 +1155,23 @@ static const struct net_device_ops c_can_netdev=
_ops =3D {
> =20
>  int register_c_can_dev(struct net_device *dev)
>  {
> +	int ret;
> +	struct c_can_priv *priv =3D netdev_priv(dev);
> +
> +	if (priv->device)
> +		pm_runtime_enable(priv->device);

I'll add a static inline for these two new function, too.

> +
>  	dev->flags |=3D IFF_ECHO;	/* we support local echo */
>  	dev->netdev_ops =3D &c_can_netdev_ops;
> =20
> -	return register_candev(dev);
> +	ret =3D register_candev(dev);
> +	if (ret) {
> +		if (priv->device)
> +			pm_runtime_disable(priv->device);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(register_c_can_dev);
> =20
> @@ -1170,6 +1183,9 @@ void unregister_c_can_dev(struct net_device *dev)=

>  	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
> =20
>  	unregister_candev(dev);
> +
> +	if (priv->device)
> +		pm_runtime_disable(priv->device);
>  }
>  EXPORT_SYMBOL_GPL(unregister_c_can_dev);
> =20
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index c351975..491101a 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -32,7 +32,6 @@
>  #include <linux/clk.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/pinctrl/consumer.h>
> =20
>  #include <linux/can/dev.h>
> @@ -185,8 +184,6 @@ static int __devinit c_can_plat_probe(struct platfo=
rm_device *pdev)
>  		goto exit_free_device;
>  	}
> =20
> -	pm_runtime_enable(&pdev->dev);
> -
>  	dev->irq =3D irq;
>  	priv->base =3D addr;
>  	priv->device =3D &pdev->dev;
> @@ -209,7 +206,6 @@ static int __devinit c_can_plat_probe(struct platfo=
rm_device *pdev)
> =20
>  exit_clear_drvdata:
>  	platform_set_drvdata(pdev, NULL);
> -	pm_runtime_disable(&pdev->dev);

When squaahsing both patches we see still some changes here, I'll fix
that, too.

>  exit_free_device:
>  	free_c_can_dev(dev);
>  exit_iounmap:
> @@ -239,7 +235,6 @@ static int __devexit c_can_plat_remove(struct platf=
orm_device *pdev)
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));
> =20
> -	pm_runtime_disable(&pdev->dev);
>  	clk_put(priv->priv);
> =20
>  	return 0;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE3DFDFECD0E799487D15F836
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBRj7oACgkQjTAFq1RaXHNJ2ACfdBz72JJ8B0zPfw+mv0kF+oz3
x90AoJX66S4uKFbQ8nAlqtiruwkP3TwU
=ZHF4
-----END PGP SIGNATURE-----

--------------enigE3DFDFECD0E799487D15F836--
