From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Tue, 17 Mar 2015 12:14:11 +0100
Message-ID: <CDA0FF88-2D00-46E0-828E-DD6F4FF4ADAF@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com> <1423088075-10025-4-git-send-email-marek@goldelico.com> <20150316210532.GA11441@amd> <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com> <20150317084730.GA9761@amd> <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com> <20150317103746.GB3759@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150317103746.GB3759@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Belisko Marek <marek.belisko@gmail.com>, mark.rutland@arm.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

Am 17.03.2015 um 11:37 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
>=20
>>>>> to introduce coefficients for temperature and discharge rate?
>>>> What do you mean? Nothing like that is used in current driver why =
do
>>>> we need to add it?
>>>=20
>>> Well, conversion between Li-ion's voltage and state of charge at 0
>>> current is well known:
>>=20
>> We can=92t measure at 0 current since the OMAP is driven from batter=
y
>> and charger and may also draw some mA=85
>=20
> Yes, but you know how many mA you are taking just now. So if you knew
> the internal resistance, you could compute the voltage at 0
> current. (And it should also work during charging, as long as you kno=
w
> how much current is going in.)

As far as I understand the twl4030 charger and MADC it is not possible =
to
separate these values. It is only reporting the inflow from charger to
battery + system. So you don=92t know how many mA are supplying the sys=
tem
and how many mA are left over for charging.

You can only assume how much the system is drawing while running (somet=
hing
between 50 and 600 mA but this depends on system activities, power stat=
e
of peripherald and e.g. backlight being switched on).

I think your basic assumption that we know any time how many mA the sys=
tem
is taking is not given.

>=20
>>>   def percent(m, v):
>>>   	u =3D 0.0387-(1.4523*(3.7835-v))
>>>       if u < 0:
>>>           return 0
>>>         return (0.1966+math.sqrt(u))*100
>>>=20
>>> And there's not much to calibrate there, and it should become libra=
ry
>>> helper function; there's no need to write it to every single dts.
>>>=20
>>> The charge/discharge difference is due to internal battery resistan=
ce,
>>> and Ohm's law. (Then, you should not need different values for
>>> charging/discharging case.)
>>=20
>> Yes, and that also depends on the board and battery type. So you alw=
ays
>> need to specify some battery specific coefficient for that in the DT=
=2E
>=20
> Yes, and that coefficient should be internal battery resistance ;-).

But where do you know this value from to write it into a DT file?
Usually you can=92t measure it easily and for some batteries you don=92=
t have
a data sheet.

Contrary, the calibration curves can easily be measured on the device
(assuming that the charge level decreases/increases linearly over time
between Full and Empty).

I tend to make software easy to use for the user (developer of a board =
support
package) of a driver, not theoretically correct or mathematically elega=
nt.

>=20
>> We simply did choose a table, because calculating the right coeffici=
ents
>> is more complex and getting the table values can easily be done from
>> running one full charge-discharge-charge cycle.
>=20
> Well.. One set of coefficients would be kind of ok. But you are doing
> two, because it really depends on current, not charge/discharge. So
> why not do it right, for all currents=85?

Because the right solution for all these issues is to use a fuel gauge =
chip
(bq27xxx).

This driver is just for systems where the hardware designer did forget
(or did not want to spend money) for such a chip, but user space
expects some /sys/class/power_supply indication (e.g. Android/Replicant=
).

The missing optimal precision is something we can live with.

>=20
>>> With your aproach, you'll get lower percentage when phone is under
>>> load vs. idle. Taking internal resistance into account would give y=
ou
>>> more precise readings. (Attached, old patch for zaurus shows the
>>> needed computation).
>>=20
>> This is why we have a charging and a discharging table to compensate
>> for this effect.
>=20
> Yes, but there's very different current during "idle" phone and durin=
g
> call (for example). So yes, you are compensating for different curren=
t
> during charge and discharge, but it is possible to do better.

I am not convinced that it can be really done better, considering the
limitations of the twl4030 circuits, and I doubt that it is worth the e=
fforts
of doing it better.

>=20
>>> I guess this should go into library somewhere, because many machine=
s
>>> need similar code.
>>=20
>> Is a library easier to maintain and handle than just a set of table
>> values?
>=20
> I think so, yes, because otherwise you need a set of tables for each
> machine.

Yes, but what is the problem? We have different device trees for each
machine anyways. And as soon as they differ in battery characteristics
the coefficients for your calculation have to be defined for each machi=
ne.

So someone has to write in some DT values (difficult to understand
and derive coefficients or two simple mapping tables).

To me it looks as if you want to make it a 100% solution while I am hap=
py
with the 80% solution, which already exists as a platform data driver a=
nd
just want to get it back into DT based boards.

So I would suggest that Mareks patches to make the platform data
driver DT compatible are applied first, and you are invited to submit a
technically better solution for testing on real hardware.

BR,
Nikolaus

