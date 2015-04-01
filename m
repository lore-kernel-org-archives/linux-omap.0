From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Wed, 1 Apr 2015 10:18:05 +0200
Message-ID: <BC5A7447-CAD7-4CCE-8F08-8CEFBB5C6905@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com> <1426022847-30912-4-git-send-email-marek@goldelico.com> <20150311152414.GX5264@atomide.com> <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com> <20150311164442.GA5264@atomide.com> <20150331072643.GB30788@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150331072643.GB30788@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

Am 31.03.2015 um 09:26 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
>=20
>>>>> +		io-channels =3D <&twl_madc 1>,
>>>>> +	                      <&twl_madc 10>,
>>>>> +			      <&twl_madc 12>;
>>>>> +		io-channel-names =3D "temp",
>>>>> +		                   "ichg",
>>>>> +		                   "vbat";
>>>>> +	};
>>>>=20
>>>> Rather than just making platform_data into device tree properties.=
=2E
>>>>=20
>>>> Can't you hide the these custom properties behind the compatible f=
lag?
>>>>=20
>>>> You can initialize that data in the driver based on the compatible
>>>> flag and the match data.
>>>>=20
>>>> This makes sense if you can group things to similar configurations=
=2E
>>>=20
>>> Maybe I have not completely understood your proposal.
>>>=20
>>> Do you mean to go back to have big parameter tables for each device=
/battery
>>> combination in the driver code and the compatible flag (e.g. compat=
ible =3D =93board17=94)
>>> chooses the right data set for the charging map and channels?
>>=20
>> If you can somehow group them, then yes. Not for every board if ther=
e
>> are many of them naturally.
>>=20
>>> I thought this is what the DT was introduced for - to have the same=
 driver=20
>>> code but adapt to different boards depending on hardware variations=
=2E
>>=20
>> Yeah but you also need to consider the issues related to introducing
>> new device tree properties. The device tree properties introduced
>> should be generic where possible.
>>=20
>>> And batteries have very different characteristics and vary between =
devices=85
>>=20
>> Right. Maybe that has been already agreed on to use capacity-uah for
>> batteries in general? In that case I have not problem with that as
>> it's a generic property :)
>>=20
>>> The charging maps are depending on the battery type connected to th=
e twl4030
>>> and which madc channel is which value is also a little hardware dep=
endent
>>> (although the twl4030 doesn=92t give much choice).
>>=20
>> Just to consider alternatives before introducing driver specific
>> property for the maps.. Maybe here you could have few different type
>> of maps and select something safe by default? Of course it could be =
this
>> is higly board specific, I think some devices may be able to run bel=
ow
>> 3.3V for example..
>=20
> As I explained in some other mail, those tables should not be
> neccessary at all. They can be computed from li-ion characteristics
> and internal resistance, and assumed current during charge and
> discharge.

I already explained that we do not know the charging and discharging
current well enough for such a calculation.

And I explained that the =93internal resistance=94 is a system (battery=
 + cables +
connectors + other circuits) parameter that is not easy to derive or me=
asure
and type into the .dts source code.

At least I have no idea how I should find it out for my boards. While I=
 can
easily determine the curves (and we already have them for the platform_=
data
driver).

Please propose your own code doing that so that we can test if it is
better.

>=20
> Running below 3.3V.. not really. At that point, the battery is really
> _empty_, and voltage is going down really really fast.

It is the diffference between 2% and 0% where a fuel indication might
be most important=85

>=20
> Plus, you are damaging the battery at that point.

The power controller will shut down - but the driver should report
reasonable (but IMHO not necessarily perfect) values until the last
moment.

BR,
Nikolaus

