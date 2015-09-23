From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Date: Wed, 23 Sep 2015 19:03:37 +0200
Message-ID: <05683602-B29C-45F9-A00D-127F6ECC4E21@goldelico.com>
References: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com> <cover.1443012491.git.hns@goldelico.com> <4254897D-374E-4122-A1A6-269A22C2D622@goldelico.com> <20150923165613.GG23801@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150923165613.GG23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk, jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, notaz@openpandora.org
List-Id: linux-omap@vger.kernel.org

Hi,

Am 23.09.2015 um 18:56 schrieb Tony Lindgren <tony@atomide.com>:

> * H. Nikolaus Schaller <hns@goldelico.com> [150923 05:53]:
>=20
> Missing description?

well, description is =93ARM: dts: omap5-uevm: enable iio gpadc for Palm=
as"

and I didn=92t catch that the commit is otherwise empty. Sorry.

> BTW, this I want to queue separately
> as I have patches in works to support omap5 variants with
> omap5-board-common.dtsi to avoid duplicating things as
> we get omap5 better supported for things like regulators.

Yes, it should work for all Palmas based OMAP5 boards and a=20
omap5-board-common.dtsi would be the right place (after
it comes to existence).

>=20
> Regards,
>=20
> Tony
>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap5-uevm.dts | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/om=
ap5-uevm.dts
>> index 3b16e8f..0d4c8ff 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -342,6 +342,28 @@
>>=20
>> 			ti,ldo6-vibrator;
>>=20
>> +			gpadc {
>> +				compatible =3D "ti,palmas-gpadc";
>> +				interrupts =3D <18 0
>> +					      16 0
>> +					      17 0>;
>> +				ti,channel0-current-microamp =3D <5>;
>> +				ti,channel3-current-microamp =3D <10>;
>> +				iio_map {
>> +					ch1 {
>> +						ti,adc-channel-number =3D <1>;
>> +						ti,adc-consumer-device =3D "generic-adc-thermal.0";
>> +						ti,adc-consumer-channel =3D"battery-temp-channel";
>> +					};
>> +
>> +					ch6 {
>> +						ti,adc-channel-number =3D <6>;
>> +						ti,adc-consumer-device =3D "palmas-battery";
>> +						ti,adc-consumer-channel =3D"vbat_channel";
>> +					};
>> +				};
>> +			};
>> +
>> 			regulators {
>> 				smps123_reg: smps123 {
>> 					/* VDD_OPP_MPU */
>> --=20
>> 2.5.1
>>=20

BR,
Nikolaus
