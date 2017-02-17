From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 0/3] Adding DT support for TI HECC module
Date: Fri, 17 Feb 2017 10:36:27 +0100
Message-ID: <629fc164-dbdc-7305-c472-908d21cc8a89@pengutronix.de>
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
 <7c8fb14d-835b-d1d0-ca4f-4d184b711ae0@pengutronix.de>
 <CAGm1_kuQ1skHayOKu16JdZ3Bah+=CqzZJ5e6j2VDj3WW5No2vw@mail.gmail.com>
 <b6c8bfbe-1748-ee2c-2129-96e1bce9b324@pengutronix.de>
 <CAGm1_kvN_SiFS69aKRsJ-Hm9bjgVskYiONh_bTUGLhRozrKF_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Xbc9rKX3C6tUx1RMpDru4S7sTNXhKKtoH"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <CAGm1_kvN_SiFS69aKRsJ-Hm9bjgVskYiONh_bTUGLhRozrKF_A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, robh+dt@kernel.org, Tony Lindgren <tony@atomide.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, hs@denx.de, Anton Glukhov <anton.a.glukhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xbc9rKX3C6tUx1RMpDru4S7sTNXhKKtoH
Content-Type: multipart/mixed; boundary="oQvtcN6wvxRa9hm84FvMQImFn5FQ5B9rF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 Tony Lindgren <tony@atomide.com>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, hs@denx.de,
 Anton Glukhov <anton.a.glukhov@gmail.com>
Message-ID: <629fc164-dbdc-7305-c472-908d21cc8a89@pengutronix.de>
Subject: Re: [PATCH v3 0/3] Adding DT support for TI HECC module
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
 <7c8fb14d-835b-d1d0-ca4f-4d184b711ae0@pengutronix.de>
 <CAGm1_kuQ1skHayOKu16JdZ3Bah+=CqzZJ5e6j2VDj3WW5No2vw@mail.gmail.com>
 <b6c8bfbe-1748-ee2c-2129-96e1bce9b324@pengutronix.de>
 <CAGm1_kvN_SiFS69aKRsJ-Hm9bjgVskYiONh_bTUGLhRozrKF_A@mail.gmail.com>
In-Reply-To: <CAGm1_kvN_SiFS69aKRsJ-Hm9bjgVskYiONh_bTUGLhRozrKF_A@mail.gmail.com>

--oQvtcN6wvxRa9hm84FvMQImFn5FQ5B9rF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 10:23 AM, Yegor Yefremov wrote:
> On Fri, Feb 17, 2017 at 9:51 AM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
>> On 02/17/2017 09:50 AM, Yegor Yefremov wrote:
>>> On Fri, Feb 17, 2017 at 9:46 AM, Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
>>>> On 02/15/2017 03:48 PM, yegorslists@googlemail.com wrote:
>>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>>
>>>>> This is an attempt to revive DT support for TI HECC that was starte=
d in 2015 [1].
>>>>>
>>>>> Changes v2 -> v3:
>>>>>   - rename compatible property to "ti,am3517-hecc" (though there is=
 a stipped
>>>>>     device named 3505, EMAC driver already uses am3517-emac name, s=
o keep this
>>>>>     property consistent)
>>>>>   - use reg-names to specify different HECC I/O mapping (suggested =
by Tony Lindgren)
>>>>>   - provide fallback offsets and sizes for board files
>>>>
>>>> Are there any board files using te_hecc intree? I don't see any on t=
he
>>>> first glance. What about making the driver DT only?
>>>
>>> Good idea. I aslo wanted to ask this. So this means we could
>>> completely get rid of include/linux/can/platform/ti_hecc.h?
>>
>> If there isn't any in-tree user, thes yes.
>=20
> Btw. what should we do about "@transceiver_switch: platform specific
> callback fn for transceiver control"? Model it via something like
> this:
>=20
> enable-gpios =3D <&gpio6 15 GPIO_ACTIVE_HIGH>; /* gpio 175 */

Make it a regulator as in the flexcan:

> 	reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oQvtcN6wvxRa9hm84FvMQImFn5FQ5B9rF--

--Xbc9rKX3C6tUx1RMpDru4S7sTNXhKKtoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlimxBsACgkQHv7KIOw4
HPZKzAf+Lg4VEaDqDl2ocHz+usiNn+HvmTjq1CukAN1HqDz0JAHwihgOPNuEMVOM
jycfA77PwiPwB8/hYYN9J6dF9Hd4d5JXdXswJZim9IluCCevYY393zpvsXCxpErg
z0qEE1Z5xJUM0TjYOnsjRkFt+t+vMKBrMVoD3p62PrPTTGOFMy/uuJipZAqJn7yg
4YNwgx7VLx7GSjQyaIdsCPnopoXG6jEzlDD6ttjQJPWBRNOcVpep0GKWzAdqFyvq
Z3nA5KtryWKz4oRyondxVRd9ub+ma7Iowi6eC5wbvbyMSUGzndDQexNQ3wSfLY75
VDcjBxeW1cFgiKIuo8AKzpS1TwOAWQ==
=0ZoU
-----END PGP SIGNATURE-----

--Xbc9rKX3C6tUx1RMpDru4S7sTNXhKKtoH--
