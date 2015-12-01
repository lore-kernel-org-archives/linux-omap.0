From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH] clocksource: ti-32k: convert to platform device
Date: Tue, 1 Dec 2015 17:08:39 +0200
Message-ID: <565DB7F7.4020702@ti.com>
References: <1448040129-23869-1-git-send-email-grygorii.strashko@ti.com>
 <87h9kgcz1k.fsf@saruman.tx.rr.com> <5658B8B2.5030505@ti.com>
 <20151130162815.GA2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151130162815.GA2517@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 11/30/2015 06:28 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [151127 12:11]:
>> On 11/20/2015 08:21 PM, Felipe Balbi wrote:
>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>> Since system clocksource is finally selected by Clocksource core a=
t
>>>> fs_initcall stage during boot there are no reasons to initialize
>>>> ti_32k_timer at early boot stages. Hence, ti_32k_timer can be
>>>> converted to use platform device/driver model and its PM can be
>>>> implemented using PM runtime which is common for OMAP devices.
>>>>
>>>> Platform specific initialization code has to be disabled once as
>>>> ti_32k_timer is converted to platform device - otherwise OMAP plat=
form
>>>> code will generate boot warnings.
>>>>
>>>> After this change, all counter_32k's platform code can be removed
>>>> once all OMAP boards will be converted to DT.
>>>>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Cc: Felipe Balbi <balbi@ti.com>
>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>> ---
>>
>> [...]
>>
>>>> +
>>>> +static struct platform_driver ti_32k_driver __initdata =3D {
>>>> +	.probe		=3D ti_32k_probe,
>>>> +	.driver		=3D {
>>>> +		.name	=3D "ti_32k_timer",
>>>> +		.of_match_table =3D of_match_ptr(ti_32k_of_table),
>>>> +	}
>>>> +};
>>>> +
>>>> +static int __init ti_32k_init(void)
>>>> +{
>>>> +	return platform_driver_register(&ti_32k_driver);
>>>>    }
>>>> -CLOCKSOURCE_OF_DECLARE(ti_32k_timer, "ti,omap-counter32k",
>>>> -		ti_32k_timer_init);
>>>> +
>>>> +subsys_initcall(ti_32k_init);
>>>> +
>>>> +MODULE_AUTHOR("Paul Mundt");
>>>> +MODULE_AUTHOR("Juha Yrj=C3=B6l=C3=A4");
>>>> +MODULE_DESCRIPTION("OMAP2 32k Timer");
>>>> +MODULE_ALIAS("platform:ti_32k_timer");
>>>> +MODULE_LICENSE("GPL v2");
>>>
>>> this will break clksource_of_init(), right ? Eventually, we want th=
at to
>>> be the only thing called by our .init_time method. I'll leave it to=
 Tony
>>> to decide, but IMO this is not a good path forward for timers.
>>>
>>
>> Yeh :(.  I did additional tests, and, unfortunately, this can't be u=
sed as is.
>> But not because of clocksource_of_init() which will just produce boo=
t warning.
>> It can't be done because of sched_clock_register() which is expected=
 to be
>> called during early boot time only and with disabled IRQs.
>>
>> It was so tempting to try :)
>=20
> We should be able to make this into an early_platform_device and just
> have it depend on the source clock muxes. See the omap initcall chang=
es
> patches I just posted.
>=20

Sry, may be I've missed smth, but how early_platform_device will help u=
s
to get rid of platform code - We'd still need to power on manually=20
early_platform_device's from platform code :( through hwmod.

The main reason why I've tried this is because clocksource will be real=
ly selected
only at fs_initcall time - and at that time we have no restriction for =
using platform
devices, Pm runtime APIs, etc. (exception/blocker is sched_clock :().

--=20
regards,
-grygorii
