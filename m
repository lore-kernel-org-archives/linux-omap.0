From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v7 1/8] can: dev: Add support for limiting configured
 bitrate
Date: Mon, 15 Jan 2018 14:40:59 +0100
Message-ID: <d82752f1-657f-b07e-5d91-b39ea0b6984d@pengutronix.de>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-2-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZxzHiZ5fqlE97kubpqVPApySj5MnCSqft"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1515581725-29242-2-git-send-email-faiz_abbas@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZxzHiZ5fqlE97kubpqVPApySj5MnCSqft
Content-Type: multipart/mixed; boundary="P0AcwNiSf30O1HYpeA3Ier7twBlCFFmhH";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org,
 b29396@freescale.com
Message-ID: <d82752f1-657f-b07e-5d91-b39ea0b6984d@pengutronix.de>
Subject: Re: [PATCH v7 1/8] can: dev: Add support for limiting configured
 bitrate
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-2-git-send-email-faiz_abbas@ti.com>
In-Reply-To: <1515581725-29242-2-git-send-email-faiz_abbas@ti.com>

--P0AcwNiSf30O1HYpeA3Ier7twBlCFFmhH
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 11:55 AM, Faiz Abbas wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
>=20
> Various CAN or CAN-FD IP may be able to run at a faster rate than
> what the transceiver the CAN node is connected to. This can lead to
> unexpected errors. However, CAN transceivers typically have fixed
> limitations and provide no means to discover these limitations at
> runtime. Therefore, add support for a can-transceiver node that
> can be reused by other CAN peripheral drivers to determine for both
> CAN and CAN-FD what the max bitrate that can be used. If the user
> tries to configure CAN to pass these maximum bitrates it will throw
> an error.
>=20
> Also add support for reading bitrate_max via the netlink interface.

added to can-next with some minor changes. See inline.

