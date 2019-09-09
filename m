From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
Date: Mon, 9 Sep 2019 20:20:43 +0200
Message-ID: <CBA5BBAF-3875-415D-A6C1-2C5B18AAA002@goldelico.com>
References: <20190909154502.19804-1-aford173@gmail.com> <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com> <CAHCN7xLfOo7xsmDq5ZuPZsh02pjKx3w9FkJGN6AowJoHkRrWmg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xLfOo7xsmDq5ZuPZsh02pjKx3w9FkJGN6AowJoHkRrWmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>, Adam Ford <adam.ford@logicpd.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 09.09.2019 um 20:17 schrieb Adam Ford <aford173@gmail.com>:
>=20
> On Mon, Sep 9, 2019 at 1:13 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Hi Adam,
>>=20
>>> Am 09.09.2019 um 17:45 schrieb Adam Ford <aford173@gmail.com>:
>>>=20
>>> The AM3517 only lists 600MHz @ 1.2V, but the revister values for
>>=20
>> a small typo...
>>=20
>> s/revister/register/
>>=20
>>> 0x4830A204 =3D 1b86 802f, it seems like am3517 might be a derivative
>>> of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
>>> (600 MHz).
>>>=20
>>> This patch simply enable adds the am3517 to the compatible table
>>> using the omap3630 structure instead of the 3430.
>>>=20
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>=20
>>> diff --git a/drivers/cpufreq/ti-cpufreq.c =
b/drivers/cpufreq/ti-cpufreq.c
>>> index f2f58d689320..6b69fb1d6bdf 100644
>>> --- a/drivers/cpufreq/ti-cpufreq.c
>>> +++ b/drivers/cpufreq/ti-cpufreq.c
>>> @@ -270,6 +270,7 @@ static int =
ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
>>>=20
>>> static const struct of_device_id ti_cpufreq_of_match[] =3D {
>>>      { .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
>>> +     { .compatible =3D "ti,am3517", .data =3D &omap36xx_soc_data, =
},
>>>      { .compatible =3D "ti,am43", .data =3D &am4x_soc_data, },
>>>      { .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
>>>      { .compatible =3D "ti,omap34xx", .data =3D &omap34xx_soc_data, =
},
>>> --
>>> 2.17.1
>>>=20
>>=20
>> Looks good to me.
>>=20
>> Should I include your two patches to my patch set (and resend)?
>> Or should we keep them separated?
>=20
> Go ahead and take credit for them.  I just did what you told me to do
> and tested them.

Well, you are still the Author, the one who wrote down the ideas :)
I think git will even keep the author name untouched.

> Go ahead and mark it as Tested-by with my name.

Best is to keep your Signed-Off + mine and add a tested-by as well :)

BR and thanks,
Nikolaus
