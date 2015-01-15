From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] input: tsc2007: Add pre-calibration, flipping and rotation
Date: Thu, 15 Jan 2015 19:49:52 +0100
Message-ID: <0CD142CE-0BC3-4A86-AAFB-383805A81646@goldelico.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com> <1412108254-19234-2-git-send-email-marek@goldelico.com> <CAAfyv36bD9ZratOzr7FkeQde8k-K9XjEjH9gkntm9qewD-cH9g@mail.gmail.com> <20150115005938.GB9134@dtor-ws> <0F9A17C1-9B01-4EE9-BE98-266B8FC02B84@goldelico.com> <20150115143855.GD512@earth.universe> <8B08216C-13DD-40D8-9BA9-060F1C18A018@goldelico.com> <20150115181637.GE33214@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20150115181637.GE33214@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Belisko Marek <marek.belisko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Marek Belisko <marek@goldelico.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Yoichi Yuasa <yuasa@linux-mips.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, List
List-Id: linux-omap@vger.kernel.org


Am 15.01.2015 um 19:16 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.c=
om>:

> On Thu, Jan 15, 2015 at 05:14:38PM +0100, Dr. H. Nikolaus Schaller wr=
ote:
>>=20
>> Am 15.01.2015 um 15:38 schrieb Sebastian Reichel <sre@kernel.org>:
>>=20
>>> Hi,
>>>=20
>>> On Thu, Jan 15, 2015 at 08:36:44AM +0100, Dr. H. Nikolaus Schaller =
wrote:
>>>>> 1. Perform conversion in input core rather than individual driver=
s. I
>>>>> think we should allocate a new bitmaps for some transformations a=
nd have
>>>>> the code do X/Y flip/clip of the coordinates.
>>>>=20
>>>> Do you have a suggestion where this should be (I have no clue how
>>>> the input system works or is structured - we just know how to exte=
nd a
>>>> driver that uses it)?
>>>>=20
>>>>> 2. Standardize on bindings. We already have of-touchscreen.c doin=
g
>>>>> rudimentary parsing, we shoudl look into extending it rather than
>>>>> creating myriad of driver-specific bindings.
>>>>=20
>>>> Ok, looks reasonable.
>>>=20
>>> Documentation is in=20
>>>=20
>>> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>=20
>> I did look into it now. Unfortunately, it does not fit well into my =
view of how bindings
>> should be. They should describe hardware (as we are told for many ot=
her kernel
>> subsystems).
>>=20
>> Pixels and resolutions are IMHO related to the screen it is glued on=
 - and that is
>> quite independent.
>=20
> Well, I think pixels was the wrong word to be used there. It is meant=
 to
> be native units, as opposed to millimeters, inches, points, etc.

ok.

>=20
>>=20
>> So I don=92t see how they do describe the different ways the touch s=
creen can be
>> wired to a tsc2007 controller.
>>=20
>> Please can you add minimum and maximum properties for us?
>>=20
>> Then, inverted-x and inverted-y is redundant because it is the same =
as having
>> an expected higher value from the ADC for the minimum coordinate and=
 a lower
>> for the maximum.
>=20
> I'd rather not add minimum and maximum, but add the touchscreen-start=
-x and
> touchscreen-start-y instead so that we limit the number of obsolete
> properties.

ok, that should not be too difficult to add.

So we will modify our driver to use the new functions and align omap3-g=
ta04.dtsi accordingly.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
