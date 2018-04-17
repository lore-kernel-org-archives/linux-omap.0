From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/3] Input: ti_am335x_tsc - Mark IRQ as wakeup capable
Date: Tue, 17 Apr 2018 13:50:18 +0530
Message-ID: <92f270e1-e72b-9ccd-ce9f-d11120786941@ti.com>
References: <20180414095153.32060-1-vigneshr@ti.com>
 <20180414095153.32060-2-vigneshr@ti.com> <20180416174542.GB77055@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416174542.GB77055@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 16 April 2018 11:15 PM, Dmitry Torokhov wrote:
> On Sat, Apr 14, 2018 at 03:21:51PM +0530, Vignesh R wrote:
>> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
>> IRQ as wakeup capable, so that device irq is not disabled during system
>> suspend.
>> 
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>> 
>> v2: No changes
>> 
>>  drivers/input/touchscreen/ti_am335x_tsc.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
>> index f1043ae71dcc..810e05c9c4f5 100644
>> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
>> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/sort.h>
>> +#include <linux/pm_wakeirq.h>
>>  
>>  #include <linux/mfd/ti_am335x_tscadc.h>
>>  
>> @@ -432,6 +433,12 @@ static int titsc_probe(struct platform_device *pdev)
>>                goto err_free_mem;
>>        }
>>  
>> +     if (device_may_wakeup(tscadc_dev->dev)) {
>> +             err = dev_pm_set_wake_irq(tscadc_dev->dev, ts_dev->irq);
> 
> Hmm, most of the drivers simply use enable_irq_wake()/disable_irq_wake()
> in suspend/resume paths 

dev_pm_*_wake_irq() function are alternative to above

[1]:
For most drivers, we should be able to drop the following
boilerplate code from runtime_suspend and runtime_resume
functions:

	...
	device_init_wakeup(dev, true);
	...
	if (device_may_wakeup(dev))
		enable_irq_wake(irq);
	...
	if (device_may_wakeup(dev))
		disable_irq_wake(irq);
	...
	device_init_wakeup(dev, false);
	...

We can replace it with just the following init and exit
time code:

	...
	device_init_wakeup(dev, true);
	dev_pm_set_wake_irq(dev, irq);
	...
	dev_pm_clear_wake_irq(dev);
	device_init_wakeup(dev, false);

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/base/power/wakeirq.c?id=4990d4fe327b9d9a7a3be7103a82699406fdde69

I see device_may_wakeup() check is not required. Will drop that in next version.

> and use dev_pm_set_wake_irq() only for dedicated
> and distinct wake interrupts. Why do we not follow the same pattern
> here?

Thats dev_pm_*_dedicated_wake_irq()


Thanks for the review!


-- 
Regards
Vignesh
