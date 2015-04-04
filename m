From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Sat, 4 Apr 2015 11:46:10 +0200
Message-ID: <920D9B36-7369-4E3F-83F3-DB27D52503CC@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com> <1426022847-30912-4-git-send-email-marek@goldelico.com> <20150311152414.GX5264@atomide.com> <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com> <20150311164442.GA5264@atomide.com> <20150331072643.GB30788@amd> <BC5A7447-CAD7-4CCE-8F08-8CEFBB5C6905@goldelico.com> <20150401201605.GA11421@amd> <D659872E-E276-4E00-BAFC-1E461EDA1FA7@goldelico.com> <20150404081655.GD31064@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150404081655.GD31064@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

Am 04.04.2015 um 10:16 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
>=20
>>>> Please propose your own code doing that so that we can test if it =
is
>>>> better.
>>>=20
>>> So, how does this look?
>>>=20
>>> It looks to me like you have cca 0.1 Ohm resistance in your system,
>>=20
>> This is completely unknown.
>>=20
>>> and are using cca 75mA while discharging, and charge by cca 1.4A.
>>=20
>> Where do you get these figures from?
>=20
> Least squares fitting of my coefficients to your tables.

Ah, I see.

>=20
>> A GTA04 board discharges usually between 50 and 400 mA (depending on=
 activities)
>> and if you turn on WiFi, it will be up to 600 mA. If you use 3G it c=
an draw even more
>> during operation.
>=20
> How big battery do you have?

1200 mAh

> According to least squares fitting,
> assuming maximum charge of .46A, you were taking about 25mA when
> doing the discharge test.

No, that can=92t fit well. But I do not remember who has done this cali=
bration in which situation
because it was done many months ago for the platform data version. We h=
ave just reformatted
the table for the DT.

>=20
>> Total current going in is 500-800 mA (depending on USB negotiations)=
 and this is
>> split into system operation and charging current. So 1.4A charging c=
urrent is not
>> possible. Rather 200-500 mA.
>>=20
>> So it might be that the battery is discharged although the system is=
 connected
>> to a charger.
>=20
> Yah, and your battery meter will be wrong in such case, as will be
> mine, because they are based on same information.

Well, it is not =93mine=94, it is the platform_data based driver alread=
y in kernel.org
since ca. 3.12.

We have just updated it to DT to get rid of platform_data in this area =
as well=85

Yes, I see your argument that hiding the tables (two characteristic cur=
ves)
into an analytic approximation can be superior.=20

The problem I see is just that your formula needs some parameters which
are difficult to derive or estimate. And must be adjusted to the specif=
ic
battery and system setup in a non-trivial way.

At least we must supply a tool (in the kernel/scripts directory?) where=
 someone
can can estimate the parameters of the formula from the characteristic =
curves.

Maybe a tool that automatically runs several charge/discharge cycles at
different system load. And measures time vs. voltage. And assumes a lin=
ear
capacity decrease between the end points. (i.e. if it needs 10 hours to=
 charge
from completely empty to full, we can assume 50% after 5,0 hours).

So my goal is to measure all characteristics of the battery - and no ne=
ed to
study a (potentially non-existing) data sheet.

If you can provide that for all parameters of your algorithm I am fine =
with it.

> The thing is, mine
> can be improved without adding more tables.=20

How can you improve your algorithm without tweaking or adding new param=
eters?

>=20
>>> It is tricky to do a good job near 0%... or anywhere else. See for
>>> example
>>>=20
>>> http://cseweb.ucsd.edu/~trosing/lectures/battery.pdf
>>>=20
>>> You start a call, percentage goes down, end a call, it will go
>>> back up. I'm pretty sure you will not be able to make a call with "=
5%"
>>> indication from your code at low battery temperature (say -10C).
>>=20
>> The whole system is heating up a little, so that you never have -10C=
 for the
>> battery.
>=20
> Umm. When not calling, your phone should not heat itself up.

Yes, in suspend it needs <20 mA which does not heat or course.
But steady operation at 20-400 mA does significantly rise OMAP
temperature beyond environment temperature.

> And you
> definitely can power it down, leave it in outer pocket, then power it
> up. It is actually something people do when they want to preserve bat=
tery...
>=20
>> I think you are trying to solve situations that don=92t exist in pra=
ctice.
>>=20
>> And AFAIK, the GTA04 board is the only user of this driver in case t=
he battery
>> has no built-in fuel gauge. So why improve it beyond what the GTA04
>> users need?
>=20
> Because then other users can share the same code, and because you

But you have ugly parameters in dts that nobody can easily see in the s=
chematics
and that are full of assumptions.

=46rom a perspective of uncertainty analysis, estimation of the interna=
l parameters
needs a higher precision than the calibration points.

> avoid big ugly tables in dts.

Well, the biggest tables I have seen in dts are keyboard matrix codes=85

>=20
>> I repeat myself: this driver is not built for highest precision beca=
use there are
>> better methods (fuel gauge chip). These might not be available so th=
is fall-back
>> driver has been built.
>>=20
>> It is definitively better than no driver and worse than the optimum.
>=20
> And my email suggested solution better than your driver, so why not
> just use it?

I am not yet convinced that it is better.

It just moves the (unavoidable) limitations (measuring multiple calibra=
tion points)
just to a different area (measuring the hidden and not precisely known =
parameter
of the system).

>=20
>=20
>>> #perc =3D percent(volt)
>>> compute(charging, 1)
>>> compute(discharging, 0)
>>=20
>> Please explain what you calculate here. Especially what =93Badness=94=
 is?
>=20
> Badness is error in least squares method.

Ok, I see. Thanks for clarification.

BR,
NIkolaus

