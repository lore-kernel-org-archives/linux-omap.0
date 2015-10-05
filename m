From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 2/3] iio:adc:palmas: add DT support
Date: Mon, 5 Oct 2015 16:26:22 +0200
Message-ID: <30A5D09D-1628-4F2C-8601-9C3ABF778CE0@goldelico.com>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com> <cover.1443973837.git.hns@goldelico.com> <6C211191-87B8-4444-ADA7-8BE454C2B3D3@goldelico.com> <20151005111754.GG19064@leverpostej>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151005111754.GG19064@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk, jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org


Am 05.10.2015 um 13:17 schrieb Mark Rutland <mark.rutland@arm.com>:

> On Sun, Oct 04, 2015 at 06:05:59PM +0200, H. Nikolaus Schaller wrote:
>> From: Marek Belisko <marek@goldelico.com>
>>=20
>> Code was found at:
>> https://android.googlesource.com/kernel/tegra/+/a90856a6626d502d42c6=
e7abccbdf9d730b36270%5E%21/#F1
>>=20
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> [Fixed minor typos + add channels list to documentation]
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>> .../devicetree/bindings/iio/adc/palmas-gpadc.txt   | 46 ++++++++++++=
+++++++
>> drivers/iio/adc/palmas_gpadc.c                     | 52 ++++++++++++=
+++++++---
>> 2 files changed, 93 insertions(+), 5 deletions(-)
>> create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-=
gpadc.txt
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.=
txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
>> new file mode 100644
>> index 0000000..2149afe
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
>> @@ -0,0 +1,46 @@
>> +* Palmas general purpose ADC IP block devicetree bindings
>> +
>> +Channels list:
>> +	0 battery type
>> +	1 battery temp NTC (optional current source)
>> +	2 GP
>> +	3 temp (with ext. diode, optional current source)
>> +	4 GP
>> +	5 GP
>> +	6 VBAT_SENSE
>> +	7 VCC_SENSE
>> +	8 Backup Battery voltage
>> +	9 external charger (VCHG)
>> +	10 VBUS
>> +	11 DC-DC current probe (how does this work?)
>> +	12 internal die temp
>> +	13 internal die temp
>> +	14 USB ID pin voltage
>> +	15 test network
>> +
>> +Required properties:
>> +- compatible : Must be "ti,palmas-gpadc".
>> +
>> +Optional sub-nodes:
>> +ti,channel0-current-microamp: Channel 0 current in uA.
>> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
>> +ti,channel3-current-microamp: Channel 3 current in uA.
>> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
>=20
> It's only possible to configure channels 0 and 3 in this manner?

Yes. The other channels have no built-in current source, i.e. these
channels are special.

>=20
>> +ti,enable-extended-delay: Enable extended delay.
>=20
> What is this? When would I select it? Why does it belong in the DT
> rather than being a runtime option?

The chip allows to extend the time window between channel selection
and sampling by 400=B5s (according to data sheet). But for all channels
and not each one. As far as I understand, this is - depending on hardwa=
re
setup - to get more stable ADC readings.

Most channels have a fixed function (e.g. battery voltage, USB VBUS,
temperature NTC) so it can't be arbitrarily chosen and depends on how
the Palmas is embedded (it is a PMIC with a bank of ADCs and not a
general purpose ADC chip).

So I think it is really a hardware dependent parameter and not somethin=
g
the user should be able to change.

>=20
>> +Example:
>> +
>> +pmic {
>> +	compatible =3D "ti,twl6035-pmic", "ti,palmas-pmic";
>> +	...
>> +	gpadc {
>> +		compatible =3D "ti,palmas-gpadc";
>> +		interrupts =3D <18 0
>> +			      16 0
>> +			      17 0>;
>> +		ti,channel0-current-microamp =3D <5>;
>> +		ti,channel3-current-microamp =3D <10>;
>> +		};
>> +	};
>> +	...
>> +};
>=20
> I thought you needed #iio-cells for encoding the channel?

Yes, we forgot (we don't have a client for it in our setup yet - so did=
 not test :)

>=20
> Mark.

Thanks,
Nikolaus Schaller
