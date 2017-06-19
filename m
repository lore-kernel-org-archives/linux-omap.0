From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v6 4/4] power: supply: twl4030-charger: add deferred probing for phy and iio
Date: Mon, 19 Jun 2017 10:40:53 +0200
Message-ID: <20C06268-8BAC-4631-AE3F-80E65D7639DE@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com> <6573ec523aa73971562c9b7e7d89f6045185d8c4.1497432355.git.hns@goldelico.com> <20170615115757.wuhzc6c2qrme2te6@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_ED7155D3-150B-44FD-AB6F-145B7D13C24E"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170615115757.wuhzc6c2qrme2te6@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_ED7155D3-150B-44FD-AB6F-145B7D13C24E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 15.06.2017 um 13:57 schrieb Sebastian Reichel =
<sebastian.reichel@collabora.co.uk>:
>=20
> Hi,
>=20
> On Wed, Jun 14, 2017 at 11:25:56AM +0200, H. Nikolaus Schaller wrote:
>> This fixes an issue if both this twl4030_charger driver and
>> phy-twl4030-usb are compiled as modules and loaded in random order.
>>=20
>> It has been observed on GTA04 and OpenPandora devices that in worst
>> case the boot process hangs and in best case the AC detection fails
>> with a warning.
>>=20
>> Therefore we add deferred probing checks for the usb_phy and the
>> iio channel for AC detection.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/power/supply/twl4030_charger.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/power/supply/twl4030_charger.c =
b/drivers/power/supply/twl4030_charger.c
>> index 3bebeecb4a1f..6ac8816262bd 100644
>> --- a/drivers/power/supply/twl4030_charger.c
>> +++ b/drivers/power/supply/twl4030_charger.c
>> @@ -989,15 +989,21 @@ static int twl4030_bci_probe(struct =
platform_device *pdev)
>>=20
>> 		phynode =3D =
of_find_compatible_node(bci->dev->of_node->parent,
>> 						  NULL, =
"ti,twl4030-usb");
>> -		if (phynode)
>> +		if (phynode) {
>> 			bci->transceiver =3D devm_usb_get_phy_by_node(
>> 				bci->dev, phynode, &bci->usb_nb);
>> +			if (IS_ERR(bci->transceiver) &&
>> +			    PTR_ERR(bci->transceiver) =3D=3D =
-EPROBE_DEFER)
>> +				return -EPROBE_DEFER;	/* PHY not ready =
*/
>> +		}
>> 	}
>=20
> Let's also set to NULL + dev_warn for other errors (like the iio
> channel error handling).

Added to v7.

Also added a %d to print the error number to aid spotting the problems.

>=20
>> 	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
>> 	if (IS_ERR(bci->channel_vac)) {
>> -		bci->channel_vac =3D NULL;
>> +		if (PTR_ERR(bci->channel_vac) =3D=3D -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;	/* iio not ready */
>> 		dev_warn(&pdev->dev, "could not request vac iio =
channel");
>> +		bci->channel_vac =3D NULL;
>> 	}
>>=20
>> 	bci->ac =3D devm_power_supply_register(&pdev->dev, =
&twl4030_bci_ac_desc,
>=20
> -- Sebastian


--Apple-Mail=_ED7155D3-150B-44FD-AB6F-145B7D13C24E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZR44WAAoJEIl79TGLgAm6crAQAKJuBd82kpbgrqFf/Jvv2BjI
2hKaTppxjad1+cnKWAQtxZlmDeNcMJkRHTsifXq5BHWXhAXTd6QOc9k+nAWqgcf6
pt/vnYwh/fklPmRGa6RXTxiSfkaNdlGWOzm821+5XivfanXapUdc6HWeB7gJlZ03
xOKZjBnMb1qzUVmTIFv2N2brdubThA1+QOkPPaTMWyj0fHE0ksMmPFfnGtTAThpl
9wToeDcBQ2GhOe0fafqhiKT6WDDRiYARc6ka0FNaMgeaCxaXuNRDOT+D4Bjtwfuk
6W3RFv9U82lTJCX7N3rLwKGrpC/yp9ZVLhhF4+3dWU66tDPnR9jFW9icTBIfjLBV
LP1ik0NrHiWF+m5zovjX2QMS7PComoLdrmv/m93eIzXt0i+Eajr210uBffbUjrmW
gTE8/Nl3p8277421yP0uumxSpkpzimGyliow8vM/8W5pRxqXebSON5aWeqM2t5HE
nXvvGyzafhhMgduEOQZ7Ibu9lBqci7V2rjUYg+VnoTDhmgUSQkf3jKsn/BxzjUz+
75ghH2fNUHtnadsQ5ZM6dJecY6a9DDk7osHH3jv164uN8XYMFg11ml+Hamk0aL/a
j8VC6ssAXS/k1nuR5qUIL5jOXm38qNs0wYSYREY8sWA6PmSmXoh0MQB97zg1bYcF
AH6FCbWMhntHNo0xJcpf
=7ZXU
-----END PGP SIGNATURE-----

--Apple-Mail=_ED7155D3-150B-44FD-AB6F-145B7D13C24E--
