From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH v3 1/5] mfd: tps65217: Add support for IRQs
Date: Fri, 17 Jun 2016 16:05:15 +0200
Message-ID: <123e6759-fa44-48f0-860d-623aaa39f8ea@grinn-global.com>
References: <20160616114110.23455-1-m.niestroj@grinn-global.com>
 <20160616114110.23455-2-m.niestroj@grinn-global.com>
 <5762A3AC.9010409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <5762A3AC.9010409@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 16.06.2016 15:03, Grygorii Strashko wrote:
> On 06/16/2016 02:41 PM, Marcin Niestroj wrote:
>> Add support for handling IRQs: power button, AC and USB power state
>> changes. Mask and interrupt bits are shared within one register, which
>> prevents us to use regmap_irq implementation. New irq_domain is
>> created in
>> order to add interrupt handling for each tps65217's subsystem. IRQ
>> resources have been added for charger subsystem to be able to notify
>> about
>> AC and USB state changes.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>> ---
>>   drivers/mfd/Kconfig          |   1 +
>>   drivers/mfd/tps65217.c       | 194
>> +++++++++++++++++++++++++++++++++++++++++--
>>   include/linux/mfd/tps65217.h |  11 +++
>>   3 files changed, 198 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 1bcf601..f8c9580 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1200,6 +1200,7 @@ config MFD_TPS65217
>>       depends on I2C
>>       select MFD_CORE
>>       select REGMAP_I2C
>> +    select IRQ_DOMAIN
>>       help
>>         If you say yes here you get support for the TPS65217 series of
>>         Power Management / White LED chips.
>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>> index 049a6fc..7763dbc 100644
>> --- a/drivers/mfd/tps65217.c
>> +++ b/drivers/mfd/tps65217.c
>> @@ -15,22 +15,99 @@
>>    * GNU General Public License for more details.
>>    */
>>
>> -#include <linux/kernel.h>
>>   #include <linux/device.h>
>> -#include <linux/module.h>
>> -#include <linux/platform_device.h>
>> +#include <linux/err.h>
>>   #include <linux/init.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/i2c.h>
>> -#include <linux/slab.h>
>> -#include <linux/regmap.h>
>> -#include <linux/err.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>>
>>   #include <linux/mfd/core.h>
>>   #include <linux/mfd/tps65217.h>
>>
>> -static const struct mfd_cell tps65217s[] = {
>> +static struct resource charger_resources[] = {
>> +    DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_AC, "AC"),
>> +    DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>> +};
>> +
>> +struct tps65217_irq {
>> +    int mask;
>> +    int interrupt;
>> +};
>> +
>> +static const struct tps65217_irq tps65217_irqs[] = {
>> +    [TPS65217_IRQ_PB] = {
>> +        .mask = TPS65217_INT_PBM,
>> +        .interrupt = TPS65217_INT_PBI,
>> +    },
>> +    [TPS65217_IRQ_AC] = {
>> +        .mask = TPS65217_INT_ACM,
>> +        .interrupt = TPS65217_INT_ACI,
>> +    },
>> +    [TPS65217_IRQ_USB] = {
>> +        .mask = TPS65217_INT_USBM,
>> +        .interrupt = TPS65217_INT_USBI,
>> +    },
>> +};
>> +
>> +static void tps65217_irq_lock(struct irq_data *data)
>> +{
>> +    struct tps65217 *tps = irq_data_get_irq_chip_data(data);
>> +
>> +    mutex_lock(&tps->irq_lock);
>> +}
>> +
>> +static void tps65217_irq_sync_unlock(struct irq_data *data)
>> +{
>> +    struct tps65217 *tps = irq_data_get_irq_chip_data(data);
>> +    int ret;
>> +
>> +    ret = tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
>> +                TPS65217_PROTECT_NONE);
>> +    if (ret != 0)
>> +        dev_err(tps->dev, "Failed to sync IRQ masks\n");
>> +
>> +    mutex_unlock(&tps->irq_lock);
>> +}
>> +
>> +static const inline struct tps65217_irq *
>> +irq_to_tps65217_irq(struct tps65217 *tps, struct irq_data *data)
>> +{
>> +    return &tps65217_irqs[data->hwirq];
>> +}
>> +
>> +static void tps65217_irq_enable(struct irq_data *data)
>> +{
>> +    struct tps65217 *tps = irq_data_get_irq_chip_data(data);
>> +    const struct tps65217_irq *irq_data = irq_to_tps65217_irq(tps,
>> data);
>> +
>> +    tps->irq_mask &= ~irq_data->mask;
>> +}
>> +
>> +static void tps65217_irq_disable(struct irq_data *data)
>> +{
>> +    struct tps65217 *tps = irq_data_get_irq_chip_data(data);
>> +    const struct tps65217_irq *irq_data = irq_to_tps65217_irq(tps,
>> data);
>> +
>> +    tps->irq_mask |= irq_data->mask;
>> +}
>> +
>> +static struct irq_chip tps65217_irq_chip = {
>> +    .irq_bus_lock        = tps65217_irq_lock,
>> +    .irq_bus_sync_unlock    = tps65217_irq_sync_unlock,
>> +    .irq_enable        = tps65217_irq_enable,
>> +    .irq_disable        = tps65217_irq_disable,
>> +};
>> +
>> +static struct mfd_cell tps65217s[] = {
>>       {
>>           .name = "tps65217-pmic",
>>           .of_compatible = "ti,tps65217-pmic",
>> @@ -41,10 +118,89 @@ static const struct mfd_cell tps65217s[] = {
>>       },
>>       {
>>           .name = "tps65217-charger",
>> +        .num_resources = ARRAY_SIZE(charger_resources),
>> +        .resources = charger_resources,
>>           .of_compatible = "ti,tps65217-charger",
>>       },
>>   };
>>
>> +static irqreturn_t tps65217_irq_thread(int irq, void *data)
>> +{
>> +    struct tps65217 *tps = data;
>> +    unsigned int status;
>> +    bool handled = false;
>> +    int i;
>> +    int ret;
>> +
>> +    ret = tps65217_reg_read(tps, TPS65217_REG_INT, &status);
>> +    if (ret < 0) {
>> +        dev_err(tps->dev, "Failed to read IRQ status: %d\n",
>> +            ret);
>> +        return IRQ_NONE;
>> +    }
>> +
>> +    for (i = 0; i < ARRAY_SIZE(tps65217_irqs); i++) {
>> +        if (status & tps65217_irqs[i].interrupt) {
>> +            handle_nested_irq(irq_find_mapping(tps->irq_domain, i));
>> +            handled = true;
>> +        }
>> +    }
>> +
>> +    if (handled)
>> +        return IRQ_HANDLED;
>> +
>> +    return IRQ_NONE;
>> +}
>> +
>> +static int tps65217_irq_map(struct irq_domain *h, unsigned int virq,
>> +            irq_hw_number_t hw)
>> +{
>> +    struct tps65217 *tps = h->host_data;
>> +
>> +    irq_set_chip_data(virq, tps);
>> +    irq_set_chip_and_handler(virq, &tps65217_irq_chip, handle_edge_irq);
>> +    irq_set_nested_thread(virq, 1);
>> +    irq_set_noprobe(virq);
>
> irq_set_parent()?

Yes, it is missing. Thanks for spotting it.

Will add that.

>
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct irq_domain_ops tps65217_irq_domain_ops = {
>> +    .map = tps65217_irq_map,
>> +};
>> +
>> +static int tps65217_irq_init(struct tps65217 *tps, int irq)
>> +{
>> +    int ret;
>> +
>> +    mutex_init(&tps->irq_lock);
>> +
>> +    /* Mask all interrupt sources */
>> +    tps->irq_mask = (TPS65217_INT_RESERVEDM | TPS65217_INT_PBM
>> +            | TPS65217_INT_ACM | TPS65217_INT_USBM);
>> +    tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
>> +            TPS65217_PROTECT_NONE);
>> +
>> +    tps->irq_domain = irq_domain_add_linear(tps->dev->of_node,
>> +        TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
>> +    if (!tps->irq_domain) {
>> +        dev_err(tps->dev, "Could not create IRQ domain\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    ret = devm_request_threaded_irq(tps->dev, irq, NULL,
>> +                    tps65217_irq_thread,
>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>
> Are there any reasons why IRQ trigger type specified here explicitly?

Not really. I have configured it that way, it worked and I forgot about
it when preparing patches. Could you give some hint here?

>
>> +                    "tps65217-irq", tps);
>> +    if (ret) {
>> +        dev_err(tps->dev, "Failed to request IRQ %d: %d\n",
>> +            irq, ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>
>
>
>

-- 
Marcin Niestroj
