From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: c_can: Add d_can raminit support
Date: Tue, 20 Nov 2012 14:46:04 +0100
Message-ID: <50AB899C.3040701@pengutronix.de>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com> <1352916505-12343-2-git-send-email-anilkumar@ti.com> <50AB6081.9060701@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA771E9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFF8A2E2505FD4FC5AE0581D7"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA771E9@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFF8A2E2505FD4FC5AE0581D7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/20/2012 02:05 PM, AnilKumar, Chimata wrote:
[...]

>>>  static struct platform_device_id c_can_id_table[] =3D {
>>>  	[BOSCH_C_CAN_PLATFORM] =3D {
>>>  		.name =3D KBUILD_MODNAME,
>>> @@ -99,7 +119,7 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>>>  	const struct of_device_id *match;
>>>  	const struct platform_device_id *id;
>>>  	struct pinctrl *pinctrl;
>>> -	struct resource *mem;
>>> +	struct resource *mem, *res;
>>>  	int irq;
>>>  	struct clk *clk;
>>> =20
>>> @@ -178,6 +198,18 @@ static int __devinit c_can_plat_probe(struct pla=
tform_device *pdev)
>>>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
>>>  		priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>>>  		priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
>>> +
>>> +		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +		priv->raminit_ctrlreg =3D
>>> +				devm_request_and_ioremap(&pdev->dev, res);
>>
>> What happens if there isn't a second IORESOURCE_MEM region? devm_reque=
st
>> will print an error in this case and any other error, too [1]. Do we
>> need streamlining here?
>>
>> [1] http://lxr.free-electrons.com/source/drivers/base/platform.c#L59
>=20
> I did not get what the point is.
>=20
> In most of the cases above two API's returns NULL. Even res is NULL
> nothing to worry, first condition in devm_request_and_ioremap() is
> NULL pointer check of res. If "res" is NULL then devm_xx will return
> NULL which result into printing of below warning.
>=20
>>
>>> +		if (!priv->raminit_ctrlreg)
>>> +			dev_warn(&pdev->dev, "failed to obtain control memory\n");
>=20
> I will change this warning to info
>=20
> if (!priv->raminit_ctrlreg)
> 	dev_info(&pdev->dev, "control memory is not used for raminit\n");

That's more descriptive, good.

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigFF8A2E2505FD4FC5AE0581D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCriZwACgkQjTAFq1RaXHOorACfQcpB04G5RqL6lyMNirIR8tqg
F5QAnR5qjRg4nw6aEbZflIRApacLPTsL
=E1Vw
-----END PGP SIGNATURE-----

--------------enigFF8A2E2505FD4FC5AE0581D7--
