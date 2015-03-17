From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Tue, 17 Mar 2015 09:56:55 +0100
Message-ID: <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com> <1423088075-10025-4-git-send-email-marek@goldelico.com> <20150316210532.GA11441@amd> <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com> <20150317084730.GA9761@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:23561 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbbCQI5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 04:57:41 -0400
In-Reply-To: <20150317084730.GA9761@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Belisko Marek <marek.belisko@gmail.com>, mark.rutland@arm.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>

Hi,

Am 17.03.2015 um 09:47 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
>=20
>>>> diff --git a/Documentation/devicetree/bindings/power_supply/twl403=
0_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl=
4030_madc_battery.txt
>>>> new file mode 100644
>>>> index 0000000..bb3580c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_=
battery.txt
>>>> @@ -0,0 +1,43 @@
>>>> +twl4030_madc_battery
>>>> +
>>>> +Required properties:
>>>> + - compatible : "ti,twl4030-madc-battery"
>>>> + - capacity-uah : battery capacity in uAh
>>>=20
>>> Could we make it capacity-uAh ?
>> This name was suggested by Mark Rutland [1] and naming convention
>> should be all lowercase. There exists already bindings
>> without uppercase (e.g. ti,bb-uamp) so I would keep it consistent.
>=20
> Messing up SI units due to "convention" is _stupid_. Don't do it.
>=20
>>> to introduce coefficients for temperature and discharge rate?
>> What do you mean? Nothing like that is used in current driver why do
>> we need to add it?
>=20
> Well, conversion between Li-ion's voltage and state of charge at 0
> current is well known:

We can=92t measure at 0 current since the OMAP is driven from battery
and charger and may also draw some mA=85

>=20
>    def percent(m, v):
>    	u =3D 0.0387-(1.4523*(3.7835-v))
>        if u < 0:
>            return 0
>          return (0.1966+math.sqrt(u))*100
>=20
> And there's not much to calibrate there, and it should become library
> helper function; there's no need to write it to every single dts.
>=20
> The charge/discharge difference is due to internal battery resistance=
,
> and Ohm's law. (Then, you should not need different values for
> charging/discharging case.)

Yes, and that also depends on the board and battery type. So you always
need to specify some battery specific coefficient for that in the DT.

We simply did choose a table, because calculating the right coefficient=
s
is more complex and getting the table values can easily be done from
running one full charge-discharge-charge cycle.

>=20
> With your aproach, you'll get lower percentage when phone is under
> load vs. idle. Taking internal resistance into account would give you
> more precise readings. (Attached, old patch for zaurus shows the
> needed computation).

This is why we have a charging and a discharging table to compensate
for this effect.

>=20
> And if you wanted even more precise readings... internal resistance
> depends on temperature.

We don=92t necessarily know the real battery temperature.

>=20
> I guess this should go into library somewhere, because many machines
> need similar code.

Is a library easier to maintain and handle than just a set of table val=
ues?

Anyways it ends up in a representation of a mapping function with two
input parameters (voltage and charge/discharge indication).

My proposal: keep it simple for everybody. And I can=92t imagine someth=
ing
easier than a mapping table.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
