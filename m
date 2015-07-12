From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: dra7x-evm: Prevent glitch on DCAN1 pinmux
Date: Sun, 12 Jul 2015 21:18:47 +0200
Message-ID: <55A2BD97.8080006@pengutronix.de>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
 <1436279277-3386-3-git-send-email-rogerq@ti.com>
 <559EBEC8.1070609@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Q8btbFFxjd27kUtdRAj6DPtoNqWAbxiDQ"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <559EBEC8.1070609@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, wg@grandegger.com, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q8btbFFxjd27kUtdRAj6DPtoNqWAbxiDQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/09/2015 08:34 PM, Marc Kleine-Budde wrote:
> On 07/07/2015 04:27 PM, Roger Quadros wrote:
>> Driver core sets "default" pinmux on on probe and CAN driver
>> sets "sleep" pinmux during register. This causes a small window
>> where the CAN pins are in "default" state with the DCAN module
>> being disabled.
>>
>> Change the "default" state to be like sleep so this glitch is
>> avoided. Add a new "active" state that is used by the driver
>> when CAN is actually active.
>=20
> Who is taking care of this patch? I'm applying 1/2 (v2) to linux-can,
> should I take this patch, too?

I've included this patch in my pull request.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Q8btbFFxjd27kUtdRAj6DPtoNqWAbxiDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVor2XAAoJEP5prqPJtc/HB5wIAKPXm976UHlLXkYnaMNQJThy
ZZmpqTBQwYaoCIUkPVe96P963lGYbjfFrZkiaQpQvWrp7zKVWtQE0h401FqqQ95B
FSAql+DAIlez8/i8gHK/00uuG3kD2Sgu/HTRfSeQyBLbyiUlcrFKzmlrMZpb/09m
wb9c9WR3Z3o/MSXtFYmJ8kanBYKb7yb/X7+jU4xbO0JAgghq/VTJz5SAR19eCE/A
nxFfPU8fhgBi8C8Nut1LvBoaDukr6zYCHJJJLgojgiy42MqRdbjXcLlIJvsaRuGX
E6nk04ebq2+vB8or60KoJNl8hY22l6ACRbFH4YxvKOrUAibaIc56zUi5m15Hf90=
=VGTK
-----END PGP SIGNATURE-----

--Q8btbFFxjd27kUtdRAj6DPtoNqWAbxiDQ--
