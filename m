From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 4/5] mfd: tps65217: Add power button as subdevice
Date: Mon, 11 Apr 2016 13:27:10 +0300
Message-ID: <570B7BFE.6000501@ti.com>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
 <1459789865-3704-6-git-send-email-m.niestroj@grinn-global.com>
 <20160411094452.GC8094@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160411094452.GC8094@x1>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2016 12:44 PM, Lee Jones wrote:
> On Mon, 04 Apr 2016, Marcin Niestroj wrote:
>
>> Add tps65217 power buttor subdevice with assigned IRQ resources.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>> ---
>>   drivers/mfd/tps65217.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>
> Applied, thanks.

Seems there is dependency from patch 1 :(

>
>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>> index a20980f..fd3b5d8 100644
>> --- a/drivers/mfd/tps65217.c
>> +++ b/drivers/mfd/tps65217.c
>> @@ -38,6 +38,10 @@ static struct resource charger_resources[] = {
>>   	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>>   };
>>
>> +static struct resource pb_resources[] = {
>> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
>> +};
>> +
>>   struct tps65217_irq {
>>   	int mask;
>>   	int interrupt;
>> @@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] = {
>>   		.resources = charger_resources,
>>   		.of_compatible = "ti,tps65217-charger",
>>   	},
>> +	{
>> +		.name = "tps65217-pwrbutton",
>> +		.num_resources = ARRAY_SIZE(pb_resources),
>> +		.resources = pb_resources,
>> +		.of_compatible = "ti,tps65217-pwrbutton",
>> +	},
>>   };
>>
>>   static irqreturn_t tps65217_irq_thread(int irq, void *data)
>


-- 
regards,
-grygorii
