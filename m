From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Tue, 17 Mar 2015 15:12:58 +0100
Message-ID: <4E240771-5F35-44BB-B1BA-7D24FE93F08E@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com> <1423088075-10025-4-git-send-email-marek@goldelico.com> <20150316210532.GA11441@amd> <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com> <20150317084730.GA9761@amd> <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com> <20150317103746.GB3759@amd> <CDA0FF88-2D00-46E0-828E-DD6F4FF4ADAF@goldelico.com> <20150317135913.GA4034@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:63389 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbbCQONp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 10:13:45 -0400
In-Reply-To: <20150317135913.GA4034@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Belisko Marek <marek.belisko@gmail.com>, mark.rutland@arm.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>

Hi Pavel,

Am 17.03.2015 um 14:59 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
>=20
>>>>>>> to introduce coefficients for temperature and discharge rate?
>>>>>> What do you mean? Nothing like that is used in current driver wh=
y do
>>>>>> we need to add it?
>>>>>=20
>>>>> Well, conversion between Li-ion's voltage and state of charge at =
0
>>>>> current is well known:
>>>>=20
>>>> We can=92t measure at 0 current since the OMAP is driven from batt=
ery
>>>> and charger and may also draw some mA=85
>>>=20
>>> Yes, but you know how many mA you are taking just now. So if you kn=
ew
>>> the internal resistance, you could compute the voltage at 0
>>> current. (And it should also work during charging, as long as you k=
now
>>> how much current is going in.)
>>=20
>> As far as I understand the twl4030 charger and MADC it is not possib=
le to
>> separate these values. It is only reporting the inflow from charger =
to
>> battery + system. So you don=92t know how many mA are supplying the =
system
>> and how many mA are left over for charging.
>>=20
>> You can only assume how much the system is drawing while running (so=
mething
>> between 50 and 600 mA but this depends on system activities, power s=
tate
>> of peripherald and e.g. backlight being switched on).
>>=20
>> I think your basic assumption that we know any time how many mA the =
system
>> is taking is not given.
>=20
> So.. you won't be able to get exact value while charging, but you
> get one while discharging, which is what really matters=85?

Is it the same during charging?

And, as we already discussed it depends on the situation.

In addition, GSM power consumption runs in bursts and I don=92t know if=
 the sample
rate of the MADC is good enough to track that correctly.

>=20
>>> Yes, and that coefficient should be internal battery resistance ;-)=
=2E
>>=20
>> But where do you know this value from to write it into a DT file?
>> Usually you can=92t measure it easily and for some batteries you don=
=92t have
>> a data sheet.
>>=20
>> Contrary, the calibration curves can easily be measured on the devic=
e
>> (assuming that the charge level decreases/increases linearly over ti=
me
>> between Full and Empty).
>=20
> If you can copy it from the data sheet, that's the easiest option. If
> not, you should be able to easily compute it from the charge/discharg=
e
> curves or from measured voltage at different loads.

Well, this again assumes that you can generate/control different loads
easily (e.g. turn on/off this and that peripheral) to check the voltage
drop. Sounds good in theory, but I don=92t want to do it in practice to
derive this parameter.

And, don=92t forget that the MADC signals are nosiy and don=92t have th=
e
best precision. So it is likely that you get wrong values.

As said, I think it is not worth the effort around the imperfect twl403=
0/MADC
charging system.

If someone wants precise data, that is what fuel gauge chips are good f=
or.
And we already have drivers for them.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
