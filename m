From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Tue, 07 Aug 2012 13:57:05 +0200
Message-ID: <50210291.6020307@pengutronix.de>
References: <1344338457-595-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4F7E1AC2F146BEF91ECCC057"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58009 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab2HGL5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 07:57:17 -0400
In-Reply-To: <1344338457-595-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F7E1AC2F146BEF91ECCC057
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/07/2012 01:20 PM, AnilKumar Ch wrote:
> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> register of C_CAN/D_CAN IP when clock is turned off.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> This patch has been tested on AM335X EVM. Due to lack of hardware
> I am not able to test c_can functionality. I appreciate if anyone
> can test c_can functionality with this patch.

The "priv->pdev->dev" will not work for c_can/d_can which are not using
the platform driver. Options:
a) priv->dev
   add a struct device pointer to the priv, and
   1) guard pm_runtime_get_sync() for priv->dev =3D=3D NULL
      (or check if pm_runtime_get_sync copes with NULL pointer)

   - or -

   2) fill in the priv->dev in all other drivers (i.e. PCI)
      and check if it makes sense/works to call it on PCI hardware

b) convert all other drivers, i.e. the PCI driver to create a
   platform device

Without thinking long, I suggest to a) with flavour 1)

Maybe there are better solutions.

Marc

More comments inline:

>=20
> This patch is based on "can-next/master"=20
>=20
> Changes from v4:
> 	- Incorporated Vaibhav H review comments on v4.
> 	  * Moved pm_runtime put/get_sync calls to appropriate positions.
> 	- This patch is from "Add DT support to C_CAN/D_CAN controller"
> 	  patch series. Rest of the patches in this series were applied
> 	  so this v5 contains only this patch.
>=20
>  drivers/net/can/c_can/c_can.c          |    8 ++++++++
>  drivers/net/can/c_can/c_can.h          |    1 +
>  drivers/net/can/c_can/c_can_platform.c |   11 +++++++++++
>  3 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index eea6608..ca1151d 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -34,6 +34,8 @@
>  #include <linux/if_ether.h>
>  #include <linux/list.h>
>  #include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -673,6 +675,8 @@ static int c_can_get_berr_counter(const struct net_=
device *dev,
>  	unsigned int reg_err_counter;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> +	pm_runtime_get_sync(&priv->pdev->dev);
> +

Why do you make a get_sync() here, where's the correspondning put_sync()?=


>  	reg_err_counter =3D priv->read_reg(priv, C_CAN_ERR_CNT_REG);
>  	bec->rxerr =3D (reg_err_counter & ERR_CNT_REC_MASK) >>
>  				ERR_CNT_REC_SHIFT;
> @@ -1053,6 +1057,8 @@ static int c_can_open(struct net_device *dev)
>  	int err;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> +	pm_runtime_get_sync(&priv->pdev->dev);
> +
>  	/* open the can device */
>  	err =3D open_candev(dev);
>  	if (err) {

What if open_candev() fails? Please add a jump label
exit_open_candev_fail and add thje put_sync() there.

		goto exit_open_candev_fail;

> @@ -1079,6 +1085,7 @@ static int c_can_open(struct net_device *dev)
> =20
>  exit_irq_fail:
>  	close_candev(dev);
 exit_open_candev_fail:
> +	pm_runtime_put_sync(&priv->pdev->dev);
>  	return err;
>  }
> =20
> @@ -1091,6 +1098,7 @@ static int c_can_close(struct net_device *dev)
>  	c_can_stop(dev);
>  	free_irq(dev->irq, dev);
>  	close_candev(dev);
> +	pm_runtime_put_sync(&priv->pdev->dev);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index 4e56baa..ef84439 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -153,6 +153,7 @@ struct c_can_priv {
>  	struct can_priv can;	/* must be the first member */
>  	struct napi_struct napi;
>  	struct net_device *dev;
> +	struct platform_device *pdev;
>  	int tx_object;
>  	int current_status;
>  	int last_status;
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index d0a66cf..cbb1184 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -32,6 +32,7 @@
>  #include <linux/clk.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include <linux/can/dev.h>
> =20
> @@ -177,7 +178,11 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		goto exit_free_device;
>  	}
> =20
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
>  	dev->irq =3D irq;
> +	priv->pdev =3D pdev;
>  	priv->base =3D addr;
>  	priv->can.clock.freq =3D clk_get_rate(clk);
>  	priv->priv =3D clk;
> @@ -192,12 +197,16 @@ static int __devinit c_can_plat_probe(struct plat=
form_device *pdev)
>  		goto exit_free_device;
>  	}
> =20
> +	pm_runtime_put_sync(&pdev->dev);
> +
>  	dev_info(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\n",
>  		 KBUILD_MODNAME, priv->base, dev->irq);
>  	return 0;
> =20
>  exit_free_device:
>  	platform_set_drvdata(pdev, NULL);
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	free_c_can_dev(dev);
>  exit_iounmap:
>  	iounmap(addr);
> @@ -226,6 +235,8 @@ static int __devexit c_can_plat_remove(struct platf=
orm_device *pdev)
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));
> =20
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	clk_put(priv->priv);
> =20
>  	return 0;
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4F7E1AC2F146BEF91ECCC057
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAhApUACgkQjTAFq1RaXHMlqwCbB4cuwReh654CfAwoq/TPcUYv
A4gAoIwvuiSuhf4133Jk+WtMq+T4OqCM
=lD9k
-----END PGP SIGNATURE-----

--------------enig4F7E1AC2F146BEF91ECCC057--
