From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 3/5] mfd: tps65217: Add a dependency on OF
Date: Wed, 7 Jun 2017 16:10:46 +0200
Message-ID: <CABxcv=mSqGOG+Z9eHhAnfw=ZR4-US_zVzvo3kNWY4o2mT_C-Ew@mail.gmail.com>
References: <1496760340-27959-1-git-send-email-j-keerthy@ti.com>
 <1496760340-27959-4-git-send-email-j-keerthy@ti.com> <CAFqH_52OncBvwCmu6JiFSdVckky9Gqzm7ZoUNxpqF-82oO2GAw@mail.gmail.com>
 <c13efc60-d4fd-7c1a-e889-f867ebd18446@ti.com> <20170607103753.n3entu2ylxvhdax7@dell>
 <20170607103839.2bydxqxussxyahvn@dell> <41600d7d-3754-2907-151e-57fa20f88222@ti.com>
 <CAFqH_53jSPcKB8rOiODDv3Jmbrq6h3UvW+gZLSV7JFXM1j_bWA@mail.gmail.com> <c5b31280-28fb-3dc3-dd7b-bcd9294e5b61@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5b31280-28fb-3dc3-dd7b-bcd9294e5b61@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Milo Kim <milo.kim@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Keerthy,

On Wed, Jun 7, 2017 at 3:45 PM, Keerthy <j-keerthy@ti.com> wrote:

[snip]

>>>>>>>>
>>>>>>>
>>>>>>> I think you can remove the of_match_device checks in some drivers too
>>>>>>>
>>>>>>> i.e:
>>>>>>>
>>>>>>> http://elixir.free-electrons.com/linux/latest/source/drivers/mfd/tps65217.c#L330
>>>>>>
>>>>>> Yes that and removal of unused i2c_device_id. I will follow it up once
>>>>>> this OF dependency is in.
>>>>>
>>>>> The of_match_device() checks should be removed with the OF patch.
>>>
>>> Lee Jones/ Enric,
>>>
>>> IIUC of_match_device call is still needed to obtain a match and in case
>>> there are multiple compatibles with different match data then this call
>>> is definitely needed.
>>>

That's correct...

>>
>> Not sure if I follow you. My understanding is that with DT the probe
>> of this driver is only called if there is a node with the compatible =
>> "ti,tps65217" string. So if probe is called there is always a match
>> and the call to of_match_device is redundant.
>
> How will you get the matching data?
>
> For the tps65217 case you mentioned we need the match pointer to get the
> chip_id right?
>
> chip_id = (unsigned long)match->data;
>

...but this particular driver only has a single entry in the OF table
and so you can just do:

tps->id = TPS65217;

Later if there's a variant for this chip, then you can add the logic
to query the struct of_device_id .data. But for now I think that's
better to just remove as Enric proposes and also remove the .data
field from the struct of_device_id entry.

Best regards,
Javier
