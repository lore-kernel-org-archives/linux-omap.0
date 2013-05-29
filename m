From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH] board-overo.c: enable TWL4030 power off
Date: Wed, 29 May 2013 10:34:18 +0200
Message-ID: <51A5BD8A.10702@epfl.ch>
References: <1362055461-27154-1-git-send-email-schnitzeltony@googlemail.com> <20130304190035.GT11806@atomide.com> <CALbNGRQbAq4NdS4JFmJABG_kwOWsHeY9xOuk=x7AzCk3zb9eBA@mail.gmail.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:38979 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965032Ab3E2IeX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 May 2013 04:34:23 -0400
In-Reply-To: <CALbNGRQbAq4NdS4JFmJABG_kwOWsHeY9xOuk=x7AzCk3zb9eBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Andreas_M=FCller?= <schnitzeltony@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hello Andreas,

On 03/05/2013 09:15 AM, Andreas M=FCller wrote:
> On Mon, Mar 4, 2013 at 8:00 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
>> * Andreas M=FCller <schnitzeltony@googlemail.com> [130228 04:50]:
>>
>> Can you please add a description here? Preferrably something
>> like "With commit XYZ overo poweroff stopped working. Fix this
>> by blah blah blah" so this can be queued as a fix.
>>
>> Regards,
>>
>> Tony
>>
>>> Signed-off-by: Andreas M=FCller <schnitzeltony@googlemail.com>
>>> ---
>>>   arch/arm/mach-omap2/board-overo.c |    5 +++++
>>>   1 files changed, 5 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap=
2/board-overo.c
>>> index 86bab51..b975c72 100644
>>> --- a/arch/arm/mach-omap2/board-overo.c
>>> +++ b/arch/arm/mach-omap2/board-overo.c
>>> @@ -418,9 +418,14 @@ static struct regulator_init_data overo_vmmc1 =
=3D {
>>>        .consumer_supplies      =3D overo_vmmc1_supply,
>>>   };
>>>
>>> +static struct twl4030_power_data overo_power_data =3D {
>>> +     .use_poweroff   =3D true,
>>> +};
>>> +
>>>   static struct twl4030_platform_data overo_twldata =3D {
>>>        .gpio           =3D &overo_gpio_data,
>>>        .vmmc1          =3D &overo_vmmc1,
>>> +     .power          =3D &overo_power_data,
>>>   };
>>>
>>>   static int __init overo_i2c_init(void)
>>> --
> Sorry for the noise but I am newbie here and have one question:
> Against which branch should patches send here be based on. Up to now =
I
> used Linus' mainline branch - is that OK?
>

Any plans to repost your patch?

Regards,

=46lorian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
