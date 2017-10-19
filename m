From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling
Date: Thu, 19 Oct 2017 18:55:26 +0200
Message-ID: <152FA5B1-75F9-4F0B-9E05-6277CD83C975@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com> <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com> <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd> <20171018122804.GA14376@amd> <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com> <20171018132204.GD4394@atomide.com> <0C0901E1-23E8-4D04-B3A9-8314809A7A6B@goldelico.com> <20171019162416.GE4394@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019162416.GE4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, khilman@kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 19.10.2017 um 18:24 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [171018 08:49]:
>>=20
>>> Am 18.10.2017 um 15:22 schrieb Tony Lindgren <tony@atomide.com>:
>>>=20
>>> * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
>>>>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
>>>>>=20
>>>>> So I started something, it is at.
>>>>>=20
>>>>> https://github.com/pavelmachek/libbattery
>>>>>=20
>>>>> My battery on n900 is currently uncalibrated (and charging), still =
it
>>>>> gets some kind of estimation:
>>>>>=20
>>>>> Battery -1 %
>>>>> Seconds -1
>>>>> State 1
>>>>> Voltage 3.88 V
>>>>> Battery 63 %
>>>>>=20
>>>>> Of course, there's a lot more work to be done.
>>>>=20
>>>> Nice start but not a solution to our problem.
>>>>=20
>>>> Our problem is that people simply expect that for example =
https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
>>>> displays the battery percentage.
>>>=20
>>> I think we could make things compatible with various battery apps by
>>> having libbattery write back the capacity percentage and time =
remaining
>>> to the kernel driver via sysfs or a dev entry. Then the kernel =
interface
>>> can just display the data to whatever apps.
>>=20
>> Hm. That would be quite difficult to understand and maintain code.
>=20
> How so? The libbattery can do it all, then the kernel drivers needing
> that will just display the most recent values to maintain compability
> with battery apps.

Well, it looks as if you are thinking about a much more complex solution
than I am...

The proposal we are discussing as

[RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling

just reads the current voltage, charging current and uses a (nonlinear)
mapping to 0% .. 100%.

For that we don't need a library, and we don't need a mechanism to

"write back the capacity percentage and time remaining
to the kernel driver via sysfs or a dev entry.

>=20
>> Why not have the kernel driver do the simple calculations (they do
>> not need float) and provide the standard /sys/class/power attribute?
>=20
> Because the current remaining capacity and battery empty state depend
> on maintaining a database of previous history for battery wear.

For remaining capacity I agree that you need that. But this RFC doesn't
even want to provide remaining capacity. To avoid such issues. Just
provide POWER_SUPPLY_PROP_CAPACITY:

https://lkml.org/lkml/2017/8/1/910

So we are discussing to replace these 10 lines with a library, a
daemon and a mechanism that the driver can read that from user space?

IMHO this can be added in a further step, but shouldn't be backpacked
onto this here.

> This
> data needs to be preserved across reboots, so most likely on a file
> on a disk is the way to go.

It could also be stored in some i2c eeprom (DT could provide a =
reference).

>=20
> There's a nice summary what all is involved here:
>=20
> http://www.mpoweruk.com/soc.htm

Oh yes, that is really nice!

Using their terms, we just want to add "Voltage Based SOC Estimation"
for typical "Lithium chemistry".

BTW: this already exists in the twl4030-madc-battery driver and we use =
it
for the GTA04 derivatives without fuel gauge:

=
http://elixir.free-electrons.com/linux/v3.17/source/drivers/power/twl4030_=
madc_battery.c

It uses a table driven approach which was rejected to be converted to DT
some time ago. DT maintainers asked to use an estimation formula instead
of a table and interpolation.

And this patch set does not want to solve all problems in one step :)

But it wants to:
* make it useable for any battery voltage providing iio adc and not only =
twl4030
  by modifying the generic-adc-battery driver
* make the driver device tree compatible (twl4030-madc-battery still =
isn't)
* replace table by fixed point estimation formula fuel_level_LiIon(() as =
requested

Not more.

Of course a libbattery can do a lot of additional calculations to =
predict
e.g. time to emtpy or full charge, estimate battery health etc. and =
provide
more precision by filters.

We would be very happy to have a simple estimation because it already
covers most use cases (some early smartphones had only 4 levels for =
SOC).
And we want to replace the pdata based driver with a DT driver asap.

BR and thanks,
Nikolaus
