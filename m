From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v7 1/2] power: supply: twl4030-charger: move irq allocation to just before irqs are enabled
Date: Mon, 3 Jul 2017 18:36:06 +0200
Message-ID: <6B48E0E0-3AA6-4815-A549-868B57614F51@goldelico.com>
References: <cover.1497861705.git.hns@goldelico.com> <2b919bea97f23c952e0141ed63d04dbbcea5c695.1497861705.git.hns@goldelico.com> <20170703125556.kaeds2qwk3hxgkw4@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_4DB46DF3-E29B-4D60-9950-AE8F1C0925C5"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703125556.kaeds2qwk3hxgkw4@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_4DB46DF3-E29B-4D60-9950-AE8F1C0925C5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 03.07.2017 um 14:55 schrieb Sebastian Reichel =
<sebastian.reichel@collabora.co.uk>:
>=20
> Hi,
>=20
> On Mon, Jun 19, 2017 at 10:41:45AM +0200, H. Nikolaus Schaller wrote:
>> And initialize workers and notifiers as soon as possible.
>>=20
>> This avoids a potential race if irqs are enabled and triggered too =
early
>> before the worker is properly set up.
>>=20
>> Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/power/supply/twl4030_charger.c | 29 =
+++++++++++++++--------------
>> 1 file changed, 15 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/drivers/power/supply/twl4030_charger.c =
b/drivers/power/supply/twl4030_charger.c
>> index 1fbbe0cc216a..9d974f1e3957 100644
>> --- a/drivers/power/supply/twl4030_charger.c
>> +++ b/drivers/power/supply/twl4030_charger.c
>> @@ -984,12 +984,27 @@ static int twl4030_bci_probe(struct =
platform_device *pdev)
>>=20
>> 	platform_set_drvdata(pdev, bci);
>>=20
>> +	INIT_WORK(&bci->work, twl4030_bci_usb_work);
>> +	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
>> +
>> 	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
>> 	if (IS_ERR(bci->channel_vac)) {
>> 		bci->channel_vac =3D NULL;
>> 		dev_warn(&pdev->dev, "could not request vac iio =
channel");
>> 	}
>>=20
>> +	if (bci->dev->of_node) {
>> +		struct device_node *phynode;
>> +
>> +		phynode =3D =
of_find_compatible_node(bci->dev->of_node->parent,
>> +						  NULL, =
"ti,twl4030-usb");
>> +		if (phynode) {
>> +			bci->transceiver =3D devm_usb_get_phy_by_node(
>> +				bci->dev, phynode, &bci->usb_nb);
>> +			bci->usb_nb.notifier_call =3D =
twl4030_bci_usb_ncb;
>=20
> those two should be the other way around.

Seems to work as well (and avoids another potential race condition).

v8 coming instantly.

BR and thanks,
Nikolaus


--Apple-Mail=_4DB46DF3-E29B-4D60-9950-AE8F1C0925C5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZWnJ3AAoJEIl79TGLgAm6AQoP/3SXUOuZdAaOofcZ4yflwCkG
tVEqi01JO153YtKboNft7xuQkmgB9j0hjOAvqZ48J6SCBUL1Nu9QCFKukjwNwDil
8zhrYF2j2czEjq3dyp32uNispszrOCKmCAmO9TYJciOyjJOed0LvP3X4C8Nrh1xF
19l0zW5Mtk7bKggjPkHB2QjLeHXS17xbAm5IkqFnXErLOrOz6h+zgQKj7J/455ii
xolBuSsWIWXVVYQc19CNuRBWVBFnaDuJhn6J99U7rBGxzdvbmxLatntkJ0HdcYMG
d/JzqEuZxMYzG0QcJARowAqC6h3IhlaiPc/eqQOWi7nQneLWbhS7YKeLy62DtuJS
jjVt3TBtEc/oIIKwQl8Lc+t6rFhcV/suZU9c47QOvj4yP9iXmIAtQdW/LZujjfpW
GJCRIJflWbK8Tz6yPWJMiUk2MNYLpPKCRSbf9yRLPN+6EnNGZ8em9/XrwuOfYt2u
6n9veZadSPzCNklk2vo5ux2RliG0dapju9CMkz4qG8U1Ws12Is2fPtmbGnCTf3Y/
/NzKNh7r/quRiauekWPHoZMhVJpCRF2I1Rc3dNtUiIk/C03ndPQRrdVsXrZ9H+H2
GHgjQjM12Vt2WefTUCh++BVKZ783Lu16P401uo8JiRZR2EeFJgBvaJ84CS+pFdIK
XDkbWU/PtK0Q/yz/yvpp
=LXLk
-----END PGP SIGNATURE-----

--Apple-Mail=_4DB46DF3-E29B-4D60-9950-AE8F1C0925C5--
