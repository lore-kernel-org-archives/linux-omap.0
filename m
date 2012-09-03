From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: c_can: Add d_can raminit support
Date: Mon, 03 Sep 2012 22:39:15 +0200
Message-ID: <50451573.4090109@pengutronix.de>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D0B8E1B09236338243A46FB"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1346673139-14540-3-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D0B8E1B09236338243A46FB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM.
> DCAN RAM holds all the message objects during transmission or
> receiving of data. This initialization/de-initialization should
> be done in synchronous with D_CAN clock.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/net/can/c_can/c_can.c          |   13 ++++++++++++
>  drivers/net/can/c_can/c_can.h          |    2 ++
>  drivers/net/can/c_can/c_can_platform.c |   10 +++++++++
>  include/linux/can/platform/c_can.h     |   36 ++++++++++++++++++++++++=
++++++++
>  4 files changed, 61 insertions(+)
>  create mode 100644 include/linux/can/platform/c_can.h
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index aa6c5eb..c175410 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -214,6 +214,12 @@ static inline void c_can_pm_runtime_put_sync(const=
 struct c_can_priv *priv)
>  		pm_runtime_put_sync(priv->device);
>  }
> =20
> +static inline void c_can_reset_ram(const struct c_can_priv *priv, bool=
 enable)
> +{
> +	if (priv->ram_init)
> +		priv->ram_init(priv->instance, enable);
> +}
> +
>  static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
>  {
>  	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
> @@ -1071,6 +1077,8 @@ static int c_can_open(struct net_device *dev)
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
>  	c_can_pm_runtime_get_sync(priv);
> +	/* Initialize DCAN RAM */
> +	c_can_reset_ram(priv, true);
> =20
>  	/* open the can device */
>  	err =3D open_candev(dev);
> @@ -1099,6 +1107,8 @@ static int c_can_open(struct net_device *dev)
>  exit_irq_fail:
>  	close_candev(dev);
>  exit_open_fail:
> +	/* De-Initialize DCAN RAM */
> +	c_can_reset_ram(priv, false);
>  	c_can_pm_runtime_put_sync(priv);
>  	return err;
>  }
> @@ -1112,6 +1122,9 @@ static int c_can_close(struct net_device *dev)
>  	c_can_stop(dev);
>  	free_irq(dev->irq, dev);
>  	close_candev(dev);
> +
> +	/* De-Initialize DCAN RAM */
> +	c_can_reset_ram(priv, false);
>  	c_can_pm_runtime_put_sync(priv);
> =20
>  	return 0;
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index 1437a6d..5f6339c 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -166,6 +166,8 @@ struct c_can_priv {
>  	unsigned int tx_echo;
>  	void *priv;		/* for board-specific data */
>  	u16 irqstatus;
> +	unsigned int instance;
> +	void (*ram_init) (unsigned int instance, bool enable);
>  };
> =20
>  struct net_device *alloc_c_can_dev(void);
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index c351975..c6963b2 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -34,6 +34,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/can/platform/c_can.h>
> =20
>  #include <linux/can/dev.h>
> =20
> @@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platform=
_device *pdev)
>  	struct net_device *dev;
>  	struct c_can_priv *priv;
>  	const struct of_device_id *match;
> +	struct c_can_platform_data *pdata =3D NULL;
>  	const struct platform_device_id *id;
>  	struct pinctrl *pinctrl;
>  	struct resource *mem;
> @@ -179,6 +181,14 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
>  		priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>  		priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
> +		pdata =3D pdev->dev.platform_data;
> +		if (!pdata) {
> +			dev_err(&pdev->dev, "d_can platform data missing\n");
> +			ret =3D -EINVAL;

Is the ram_init mandatory on all d_can? There might be non omap d_can use=
rs.

Marc

> +			goto exit_free_device;
> +		}
> +		priv->ram_init =3D pdata->ram_init;
> +		priv->instance =3D pdata->instance;
>  		break;
>  	default:
>  		ret =3D -EINVAL;
> diff --git a/include/linux/can/platform/c_can.h b/include/linux/can/pla=
tform/c_can.h
> new file mode 100644
> index 0000000..84b27d2
> --- /dev/null
> +++ b/include/linux/can/platform/c_can.h
> @@ -0,0 +1,36 @@
> +/*
> + * C_CAN controller driver platform header
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.c=
om/
> + *
> + * Bosch C_CAN/D_CAN controller is compliant to CAN protocol version 2=
=2E0
> + * part A and B.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty=

> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __CAN_PLATFORM_C_CAN_H__
> +#define __CAN_PLATFORM_C_CAN_H__
> +
> +/**
> + * struct c_can_platform_data - C_CAN/D_CAN Platform Data
> + *
> + * @instance:		CAN instance, required for d_can raminit
> + * @ram_init:		CAN RAM initialization
> + *
> + * Platform data structure to get all platform specific settings.
> + * this structure also accounts the fact that the IP may have differen=
t
> + * RAM for different SOC's
> + */
> +struct c_can_platform_data {
> +	unsigned int instance;
> +	void (*ram_init) (unsigned int instance, bool enable);
> +};
> +#endif
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2D0B8E1B09236338243A46FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBFFXgACgkQjTAFq1RaXHMvywCfX0Qn+aiiaPuZouF3gaSewL3r
aFMAoJhOhKQxVL9EA4FBT84Ew0TSi/R/
=w/6f
-----END PGP SIGNATURE-----

--------------enig2D0B8E1B09236338243A46FB--
