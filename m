From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] mfd: tps65217: Instantiate sub-devices from device tree
Date: Thu, 8 Jun 2017 23:35:35 +0200
Message-ID: <CAFqH_52rU7ZBG_Muy2JHoqJGdXOdsNfmtJxsZoPRyx3V1aWmFw@mail.gmail.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
 <20170607103242.16008-4-enric.balletbo@collabora.com> <6359abe2-9a21-78a2-f5ea-87e2e3335af3@ti.com>
 <CAFqH_53v32iODN4xhoh4ho4s6grxknEDS3Ak6CHBcTAQo6fDNw@mail.gmail.com> <578f348c-509f-79d3-9770-73c9fcffe19c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <578f348c-509f-79d3-9770-73c9fcffe19c-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Mark Rutland <mark.rutland@arm.c>
List-Id: linux-omap@vger.kernel.org

2017-06-08 19:11 GMT+02:00 Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>:
>
>
> On 06/08/2017 08:16 AM, Enric Balletbo Serra wrote:
>> 2017-06-07 18:05 GMT+02:00 Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>:
>>>
>>>
>>> On 06/07/2017 05:32 AM, Enric Balletbo i Serra wrote:
>>>> The driver boots only via device tree but currently all the MFD sub-devices
>>>> are instatiated independently of the device tree configuration, i.e
>>>> although tps65217-charger is disabled by default it's instantiated by the
>>>> MFD driver.
>>>>
>>>> Instead of register all sub-devices, if the TPS65217 device tree node has a
>>>> sub-node enabled, try to instatiate them as MFD sub-devices but not
>>>> instantiate sub-nodes that are not enabled.
>>>>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>>>> ---
>>>>    drivers/mfd/tps65217.c       | 56 +++++++-------------------------------------
>>>>    include/linux/mfd/tps65217.h |  6 -----
>>>>    2 files changed, 9 insertions(+), 53 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>>>> index f769c7d..9effdda 100644
>>>> --- a/drivers/mfd/tps65217.c
>>>> +++ b/drivers/mfd/tps65217.c
>>>> @@ -33,14 +33,7 @@
>>>>    #include <linux/mfd/core.h>
>>>>    #include <linux/mfd/tps65217.h>
>>>>
>>>> -static struct resource charger_resources[] = {
>>>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_AC, "AC"),
>>>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>>>> -};
>>>> -
>>>> -static struct resource pb_resources[] = {
>>>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
>>>> -};
>>>
>>> May be I messed smth, but how about interrupts for charger and pwrbutton?
>>>
>>
>> I might be wrong but as this driver is DT-only these resources came
>> from the DT. The driver calls platform_get_irq_byname and then
>> of_irq_get_byname.
>>
>> i.e arch/arm/boot/dts/am335x-bone-common.dtsi
>>
>> &tps {
>>          charger {
>>                  interrupts = <0>, <1>;
>>                  interrupt-names = "USB", "AC";
>>                  status = "okay";
>>          };
>>
>>          pwrbutton {
>>                  interrupts = <2>;
>>                  status = "okay";
>>          };
>> };
>
> Sry, but this make no sense - those IRQ configuration is static,
> so it should be defined in arch/arm/boot/dts/tps65217.dtsi at least.

I was describing the state-of-art not what should be. If you mean that
what doesn't make sense have these interrupts portions in the DT and
the resources in the driver I'm completely agree. So we have two
options:

 1) Get rid of the irq resources from tps65217 MFD driver and
configure all with the DT (these patches)
 2) Get rid of the DT portions as doesn't make sense have them in two places.

