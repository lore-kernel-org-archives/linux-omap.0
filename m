From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix poweroff with PM configuration enabled
Date: Wed, 12 Nov 2014 21:26:54 +0100
Message-ID: <515E660B-B65D-41EF-97F5-74E4DE8FDD13@goldelico.com>
References: <20141102180756.GH31454@atomide.com> <5458D29E.50908@compulab.co.il> <20141104154231.GP31454@atomide.com> <CANOLnOP8JmROaCruC8NEwh+Nzq_-fFit-+5d_W9vU9KtNTphoA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANOLnOP8JmROaCruC8NEwh+Nzq_-fFit-+5d_W9vU9KtNTphoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org


Am 12.11.2014 um 16:45 schrieb Grazvydas Ignotas <notasas@gmail.com>:

> On Tue, Nov 4, 2014 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
>> * Igor Grinberg <grinberg@compulab.co.il> [141104 05:22]:
>>> Hi Tony,
>>>=20
>>> On 11/02/14 20:07, Tony Lindgren wrote:
>>>> Commit e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset
>>>> configuration") enabled configuring the PM features for twl4030.
>>>>=20
>>>> This caused poweroff command to fail on devices that have the
>>>> BCI charger on twl4030 wired, or have power wired for VBUS.
>>>> Instead of powering off, the device reboots. This is because
>>>> voltage is detected on charger or VBUS with the default bits
>>>> enabled for the power transition registers.
>>>>=20
>>>> To fix the issue, let's just clear VBUS and CHG bits as we want
>>>> poweroff command to keep the system powered off.
>>>=20
>>> What about devices that really need to start once VBUS or CHG is co=
nnected?
>>=20
>> More handling can be added for some cases. With this patch the
>> poweron bits will clear to defaults if power is completely removed.
>> So start-up with VBUS and CHG works in that case.
>>=20
>> However, if you have a battery connected, and you poweroff, with
>> this patch the device won't power up with VBUS or CHG connected.
>>=20
>> Note that most battery operated devices are not using the charger
>> on twl4030 because it has issues charging a completely empty
>> battery AFAIK. So most battery powered devices have been using an
>> external USB charger chip that's not affected by this patch.
>=20
> Pandora does, as well as GTA04 AFAIK,

Yes. The trick is that the power level that turns on the device is a li=
ttle higher
and the battery provides enough energy for approx. 30 seconds until it =
drained
to a level where it turns off. Depending on general setup (WIFI must re=
main
powered off after boot) this is enough to boot into Linux and start ful=
l charging.
Another trick is to modify MLO and U-Boot to raise the charging current=
=2E

> but that's not "most devices=93 I

Indeed.

> guess.. At least pandora was booting up on charger connect up until
> now.

Same for GTA04.

> I don't know why shutdown used to work for Russell in legacy boot
> and it changed for DT, the device would always start up when there wa=
s
> AC power here.
>=20
>=20
> Grazvydas
>=20
>>=20
>> We could consider exporting a function for the charger driver to
>> configure the poweron mask. And we could also consider passing a
>> mask in ti,use_poweroff =3D 0xff.

Yes, exporting these masks would be fine - if a board needs a non-defau=
lt
setup.

>>=20
>>> It seems to me that forcing these bits on power off can break that =
kind of
>>> devices and these settings should really be board specific.
>>> What do you think?
>>=20
>> There's a patch series for "[RFC,01/16] kernel: Add support for
>> poweroff handler call chain" that should help with that. For sure
>> the poweroff handling needs to be board specific as some systems
>> may need to use a GPIO to shut off a regulator powering something
>> before powering off the SoC.
>>=20
>> Regards,
>>=20
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR,
Nikolaus
