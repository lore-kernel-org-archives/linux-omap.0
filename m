From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net: can: c_can: Fix default pinmux glitch at init
Date: Tue, 7 Jul 2015 16:43:05 +0200
Message-ID: <559BE579.2020109@pengutronix.de>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
 <1436279277-3386-2-git-send-email-rogerq@ti.com>
 <559BE34F.8080508@pengutronix.de> <559BE3BE.2020608@ti.com>
 <559BE433.9020308@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Nn1rnQlbGDrUM2QoIMK8BmMIUEIrHfrFl"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <559BE433.9020308@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, wg@grandegger.com, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nn1rnQlbGDrUM2QoIMK8BmMIUEIrHfrFl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2015 04:37 PM, Roger Quadros wrote:
>>>> diff --git a/drivers/net/can/c_can/c_can.c
>>>> b/drivers/net/can/c_can/c_can.c
>>>> index 041525d..66e98e7 100644
>>>> --- a/drivers/net/can/c_can/c_can.c
>>>> +++ b/drivers/net/can/c_can/c_can.c
>>>> @@ -605,7 +605,18 @@ static int c_can_start(struct net_device *dev)
>>>>       priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>>>>
>>>>       /* activate pins */
>>>> -    pinctrl_pm_select_default_state(dev->dev.parent);
>>>> +#ifdef CONFIG_PINCTRL
>>>
>>> Please remove the ifdef, AFAICS there are static inline noop function=
s
>>> if CONFIG_PINCTRL switched off.
>>
>> yes, you are right.
>=20
> On second thoughts
>=20
> device->pins are not defined if CONFIG_PINCTRL is not set.
> so we can't remove the #ifdef.

Too bad :(

okay - should I add stable@v.k.o on Cc?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Nn1rnQlbGDrUM2QoIMK8BmMIUEIrHfrFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVm+V5AAoJEP5prqPJtc/HBxEIAJ4WIP0MQfzgygNgENNA3SYX
SFszysMjsErA6GncYP66hPnKYP+rRJ3FrA8MWJxj8Z31ZM+K9+bXjl78BQFHslVu
yduiCgKuHRTcmLITF2KjuGFDGM0faqVh4ZfSRHwhiQP8P7SFlk1MSxYjql9vIcTq
V9sN6z17UYsL3mxUKHpv/G+t99x+oJgvlBrfziJtC5+IiO9BGdj4bVcHKsutuwxa
SwjMGZcgUfzX/6mkMnK3/sWlIGHFfdNEVFBC7SFfzZuUf+nEWs3XyWzuxgRFXlPR
ylDAGWPr98Ate4bGhvSRxXaI3We+1Xl6z2u3H498zbAJA5i7RRuxVGtTsRm5yc0=
=DI7g
-----END PGP SIGNATURE-----

--Nn1rnQlbGDrUM2QoIMK8BmMIUEIrHfrFl--
