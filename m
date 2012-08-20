From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Mon, 20 Aug 2012 13:11:46 +0200
Message-ID: <50321B72.5010500@pengutronix.de>
References: <1345452359-1137-1-git-send-email-anilkumar@ti.com> <5032144C.2090007@pengutronix.de> <50321831.1070106@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA19F35@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8606303AF2A12BFD12515A25"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA19F35@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8606303AF2A12BFD12515A25
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2012 01:06 PM, AnilKumar, Chimata wrote:
> On Mon, Aug 20, 2012 at 16:33:43, AnilKumar, Chimata wrote:
>> On Mon, Aug 20, 2012 at 16:27:53, Marc Kleine-Budde wrote:
>>> On 08/20/2012 12:41 PM, Marc Kleine-Budde wrote:
>>>> On 08/20/2012 10:45 AM, AnilKumar Ch wrote:
>>>>> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
>>>>> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
>>>>> register of C_CAN/D_CAN IP when clock is turned off.
>>>>>
>>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>>>> ---
>>>>> This patch has been tested on AM335X EVM. Due to lack of hardware
>>>>> I am not able to test c_can functionality. I appreciate if anyone
>>>>> can test c_can functionality with this patch.
>>>>>
>>>>> This patch is based on "can-next/master"=20
>>>>>
>>>>> Changes from v7:
>>>>> 	- Incorporated Marc's commets on v7
>>>>> 	  * changed device pointer to c_can_priv pointer
>>>>
>>>> looks good.
>>>>
>>>> [...]
>>>>
>>>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>>>> @@ -32,6 +32,7 @@
>>>>>  #include <linux/clk.h>
>>>>>  #include <linux/of.h>
>>>>>  #include <linux/of_device.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>> =20
>>>>>  #include <linux/can/dev.h>
>>>>> =20
>>>>> @@ -177,8 +178,11 @@ static int __devinit c_can_plat_probe(struct p=
latform_device *pdev)
>>>>>  		goto exit_free_device;
>>>>                      ^^^^^^^^^^^^^^^^
>>>>>  	}
>>>>> =20
>>>>> +	pm_runtime_enable(&pdev->dev);
>>>>> +
>>>>>  	dev->irq =3D irq;
>>>>>  	priv->base =3D addr;
>>>>> +	priv->device =3D &pdev->dev;
>>>>>  	priv->can.clock.freq =3D clk_get_rate(clk);
>>>>>  	priv->priv =3D clk;
>>>>> =20
>>>>> @@ -198,6 +202,7 @@ static int __devinit c_can_plat_probe(struct pl=
atform_device *pdev)
>>>>> =20
>>>>>  exit_free_device:
>>>>>  	platform_set_drvdata(pdev, NULL);
>>>>> +	pm_runtime_disable(&pdev->dev);
>>>>
>>>> I think this will end up in a NULL pointer deferf.
>>>
>>> Should be no problem, as you're using pdev->dev not priv->device.
>>>
>>> Sorry for the noise :)
>>>
>>
>> One more catch here, return path is not proper.
>>
>> exit_free_device: should contain only free_c_can_dev(dev);
>=20
> And second goto exit_free_device; call should modify to
> goto exit_clear_drvdata;
>=20
> return path looks like this
>=20
> exit_clear_drvdata:
> 	platform_set_drvdata(pdev, NULL);
> 	pm_runtime_disable(&pdev->dev);
> exit_free_device:
> 	free_c_can_dev(dev);
> ...

yes, please send a V9


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8606303AF2A12BFD12515A25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAyG3gACgkQjTAFq1RaXHMINgCghnPxon7V2/ZVUztkfYgh4gS3
2lQAn0g8o0Dif5/2TTkXAc9glJn3A/Jw
=DiKF
-----END PGP SIGNATURE-----

--------------enig8606303AF2A12BFD12515A25--
