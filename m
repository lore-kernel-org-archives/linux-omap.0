From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Mon, 20 Aug 2012 12:57:53 +0200
Message-ID: <50321831.1070106@pengutronix.de>
References: <1345452359-1137-1-git-send-email-anilkumar@ti.com> <5032144C.2090007@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3204E88F035F50721AD1423A"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <5032144C.2090007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3204E88F035F50721AD1423A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2012 12:41 PM, Marc Kleine-Budde wrote:
> On 08/20/2012 10:45 AM, AnilKumar Ch wrote:
>> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
>> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
>> register of C_CAN/D_CAN IP when clock is turned off.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>> This patch has been tested on AM335X EVM. Due to lack of hardware
>> I am not able to test c_can functionality. I appreciate if anyone
>> can test c_can functionality with this patch.
>>
>> This patch is based on "can-next/master"=20
>>
>> Changes from v7:
>> 	- Incorporated Marc's commets on v7
>> 	  * changed device pointer to c_can_priv pointer
>=20
> looks good.
>=20
> [...]
>=20
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>> =20
>>  #include <linux/can/dev.h>
>> =20
>> @@ -177,8 +178,11 @@ static int __devinit c_can_plat_probe(struct plat=
form_device *pdev)
>>  		goto exit_free_device;
>                      ^^^^^^^^^^^^^^^^
>>  	}
>> =20
>> +	pm_runtime_enable(&pdev->dev);
>> +
>>  	dev->irq =3D irq;
>>  	priv->base =3D addr;
>> +	priv->device =3D &pdev->dev;
>>  	priv->can.clock.freq =3D clk_get_rate(clk);
>>  	priv->priv =3D clk;
>> =20
>> @@ -198,6 +202,7 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>> =20
>>  exit_free_device:
>>  	platform_set_drvdata(pdev, NULL);
>> +	pm_runtime_disable(&pdev->dev);
>=20
> I think this will end up in a NULL pointer deferf.

Should be no problem, as you're using pdev->dev not priv->device.

Sorry for the noise :)

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3204E88F035F50721AD1423A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAyGDEACgkQjTAFq1RaXHPVowCfVAbwIyOtEJ6d8P/auRJQCCIr
mw0An3oRmy1Iu0maXwvB2vsucEDJZ0JX
=/Nr/
-----END PGP SIGNATURE-----

--------------enig3204E88F035F50721AD1423A--
