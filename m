From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 3/5] mfd: tps65217: Add a dependency on OF
Date: Wed, 7 Jun 2017 16:54:53 +0530
Message-ID: <41600d7d-3754-2907-151e-57fa20f88222@ti.com>
References: <1496760340-27959-1-git-send-email-j-keerthy@ti.com>
 <1496760340-27959-4-git-send-email-j-keerthy@ti.com>
 <CAFqH_52OncBvwCmu6JiFSdVckky9Gqzm7ZoUNxpqF-82oO2GAw@mail.gmail.com>
 <c13efc60-d4fd-7c1a-e889-f867ebd18446@ti.com>
 <20170607103753.n3entu2ylxvhdax7@dell> <20170607103839.2bydxqxussxyahvn@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607103839.2bydxqxussxyahvn@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, milo.kim@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Wednesday 07 June 2017 04:08 PM, Lee Jones wrote:
> On Wed, 07 Jun 2017, Lee Jones wrote:
> 
>> On Wed, 07 Jun 2017, Keerthy wrote:
>>
>>>
>>>
>>> On Tuesday 06 June 2017 08:34 PM, Enric Balletbo Serra wrote:
>>>> Hi Keerthy,
>>>>
>>>> By change I was looking at this. Some comments below that I think can
>>>> be applied to all patches in this series
>>>>
>>>> 2017-06-06 16:45 GMT+02:00 Keerthy <j-keerthy@ti.com>:
>>>>> Currently the driver boots only via device tree hence add a
>>>>> dependency on OF.
>>>>>
>>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>>> ---
>>>>>  drivers/mfd/Kconfig | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>> index 75b59f1..2d1425d 100644
>>>>> --- a/drivers/mfd/Kconfig
>>>>> +++ b/drivers/mfd/Kconfig
>>>>> @@ -1297,7 +1297,7 @@ config MFD_TPS65090
>>>>>
>>>>>  config MFD_TPS65217
>>>>>         tristate "TI TPS65217 Power Management / White LED chips"
>>>>> -       depends on I2C
>>>>> +       depends on I2C && OF
>>>>
>>>> Shouldn't you add || COMPILE_TEST here ?
>>>
>>> Sure.
>>>
>>>>
>>>>>         select MFD_CORE
>>>>>         select REGMAP_I2C
>>>>>         select IRQ_DOMAIN
>>>>>
>>>>
>>>> I think you can remove the of_match_device checks in some drivers too
>>>>
>>>> i.e:
>>>>
>>>> http://elixir.free-electrons.com/linux/latest/source/drivers/mfd/tps65217.c#L330
>>>
>>> Yes that and removal of unused i2c_device_id. I will follow it up once
>>> this OF dependency is in.
>>
>> The of_match_device() checks should be removed with the OF patch.

Lee Jones/ Enric,

IIUC of_match_device call is still needed to obtain a match and in case
there are multiple compatibles with different match data then this call
is definitely needed.

There is no need to check for return value as we will find one match for
sure and that can be removed.

Even checks like 'if (client->dev.of_node) {' can surely be removed with
depends on OF.

Please correct me if i am wrong.

Regards,
Keerthy
> 
> In fact, just squash these changes into the I2C removal patches.
> 
