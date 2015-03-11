From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Wed, 11 Mar 2015 18:13:00 +0100
Message-ID: <F7BA143D-5CF9-42E3-AFA8-B83B149EF77E@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com> <1426022847-30912-4-git-send-email-marek@goldelico.com> <20150311152414.GX5264@atomide.com> <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com> <20150311164442.GA5264@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150311164442.GA5264@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Am 11.03.2015 um 17:44 schrieb Tony Lindgren <tony@atomide.com>:

> * Dr. H. Nikolaus Schaller <hns@goldelico.com> [150311 09:17]:
>> Hi,
>>=20
>> Am 11.03.2015 um 16:24 schrieb Tony Lindgren <tony@atomide.com>:
>>=20
>>> Hi,
>>>=20
>>> * Marek Belisko <marek@goldelico.com> [150310 14:28]:
>>>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>>>> ---
>>>> .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++=
++++++++++++
>>>> 1 file changed, 43 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/power_supply/=
twl4030_madc_battery.txt
>>>>=20
>>>> diff --git a/Documentation/devicetree/bindings/power_supply/twl403=
0_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl=
4030_madc_battery.txt
>>>> new file mode 100644
>>>> index 0000000..d3dd9d8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_=
battery.txt
>>>> @@ -0,0 +1,43 @@
>>>> +twl4030_madc_battery
>>>> +
>>>> +Required properties:
>>>> + - compatible : "ti,twl4030-madc-battery"
>>>> + - capacity-uah : battery capacity in uAh
>>>> + - ti,volt-to-capacity-charging-map : list of voltage(mV):level(%=
) values
>>>> +	for charging calibration (see example)
>>>> + - ti,volt-to-capacity-discharging-map : list of voltage(mV):leve=
l(%) values
>>>> +	for discharging calibration (see example)
>>>> + - io-channels: Should contain IIO channel specifiers
>>>> +	for each element in io-channel-names.
>>>> +- io-channel-names: Should contain the following values:
>>>> + * "temp" - The ADC channel for temperature reading
>>>> + * "ichg" - The ADC channel for battery charging status
>>>> + * "vbat" - The ADC channel to measure the battery voltage
>>>> +
>>>> +Example:
>>>> +	madc-battery {
>>>> +		compatible =3D "ti,twl4030-madc-battery";
>>>> +		capacity-uah =3D <1200000>;
>>>> +		ti,volt-to-capacity-charging-map =3D <4200 100>,
>>>> +					        <4100 75>,
>>>> +					        <4000 55>,
>>>> +					        <3900 25>,
>>>> +					        <3800 5>,
>>>> +					        <3700 2>,
>>>> +					        <3600 1>,
>>>> +					        <3300 0>;
>>>> +
>>>> +		ti,volt-to-capacity-discharging-map =3D <4200 100>
>>>> +						   <4100 95>,
>>>> +						   <4000 70>,
>>>> +						   <3800 50>,
>>>> +						   <3700 10>,
>>>> +						   <3600 5>,
>>>> +						   <3300 0>;
>>>> +		io-channels =3D <&twl_madc 1>,
>>>> +	                      <&twl_madc 10>,
>>>> +			      <&twl_madc 12>;
>>>> +		io-channel-names =3D "temp",
>>>> +		                   "ichg",
>>>> +		                   "vbat";
>>>> +	};
>>>=20
>>> Rather than just making platform_data into device tree properties..
>>>=20
>>> Can't you hide the these custom properties behind the compatible fl=
ag?
>>>=20
>>> You can initialize that data in the driver based on the compatible
>>> flag and the match data.
>>>=20
>>> This makes sense if you can group things to similar configurations.
>>=20
>> Maybe I have not completely understood your proposal.
>>=20
>> Do you mean to go back to have big parameter tables for each device/=
battery
>> combination in the driver code and the compatible flag (e.g. compati=
ble =3D =93board17=94)
>> chooses the right data set for the charging map and channels?
>=20
> If you can somehow group them, then yes.

I don=92t see how to group them. Could you make a proposal?

> Not for every board if there
> are many of them naturally.
>=20
>> I thought this is what the DT was introduced for - to have the same =
driver=20
>> code but adapt to different boards depending on hardware variations.
>=20
> Yeah but you also need to consider the issues related to introducing
> new device tree properties. The device tree properties introduced
> should be generic where possible.

Yes, that was discussed for a while for this driver=92s bindings leadin=
g to v4.

Which ones do you think are not generic enough?

>=20
>> And batteries have very different characteristics and vary between d=
evices=85
>=20
> Right. Maybe that has been already agreed on to use capacity-uah for
> batteries in general?

Ah, do you mean with generic/not generic the distinction between a =93t=
i,=94 prefix
and no prefix?

Well, I don=92t know if there is such an agreement and I would have no =
argument
against calling it =93ti,capacity-uah=94.

> In that case I have not problem with that as
> it=92s a generic property :)

Well, many batteries and systems have a fuel gauge chip (e.g. bq27000).=
 This
chip =93knows=94 the capacity. But therefore it is not needed to specif=
y
it anywhere because it can be read out (usually in uAh).

This driver is to solve the issue that there is no such factory-program=
med
battery or fuel gauge chip connected to a twl4030 driver. Nobody can pr=
ogram
that capacity value - except someone matching the device tree with real=
 hardware.

And, by doing and averaging some charge-discharge cycles the fuel gauge
mapping is calibrated.

>=20
>> The charging maps are depending on the battery type connected to the=
 twl4030
>> and which madc channel is which value is also a little hardware depe=
ndent
>> (although the twl4030 doesn=92t give much choice).
>=20
> Just to consider alternatives before introducing driver specific
> property for the maps.. Maybe here you could have few different type
> of maps and select something safe by default? Of course it could be t=
his
> is higly board specific, I think some devices may be able to run belo=
w
> 3.3V for example..

Every battery setup has a different map (which also might depend on the
series resistance of the battery and the wiring).

>=20
>> And moving this information into the driver for each board that uses=
 it
>> would blow up the code.
>=20
> Right, I'm not saying we should build databases into the kernel drive=
rs.
> Just trying to avoid introducing driver specific properties unless
> really needed :)

They are not really driver specific, they are battery specific. They
describe properties of the battery:

* capacity - depends on battery
* voltage depending on current charging level - depends on battery (and=
 differs between charging and discharging)
* wiring of MADC inputs to the twl4030 is board dependent.

So all these properties are not driver specific, but describe hardware.
And therefore they had been introduced exactly this way into the old
platform_data driver.

So if you want to see a =93ti," prefix to the capacity property I would=
 be
fine.

BR,
Nikolaus


