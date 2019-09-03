From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 2/5] ARM: dts: add support for opp-v2 for omap34xx and omap36xx
Date: Tue, 3 Sep 2019 07:58:43 +0200
Message-ID: <F72772FC-088A-43B6-B486-7AD172885796@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com> <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 03.09.2019 um 04:38 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
>=20
> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
>> +		opp1-125000000 {
>> +			opp-hz =3D /bits/ 64 <125000000>;
>> +			// we currently only select the max voltage from =
table Table 3-3 of the omap3530 Data sheet (SPRS507F)
>> +			// <target min max> could also be single =
<target>
>> +			opp-microvolt =3D <975000 975000 975000>;
>> +			// first value is silicon revision, second one =
720MHz Device Identification
>=20
>> +			opp-supported-hw =3D <0xffffffff 3>;
>=20
> I don't see the driver changes using this field, am I missing
> something ?

This is parsed by _opp_is_supported() which is called
indirectly by ti_cpufreq_probe().

BR,
Nikolaus
