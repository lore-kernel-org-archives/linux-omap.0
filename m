From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/2] input: touchscreen: pixcir_i2c_ts: Add support
 for optional wakeup interrupt
Date: Tue, 28 Jul 2015 12:04:16 +0300
Message-ID: <55B74590.4090506@ti.com>
References: <1437663246-16049-1-git-send-email-vigneshr@ti.com> <1437663246-16049-2-git-send-email-vigneshr@ti.com> <55B60CA1.3090800@ti.com> <55B613BA.3070402@ti.com> <20150727212042.GD5144@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150727212042.GD5144@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vignesh R <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Henrik Rydberg <rydberg@bitmath.org>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 28/07/15 00:20, Dmitry Torokhov wrote:
> On Mon, Jul 27, 2015 at 04:49:22PM +0530, Vignesh R wrote:
>>
>>
>> On 07/27/2015 04:19 PM, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 23/07/15 17:54, Vignesh R wrote:
>>>> On am437x-gp-evm, pixcir touchscreen can wake the system from low power
>>>> state by generating wake-up interrupt via pinctrl and IO daisy chain.
>>>> Add support for optional wakeup interrupt source by regsitering to
>>>> automated wake IRQ framework introduced by commit 4990d4fe327b ("PM /
>>>> Wakeirq: Add automated device wake IRQ handling").
>>>> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
>>>> support for optional wake-up")
>>>>
>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>>> ---
>>>>
>>>> v3:
>>>>  * handle error code returned by of_irq_get_byname()
>>>>
>>>> v2:
>>>>  * use of_irq_get_byname()
>>>>  * remove enable/disable_wake_irq()
>>>>
>>>>  drivers/input/touchscreen/pixcir_i2c_ts.c | 22 ++++++++++++++++++----
>>>>  include/linux/input/pixcir_ts.h           |  1 +
>>>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
>>>> index 8f3e243a62bf..3a4ab358bf52 100644
>>>> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
>>>> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
>>>> @@ -29,6 +29,8 @@
>>>>  #include <linux/of.h>
>>>>  #include <linux/of_gpio.h>
>>>>  #include <linux/of_device.h>
>>>> +#include <linux/of_irq.h>
>>>> +#include <linux/pm_wakeirq.h>
>>>>  
>>>>  #define PIXCIR_MAX_SLOTS       5 /* Max fingers supported by driver */
>>>>  
>>>> @@ -364,8 +366,6 @@ static int __maybe_unused pixcir_i2c_ts_suspend(struct device *dev)
>>>>  				goto unlock;
>>>>  			}
>>>>  		}
>>>> -
>>>> -		enable_irq_wake(client->irq);
>>>>  	} else if (input->users) {
>>>>  		ret = pixcir_stop(ts);
>>>>  	}
>>>> @@ -386,8 +386,6 @@ static int __maybe_unused pixcir_i2c_ts_resume(struct device *dev)
>>>>  	mutex_lock(&input->mutex);
>>>>  
>>>>  	if (device_may_wakeup(&client->dev)) {
>>>> -		disable_irq_wake(client->irq);
>>>> -
>>>>  		if (!input->users) {
>>>>  			ret = pixcir_stop(ts);
>>>>  			if (ret) {
>>>> @@ -445,6 +443,13 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
>>>>  	dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
>>>>  		pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
>>>>  
>>>> +	pdata->wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
>>>> +	if (pdata->wakeirq < 0 && pdata->wakeirq != -ENODATA &&
>>>> +	    pdata->wakeirq != -EINVAL) {
>>>> +		dev_err(dev, "Failed to get wakeirq\n");
>>>> +		return ERR_PTR(pdata->wakeirq);
>>>> +	}
>>>> +
>>>>  	return pdata;
>>>>  }
>>>>  #else
>>>> @@ -564,11 +569,20 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>>>>  	i2c_set_clientdata(client, tsdata);
>>>>  	device_init_wakeup(&client->dev, 1);
>>>>  
>>>> +	/* Register wakeirq */
>>>> +	error = (pdata->wakeirq > 0) ?
>>>> +		dev_pm_set_dedicated_wake_irq(dev, pdata->wakeirq) :
>>>> +		dev_pm_set_wake_irq(dev, client->irq);
>>>
>>> Can 0 be a valid wakeirq or client->irq?
>>> If yes then this logic is broken.
>>>
>>
>> AFAIK, IRQ 0 is always assigned to system timer interrupt (cannot find
>> reliable source to quote).
>>
>>> I would set wakeirq to -EINVAL or something if it is not available
>>> during probe and check for that condition.
>>>
>>
>> Not sure, if I understand you correctly
>> pdata->wakeirq will have -ENODATA or -EINVAL(as returned by
>> of_irq_get_byname()), if wakeirq is not available. Do you want me to
>> check for these two conditions specifically rather than
>> (pdata->wakeirq > 0) ?
> 
> 0 is not really valid general IRQ number; I2C for example sets
> client->irq to 0 when there is no IRQ.

OK. If we assume 0 is invalid IRQ, then the patch is fine.

cheers,
-roger
