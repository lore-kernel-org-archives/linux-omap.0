From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
Date: Tue, 3 Sep 2019 08:34:50 +0200
Message-ID: <98AF4586-C6FF-43A5-99B9-797145F50D07@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com> <20190903023635.44yf32jowpm3hgfp@vireshk-i7> <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com> <20190903061403.k3d333f54gj2kuxi@vireshk-i7> <6B7B0EDB-8A60-48A0-AFAB-8A266358300C@goldelico.com> <20190903062808.p6jkgwylyqxcjs4z@vireshk-i7>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903062808.p6jkgwylyqxcjs4z@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 03.09.2019 um 08:28 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
>=20
> On 03-09-19, 08:23, H. Nikolaus Schaller wrote:
>>=20
>>> Am 03.09.2019 um 08:14 schrieb Viresh Kumar =
<viresh.kumar@linaro.org>:
>>>=20
>>> On 03-09-19, 08:01, H. Nikolaus Schaller wrote:
>>>>=20
>>>>> Am 03.09.2019 um 04:36 schrieb Viresh Kumar =
<viresh.kumar@linaro.org>:
>>>>>=20
>>>>> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
>>>>>> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
>>>>>> 1GHz capability is automatically detected.
>>>>>>=20
>>>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>>>> ---
>>>>>> arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
>>>>>> 1 file changed, 7 deletions(-)
>>>>>>=20
>>>>>> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi =
b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>>>>>> index 5441e9ffdbb4..e98b0c615f19 100644
>>>>>> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
>>>>>> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>>>>>> @@ -11,13 +11,6 @@
>>>>>> 	cpus {
>>>>>> 		cpu@0 {
>>>>>> 			cpu0-supply =3D <&vcc>;
>>>>>> -			operating-points =3D <
>>>>>> -				/* kHz    uV */
>>>>>> -				300000  1012500
>>>>>> -				600000  1200000
>>>>>> -				800000  1325000
>>>>>> -				1000000	1375000
>>>>>> -			>;
>>>>>> 		};
>>>>>> 	};
>>>>>=20
>>>>> This should be merged with 2/5 ?
>>>>=20
>>>> Well, it bloats 2/5.
>>>=20
>>> It is logically the right place to do this as that's where we are
>>> adding opp-v2.
>>=20
>> Well, sometimes the philosophy of patches is to add something new
>> first and remove the old in a second separate patch if the system
>> can live with both. This makes it easier to digest single patches
>> (because they are smaller) and might also better pinpoint an issue
>> by bisect.
>=20
> Right, but you already removed some of the opp-v1 stuff in patch 2/5.
> Why leave this one out ?
>=20
>>>=20
>>>> What I hope (I can't test) is that this opp-v1 table
>>>> is ignored if an opp-v2 table exists. So that it can be
>>>> removed by a separate follow-up patch.
>>>=20
>>> It should work as that's what we are doing in OPP core, but I still
>>> feel this better get merged with 2/5.
>>=20
>> Ok, I see. Noted for RFCv2.
>>=20
>> There will also be a big batch of changes for the compatible record
>> (omap3530->omap35xx, add omap34xx where needed) of ca. 10 board =
definition
>> DTS files. Should this then also become part of the new 2/5?
>=20
> Compatible thing should be separate patch anyway, I was just talking
> about replacing opp-v1 with v2.

Ok, understood.

BR and thanks,
Nikolaus
