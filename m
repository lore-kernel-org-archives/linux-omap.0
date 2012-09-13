From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: Move pm_runtime_enable/disable calls to common
 code
Date: Thu, 13 Sep 2012 16:19:08 +0200
Message-ID: <5051EB5C.7000907@pengutronix.de>
References: <1347521292-28751-1-git-send-email-anilkumar@ti.com> <87bohaf1sd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4785F440CEEA87A78D8705DF"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <87bohaf1sd.fsf@deeprootsystems.com>
Sender: linux-can-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4785F440CEEA87A78D8705DF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/13/2012 04:14 PM, Kevin Hilman wrote:
> AnilKumar Ch <anilkumar@ti.com> writes:
>=20
>> Move pm_runtime_enable/disable calls to c_can.c driver. Current
>> implementation is such that platform driver is doing pm_runtime
>> enable/disable and core driver is doing put_sync/get_sync.
>>
>> PM runtime calls should be invoked if there is a valid device
>> pointer from platform driver so moving enable/disable calls
>> to core driver.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>> Incorporated Kevin's comments on "can: c_can: Add runtime PM
>> support to Bosch C_CAN/D_CAN controller" patch.
>=20
> This looks better, but in addition, you can get rid of the
> runtime PM helper functions you added (the ones that check for
> priv->device) and call the pm_runtime_get/put APIs directly.

But priv->device might be NULL. AFAICS pm_runtime_get() is not safe to
be called with a NULL pointer.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4785F440CEEA87A78D8705DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBR618ACgkQjTAFq1RaXHP/4QCeKvTMJmTZ/a61Dgs4pmJj6BSl
tzsAnA/ODGcz5mYOLh2W9+MlKuQGegXH
=R+vt
-----END PGP SIGNATURE-----

--------------enig4785F440CEEA87A78D8705DF--
