From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8 9/9] net: can: c_can: Add support for TI am4372 DCAN
Date: Mon, 17 Nov 2014 15:31:33 +0100
Message-ID: <546A06C5.3020601@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de> <5469E55F.1050502@ti.com> <5469E61D.4050507@pengutronix.de> <5469EABB.10506@ti.com> <546A03D5.5080103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2e9kUVrwcJdnqL8b6tbgswgJInPU1CgwK"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <546A03D5.5080103@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2e9kUVrwcJdnqL8b6tbgswgJInPU1CgwK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2014 03:19 PM, Roger Quadros wrote:
> On 11/17/2014 02:31 PM, Roger Quadros wrote:
>> On 11/17/2014 02:12 PM, Marc Kleine-Budde wrote:
>>> On 11/17/2014 01:09 PM, Roger Quadros wrote:
>>>> AM4372 SoC has 2 DCAN modules. Add compatible id and
>>>> raminit driver data for it. The driver data is same as AM3352
>>>> but this gives us flexibility to add AM4372 specific quirks
>>>> if required later.
>>>
>>> Strictly speaking we don't need the hunk in
>>> "drivers/net/can/c_can/c_can_platform.c" yet, iff the AM4372 dts(i) h=
as
>>> this compatible:
>>>
>>> "ti,am4372-d_can", "ti,am3352-d_can"
>>
>> I tried with that, but checkpatch still gives this warning
>> WARNING: DT compatible string "ti,am4372-d_can" appears un-documented =
-- check ./Documentation/devicetree/bindings/
>>
>> I guess we can just live with it. Please ignore this patch in that cas=
e.
>=20
> Did you meant that we still need to add it in the binding documentation=
?
> It is not usable by itself so won't it be a problem to exist in documen=
tation?

I'll take patch 9 as is, since checkpatch is a bit more picky now :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2e9kUVrwcJdnqL8b6tbgswgJInPU1CgwK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUagbFAAoJECte4hHFiupUW6YQAJYpP4oEncsl0jHSjvvCMrtH
QKYWzlICFdXRqU3ULO1jJ3rhvI+SSf924gIx7eJvtXPpf0KoHlQnVWfyBAepm8pr
IaSh5J8jWmucwyB1iCea5WkF9Z4zv5RJE7RV8qez7gJAtYuJZftZw7CpJCBl5Abi
q49F5GjlQmRzg7IeEp+2xY+9kebbovbk1dVazW1IKqPveouQRI/G03RXd06ZOdjn
stAPX/2h7CkDmkkf7fz4/Rybmkbb/IUTzQR2XTuHSRKp/LAMx9zwvY3PE/YA3Sw5
rH8ExdUArSaiN2DeFiPKi3PfBpesAoTvZdKsdqFZTPhu0MTQpdfZh5zMAH7OF6Ig
41C8D9fYMNyXpJCjcB3fpTceEV9Ly3eleDhwZiMaDvMgl0OrtXg2Y/GFFSPd0N0e
1CV0vJO7fdiaCWzDGF0H7OTY/Me5Hgz6wmnZYoAZByaUjgUxhh2JmPV74m5iTalp
oNMkd/ERkt9une7a54Nl352MO3iut5QrOPTRfOLILL3GJx839sYcMaCuUwjABG9d
A+1KMBp4rZ/8AhscXoflvjfAz85hf3PSk4mHukr8zex8mfdOk4m7Y+j4VIe8Pg5z
6uxYrYCSy39bmp80bSFEF7mGz1I6YlChBa6az+9nKPYBxMrKcfTvmbE/wIPd35WG
TYdyjlGJ/esNVK2eKy9C
=zLtL
-----END PGP SIGNATURE-----

--2e9kUVrwcJdnqL8b6tbgswgJInPU1CgwK--
