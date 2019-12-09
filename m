From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] gpio: pca953x: Read irq trigger type from DT
Date: Mon, 9 Dec 2019 10:45:34 +0530
Message-ID: <bfaa7ed4-6acf-3941-0de6-f139eed7cf99@ti.com>
References: <20191205144508.31339-1-vigneshr@ti.com>
 <5837a37d-479d-5c33-45b5-c1b32b0cdc52@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5837a37d-479d-5c33-45b5-c1b32b0cdc52@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On 05/12/19 8:31 pm, Grygorii Strashko wrote:
> 
> 
> On 05/12/2019 16:45, Vignesh Raghavendra wrote:
[...]

>> @@ -768,10 +769,14 @@ static int pca953x_irq_setup(struct pca953x_chip
>> *chip, int irq_base)
>>       bitmap_and(chip->irq_stat, irq_stat, reg_direction,
>> chip->gpio_chip.ngpio);
>>       mutex_init(&chip->irq_lock);
>>   +    irqflags = irq_get_trigger_type(client->irq);
>> +    if (irqflags == IRQF_TRIGGER_NONE)
>> +        irqflags = IRQF_TRIGGER_LOW;
> 
> I think you can just drop IRQF_TRIGGER_LOW:
> - for paltform code it will be set from resources in
> platform_get_irq_optional()
> - for DT code it will be set in __setup_irq()
> 

Ok, will drop setting IRQF_TRIGGER_LOW in v2.

Thanks for the review!

>> +    irqflags |= IRQF_ONESHOT | IRQF_SHARED;
>> +
>>       ret = devm_request_threaded_irq(&client->dev, client->irq,
>>                       NULL, pca953x_irq_handler,
>> -                    IRQF_TRIGGER_LOW | IRQF_ONESHOT |
>> -                    IRQF_SHARED,
>> +                    irqflags,
>>                       dev_name(&client->dev), chip);
>>       if (ret) {
>>           dev_err(&client->dev, "failed to request irq %d\n",
>>
> 

-- 
Regards
Vignesh
