From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: c_can: Add d_can suspend resume support
Date: Tue, 04 Sep 2012 09:27:18 +0200
Message-ID: <5045AD56.2050400@pengutronix.de>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-5-git-send-email-anilkumar@ti.com> <50450C9F.6010203@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA26300@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA62F9BCE4B9C81558C445340"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53533 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab2IDH1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 03:27:32 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA26300@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "tony@atomide.com" <tony@atomide.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA62F9BCE4B9C81558C445340
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/04/2012 08:14 AM, AnilKumar, Chimata wrote:
> Marc,
>=20
> Thanks for the comments,
>=20
> On Tue, Sep 04, 2012 at 01:31:35, Marc Kleine-Budde wrote:
>> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
>>> Adds suspend resume support to DCAN driver which enables
>>> DCAN power down mode bit (PDR). Then DCAN will ack the local
>>> power-down mode by setting PDA bit in STATUS register.
>>>
>>> Also adds a status flag to know the status of DCAN module,
>>> whether it is opened or not.
>>
>> Use "ndev->flags & IFF_UP" for that. Have a look at the at91_can drive=
r
>> [1]. I'm not sure if you need locking here.
>>
>=20
> Then I can use this to check the status, lock is not
> required.
>=20
>> [1] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L1=
198
>>
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>>  drivers/net/can/c_can/c_can.c          |   78 ++++++++++++++++++++++=
++++++++++
>>>  drivers/net/can/c_can/c_can.h          |    5 ++
>>>  drivers/net/can/c_can/c_can_platform.c |   70 ++++++++++++++++++++++=
++++--
>>>  3 files changed, 150 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_=
can.c
>>> index c175410..36d5db4 100644
>>> --- a/drivers/net/can/c_can/c_can.c
>>> +++ b/drivers/net/can/c_can/c_can.c
>>> @@ -46,6 +46,9 @@
>>>  #define IF_ENUM_REG_LEN		11
>>>  #define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + (iface) * IF_ENUM=
_REG_LEN)
>>> =20
>>> +/* control extension register D_CAN specific */
>>> +#define CONTROL_EX_PDR		BIT(8)
>>> +
>>>  /* control register */
>>>  #define CONTROL_TEST		BIT(7)
>>>  #define CONTROL_CCE		BIT(6)
>>> @@ -65,6 +68,7 @@
>>>  #define TEST_BASIC		BIT(2)
>>> =20
>>>  /* status register */
>>> +#define STATUS_PDA		BIT(10)
>>>  #define STATUS_BOFF		BIT(7)
>>>  #define STATUS_EWARN		BIT(6)
>>>  #define STATUS_EPASS		BIT(5)
>>> @@ -164,6 +168,9 @@
>>>  /* minimum timeout for checking BUSY status */
>>>  #define MIN_TIMEOUT_VALUE	6
>>> =20
>>> +/* Wait for ~1 sec for INIT bit */
>>> +#define INIT_WAIT_COUNT		1000
>>
>> What unit? INIT_WAIT_MS would be a better name.
>>
>=20
> Sure, will change
>=20
>>> +
>>>  /* napi related */
>>>  #define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
>>> =20
>>> @@ -1102,6 +1109,7 @@ static int c_can_open(struct net_device *dev)
>>> =20
>>>  	netif_start_queue(dev);
>>> =20
>>> +	priv->is_opened =3D true;
>>>  	return 0;
>>> =20
>>>  exit_irq_fail:
>>> @@ -1126,6 +1134,7 @@ static int c_can_close(struct net_device *dev)
>>>  	/* De-Initialize DCAN RAM */
>>>  	c_can_reset_ram(priv, false);
>>>  	c_can_pm_runtime_put_sync(priv);
>>> +	priv->is_opened =3D false;
>>> =20
>>>  	return 0;
>>>  }
>>> @@ -1154,6 +1163,75 @@ struct net_device *alloc_c_can_dev(void)
>>>  }
>>>  EXPORT_SYMBOL_GPL(alloc_c_can_dev);
>>> =20
>>> +#ifdef CONFIG_PM
>>> +int c_can_power_down(struct net_device *dev)
>>> +{
>>> +	unsigned long time_out;
>>> +	struct c_can_priv *priv =3D netdev_priv(dev);
>>> +
>>> +	if (!priv->is_opened)
>>> +		return 0;
>>
>> Should we add a BUG_ON(id->driver_data !=3D BOSCH_D_CAN)?
>=20
> These APIs are called from platform driver where device type
> device type is verified. I think we have to add BUG_ON() in
> platform driver.

The platform driver returns if not on D_CAN and will not call this
function. But this functions are exported, so can be called by someone
else. So if the caller is not D_CAN, it's a bug.

>>> +
>>> +	/* set `PDR` value so the device goes to power down mode */
>>> +	priv->write_reg(priv, C_CAN_CTRL_EX_REG,
>>> +		priv->read_reg(priv, C_CAN_CTRL_EX_REG) | CONTROL_EX_PDR);
>>
>> Please use an intermediate variable:
>>
>> u32 val;
>>
>> val =3D priv->read_reg(priv, C_CAN_CTRL_EX_REG);
>> val |=3D CONTROL_EX_PDR;
>> priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
>=20
> I will change
>=20
>>
>>> +
>>> +	/* Wait for the PDA bit to get set */
>>> +	time_out =3D jiffies + msecs_to_jiffies(INIT_WAIT_COUNT);
>>> +	while (!(priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
>>> +				time_after(time_out, jiffies))
>>> +		cpu_relax();
>>> +
>>> +	if (time_after(jiffies, time_out))
>>> +		return -ETIMEDOUT;
>>> +
>>> +	c_can_stop(dev);
>>> +
>>> +	/* De-initialize DCAN RAM */
>>> +	c_can_reset_ram(priv, false);
>>> +	c_can_pm_runtime_put_sync(priv);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(c_can_power_down);
>>> +
>>> +int c_can_power_up(struct net_device *dev)
>>> +{
>>> +	unsigned long time_out;
>>> +	struct c_can_priv *priv =3D netdev_priv(dev);
>>> +
>>
>> BUG_ON?
>>
>>> +	if (!priv->is_opened)
>>> +		return 0;
>>> +
>>> +	c_can_pm_runtime_get_sync(priv);
>>> +	/* Initialize DCAN RAM */
>>> +	c_can_reset_ram(priv, true);
>>> +
>>> +	/* Clear PDR and INIT bits */
>>> +	priv->write_reg(priv, C_CAN_CTRL_EX_REG,
>>> +		priv->read_reg(priv, C_CAN_CTRL_EX_REG) & ~CONTROL_EX_PDR);
>>> +	priv->write_reg(priv, C_CAN_CTRL_REG,
>>> +		priv->read_reg(priv, C_CAN_CTRL_REG) & ~CONTROL_INIT);
>>> +
>>> +	/* Wait for the PDA bit to get clear */
>>> +	time_out =3D jiffies + msecs_to_jiffies(INIT_WAIT_COUNT);
>>> +	while ((priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
>>> +				time_after(time_out, jiffies))
>>> +		cpu_relax();
>>> +
>>> +	if (time_after(jiffies, time_out))
>>> +		return -ETIMEDOUT;
>>> +
>>> +	c_can_start(dev);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(c_can_power_up);
>>> +#else
>>> +#define c_can_power_down NULL
>>> +#define c_can_power_up NULL
>>
>> These are not used, are they?
>=20
> Not used, I will remove this else part and adding
> #ifdef CONFIG_PM in header file as well.


okay.

>>> +#endif
>>> +
>>>  void free_c_can_dev(struct net_device *dev)
>>>  {
>>>  	free_candev(dev);
>>> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_=
can.h
>>> index 5f6339c..e5dd7ef 100644
>>> --- a/drivers/net/can/c_can/c_can.h
>>> +++ b/drivers/net/can/c_can/c_can.h
>>> @@ -24,6 +24,7 @@
>>> =20
>>>  enum reg {
>>>  	C_CAN_CTRL_REG =3D 0,
>>> +	C_CAN_CTRL_EX_REG,
>>>  	C_CAN_STS_REG,
>>>  	C_CAN_ERR_CNT_REG,
>>>  	C_CAN_BTR_REG,
>>> @@ -104,6 +105,7 @@ static const u16 reg_map_c_can[] =3D {
>>> =20
>>>  static const u16 reg_map_d_can[] =3D {
>>>  	[C_CAN_CTRL_REG]	=3D 0x00,
>>> +	[C_CAN_CTRL_EX_REG]	=3D 0x02,
>>>  	[C_CAN_STS_REG]		=3D 0x04,
>>>  	[C_CAN_ERR_CNT_REG]	=3D 0x08,
>>>  	[C_CAN_BTR_REG]		=3D 0x0C,
>>> @@ -166,6 +168,7 @@ struct c_can_priv {
>>>  	unsigned int tx_echo;
>>>  	void *priv;		/* for board-specific data */
>>>  	u16 irqstatus;
>>> +	bool is_opened;
>>>  	unsigned int instance;
>>>  	void (*ram_init) (unsigned int instance, bool enable);
>>>  };
>>> @@ -174,5 +177,7 @@ struct net_device *alloc_c_can_dev(void);
>>>  void free_c_can_dev(struct net_device *dev);
>>>  int register_c_can_dev(struct net_device *dev);
>>>  void unregister_c_can_dev(struct net_device *dev);
>>> +int c_can_power_up(struct net_device *dev);
>>> +int c_can_power_down(struct net_device *dev);
>>> =20
>>>  #endif /* C_CAN_H */
>>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can=
/c_can/c_can_platform.c
>>> index c6963b2..65ec232 100644
>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>> @@ -255,15 +255,79 @@ static int __devexit c_can_plat_remove(struct p=
latform_device *pdev)
>>>  	return 0;
>>>  }
>>> =20
>>> +#ifdef CONFIG_PM
>>> +static int c_can_suspend(struct platform_device *pdev, pm_message_t =
state)
>>> +{
>>> +	int ret;
>>> +	struct net_device *ndev =3D platform_get_drvdata(pdev);
>>> +	struct c_can_priv *priv =3D netdev_priv(ndev);
>>> +	const struct platform_device_id *id =3D platform_get_device_id(pdev=
);
>>
>> Does that work on DT probed devices? You probably have to save the
>> id->driver_data in struct c_can_priv.
>=20
> I will add extra variable to c_can_priv to save the dev_id so
> that it will work for dt case as well.
>=20
>>
>>> +
>>> +	if (id->driver_data !=3D BOSCH_D_CAN) {
>>> +		dev_warn(&pdev->dev, "Not supported\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	if (netif_running(ndev)) {
>>> +		netif_stop_queue(ndev);
>>> +		netif_device_detach(ndev);
>>> +	}
>>> +
>>> +	ret =3D c_can_power_down(ndev);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to enter power down mode\n");
>> netdev_err
>>> +		return ret;
>>> +	}
>>> +
>>> +	priv->can.state =3D CAN_STATE_SLEEPING;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int c_can_resume(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +
>> please remove the empty line ^^
>=20
> Sure
>=20
>>> +	struct net_device *ndev =3D platform_get_drvdata(pdev);
>>> +	struct c_can_priv *priv =3D netdev_priv(ndev);
>>> +	const struct platform_device_id *id =3D platform_get_device_id(pdev=
);
>>> +
>>> +	if (id->driver_data !=3D BOSCH_D_CAN) {
>>> +		dev_warn(&pdev->dev, "Not supported\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	ret =3D c_can_power_up(ndev);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "Still in power down mode\n");
>>
>> netdev_err
>=20
> I will change.
>=20
>>
>>> +		return ret;
>>> +	}
>>> +
>>> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>>> +
>>> +	if (netif_running(ndev)) {
>>> +		netif_device_attach(ndev);
>>> +		netif_start_queue(ndev);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +#else
>>> +#define c_can_suspend NULL
>>> +#define c_can_resume NULL
>>> +#endif
>>> +
>>>  static struct platform_driver c_can_plat_driver =3D {
>>>  	.driver =3D {
>>>  		.name =3D KBUILD_MODNAME,
>>>  		.owner =3D THIS_MODULE,
>>>  		.of_match_table =3D of_match_ptr(c_can_of_table),
>>>  	},
>>> -	.probe =3D c_can_plat_probe,
>>> -	.remove =3D __devexit_p(c_can_plat_remove),
>>> -	.id_table =3D c_can_id_table,
>>> +	.probe		=3D c_can_plat_probe,
>>> +	.remove		=3D __devexit_p(c_can_plat_remove),
>>> +	.suspend	=3D c_can_suspend,
>>> +	.resume		=3D c_can_resume,
>>> +	.id_table	=3D c_can_id_table,
>>
>> Please don't indent here with tab. Just stay with one space on both
>> sides of the "=3D".
>>
>=20
> Point taken
>=20
> Thanks
> AnilKumar
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA62F9BCE4B9C81558C445340
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBFrVkACgkQjTAFq1RaXHMw+ACcCX/YwHEy3aiv0fWfSGAaFsp4
29kAoIlnuiMk/qIxjVUFbNiqitB2JSOZ
=RvJ0
-----END PGP SIGNATURE-----

--------------enigA62F9BCE4B9C81558C445340--
