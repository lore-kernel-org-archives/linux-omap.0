From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/3] Input: ti_am335x_tsc - Ack pending IRQs at probe
 and before suspend
Date: Tue, 17 Apr 2018 13:49:00 +0530
Message-ID: <59afa48c-df5f-1c45-70e5-a0ae0aae8cff@ti.com>
References: <20180414095153.32060-1-vigneshr@ti.com>
 <20180414095153.32060-3-vigneshr@ti.com> <20180416175909.GC77055@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416175909.GC77055@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On Monday 16 April 2018 11:29 PM, Dmitry Torokhov wrote:
> On Sat, Apr 14, 2018 at 03:21:52PM +0530, Vignesh R wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>> 
>> It is seen that just enabling the TSC module triggers a HW_PEN IRQ
>> without any interaction with touchscreen by user. This results in first
>> suspend/resume sequence to fail as system immediately wakes up from
>> suspend as soon as HW_PEN IRQ is enabled in suspend handler due to the
>> pending IRQ. Therefore clear all IRQs at probe and also in suspend
> 
> Are the interrupts configured as edge?
> 

No, its a level interrupt.

>> callback for sanity.
>> 
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> ---
>> 
>> v2: Add Acks from v1.
>> 
>>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 ++
>>  include/linux/mfd/ti_am335x_tscadc.h      | 1 +
>>  2 files changed, 3 insertions(+)
>> 
>> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
>> index 810e05c9c4f5..dcd9db768169 100644
>> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
>> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>> @@ -439,6 +439,7 @@ static int titsc_probe(struct platform_device *pdev)
>>                        dev_err(&pdev->dev, "irq wake enable failed.\n");
>>        }
>>  
>> +     titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);
>>        titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>>        titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
> 
> Out of curiosity, should this be:
> 
>         titsc_writel(ts_dev, REG_IRQENABLE,
>                         IRQENB_FIFO0THRES | IRQENB_EOS);
> 
> ?
> 
> Because 2nd titsc_writel() overwrites the first? Or separate writes to
> the same register are distinct?
> 

As per TRM, writing 0 to any bit of REG_IRQENABLE has no effect(IRQs are
cleared by writing to REG_IRQCLR). Therefore, second write does not
overwrite the first. I agree that there is nothing that prevents us from
enabling both IRQs in a single write. That can be a separate cleanup patch.

>>        err = titsc_config_wires(ts_dev);
>> @@ -504,6 +505,7 @@ static int __maybe_unused titsc_suspend(struct device *dev)
>>  
>>        tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
>>        if (device_may_wakeup(tscadc_dev->dev)) {
>> +             titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);
> 
> The comment in titsc_irq() says that we should not be touching
> IRQENB_FIFO0THRES as it is used by another driver, but here we are
> whacking it. Can you elaborate why this is safe?
> 
> You might need to rework the interrupt handling since you have several
> drivers...
> 

I guess you meant IRQENB_FIFO1THRES(FIFO0 is used for TSC and FIFO1 is
ADC). Yes, this driver must not touch FIFO1 related IRQs, I will fix
that up in next version.


>>                idle = titsc_readl(ts_dev, REG_IRQENABLE);
>>                titsc_writel(ts_dev, REG_IRQENABLE,
>>                                (idle | IRQENB_HW_PEN));
>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>> index b9a53e013bff..1a6a34f726cc 100644
>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>> @@ -63,6 +63,7 @@
>>  #define IRQENB_FIFO1OVRRUN   BIT(6)
>>  #define IRQENB_FIFO1UNDRFLW  BIT(7)
>>  #define IRQENB_PENUP         BIT(9)
>> +#define IRQENB_MASK          (0x7FF)
>>  
>>  /* Step Configuration */
>>  #define STEPCONFIG_MODE_MASK (3 << 0)
>> -- 
>> 2.17.0
>> 
> 
> Thanks.
> 
> -- 
> Dmitry

-- 
Regards
Vignesh
