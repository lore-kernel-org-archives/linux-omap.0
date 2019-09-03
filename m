From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
Date: Tue, 3 Sep 2019 08:01:05 +0200
Message-ID: <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com> <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 03.09.2019 um 04:36 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
>=20
> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
>> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
>> 1GHz capability is automatically detected.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
>> 1 file changed, 7 deletions(-)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi =
b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>> index 5441e9ffdbb4..e98b0c615f19 100644
>> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
>> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>> @@ -11,13 +11,6 @@
>> 	cpus {
>> 		cpu@0 {
>> 			cpu0-supply =3D <&vcc>;
>> -			operating-points =3D <
>> -				/* kHz    uV */
>> -				300000  1012500
>> -				600000  1200000
>> -				800000  1325000
>> -				1000000	1375000
>> -			>;
>> 		};
>> 	};
>=20
> This should be merged with 2/5 ?

Well, it bloats 2/5.

What I hope (I can't test) is that this opp-v1 table
is ignored if an opp-v2 table exists. So that it can be
removed by a separate follow-up patch.

BR,
Nikolaus=
