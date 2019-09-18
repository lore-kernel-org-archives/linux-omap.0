From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Wed, 18 Sep 2019 11:36:26 +0200
Message-ID: <6B087285-DFAF-45AD-8D32-6A1264252342@goldelico.com>
References: <20190912183037.18449-1-aford173@gmail.com> <51bb8890-bfd7-c241-1ce5-151df3a90513@linaro.org> <CAHCN7xKjwkJHysSkNymF=sw6KuS=FqbapuRFZODuj6E_hmRG1A@mail.gmail.com> <2ef812a4-2f2d-b2e2-9fa4-080775e24bc8@linaro.org> <20190918092418.que4c5jpcn2dcavx@vireshk-mac-ubuntu>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190918092418.que4c5jpcn2dcavx@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Adam Ford <aford173@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 18.09.2019 um 11:24 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
>=20
> On 13-09-19, 00:33, Daniel Lezcano wrote:
>>=20
>> Hi Adam,
>>=20
>> On 12/09/2019 23:19, Adam Ford wrote:
>>> On Thu, Sep 12, 2019 at 4:12 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>=20
>>>> On 12/09/2019 20:30, Adam Ford wrote:
>>>>> The thermal sensor in the omap3 family isn't accurate, but it's
>>>>> better than nothing.  The various OPP's enabled for the omap3630
>>>>> support up to OPP1G, however the datasheet for the DM3730 states
>>>>> that OPP130 and OPP1G are not available above TJ of 90C.
>>>>>=20
>>>>> This patch configures the thermal throttling to limit the
>>>>> operating points of the omap3630 to Only OPP50 and OPP100 if
>>>>> the thermal sensor reads a value above 90C.
>>=20
>> Oh, that's a very interesting use case.
>>=20
>> AFAICT the thermal framework is not designed to deal with this
>> situation. I agree this setup may work (even if I'm not convinced =
about
>> the stability of the whole).
>>=20
>> May be Viresh can help for the cpufreq side?
>=20
> Sorry but I am not able to understand what's not supported by thermal =
framework
> here and what can I do to help :)

Well, it appears that it is not supported that the thermal
framework can enable/disable individual OPPs. Rather it disables
more and more of them from highest index to lowest (like a
fan spinning up in speed).

But it has turned out that we do not need that. It was only
a too verbatim interpretation of the data sheet which says
that certain OPPs (OPP130 and OPP1G) must not be enabled above
a thermal limit of 90=C2=B0C while the others can be used above.

But just going down stepwise to lower frequency OPPs as long
as above thermal limit is fine for practical situations.

So instead of "limit the operating points of the omap3630 to
Only OPP50 and OPP100 if the thermal sensor reads a value above
90C" we can just "go down from OPP1G -> OPP130 -> OPP100 -> OPP50
until the thermal sensors reads a value below 90C". And
that is easily done with existing cpufreq and thermal framework
(as we have tested).

This will of course also exclude OPP100 and OPP50 above 90=C2=B0C
where no thermal limit is given in the data sheet, but as far
as we know it is impossible (without running the board in a thermal
chamber) to get the chip above 90C in these low-frequency/voltage
OPPs.

Hope this clarifies.

BR and thanks,
Nikolaus
