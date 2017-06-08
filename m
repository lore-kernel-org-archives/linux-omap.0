From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 4/4] mfd: tps65217: Instantiate sub-devices from device
 tree
Date: Thu, 8 Jun 2017 12:11:35 -0500
Message-ID: <578f348c-509f-79d3-9770-73c9fcffe19c@ti.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
 <20170607103242.16008-4-enric.balletbo@collabora.com>
 <6359abe2-9a21-78a2-f5ea-87e2e3335af3@ti.com>
 <CAFqH_53v32iODN4xhoh4ho4s6grxknEDS3Ak6CHBcTAQo6fDNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFqH_53v32iODN4xhoh4ho4s6grxknEDS3Ak6CHBcTAQo6fDNw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Richard Purdie <rpurdie@rpsys.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-leds@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-omap@vger.kernel.org



On 06/08/2017 08:16 AM, Enric Balletbo Serra wrote:
> 2017-06-07 18:05 GMT+02:00 Grygorii Strashko <grygorii.strashko@ti.com>:
>>
>>
>> On 06/07/2017 05:32 AM, Enric Balletbo i Serra wrote:
>>> The driver boots only via device tree but currently all the MFD sub-devices
>>> are instatiated independently of the device tree configuration, i.e
>>> although tps65217-charger is disabled by default it's instantiated by the
>>> MFD driver.
>>>
>>> Instead of register all sub-devices, if the TPS65217 device tree node has a
>>> sub-node enabled, try to instatiate them as MFD sub-devices but not
>>> instantiate sub-nodes that are not enabled.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>    drivers/mfd/tps65217.c       | 56 +++++++-------------------------------------
>>>    include/linux/mfd/tps65217.h |  6 -----
>>>    2 files changed, 9 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>>> index f769c7d..9effdda 100644
>>> --- a/drivers/mfd/tps65217.c
>>> +++ b/drivers/mfd/tps65217.c
>>> @@ -33,14 +33,7 @@
>>>    #include <linux/mfd/core.h>
>>>    #include <linux/mfd/tps65217.h>
>>>
>>> -static struct resource charger_resources[] = {
>>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_AC, "AC"),
>>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>>> -};
>>> -
>>> -static struct resource pb_resources[] = {
>>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
>>> -};
>>
>> May be I messed smth, but how about interrupts for charger and pwrbutton?
>>
> 
> I might be wrong but as this driver is DT-only these resources came
> from the DT. The driver calls platform_get_irq_byname and then
> of_irq_get_byname.
> 
> i.e arch/arm/boot/dts/am335x-bone-common.dtsi
> 
> &tps {
>          charger {
>                  interrupts = <0>, <1>;
>                  interrupt-names = "USB", "AC";
>                  status = "okay";
>          };
> 
>          pwrbutton {
>                  interrupts = <2>;
>                  status = "okay";
>          };
> };

Sry, but this make no sense - those IRQ configuration is static,
so it should be defined in arch/arm/boot/dts/tps65217.dtsi at least.
But, again, it also not required, because it is strictly static for 
this particular device and so defined in code.
And  platform_get_irq_byname() should perfectly work with mfd_add_devices().

Also not that  tps65217.dtsi included in below files, but 

./arch/arm/boot/dts/am335x-bone-common.dtsi:/include/ "tps65217.dtsi"
./arch/arm/boot/dts/am335x-chilisom.dtsi:/include/ "tps65217.dtsi"
./arch/arm/boot/dts/am335x-nano.dts:#include "tps65217.dtsi"
./arch/arm/boot/dts/am335x-pepper.dts:/include/ "tps65217.dtsi"
./arch/arm/boot/dts/am335x-sl50.dts:#include "tps65217.dtsi"

but IRQs defined only in
./arch/arm/boot/dts/am335x-bone-common.dtsi:		interrupt-names = "USB", "AC";
./arch/arm/boot/dts/am335x-chiliboard.dts:		interrupt-names = "USB", "AC";

So how are other boards working?


