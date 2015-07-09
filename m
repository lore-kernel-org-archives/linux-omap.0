From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] net: can: c_can: Fix default pinmux glitch at init
Date: Thu, 9 Jul 2015 12:59:30 +0200
Message-ID: <559E5412.5090604@pengutronix.de>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
 <1436279277-3386-2-git-send-email-rogerq@ti.com> <559D0BA4.9000000@ti.com>
 <559E53CD.5080302@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="J74rbFDEB9k7GWpGBI39vMvsdVnRsTPP4"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <559E53CD.5080302@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Roger Quadros <rogerq@ti.com>, wg@grandegger.com, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J74rbFDEB9k7GWpGBI39vMvsdVnRsTPP4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/09/2015 12:58 PM, Grygorii Strashko wrote:
> On 07/08/2015 02:38 PM, Roger Quadros wrote:
>> From: "J.D. Schroeder" <jay.schroeder@garmin.com>
>>
>> The previous change 3973c526ae9c (net: can: c_can: Disable pins when C=
AN interface
>> is down) causes a slight glitch on the pinctrl settings when used. Sin=
ce
>> commit ab78029 (drivers/pinctrl: grab default handles from device core=
),
>> the device core will automatically set the default pins. This causes
>> the pins to be momentarily set to the default and then to the sleep
>> state in register_c_can_dev(). By adding an optional "enable" state,
>> boards can set the default pin state to be disabled and avoid the
>> glitch when the switch from default to sleep first occurs. If the
>> "enable" state is not available c_can_pinctrl_select_state() falls
>> back to using the "default" pinctrl state.
>>
>> [Roger Q] - Forward port to v4.2 and use pinctrl_get_select().
>>
>> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/net/can/c_can/c_can.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_c=
an.c
>> index 041525d..5d214d1 100644
>> --- a/drivers/net/can/c_can/c_can.c
>> +++ b/drivers/net/can/c_can/c_can.c
>> @@ -592,6 +592,7 @@ static int c_can_start(struct net_device *dev)
>>   {
>>   	struct c_can_priv *priv =3D netdev_priv(dev);
>>   	int err;
>> +	struct pinctrl *p;
>>
>>   	/* basic c_can configuration */
>>   	err =3D c_can_chip_config(dev);
>> @@ -604,8 +605,13 @@ static int c_can_start(struct net_device *dev)
>>
>>   	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>>
>> -	/* activate pins */
>> -	pinctrl_pm_select_default_state(dev->dev.parent);
>> +	/* Attempt to use "active" if available else use "default" */
>> +	p =3D pinctrl_get_select(priv->device, "active");
>> +	if (!IS_ERR(p))
>> +		pinctrl_put(p);
>> +	else
>> +		pinctrl_pm_select_default_state(priv->device);
>> +
>=20
> Thanks. This part looks good to me now.

Is this an Acked-by?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--J74rbFDEB9k7GWpGBI39vMvsdVnRsTPP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVnlQSAAoJEP5prqPJtc/HDe8H/2LA5YTdwXF9E2kcKPtJsZl6
dLa8vitIGnq/AsN2NE55yR4AEffZ1BXTx7457pveMIbF3BPCNhK/z8FO/uGpZzoj
kZf5lPXZ2XA2ojO6Rt6cpun28NBBsj50W+V+Qyk8YoCWiylrN6teSRoI9JBf5eC1
ctP4Zu0OasU77KoK9lEb/JF4ydoi/eYCzFH0O2XQpVr0Z7QmjJA90ISnpCSJs3BO
WVVwi6c5q/0gedJszbQIZDPkM+03o9ausBP0oailOygdJV4vx12aK5r0YAWueLBq
KG0Szsjwgo4nHbWYDA5bGbyx6eXmj2nkzDCKoWLC/0HpvGql+/uAvOcNHw8gLh0=
=ujh6
-----END PGP SIGNATURE-----

--J74rbFDEB9k7GWpGBI39vMvsdVnRsTPP4--
