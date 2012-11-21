From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] can: c_can: Add d_can raminit support
Date: Wed, 21 Nov 2012 09:27:17 +0100
Message-ID: <50AC9065.4010705@pengutronix.de>
References: <1353476650-24398-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1552462886570304591=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353476650-24398-1-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
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
--===============1552462886570304591==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD8BDE1FE0BBC01CA9C9E54FD"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8BDE1FE0BBC01CA9C9E54FD
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
> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> ---
> Changes from v1:
> 	- Incorporated Marc's comments on v1
> 	  * sanity check moved to c_can_probe() from c_can_hw_raminit()
> 	  * device instance is assigned using conditional operator
> 	  * Changed warning to info to tell control module is not
> 	    used for raminit if there is no second IORESOURCE_MEM
> 	- Dropped dt patches
> 	  * No changes from v1
> 	  * Those will go to linux-omap/master
>=20
>  drivers/net/can/c_can/c_can.c          |   12 ++++++++++++
>  drivers/net/can/c_can/c_can.h          |    3 +++
>  drivers/net/can/c_can/c_can_platform.c |   33 ++++++++++++++++++++++++=
+++++++-
>  3 files changed, 47 insertions(+), 1 deletion(-)
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
> index ee141613..d1c31c8 100644
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
> @@ -68,6 +70,21 @@ static void c_can_plat_write_reg_aligned_to_32bit(st=
ruct c_can_priv *priv,
>  	writew(val, priv->base + 2 * priv->regs[index]);
>  }
> =20
> +static void c_can_hw_raminit(const struct c_can_priv *priv, bool enabl=
e)
> +{
> +	u32 val;
> +
> +	val =3D readl(priv->raminit_ctrlreg);
> +	if (enable) {
> +		val &=3D ~CAN_RAMINIT_START_MASK(priv->instance);

What's the point of clearing the bit first?

> +		val |=3D CAN_RAMINIT_START_MASK(priv->instance);
> +		writel(val, priv->raminit_ctrlreg);
> +	} else {
> +		val &=3D ~CAN_RAMINIT_START_MASK(priv->instance);
> +		writel(val, priv->raminit_ctrlreg);
> +	}

This should do the same?

	if (enable)
		val |=3D CAN_RAMINIT_START_MASK(priv->instance);
	else
		val &=3D ~CAN_RAMINIT_START_MASK(priv->instance);
	writel(val, priv->raminit_ctrlreg);

I can add the changes while applying the patch.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD8BDE1FE0BBC01CA9C9E54FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCskGkACgkQjTAFq1RaXHOijwCfaLLYhmnN87dKsqTtI1k3n2my
OvEAnAtGM4L7cby3yUj2eSwot+VYIlxh
=97te
-----END PGP SIGNATURE-----

--------------enigD8BDE1FE0BBC01CA9C9E54FD--

--===============1552462886570304591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1552462886570304591==--
