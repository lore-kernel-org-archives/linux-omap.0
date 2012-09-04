From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: c_can: Add d_can raminit support
Date: Tue, 04 Sep 2012 09:39:20 +0200
Message-ID: <5045B028.3070503@pengutronix.de>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-3-git-send-email-anilkumar@ti.com> <50451573.4090109@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA26305@DBDE01.ent.ti.com> <5045AF8D.7020208@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3F7B073A0CE7548ED4EF2D2B"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <5045AF8D.7020208@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F7B073A0CE7548ED4EF2D2B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/04/2012 09:36 AM, Vaibhav Hiremath wrote:
>=20
>=20
> On 9/4/2012 11:44 AM, AnilKumar, Chimata wrote:
>> Hi Marc,
>>
>> On Tue, Sep 04, 2012 at 02:09:15, Marc Kleine-Budde wrote:
>>> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
>>>> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM.
>>>> DCAN RAM holds all the message objects during transmission or
>>>> receiving of data. This initialization/de-initialization should
>>>> be done in synchronous with D_CAN clock.
>>>>
>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>>> ---
>>>>  drivers/net/can/c_can/c_can.c          |   13 ++++++++++++
>>>>  drivers/net/can/c_can/c_can.h          |    2 ++
>>>>  drivers/net/can/c_can/c_can_platform.c |   10 +++++++++
>>>>  include/linux/can/platform/c_can.h     |   36 +++++++++++++++++++++=
+++++++++++
>>>>  4 files changed, 61 insertions(+)
>>>>  create mode 100644 include/linux/can/platform/c_can.h
>>>>
>>>> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c=
_can.c
>>>> index aa6c5eb..c175410 100644
>>>> --- a/drivers/net/can/c_can/c_can.c
>>>> +++ b/drivers/net/can/c_can/c_can.c
>>>> @@ -214,6 +214,12 @@ static inline void c_can_pm_runtime_put_sync(co=
nst struct c_can_priv *priv)
>>>>  		pm_runtime_put_sync(priv->device);
>>>>  }
>>>> =20
>>>> +static inline void c_can_reset_ram(const struct c_can_priv *priv, b=
ool enable)
>>>> +{
>>>> +	if (priv->ram_init)
>>>> +		priv->ram_init(priv->instance, enable);
>>>> +}
>>>> +
>>>>  static inline int get_tx_next_msg_obj(const struct c_can_priv *priv=
)
>>>>  {
>>>>  	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
>>>> @@ -1071,6 +1077,8 @@ static int c_can_open(struct net_device *dev)
>>>>  	struct c_can_priv *priv =3D netdev_priv(dev);
>>>> =20
>>>>  	c_can_pm_runtime_get_sync(priv);
>>>> +	/* Initialize DCAN RAM */
>>>> +	c_can_reset_ram(priv, true);
>>>> =20
>>>>  	/* open the can device */
>>>>  	err =3D open_candev(dev);
>>>> @@ -1099,6 +1107,8 @@ static int c_can_open(struct net_device *dev)
>>>>  exit_irq_fail:
>>>>  	close_candev(dev);
>>>>  exit_open_fail:
>>>> +	/* De-Initialize DCAN RAM */
>>>> +	c_can_reset_ram(priv, false);
>>>>  	c_can_pm_runtime_put_sync(priv);
>>>>  	return err;
>>>>  }
>>>> @@ -1112,6 +1122,9 @@ static int c_can_close(struct net_device *dev)=

>>>>  	c_can_stop(dev);
>>>>  	free_irq(dev->irq, dev);
>>>>  	close_candev(dev);
>>>> +
>>>> +	/* De-Initialize DCAN RAM */
>>>> +	c_can_reset_ram(priv, false);
>>>>  	c_can_pm_runtime_put_sync(priv);
>>>> =20
>>>>  	return 0;
>>>> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c=
_can.h
>>>> index 1437a6d..5f6339c 100644
>>>> --- a/drivers/net/can/c_can/c_can.h
>>>> +++ b/drivers/net/can/c_can/c_can.h
>>>> @@ -166,6 +166,8 @@ struct c_can_priv {
>>>>  	unsigned int tx_echo;
>>>>  	void *priv;		/* for board-specific data */
>>>>  	u16 irqstatus;
>>>> +	unsigned int instance;
>>>> +	void (*ram_init) (unsigned int instance, bool enable);
>>>>  };
>>>> =20
>>>>  struct net_device *alloc_c_can_dev(void);
>>>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/ca=
n/c_can/c_can_platform.c
>>>> index c351975..c6963b2 100644
>>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>>> @@ -34,6 +34,7 @@
>>>>  #include <linux/of_device.h>
>>>>  #include <linux/pm_runtime.h>
>>>>  #include <linux/pinctrl/consumer.h>
>>>> +#include <linux/can/platform/c_can.h>
>>>> =20
>>>>  #include <linux/can/dev.h>
>>>> =20
>>>> @@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>>>>  	struct net_device *dev;
>>>>  	struct c_can_priv *priv;
>>>>  	const struct of_device_id *match;
>>>> +	struct c_can_platform_data *pdata =3D NULL;
>>>>  	const struct platform_device_id *id;
>>>>  	struct pinctrl *pinctrl;
>>>>  	struct resource *mem;
>>>> @@ -179,6 +181,14 @@ static int __devinit c_can_plat_probe(struct pl=
atform_device *pdev)
>>>>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
>>>>  		priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>>>>  		priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
>>>> +		pdata =3D pdev->dev.platform_data;
>>>> +		if (!pdata) {
>>>> +			dev_err(&pdev->dev, "d_can platform data missing\n");
>>>> +			ret =3D -EINVAL;
>>>
>>> Is the ram_init mandatory on all d_can? There might be non omap d_can=
 users.
>>
>> As per AM335x specifications d_can module should have ram_init.
>> In that case it's better to print warning and break the switch.
>>
>=20
> As far as I know, "ram_init" is part of IP spec, how it is controlled
> does varies based on SoC integration.

Thanks for your insight. Leave the code as it is. If there is another
d_can user we know more and will improve/fix the code :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3F7B073A0CE7548ED4EF2D2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBFsCgACgkQjTAFq1RaXHMeWACdGBubxDdrl++E5SVpcbZO0M+M
UagAnRXsnq0yP4ANC2etID+CwTHz36WP
=qo7F
-----END PGP SIGNATURE-----

--------------enig3F7B073A0CE7548ED4EF2D2B--