If we select 2) at least we have the problem that currently all
sub-devices are instantiated and there is no way to disable a
sub-device (the problem I'm trying to solve) hence I proposed 1)

> But, again, it also not required, because it is strictly static for
> this particular device and so defined in code.

DT describes the hardware and I guess is full of static data so I
don't think this would be a problem.

> And  platform_get_irq_byname() should perfectly work with mfd_add_devices().
>

Agree, for a DT-only driver it would check first in the DT
(of_irq_get_byname) and if it fails get the resource with
platform_get_resource_byname. I don't have an answer here about if
it's preferred provide this info in the DT or hard-coded in the
driver.

> Also not that  tps65217.dtsi included in below files, but
>
> ./arch/arm/boot/dts/am335x-bone-common.dtsi:/include/ "tps65217.dtsi"
> ./arch/arm/boot/dts/am335x-chilisom.dtsi:/include/ "tps65217.dtsi"
> ./arch/arm/boot/dts/am335x-nano.dts:#include "tps65217.dtsi"
> ./arch/arm/boot/dts/am335x-pepper.dts:/include/ "tps65217.dtsi"
> ./arch/arm/boot/dts/am335x-sl50.dts:#include "tps65217.dtsi"
>
> but IRQs defined only in
> ./arch/arm/boot/dts/am335x-bone-common.dtsi:            interrupt-names = "USB", "AC";
> ./arch/arm/boot/dts/am335x-chiliboard.dts:              interrupt-names = "USB", "AC";
>
> So how are other boards working?
>

Because on those that the IRQs are not defined it gets the data from
the platform resources. Again a mesh that we need to solve.

>
>>
>>>> +#define TPS65217_NUM_IRQ     3
>>>>
>>>>    static void tps65217_irq_lock(struct irq_data *data)
>>>>    {
>>>> @@ -86,29 +79,6 @@ static struct irq_chip tps65217_irq_chip = {
>>>>        .irq_disable            = tps65217_irq_disable,
>>>>    };
>>>>
>>>> -static struct mfd_cell tps65217s[] = {
>>>> -     {
>>>> -             .name = "tps65217-pmic",
>>>> -             .of_compatible = "ti,tps65217-pmic",
>>>> -     },
>>>> -     {
>>>> -             .name = "tps65217-bl",
>>>> -             .of_compatible = "ti,tps65217-bl",
>>>> -     },
>>>> -     {
>>>> -             .name = "tps65217-charger",
>>>> -             .num_resources = ARRAY_SIZE(charger_resources),
>>>> -             .resources = charger_resources,
>>>> -             .of_compatible = "ti,tps65217-charger",
>>>> -     },
>>>> -     {
>>>> -             .name = "tps65217-pwrbutton",
>>>> -             .num_resources = ARRAY_SIZE(pb_resources),
>>>> -             .resources = pb_resources,
>>>> -             .of_compatible = "ti,tps65217-pwrbutton",
>>>> -     },
>>>> -};
>>>> -
>>>>    static irqreturn_t tps65217_irq_thread(int irq, void *data)
>>>>    {
>>>>        struct tps65217 *tps = data;
>>>> @@ -359,23 +329,8 @@ static int tps65217_probe(struct i2c_client *client,
>>>>                return ret;
>>>>        }
>>>>
>>>> -     if (client->irq) {
>>>> +     if (client->irq)
>>>>                tps65217_irq_init(tps, client->irq);
>>>> -     } else {
>>>> -             int i;
>>>> -
>>>> -             /* Don't tell children about IRQ resources which won't fire */
>>>> -             for (i = 0; i < ARRAY_SIZE(tps65217s); i++)
>>>> -                     tps65217s[i].num_resources = 0;
>>>> -     }
>>>> -
>>>> -     ret = devm_mfd_add_devices(tps->dev, -1, tps65217s,
>>>> -                                ARRAY_SIZE(tps65217s), NULL, 0,
>>>> -                                tps->irq_domain);
>>>> -     if (ret < 0) {
>>>> -             dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
>>>> -             return ret;
>>>> -     }
>>>
>>> And as I remember there was a request to use mfd_add_devices()
>>> and not of_platform_populate() for mfd sub-devices instantiation.
>>>
>>
>>  From what I know or you add the sub-devices via mfd_add_devices or
>> using the DT with of_platform_populate, and the first is probably the
>> preferred, but in this specific case this driver is DT-only so IMHO
>> makes more sense adding via the DT, there are already some bindings
>> i.e:
>>   arch/arm/boot/dts/tps65217.dtsi
>>   arch/arm/boot/dts/am335x-bone-common.dtsi
>>
>> Let me explain a bit more,  assume that you have another AM335x with
>> the TPS65217 PMIC but you don't want the charger because is not wired
>> in your board. Your board DT will include the tps65217.dtsi, in this
>> file you can see:
>>
>> &tps {
>>         ...
>>          charger {
>>                  compatible = "ti,tps65217-charger";
>>                  status = "disabled";
>>          };
>>          ...
>> };
>>
>> Seems that's fine but actually not works as expected, the TPS65217 MFD
>> registers all the sub-devices so the charger is enabled and running
>> even you have status = "disabled" in your DT. This looks incoherent to
>> me, hence I replaced the devm_mfd_add_devices() for the
>> of_platform_populate which takes care of the status propriety and only
>> calls the probe of the sub-devices that match and are enabled (status
>> = "okay").
>
> I can't find links on corresponding discussions, but mfd_add_devices() is
> preferred for MDF devices. Below is one commit i've found. Also you can compare number of
> drivers using mfd_add_devices() and of_platform_populate().
>

I don't think this a valid argument, I can also provide you a commit
that does exactly the contrary, replaces mfd_add_devices for
of_platform_populate (commit bb03ffb96c72)

>
> regarding your problem - I think, It might be reasonable from your side to propose change to
> mfd_add_device() which will take into account 'status = "disabled";' DT property.
>

Yes this is another solution to the problem that I thought, modify the
mfd-core to check if a device is available for use by calling
of_device_is_available and only add the sub-devices that are enabled.

Please, let's focus on how to solve the problem. Guess it's clear what
I'm trying to solve. To sum up, I think there are two ways to solve
the problem

 1) Get rid of the irq resources from tps65217 MFD driver and
configure all with the DT and of_platform_populate (these patches)
 2) Get rid of the DT portions as doesn't make sense have them in two places.
     +  2.1) Modify mfd-core to only instantiate the the sub-device is
device has status = "okay"

I don't mind to implement 2 + 2.1 if this is what people thinks is the
best. The *main* purpose of these patches was start this discussion to
find the solution.

I think at this point we need the maintainer's thoughts?

> ---
> commit 4531156db726d27e593d35800d43c74be4e393b9
> Author: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Date:   Mon Sep 19 13:09:05 2016 +0530
>
>     mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
>
>     mfd_add_devices enables parsing device tree nodes without compatibles
>     for regulators and gpio modules. Replace of_platform_populate with
>     mfd_add_devices. mfd_cell currently is populated with regulators,
>     gpio and powerbutton.
>
>     Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>     Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
>
>
>
>
> --
> regards,
> -grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
