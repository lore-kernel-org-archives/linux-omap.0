From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] can: c_can: Add d_can raminit support
Date: Tue, 20 Nov 2012 11:50:41 +0100
Message-ID: <50AB6081.9060701@pengutronix.de>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5658297958093728828=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352916505-12343-2-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5658297958093728828==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig680CCE4119FA4D03FE933421"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig680CCE4119FA4D03FE933421
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
> which holds all the message objects during transmission or
> receiving of data. This initialization/de-initialization should
> be done in synchronous with D_CAN clock.
>=20
> In case of AM335X-EVM (active user of D_CAN driver) message RAM is
> controlled through control module register for both instances. So
> control module register details is required to initialization or
> de-initialization of message RAM according to instance number.
>=20
> Control module memory resource is obtained from D_CAN dt node and
> instance number obtained from device tree aliases node.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>

Some nitpicks inline.

Marc

> ---
>  drivers/net/can/c_can/c_can.c          |   12 +++++++++++
>  drivers/net/can/c_can/c_can.h          |    3 +++
>  drivers/net/can/c_can/c_can_platform.c |   34 ++++++++++++++++++++++++=
+++++++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index e5180df..c15830c 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -233,6 +233,12 @@ static inline void c_can_pm_runtime_put_sync(const=
 struct c_can_priv *priv)
>  		pm_runtime_put_sync(priv->device);
>  }
> =20
> +static inline void c_can_reset_ram(const struct c_can_priv *priv, bool=
 enable)
> +{
> +	if (priv->ram_init)
> +		priv->ram_init(priv, enable);
> +}
> +
>  static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
>  {
>  	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
> @@ -1090,6 +1096,7 @@ static int c_can_open(struct net_device *dev)
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
>  	c_can_pm_runtime_get_sync(priv);
> +	c_can_reset_ram(priv, true);
> =20
>  	/* open the can device */
>  	err =3D open_candev(dev);
> @@ -1118,6 +1125,7 @@ static int c_can_open(struct net_device *dev)
>  exit_irq_fail:
>  	close_candev(dev);
>  exit_open_fail:
> +	c_can_reset_ram(priv, false);
>  	c_can_pm_runtime_put_sync(priv);
>  	return err;
>  }
> @@ -1131,6 +1139,8 @@ static int c_can_close(struct net_device *dev)
>  	c_can_stop(dev);
>  	free_irq(dev->irq, dev);
>  	close_candev(dev);
> +
> +	c_can_reset_ram(priv, false);
>  	c_can_pm_runtime_put_sync(priv);
> =20
>  	return 0;
> @@ -1188,6 +1198,7 @@ int c_can_power_down(struct net_device *dev)
> =20
>  	c_can_stop(dev);
> =20
> +	c_can_reset_ram(priv, false);
>  	c_can_pm_runtime_put_sync(priv);
> =20
>  	return 0;
> @@ -1206,6 +1217,7 @@ int c_can_power_up(struct net_device *dev)
>  	WARN_ON(priv->type !=3D BOSCH_D_CAN);
> =20
>  	c_can_pm_runtime_get_sync(priv);
> +	c_can_reset_ram(priv, true);
> =20
>  	/* Clear PDR and INIT bits */
>  	val =3D priv->read_reg(priv, C_CAN_CTRL_EX_REG);
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index e5ed41d..419de5c 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -169,6 +169,9 @@ struct c_can_priv {
>  	void *priv;		/* for board-specific data */
>  	u16 irqstatus;
>  	enum c_can_dev_id type;
> +	u32 __iomem *raminit_ctrlreg;
> +	unsigned int instance;
> +	void (*ram_init) (const struct c_can_priv *priv, bool enable);
>  };
> =20
>  struct net_device *alloc_c_can_dev(void);
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index ee141613..2e61d69 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -38,6 +38,8 @@
> =20
>  #include "c_can.h"
> =20
> +#define CAN_RAMINIT_START_MASK(i)	(1 << (i))
> +
>  /*
>   * 16-bit c_can registers can be arranged differently in the memory
>   * architecture of different implementations. For example: 16-bit
> @@ -68,6 +70,24 @@ static void c_can_plat_write_reg_aligned_to_32bit(st=
ruct c_can_priv *priv,
>  	writew(val, priv->base + 2 * priv->regs[index]);
>  }
> =20
> +static void c_can_hw_raminit(const struct c_can_priv *priv, bool enabl=
e)
> +{
> +	u32 val;
> +
> +	if (!priv->raminit_ctrlreg || (priv->instance < 0))
> +		return;

Can you move this sanity check to the probe function and only assign
priv->ram_init if the above is true?

> +
> +	val =3D readl(priv->raminit_ctrlreg);
> +	if (enable) {
> +		val &=3D ~CAN_RAMINIT_START_MASK(priv->instance);
> +		val |=3D CAN_RAMINIT_START_MASK(priv->instance);
> +		writel(val, priv->raminit_ctrlreg);
> +	} else {
> +		val &=3D ~CAN_RAMINIT_START_MASK(priv->instance);
> +		writel(val, priv->raminit_ctrlreg);
> +	}
> +}
> +
>  static struct platform_device_id c_can_id_table[] =3D {
>  	[BOSCH_C_CAN_PLATFORM] =3D {
>  		.name =3D KBUILD_MODNAME,
> @@ -99,7 +119,7 @@ static int __devinit c_can_plat_probe(struct platfor=
m_device *pdev)
>  	const struct of_device_id *match;
>  	const struct platform_device_id *id;
>  	struct pinctrl *pinctrl;
> -	struct resource *mem;
> +	struct resource *mem, *res;
>  	int irq;
>  	struct clk *clk;
> =20
> @@ -178,6 +198,18 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
>  		priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>  		priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
> +
> +		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		priv->raminit_ctrlreg =3D
> +				devm_request_and_ioremap(&pdev->dev, res);

What happens if there isn't a second IORESOURCE_MEM region? devm_request
will print an error in this case and any other error, too [1]. Do we
need streamlining here?

[1] http://lxr.free-electrons.com/source/drivers/base/platform.c#L59

> +		if (!priv->raminit_ctrlreg)
> +			dev_warn(&pdev->dev, "failed to obtain control memory\n");
> +
> +		if (pdev->dev.of_node)
> +			pdev->id =3D of_alias_get_id(pdev->dev.of_node, "d_can");
> +
> +		priv->instance =3D pdev->id;

Please do not modify the pdev, better you use something like this:

    pdev->id < 0 ? of_alias_get_id(pdev->dev.of_node, "d_can") :
        pdev->id;

> +		priv->ram_init =3D c_can_hw_raminit;
>  		break;
>  	default:
>  		ret =3D -EINVAL;
>=20

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig680CCE4119FA4D03FE933421
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCrYIUACgkQjTAFq1RaXHOQEQCfVPAnCzgmXkdP1gRxQ5wigQnB
hRoAnj00+NXzDO4+tPreObd+t/t2ECVw
=enEc
-----END PGP SIGNATURE-----

--------------enig680CCE4119FA4D03FE933421--

--===============5658297958093728828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5658297958093728828==--
