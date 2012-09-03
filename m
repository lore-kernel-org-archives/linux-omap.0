From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v9] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Mon, 03 Sep 2012 10:52:22 +0200
Message-ID: <50446FC6.2020203@pengutronix.de>
References: <1345461654-439-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC31ED6C21B1E15AC9B7A1D8C"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1345461654-439-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC31ED6C21B1E15AC9B7A1D8C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2012 01:20 PM, AnilKumar Ch wrote:
> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> register of C_CAN/D_CAN IP when clock is turned off.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> This patch has been tested on AM335X EVM. Due to lack of hardware
> I am not able to test c_can functionality. I appreciate if anyone
> can test c_can functionality with this patch.

Looks good. I've marked the c_can_priv *priv pointer as const in
c_can_pm_runtime_{get,put}_sync.

thanks, Marc

>=20
> This patch is based on "can-next/master"=20
>=20
> Changes from v8:
> 	- corrected the return path sequence in c_can_probe()
>=20
> Changes from v7:
> 	- Incorporated Marc's comments on v7
> 	  * changed device pointer to c_can_priv pointer
>=20
> Changes from v6:
> 	- Incorporated Marc's comments on v6
> 	  * changed dev pointer to priv
> 	  * removed platform_device.h include from c_can.c
>=20
> Changes from v5:
> 	- Incorporated Marc's comments on v5
> 	  * changed runtime pm calls in c_can driver to handle
> 	    the drivers which are not using platform drivers.
> 	  * added device pointer protection in c_can driver if
> 	    not passed from platform/pci driver.
>=20
> Changes from v4:
> 	- Incorporated Vaibhav H review comments on v4.
> 	  * Moved pm_runtime put/get_sync calls to appropriate positions.
> 	- This patch is from "Add DT support to C_CAN/D_CAN controller"
> 	  patch series. Rest of the patches in this series were applied
> 	  so this v5 contains only this patch.
>=20
>  drivers/net/can/c_can/c_can.c          |   24 +++++++++++++++++++++++-=

>  drivers/net/can/c_can/c_can.h          |    1 +
>  drivers/net/can/c_can/c_can_platform.c |   11 +++++++++--
>  3 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 4c538e3..966d318 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -34,6 +34,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/list.h>
>  #include <linux/io.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -201,6 +202,18 @@ static const struct can_bittiming_const c_can_bitt=
iming_const =3D {
>  	.brp_inc =3D 1,
>  };
> =20
> +static inline void c_can_pm_runtime_get_sync(struct c_can_priv *priv)

I've marked the priv pointer as const.

> +{
> +	if (priv->device)
> +		pm_runtime_get_sync(priv->device);
> +}
> +
> +static inline void c_can_pm_runtime_put_sync(struct c_can_priv *priv)

dito.

> +{
> +	if (priv->device)
> +		pm_runtime_put_sync(priv->device);
> +}
> +
>  static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
>  {
>  	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
> @@ -673,11 +686,15 @@ static int c_can_get_berr_counter(const struct ne=
t_device *dev,
>  	unsigned int reg_err_counter;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> +	c_can_pm_runtime_get_sync(priv);
> +
>  	reg_err_counter =3D priv->read_reg(priv, C_CAN_ERR_CNT_REG);
>  	bec->rxerr =3D (reg_err_counter & ERR_CNT_REC_MASK) >>
>  				ERR_CNT_REC_SHIFT;
>  	bec->txerr =3D reg_err_counter & ERR_CNT_TEC_MASK;
> =20
> +	c_can_pm_runtime_put_sync(priv);
> +
>  	return 0;
>  }
> =20
> @@ -1053,11 +1070,13 @@ static int c_can_open(struct net_device *dev)
>  	int err;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> +	c_can_pm_runtime_get_sync(priv);
> +
>  	/* open the can device */
>  	err =3D open_candev(dev);
>  	if (err) {
>  		netdev_err(dev, "failed to open can device\n");
> -		return err;
> +		goto exit_open_fail;
>  	}
> =20
>  	/* register interrupt handler */
> @@ -1079,6 +1098,8 @@ static int c_can_open(struct net_device *dev)
> =20
>  exit_irq_fail:
>  	close_candev(dev);
> +exit_open_fail:
> +	c_can_pm_runtime_put_sync(priv);
>  	return err;
>  }
> =20
> @@ -1091,6 +1112,7 @@ static int c_can_close(struct net_device *dev)
>  	c_can_stop(dev);
>  	free_irq(dev->irq, dev);
>  	close_candev(dev);
> +	c_can_pm_runtime_put_sync(priv);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index 4e56baa..1437a6d 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -153,6 +153,7 @@ struct c_can_priv {
>  	struct can_priv can;	/* must be the first member */
>  	struct napi_struct napi;
>  	struct net_device *dev;
> +	struct device *device;
>  	int tx_object;
>  	int current_status;
>  	int last_status;
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index d0a66cf..90801c4 100644
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
> @@ -177,8 +178,11 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		goto exit_free_device;
>  	}
> =20
> +	pm_runtime_enable(&pdev->dev);
> +
>  	dev->irq =3D irq;
>  	priv->base =3D addr;
> +	priv->device =3D &pdev->dev;
>  	priv->can.clock.freq =3D clk_get_rate(clk);
>  	priv->priv =3D clk;
> =20
> @@ -189,15 +193,17 @@ static int __devinit c_can_plat_probe(struct plat=
form_device *pdev)
>  	if (ret) {
>  		dev_err(&pdev->dev, "registering %s failed (err=3D%d)\n",
>  			KBUILD_MODNAME, ret);
> -		goto exit_free_device;
> +		goto exit_clear_drvdata;
>  	}
> =20
>  	dev_info(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\n",
>  		 KBUILD_MODNAME, priv->base, dev->irq);
>  	return 0;
> =20
> -exit_free_device:
> +exit_clear_drvdata:
>  	platform_set_drvdata(pdev, NULL);
> +	pm_runtime_disable(&pdev->dev);
> +exit_free_device:
>  	free_c_can_dev(dev);
>  exit_iounmap:
>  	iounmap(addr);
> @@ -226,6 +232,7 @@ static int __devexit c_can_plat_remove(struct platf=
orm_device *pdev)
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));
> =20
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


--------------enigC31ED6C21B1E15AC9B7A1D8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBEb8kACgkQjTAFq1RaXHN6IwCgjI691MwpCksZehHFJ7TzJp3x
h9QAmgPEtP72cFqCKWl2jHuaTXjs6c19
=9Zbp
-----END PGP SIGNATURE-----

--------------enigC31ED6C21B1E15AC9B7A1D8C--
