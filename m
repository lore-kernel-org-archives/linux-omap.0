From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 3/3] Input: ti_am335x_tsc - Prevent system suspend when
 TSC is in use
Date: Tue, 17 Apr 2018 13:49:55 +0530
Message-ID: <9a306d64-1ffd-d311-5660-aaab3a89e26d@ti.com>
References: <20180414095153.32060-1-vigneshr@ti.com>
 <20180414095153.32060-4-vigneshr@ti.com> <20180416180148.GD77055@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416180148.GD77055@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On Monday 16 April 2018 11:31 PM, Dmitry Torokhov wrote:
> On Sat, Apr 14, 2018 at 03:21:53PM +0530, Vignesh R wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>> 
>> Prevent system suspend while user has finger on touch screen,
>> because TSC is wakeup source and suspending device while in use will
>> result in failure to disable the module.
>> This patch uses pm_stay_awake() and pm_relax() APIs to prevent and
>> resume system suspend as required.
> 
> This looks like common behavior for all touchscreens and many other
> input devices, but other systems seem to cope without having to add
> pm_stay_awake() and pm_relax(). I wonder why your system requires it and
> whether we can generalize this somehow.
> 

Not sure if other touch drivers with IP level wakeup, have been tested
in the same way as above scenario. But, if user has finger on
touchscreen, its better not to enter suspend until user stops
interacting with wakeup source.
I see pm_stay_awake()/pm_relax() pair as the only way to stop system
suspend when wakeup source is active. Also, one other touchscreen
driver(zforce_ts.c) and gpio_keys.c use pm_stay_awake()/pm_relax() pair.


Regards
Vignesh
>> 
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>> 
>> v2: No changes.
>> 
>>  drivers/input/touchscreen/ti_am335x_tsc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
>> index dcd9db768169..43b22e071842 100644
>> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
>> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>> @@ -275,6 +275,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>>        if (status & IRQENB_HW_PEN) {
>>                ts_dev->pen_down = true;
>>                irqclr |= IRQENB_HW_PEN;
>> +             pm_stay_awake(ts_dev->mfd_tscadc->dev);
>>        }
>>  
>>        if (status & IRQENB_PENUP) {
>> @@ -284,6 +285,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>>                        input_report_key(input_dev, BTN_TOUCH, 0);
>>                        input_report_abs(input_dev, ABS_PRESSURE, 0);
>>                        input_sync(input_dev);
>> +                     pm_relax(ts_dev->mfd_tscadc->dev);
>>                } else {
>>                        ts_dev->pen_down = true;
>>                }
>> @@ -524,6 +526,7 @@ static int __maybe_unused titsc_resume(struct device *dev)
>>                titsc_writel(ts_dev, REG_IRQWAKEUP,
>>                                0x00);
>>                titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
>> +             pm_relax(ts_dev->mfd_tscadc->dev);
>>        }
>>        titsc_step_config(ts_dev);
>>        titsc_writel(ts_dev, REG_FIFO0THR,
>> -- 
>> 2.17.0
>> 
> 
> Thanks.
> 
> -- 
> Dmitry
