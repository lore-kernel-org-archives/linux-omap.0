From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] drivers: phy: add generic PHY framework
Date: Wed, 26 Sep 2012 20:01:42 +0200
Message-ID: <50634306.8050702@pengutronix.de>
References: <1348671675-20830-1-git-send-email-kishon@ti.com> <1348678677.15175.18.camel@joe-AO722> <2573688.gCRJ0R3vnc@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBAFF293761BECF07B5B71E4C"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2573688.gCRJ0R3vnc@dtor-d630.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joe Perches <joe@perches.com>, Kishon Vijay Abraham I <kishon@ti.com>, akpm@linux-foundation.org, davem@davemloft.net, santosh.shilimkar@ti.com, grant.likely@secretlab.ca, balbi@ti.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, robherring2@gmail.com, richard.zhao@freescale.com, B29397@freescale.com, alexander.shishkin@linux.intel.com, marex@denx.de, p.paneri@samsung.com, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBAFF293761BECF07B5B71E4C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/26/2012 07:41 PM, Dmitry Torokhov wrote:
> On Wednesday, September 26, 2012 09:57:57 AM Joe Perches wrote:
>> On Wed, 2012-09-26 at 20:31 +0530, Kishon Vijay Abraham I wrote:
>>> The PHY framework provides a set of API's for the PHY drivers to
>>> create/destroy a PHY and API's
>>
>> Just some trivial notes.
>>
>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>
>> []
>>
>>> @@ -0,0 +1,445 @@
>>
>> []
>>
>>> +static void devm_phy_release(struct device *dev, void *res)
>>> +{
>>> +	struct phy *phy =3D *(struct phy **)res;
>>
>> That's a bit twisted isn't it?
>> Perhaps
>> 	struct phy *phy =3D res;
>=20
> No, because you really need to dereference ptr, not simply cast.

To avoid this confusion I suggest to create a struct phy_res. For now
its only member will be a pointer to a struct phy.

>=20
> ...
>=20
>>> +
>>> +	ptr =3D devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
>>
>> Is this the right size?
>>
>> Because ptr is **, perhaps sizeof(struct phy) is clearer.
>=20
> But incorrect.

A proper struct will make the code more readable here, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBAFF293761BECF07B5B71E4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBjQwYACgkQjTAFq1RaXHNP5ACeMWUXO7r58ffEqgXEJmCwMgr0
Jb0AnRC76v1e2eDCAsPOC96/P2izcY0Q
=JbkN
-----END PGP SIGNATURE-----

--------------enigBAFF293761BECF07B5B71E4C--