> Reviewed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> [nsekhar@ti.com: fix build error with !CONFIG_OF]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/dev.c            | 45 ++++++++++++++++++++++++++++++++=
+++++++-
>  include/linux/can/dev.h          |  8 +++++++
>  include/uapi/linux/can/netlink.h |  1 +
>  3 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 365a8cc..c5bc33f 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -27,6 +27,7 @@
>  #include <linux/can/skb.h>
>  #include <linux/can/netlink.h>
>  #include <linux/can/led.h>
> +#include <linux/of.h>
>  #include <net/rtnetlink.h>
> =20
>  #define MOD_DESC "CAN device driver interface"
> @@ -814,6 +815,29 @@ int open_candev(struct net_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(open_candev);
> =20
> +#ifdef CONFIG_OF
> +/* Common function that can be used to understand the limitation of
> + * a transceiver when it provides no means to determine these limitati=
ons
> + * at runtime.
> + */
> +void of_can_transceiver(struct net_device *dev)
> +{
> +	struct device_node *dn;
> +	struct can_priv *priv =3D netdev_priv(dev);
> +	struct device_node *np =3D dev->dev.parent->of_node;
> +	int ret;
> +
> +	dn =3D of_get_child_by_name(np, "can-transceiver");
> +	if (!dn)
> +		return;
> +
> +	ret =3D of_property_read_u32(dn, "max-bitrate", &priv->bitrate_max);
> +	if ((ret && ret !=3D -EINVAL) || (!ret && !priv->bitrate_max))
> +		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignorin=
g bitrate limit.\n");
> +}
> +EXPORT_SYMBOL_GPL(of_can_transceiver);
> +#endif
> +
>  /*
>   * Common close function for cleanup before the device gets closed.
>   *
> @@ -913,6 +937,13 @@ static int can_changelink(struct net_device *dev, =
struct nlattr *tb[],
>  					priv->bitrate_const_cnt);
>  		if (err)
>  			return err;
> +
> +		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
> +			netdev_err(dev, "arbitration bitrate surpasses transceiver capabili=
ties of %d bps\n",
> +				   priv->bitrate_max);
> +			return -EINVAL;
> +		}
> +
>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
> =20
>  		if (priv->do_set_bittiming) {
> @@ -997,6 +1028,13 @@ static int can_changelink(struct net_device *dev,=
 struct nlattr *tb[],
>  					priv->data_bitrate_const_cnt);
>  		if (err)
>  			return err;
> +
> +		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
> +			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilit=
ies of %d bps\n",
> +				   priv->bitrate_max);
> +			return -EINVAL;
> +		}
> +
>  		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
> =20
>  		if (priv->do_set_data_bittiming) {
> @@ -1064,6 +1102,7 @@ static size_t can_get_size(const struct net_devic=
e *dev)
>  	if (priv->data_bitrate_const)				/* IFLA_CAN_DATA_BITRATE_CONST */
>  		size +=3D nla_total_size(sizeof(*priv->data_bitrate_const) *
>  				       priv->data_bitrate_const_cnt);
> +	size +=3D sizeof(priv->bitrate_max);

Added "mising" comment: /* IFLA_CAN_BITRATE_MAX */

> =20
>  	return size;
>  }
> @@ -1121,7 +1160,11 @@ static int can_fill_info(struct sk_buff *skb, co=
nst struct net_device *dev)
>  	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
>  		     sizeof(*priv->data_bitrate_const) *
>  		     priv->data_bitrate_const_cnt,
> -		     priv->data_bitrate_const))
> +		     priv->data_bitrate_const)) ||
> +
> +	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
> +		     sizeof(priv->bitrate_max),
> +		     &priv->bitrate_max))
>  	    )
> =20
>  		return -EMSGSIZE;
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 61f1cf2..a199423 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -46,8 +46,10 @@ struct can_priv {
>  	unsigned int bitrate_const_cnt;
>  	const u32 *data_bitrate_const;
>  	unsigned int data_bitrate_const_cnt;
> +	u32 bitrate_max;
>  	struct can_clock clock;
> =20
> +

I've removed this.

>  	enum can_state state;
> =20
>  	/* CAN controller features - see include/uapi/linux/can/netlink.h */
> @@ -166,6 +168,12 @@ void can_put_echo_skb(struct sk_buff *skb, struct =
net_device *dev,
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx=
);
>  void can_free_echo_skb(struct net_device *dev, unsigned int idx);
> =20
> +#ifdef CONFIG_OF
> +void of_can_transceiver(struct net_device *dev);
> +#else
> +static inline void of_can_transceiver(struct net_device *dev) { }
> +#endif
> +
>  struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame=
 **cf);
>  struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>  				struct canfd_frame **cfd);
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
> index 96710e7..9f56fad4 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -132,6 +132,7 @@ enum {
>  	IFLA_CAN_TERMINATION_CONST,
>  	IFLA_CAN_BITRATE_CONST,
>  	IFLA_CAN_DATA_BITRATE_CONST,
> +	IFLA_CAN_BITRATE_MAX,
>  	__IFLA_CAN_MAX
>  };
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--P0AcwNiSf30O1HYpeA3Ier7twBlCFFmhH--

--ZxzHiZ5fqlE97kubpqVPApySj5MnCSqft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcr2sACgkQHv7KIOw4
HPYL7ggAtTPTto9K2d3nWZFUvQipdz64GUsOi96NNE8XWCm5WknPKA3PbtfDqV+J
xoJPR7ItKZZN3531JKjKoG1xunVXMOPUUZkuLszANmd0iDcXlc2vI9bCGuCw7No4
9fvk2YcIyKsv/efKPxxmmpePhC72R/mWXgM3S1v6cKyxEcTG6yr/cAWI24e4lbcL
Ir6NkOBz/aTUm6oKXlSCmxeeCaVU2fASVSeMP/PIlf5Jdxxznsjs2CFzJUWi8Fr4
+C+i/n6Aw+9IUtsYpj96u3kmpdEcRMxFxP/96GAn2uBuSnZ/fIMImrsy9js6RiX+
LV9vpLInTb81BZZZ05wcM81t5kOkWg==
=f3Ig
-----END PGP SIGNATURE-----

--ZxzHiZ5fqlE97kubpqVPApySj5MnCSqft--