> 
>>> +#define TPS65217_NUM_IRQ     3
>>>
>>>    static void tps65217_irq_lock(struct irq_data *data)
>>>    {
>>> @@ -86,29 +79,6 @@ static struct irq_chip tps65217_irq_chip = {
>>>        .irq_disable            = tps65217_irq_disable,
>>>    };
>>>
>>> -static struct mfd_cell tps65217s[] = {
>>> -     {
>>> -             .name = "tps65217-pmic",
>>> -             .of_compatible = "ti,tps65217-pmic",
>>> -     },
>>> -     {
>>> -             .name = "tps65217-bl",
>>> -             .of_compatible = "ti,tps65217-bl",
>>> -     },
>>> -     {
>>> -             .name = "tps65217-charger",
>>> -             .num_resources = ARRAY_SIZE(charger_resources),
>>> -             .resources = charger_resources,
>>> -             .of_compatible = "ti,tps65217-charger",
>>> -     },
>>> -     {
>>> -             .name = "tps65217-pwrbutton",
>>> -             .num_resources = ARRAY_SIZE(pb_resources),
>>> -             .resources = pb_resources,
>>> -             .of_compatible = "ti,tps65217-pwrbutton",
>>> -     },
>>> -};
>>> -
>>>    static irqreturn_t tps65217_irq_thread(int irq, void *data)
>>>    {
>>>        struct tps65217 *tps = data;
>>> @@ -359,23 +329,8 @@ static int tps65217_probe(struct i2c_client *client,
>>>                return ret;
>>>        }
>>>
>>> -     if (client->irq) {
>>> +     if (client->irq)
>>>                tps65217_irq_init(tps, client->irq);
>>> -     } else {
>>> -             int i;
>>> -
>>> -             /* Don't tell children about IRQ resources which won't fire */
>>> -             for (i = 0; i < ARRAY_SIZE(tps65217s); i++)
>>> -                     tps65217s[i].num_resources = 0;
>>> -     }
>>> -
>>> -     ret = devm_mfd_add_devices(tps->dev, -1, tps65217s,
>>> -                                ARRAY_SIZE(tps65217s), NULL, 0,
>>> -                                tps->irq_domain);
>>> -     if (ret < 0) {
>>> -             dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
>>> -             return ret;
>>> -     }
>>
>> And as I remember there was a request to use mfd_add_devices()
>> and not of_platform_populate() for mfd sub-devices instantiation.
>>
> 
>  From what I know or you add the sub-devices via mfd_add_devices or
> using the DT with of_platform_populate, and the first is probably the
> preferred, but in this specific case this driver is DT-only so IMHO
> makes more sense adding via the DT, there are already some bindings
> i.e:
>   arch/arm/boot/dts/tps65217.dtsi
>   arch/arm/boot/dts/am335x-bone-common.dtsi
> 
> Let me explain a bit more,  assume that you have another AM335x with
> the TPS65217 PMIC but you don't want the charger because is not wired
> in your board. Your board DT will include the tps65217.dtsi, in this
> file you can see:
> 
> &tps {
>         ...
>          charger {
>                  compatible = "ti,tps65217-charger";
>                  status = "disabled";
>          };
>          ...
> };
> 
> Seems that's fine but actually not works as expected, the TPS65217 MFD
> registers all the sub-devices so the charger is enabled and running
> even you have status = "disabled" in your DT. This looks incoherent to
> me, hence I replaced the devm_mfd_add_devices() for the
> of_platform_populate which takes care of the status propriety and only
> calls the probe of the sub-devices that match and are enabled (status
> = "okay").

I can't find links on corresponding discussions, but mfd_add_devices() is
preferred for MDF devices. Below is one commit i've found. Also you can compare number of
drivers using mfd_add_devices() and of_platform_populate().


regarding your problem - I think, It might be reasonable from your side to propose change to
mfd_add_device() which will take into account 'status = "disabled";' DT property.

---
commit 4531156db726d27e593d35800d43c74be4e393b9
Author: Keerthy <j-keerthy@ti.com>
Date:   Mon Sep 19 13:09:05 2016 +0530

    mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
    
    mfd_add_devices enables parsing device tree nodes without compatibles
    for regulators and gpio modules. Replace of_platform_populate with
    mfd_add_devices. mfd_cell currently is populated with regulators,
    gpio and powerbutton.
    
    Signed-off-by: Keerthy <j-keerthy@ti.com>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>





-- 
regards,
-grygorii
