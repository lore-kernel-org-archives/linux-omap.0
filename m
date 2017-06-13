From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] mfd: tps65217: remove duplicated interrupt resources.
Date: Tue, 13 Jun 2017 10:18:41 +0200
Message-ID: <CAFqH_51wYc-xXU9fAF=1KNJ4wC69oZToMXjVP==yCgrMVfwn+g@mail.gmail.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
 <20170612212412.22719-3-enric.balletbo@collabora.com> <bddc09a1-53d7-e7ed-5c04-a9ecf5310dde@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bddc09a1-53d7-e7ed-5c04-a9ecf5310dde-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

2017-06-13 0:41 GMT+02:00 Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>:
>
>
> On 06/12/2017 04:24 PM, Enric Balletbo i Serra wrote:
>> I don't think it makes sense to have the interrupt resources for charger
>> and power button in two different places, the driver and the DT binding.
>> That's confusing so remove the ones from the mfd driver in favour of
>> having the interrupt resources only described in the DT. Having the
>> resources in DT may help if there is or will be a similar pmic with
>> different resource allocation.
>
> Wouldn't this break DT compatibility? Old DTs do not contain IRQ resources
> and so they work only because of IRQ definitions in code.
>

I don't think so, the DT binding [1] and [2] says that the interrupts
proprieties are required, so the bindings that that doesn't have these
proprieties are wrong. Also I suspect that the binding that doesn't
define the interrupts expect the hw block disabled as the status =
"disabled" was defined, so I don't think was his intention have i.e
the charger active.

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
[2] https://www.kernel.org/doc/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>   drivers/mfd/tps65217.c | 22 +---------------------
>>   1 file changed, 1 insertion(+), 21 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>> index f769c7d..fd83bae 100644
>> --- a/drivers/mfd/tps65217.c
>> +++ b/drivers/mfd/tps65217.c
>> @@ -33,15 +33,6 @@
>>   #include <linux/mfd/core.h>
>>   #include <linux/mfd/tps65217.h>
>>
>> -static struct resource charger_resources[] = {
>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_AC, "AC"),
>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>> -};
>> -
>> -static struct resource pb_resources[] = {
>> -     DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
>> -};
>> -
>>   static void tps65217_irq_lock(struct irq_data *data)
>>   {
>>       struct tps65217 *tps = irq_data_get_irq_chip_data(data);
>> @@ -97,14 +88,10 @@ static struct mfd_cell tps65217s[] = {
>>       },
>>       {
>>               .name = "tps65217-charger",
>> -             .num_resources = ARRAY_SIZE(charger_resources),
>> -             .resources = charger_resources,
>>               .of_compatible = "ti,tps65217-charger",
>>       },
>>       {
>>               .name = "tps65217-pwrbutton",
>> -             .num_resources = ARRAY_SIZE(pb_resources),
>> -             .resources = pb_resources,
>>               .of_compatible = "ti,tps65217-pwrbutton",
>>       },
>>   };
>> @@ -359,15 +346,8 @@ static int tps65217_probe(struct i2c_client *client,
>>               return ret;
>>       }
>>
>> -     if (client->irq) {
>> +     if (client->irq)
>>               tps65217_irq_init(tps, client->irq);
>> -     } else {
>> -             int i;
>> -
>> -             /* Don't tell children about IRQ resources which won't fire */
>> -             for (i = 0; i < ARRAY_SIZE(tps65217s); i++)
>> -                     tps65217s[i].num_resources = 0;
>> -     }
>>
>>       ret = devm_mfd_add_devices(tps->dev, -1, tps65217s,
>>                                  ARRAY_SIZE(tps65217s), NULL, 0,
>>
>
> --
> regards,
> -grygorii
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best regards,
 Enric
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
