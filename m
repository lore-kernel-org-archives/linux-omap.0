From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 4/4] mfd: tps65217: Instantiate sub-devices from device tree
Date: Fri, 9 Jun 2017 00:30:51 +0200
Message-ID: <CABxcv=mN6=hbDSqrVkwSL8zccCntN7m_3DP6ZCbkOT6CLw+skQ@mail.gmail.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
 <20170607103242.16008-4-enric.balletbo@collabora.com> <6359abe2-9a21-78a2-f5ea-87e2e3335af3@ti.com>
 <CAFqH_53v32iODN4xhoh4ho4s6grxknEDS3Ak6CHBcTAQo6fDNw@mail.gmail.com>
 <578f348c-509f-79d3-9770-73c9fcffe19c@ti.com> <CAFqH_52rU7ZBG_Muy2JHoqJGdXOdsNfmtJxsZoPRyx3V1aWmFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqH_52rU7ZBG_Muy2JHoqJGdXOdsNfmtJxsZoPRyx3V1aWmFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>Pavel Machek <p>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 8, 2017 at 11:35 PM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> 2017-06-08 19:11 GMT+02:00 Grygorii Strashko <grygorii.strashko@ti.com>:

[snip]

>>>
>>> &tps {
>>>          charger {
>>>                  interrupts = <0>, <1>;
>>>                  interrupt-names = "USB", "AC";
>>>                  status = "okay";
>>>          };
>>>
>>>          pwrbutton {
>>>                  interrupts = <2>;
>>>                  status = "okay";
>>>          };
>>> };
>>
>> Sry, but this make no sense - those IRQ configuration is static,
>> so it should be defined in arch/arm/boot/dts/tps65217.dtsi at least.

Agreed.

>
> I was describing the state-of-art not what should be. If you mean that
> what doesn't make sense have these interrupts portions in the DT and
> the resources in the driver I'm completely agree. So we have two
> options:
>
>  1) Get rid of the irq resources from tps65217 MFD driver and
> configure all with the DT (these patches)
>  2) Get rid of the DT portions as doesn't make sense have them in two places.
>
> If we select 2) at least we have the problem that currently all
> sub-devices are instantiated and there is no way to disable a
> sub-device (the problem I'm trying to solve) hence I proposed 1)
>

There's also an option (3) AFAICT. To do (1) but instead of hardcoding
in the DTS[i], to do it in the charger driver since it seems the
sub-devices are only used for this particular MFD device, and so the
IRQ numbers are always going to be the same (it's already hardcoded in
the MFD driver anyways).

So you can just move TPS65217_IRQ_{AC,USB} to the driver. Not sure
what's general opinion of having drivers calling irq_create_mapping()
to get the virtual IRQ's though...

[snip]

>>
>> I can't find links on corresponding discussions, but mfd_add_devices() is
>> preferred for MDF devices. Below is one commit i've found. Also you can compare number of
>> drivers using mfd_add_devices() and of_platform_populate().

I'm not sure if we should use that as an argument, it may well be
that's just the drivers being half converted to DT (which is pretty
common TBH).

>>
>
> I don't think this a valid argument, I can also provide you a commit
> that does exactly the contrary, replaces mfd_add_devices for
> of_platform_populate (commit bb03ffb96c72)
>
>>

[snip]

>
>> ---
>> commit 4531156db726d27e593d35800d43c74be4e393b9
>> Author: Keerthy <j-keerthy@ti.com>
>> Date:   Mon Sep 19 13:09:05 2016 +0530
>>
>>     mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
>>
>>     mfd_add_devices enables parsing device tree nodes without compatibles
>>     for regulators and gpio modules. Replace of_platform_populate with
>>     mfd_add_devices. mfd_cell currently is populated with regulators,
>>     gpio and powerbutton.
>>

For tps65218 couldn't instead of using mfd_add_devices() for all the
sub-devs, had used of_platform_populate() for the ones that have
device nodes and mfd_add_devices() only for the "tps65218-regulator"?

The commit talks about nodes without compatibles but's actually about
sub-devices without an associated device node. For me it makes sense
to use of_platform_populate() when the MFD has device nodes for their
sub-devices and mfd_add_devices() when DT knows nothing about the
sub-devices.

Best regards,
Javier
