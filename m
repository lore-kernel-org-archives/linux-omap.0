From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Fri, 13 Sep 2019 15:32:28 +0200
Message-ID: <98751DAF-B3F7-4638-97BE-1D067B24EF18@goldelico.com>
References: <20190912183037.18449-1-aford173@gmail.com> <D4F7E03C-1880-45AC-8F7C-6C8A336E2A01@goldelico.com> <CAHCN7xK100mR=fNns3qdDKpOyWsTWXgDnnngQfQ_j8cB_SFfuA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xK100mR=fNns3qdDKpOyWsTWXgDnnngQfQ_j8cB_SFfuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi Adam,

> Am 13.09.2019 um 13:07 schrieb Adam Ford <aford173@gmail.com>:

>>> +     cpu_cooling_maps: cooling-maps {
>>> +             map0 {
>>> +                     trip =3D <&cpu_alert0>;
>>> +                     /* Only allow OPP50 and OPP100 */
>>> +                     cooling-device =3D <&cpu 0 1>;
>>=20
>> omap4-cpu-thermal.dtsi uses THERMAL_NO_LIMIT constants but I do not
>> understand their meaning (and how it relates to the opp list).
>=20
> I read through the documentation, but it wasn't completely clear to
> me. AFAICT, the numbers after &cpu represent the min and max index in
> the OPP table when the condition is hit.

Ok. It seems to use "cooling state" for those and the first is minimum
and the last is maximum. Using THERMAL_NO_LIMIT (-1UL) means to have
no limits.

Since here we use the &cpu node it is likely that the "cooling state"
is the same as the OPP index currently in use.

I have looked through the .dts which use cpu_crit and the picture is
not unique...

omap4		seems to only define it
am57xx		has two different grade dtsi files
dra7		overwrites critical temperature value
am57xx-beagle	defines a gpio to control a fan

The fan is only a map0 for the board_alert0 starting to do something at =
40=C2=B0C
and above but there is nothing for the "critical" point.
But throttling is working on omap5...

Could there be some automatic handling by the govenors for the =
"critical"
trip points? So that we do not need to define any cooling-maps for =
"critical"?

Even for the exynos54xx where the crical trip point is only defined.

>>=20
>>> +             };
>>> +     };
>>=20
>> Seems to make sense when comparing to omap4-cpu-thermal.dtsi...
>>=20
>> Maybe we can add the trip points to omap3-cpu-thermal.dtsi
>> because they seem to be the same for all omap3 variants and
>> just have a SoC variant specific cooling map for omap36xx.dtsi.
>=20
> The OPP's for OMAP3530 show that OPP5 and OPP6 are capable of
> operating at 105C.  AM3517 is a little different also, so I didn't
> want to make a generic omap3 throttling table.  Since my goal was to
> try to remove the need for the turbo option from the newly supported
> 1GHz omap3630/3730, I was hoping to get this pushed first.  From
> there, we can tweak the 34xx.dtsi and 3517.dtsi for their respective
> thermal information.

My observation is that all omap3 have
commercial range	0=C2=B0C .. 90=C2=B0C
extended		-40=C2=B0C .. 105=C2=B0C

So there is no difference in defining these as trip points and
my proposal would be to have these in omap3.dtsi.

Only disabling OPPs differs. Which would make only the mapping
go to omap36xx.

>=20
>>=20
>>> +};
>>> +
>>> /* OMAP3630 needs dss_96m_fck for VENC */
>>> &venc {
>>>      clocks =3D <&dss_tv_fck>, <&dss_96m_fck>;
>>> --
>>> 2.17.1
>>>=20
>>=20
>> The question is how we can test that. Heating up the omap36xx to =
90=C2=B0C
>> or even 105=C2=B0C isn't that easy like with omap5...
>>=20
>> Maybe we can modify the millicelsius values for testing purposes to
>> something in reachable range, e.g. 60=C2=B0C and 70=C2=B0C and watch =
what happens?
>=20
> I have access to a thermal chamber at work, but the guy who knows how
> to use it is out for the rest of the week.  My plan was do as you
> suggested and change the milicelsius values, but I wanted to get some
> buy-in from TI people and/or Tony.  This also means enabling the omap3
> thermal stuff which clearly throws a message that it's inaccurate.

Basically we need two different types of test:
1. is the DTS setup correct so that the bandgap sensor is read and
   triggers correct actions
2. is the bandgap sensor correct enough to that the data sheet limits
   are really met

>  I don't know how much it's inaccurate, so we may have to make the 90C
> value lower to compensate.

Hm. If the bandgap sensor is inaccurate, we should make sure it reports =
the
maximum value, just to be on the safe side. So that the real temperature
is guaranteed to be lower than what is reported.

Then we can use the data sheet limits of 90=C2=B0C and 105=C2=B0C in the =
trip point
table (which should not be tweaked for sensor inaccuracy).

BR,
Nikolaus
