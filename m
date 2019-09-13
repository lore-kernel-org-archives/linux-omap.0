From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Fri, 13 Sep 2019 18:51:35 +0200
Message-ID: <D3AF2868-F9A4-4176-A851-5DCF029B65A9@goldelico.com>
References: <20190912183037.18449-1-aford173@gmail.com> <D4F7E03C-1880-45AC-8F7C-6C8A336E2A01@goldelico.com> <CAHCN7xK100mR=fNns3qdDKpOyWsTWXgDnnngQfQ_j8cB_SFfuA@mail.gmail.com> <98751DAF-B3F7-4638-97BE-1D067B24EF18@goldelico.com> <CAHCN7xL-CmwmXP3PLdwAHiC-9tMjrpY4k7ZhxQ9WoXY6yUz8BA@mail.gmail.com> <ABCE2ACA-D19A-42D2-9606-C60F1A5CBCCB@goldelico.com> <CAHCN7xKfeh-cqJVfbW_km27cgee2MEBdPM3edACRi0fCaohxvw@mail.gmail.com> <7C9393BD-B23B-41A6-BF96-E53CD707AAC7@goldelico.com> <CAHCN7x+_f_jrttUGyKHBOUyYjkOx0mJxba1Yb3tPm9ee7+21og@mail.gmail.com> <CAHCN7xLODa114M77-rX9WHT+uJtsH3yOmbFG2KdEjZpTSECs2w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xLODa114M77-rX9WHT+uJtsH3yOmbFG2KdEjZpTSECs2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 13.09.2019 um 18:42 schrieb Adam Ford <aford173@gmail.com>:
>=20
> On Fri, Sep 13, 2019 at 11:35 AM Adam Ford <aford173@gmail.com> wrote:
>>=20
>> On Fri, Sep 13, 2019 at 10:09 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>>=20
>>>> Am 13.09.2019 um 17:01 schrieb Adam Ford <aford173@gmail.com>:
>>>>=20
>>>> On Fri, Sep 13, 2019 at 9:24 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>>>=20
>>>>>=20
>>>>>> Am 13.09.2019 um 16:05 schrieb Adam Ford <aford173@gmail.com>:
>>>>>>=20
>>>>>> On Fri, Sep 13, 2019 at 8:32 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>>>>>=20
>>>>>>> Hi Adam,
>>>>>>>=20
>>>>>>>> Am 13.09.2019 um 13:07 schrieb Adam Ford <aford173@gmail.com>:
>>>>>>>=20
>>>>>>>>>> +     cpu_cooling_maps: cooling-maps {
>>>>>>>>>> +             map0 {
>>>>>>>>>> +                     trip =3D <&cpu_alert0>;
>>>>>>>>>> +                     /* Only allow OPP50 and OPP100 */
>>>>>>>>>> +                     cooling-device =3D <&cpu 0 1>;
>>>>>>>>>=20
>>>>>>>>> omap4-cpu-thermal.dtsi uses THERMAL_NO_LIMIT constants but I =
do not
>>>>>>>>> understand their meaning (and how it relates to the opp list).
>>>>>>>>=20
>>>>>>>> I read through the documentation, but it wasn't completely =
clear to
>>>>>>>> me. AFAICT, the numbers after &cpu represent the min and max =
index in
>>>>>>>> the OPP table when the condition is hit.
>>>>>>>=20
>>>>>>> Ok. It seems to use "cooling state" for those and the first is =
minimum
>>>>>>> and the last is maximum. Using THERMAL_NO_LIMIT (-1UL) means to =
have
>>>>>>> no limits.
>>>>>>>=20
>>>>>>> Since here we use the &cpu node it is likely that the "cooling =
state"
>>>>>>> is the same as the OPP index currently in use.
>>>>>>>=20
>>>>>>> I have looked through the .dts which use cpu_crit and the =
picture is
>>>>>>> not unique...
>>>>>>>=20
>>>>>>> omap4           seems to only define it
>>>>>>> am57xx          has two different grade dtsi files
>>>>>>> dra7            overwrites critical temperature value
>>>>>>> am57xx-beagle   defines a gpio to control a fan
>>>>>>=20
>>>>=20
>>>> I am going to push a separate but related RFC with 2 patches in the
>>>> series.  This new one will setup the alerts and maps without any
>>>> throttling for all omap3's in the first patch.  The second patch =
will
>>>> consolidate the thermal references to omap3.dtsi so omap34, omap36 =
and
>>>> am35 can all use them without having to duplicate the entries.
>>>>=20
>>>> It will make the omap36xx changes simpler to manage, because we can
>>>> just modify a portion of the entries instead of having the whole
>>>> table.
>>>>=20
>>>> Once this parallel RFC gets comments/feedback, I'll re-integrate =
the
>>>> omap36xx throttling.
>>>=20
>>> Good idea. I have looked over them and they seem to be ok.
>>=20
>> Rebasing my omap36xx throttling after the v2 RFC I pushed moving the
>> omap3-cpu thermal stuff, I modified the omap36xx accordingly to try
>> and force the alert condition:
>>=20
>> &cpu_alert0 {
>>     temperature =3D <55000>; /* millicelsius */
>> };
>>=20
>> &cpu_cooling_maps {
>>     map0 {
>>          /* OPP130 and OPP1G are not available above 90C */
>>          cooling-device =3D <&cpu 0 2>;
>>     };
>> };
>>=20
>> I would expect that with the temperature set for 55C, it would have
>> done something, but it doesn't appear to be working as I would =
expect.
>>=20
>> # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>> 58500
>>=20
>> # cat =
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
>> 300000 600000 800000
>> #
>>=20
>> :-(
>>=20
>=20
> Good news (I think)
>=20
> With cooling-device =3D <&cpu 1 2> setup, I was able to ask the max
> frequency and it returned 600MHz.
>=20
> # cat /sys/devices/virtual/thermal/thermal_zone0/temp
> 58500
> # cat =
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
> 300000 600000 800000
> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_m
> scaling_max_freq  scaling_min_freq
> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
> 600000

looks good!
But we have to understand what the <&cpu 1 2> exactly means...

Hopefully someone reading your RFCv2 can answer...

What happens with trip point 60000?
(unfortunately one has to reboot in between or can you kexec between two =
kernel/dtb versions?)

BR,
Nikolaus
