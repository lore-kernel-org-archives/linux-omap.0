From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [GIT PULL 2/5] omap board changes for v3.6 merge window
Date: Wed, 11 Jul 2012 09:20:55 +0800
Message-ID: <4FFCD4F7.5050705@windriver.com>
References: <0M4ZFU-1RqIwX3VUq-00yonj@mx.kundenserver.de> <201207101534.13166.arnd@arndb.de> <4FFCCE43.2070709@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:39454 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab2GKBVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 21:21:24 -0400
In-Reply-To: <4FFCCE43.2070709@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

It seems work well now, thanks Tony and Arnd for your extra work
on these patches.

Regards,
Zumeng
=E4=BA=8E 2012=E5=B9=B407=E6=9C=8811=E6=97=A5 08:52, Zumeng Chen =E5=86=
=99=E9=81=93:
> =E4=BA=8E 2012=E5=B9=B407=E6=9C=8810=E6=97=A5 23:34, Arnd Bergmann =E5=
=86=99=E9=81=93:
>> On Tuesday 10 July 2012, Tony Lindgren wrote:
>>> The following changes since commit=20
>>> 6887a4131da3adaab011613776d865f4bcfb5678:
>>>
>>>    Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap=20
>>> tags/omap-devel-board-for-v3.6
>>>
>>> for you to fetch changes up to=20
>>> b103a2e22a238085f5c50d96345e1a09bb1efd50:
>>>
>>>    ARM: OMAP3: Fix omap3evm randconfig error introduced by VBUS=20
>>> support (2012-07-09 23:22:24 -0700)
>>>
>>> ----------------------------------------------------------------
>>> Board and platform data related changes for omaps
>>>
>>> ----------------------------------------------------------------
>>> Andy Gross (1):
>>>        omap2+: add drm device
>>>
>>> Dmitry Lifshitz (2):
>>>        ARM: OMAP3: cm-t35: add mt9t001 camera sensor support
>>>        ARM: OMAP3: cm-t35: add tvp5150 decoder support
>>>
>>> Peter Ujfalusi (2):
>>>        ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
>>>        ARM: OMAP: board-omap4panda: MUX configuration for sys_nirq2
>>>
>>> Tony Lindgren (1):
>>>        ARM: OMAP3: Fix omap3evm randconfig error introduced by VBUS=
=20
>>> support
>>>
>>> Zumeng Chen (4):
>>>        ARM: OMAP3EVM: Add NAND flash definition
>>>        ARM: OMAP3EVM: Adding USB internal LDOs board file
>>>        ARM: omap3evm: enable VBUS switch for EHCI tranceiver
>>>        ARM: OMAP3530evm: set pendown_state and debounce time for=20
>>> ads7846
>>> diff --cc arch/arm/mach-omap2/common-board-devices.c
>> I got a conflict in arch/arm/mach-omap2/common-board-devices.c betwe=
en
>> 16aced80f6739 "ARM: OMAP3530evm: set pendown_state and debounce time=
 for
>> ads7846" and 97ee9f01d6f26 "ARM: OMAP: fix the ads7846 init code",
>> see my resolution below.
>>
>> Please check if what I have in the for-next branch makese sense to y=
ou
>> all.
> No problem,  many thanks Arnd for your information.
> I'll check it, test it, and send you feedback.
>
> Regards,
> Zumeng
>>
>>     Arnd
>>
>> * Unmerged path arch/arm/mach-omap2/common-board-devices.c
>> diff --git a/arch/arm/mach-omap2/common-board-devices.c=20
>> b/arch/arm/mach-omap2/common-board-devices.c
>> index 1706ebc..1473474 100644
>> --- a/arch/arm/mach-omap2/common-board-devices.c
>> +++ b/arch/arm/mach-omap2/common-board-devices.c
>> @@ -35,6 +35,16 @@ static struct omap2_mcspi_device_config=20
>> ads7846_mcspi_config =3D {
>>       .turbo_mode    =3D 0,
>>    };
>>
>>   +/*
>>   + * ADS7846 driver maybe request a gpio according to the value
>>   + * of pdata->get_pendown_state, but we have done this. So set
>>   + * get_pendown_state to avoid twice gpio requesting.
>>   + */
>>   +static int omap3_get_pendown_state(void)
>>   +{
>>   +    return !gpio_get_value(OMAP3_EVM_TS_GPIO);
>>   +}
>>   +
>>    static struct ads7846_platform_data ads7846_config =3D {
>>       .x_max            =3D 0x0fff,
>>       .y_max            =3D 0x0fff,
>> @@ -45,6 +55,7 @@ static struct ads7846_platform_data ads7846_config=
 =3D {
>>       .debounce_rep        =3D 1,
>>       .gpio_pendown        =3D -EINVAL,
>>       .keep_vref_on        =3D 1,
>>   +    .get_pendown_state    =3D&omap3_get_pendown_state,
>>    };
>>
>>    static struct spi_board_info ads7846_spi_board_info __initdata =3D=
 {
>> @@ -63,28 +74,30 @@ void __init omap_ads7846_init(int bus_num, int=20
>> gpio_pendown, int gpio_debounce,
>>       struct spi_board_info *spi_bi =3D&ads7846_spi_board_info;
>>       int err;
>>
>> -    if (board_pdata&&  board_pdata->get_pendown_state) {
>> -        err =3D gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown=
");
>> -        if (err) {
>> -            pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err)=
;
>> -            return;
>> -        }
>> -        gpio_export(gpio_pendown, 0);
>> -
>> -        if (gpio_debounce)
>> -            gpio_set_debounce(gpio_pendown, gpio_debounce);
>> +    err =3D gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
>> +    if (err) {
>> +        pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
>> +        return;
>>       }
>>
>> +    if (gpio_debounce)
>> +        gpio_set_debounce(gpio_pendown, gpio_debounce);
>> +
>>       spi_bi->bus_num    =3D bus_num;
>>       spi_bi->irq    =3D gpio_to_irq(gpio_pendown);
>>
>>       if (board_pdata) {
>>           board_pdata->gpio_pendown =3D gpio_pendown;
>>           spi_bi->platform_data =3D board_pdata;
>> +        if (board_pdata->get_pendown_state)
>> +            gpio_export(gpio_pendown, 0);
>>       } else {
>>           ads7846_config.gpio_pendown =3D gpio_pendown;
>>       }
>>
>> +    if (!board_pdata || (board_pdata&& =20
>> !board_pdata->get_pendown_state))
>> +        gpio_free(gpio_pendown);
>> +
>>       spi_register_board_info(&ads7846_spi_board_info, 1);
>>   }
>>   #else
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
