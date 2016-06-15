From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH v2 4/5] mfd: tps65217: Add power button as subdevice
Date: Wed, 15 Jun 2016 16:51:43 +0200
Message-ID: <61c57049-04e3-434c-6293-58a9297c73c9@grinn-global.com>
References: <20160614132927.3309-1-m.niestroj@grinn-global.com>
 <20160614132927.3309-5-m.niestroj@grinn-global.com>
 <20160615141242.GK4948@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160615141242.GK4948@dell>
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 15.06.2016 16:12, Lee Jones wrote:
> On Tue, 14 Jun 2016, Marcin Niestroj wrote:
>
>> Add tps65217 power buttor subdevice with assigned IRQ resources.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>> ---
>> depends on patch 1 in series
>>
>>  drivers/mfd/tps65217.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>
> Applied, thanks.

Did you also apply patch 1? As I stated above, this patch depends on
patch 1.

>
>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>> index d49f94e..68cf431 100644
>> --- a/drivers/mfd/tps65217.c
>> +++ b/drivers/mfd/tps65217.c
>> @@ -38,6 +38,10 @@ static struct resource charger_resources[] = {
>>  	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>>  };
>>
>> +static struct resource pb_resources[] = {
>> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
>> +};
>> +
>>  struct tps65217_irq {
>>  	int mask;
>>  	int interrupt;
>> @@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] = {
>>  		.resources = charger_resources,
>>  		.of_compatible = "ti,tps65217-charger",
>>  	},
>> +	{
>> +		.name = "tps65217-pwrbutton",
>> +		.num_resources = ARRAY_SIZE(pb_resources),
>> +		.resources = pb_resources,
>> +		.of_compatible = "ti,tps65217-pwrbutton",
>> +	},
>>  };
>>
>>  static irqreturn_t tps65217_irq_thread(int irq, void *data)
>

-- 
Marcin Niestroj
