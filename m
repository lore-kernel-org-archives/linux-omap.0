From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] input: touchscreen: pixcir_i2c_ts: Add support for
 optional wakeup interrupt
Date: Mon, 20 Jul 2015 10:18:33 +0530
Message-ID: <55AC7DA1.9050002@ti.com>
References: <1437115241-17859-1-git-send-email-vigneshr@ti.com> <1437115241-17859-2-git-send-email-vigneshr@ti.com> <20150717215122.GC39282@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150717215122.GC39282@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "Quadros, Roger" <rogerq@ti.com>, Henrik Rydberg <rydberg@bitmath.org>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

On 7/18/2015 3:21 AM, Dmitry Torokhov wrote:
> Hi Vignesh,
> 
> On Fri, Jul 17, 2015 at 12:10:40PM +0530, Vignesh R wrote:
>> On am437x-gp-evm, pixcir touchscreen can wake the system from low power
>> state by generating wake-up interrupt via pinctrl and IO daisy chain.
>> Add support for optional wakeup interrupt source by regsitering to
>> automated wake IRQ framework introduced by commit 4990d4fe327b ("PM /
>> Wakeirq: Add automated device wake IRQ handling").
>> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
>> support for optional wake-up")
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/input/touchscreen/pixcir_i2c_ts.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> index 8f3e243a62bf..f7c602027fbd 100644
>> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
>> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> @@ -29,6 +29,8 @@
>>  #include <linux/of.h>
>>  #include <linux/of_gpio.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/pm_wakeirq.h>
>>  
>>  #define PIXCIR_MAX_SLOTS       5 /* Max fingers supported by driver */
>>  
>> @@ -38,6 +40,7 @@ struct pixcir_i2c_ts_data {
>>  	const struct pixcir_ts_platform_data *pdata;
>>  	bool running;
>>  	int max_fingers;	/* Max fingers supported in this instance */
>> +	int wakeirq;
>>  };
>>  
>>  struct pixcir_touch {
>> @@ -564,11 +567,22 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>>  	i2c_set_clientdata(client, tsdata);
>>  	device_init_wakeup(&client->dev, 1);
>>  
>> +	/* Register wakeirq, if available */
>> +	tsdata->wakeirq = of_irq_get(dev->of_node, 1);
> 
> Can we put this in platform data and parse in pixcir_parse_dt() please?
> Also, why not of_irq_get_byname()?
>

Ok.

>> +	if (tsdata->wakeirq) {
>> +		error = dev_pm_set_dedicated_wake_irq(dev,
>> +						      tsdata->wakeirq);
>> +		if (error)
>> +			dev_dbg(dev, "unable to get wakeirq %d\n",
>> +				error);
>> +	}
> 
> Shouldn't his actually be:
> 
> 	error = tsdata->wakeirq ?
> 		dev_pm_set_dedicated_wake_irq(dev, tsdata->wakeirq) :
> 		dev_pm_set_wake_irq(dev, client->irq);
> 	if (error) {
> 		...
> 	}
> 
> and then we can get rid of enable_irq_wake()/disable_irq_wake() in
> pixcir_i2c_ts_suspend() and pixcir_i2c_ts_resume().
> 

Yes, I will do this in v2.

>> +
>>  	return 0;
>>  }
>>  
>>  static int pixcir_i2c_ts_remove(struct i2c_client *client)
>>  {
>> +	dev_pm_clear_wake_irq(&client->dev);
>>  	device_init_wakeup(&client->dev, 0);
> 
> I wonder if driver core should be responsible for clearing wake irq and
> also for clearing wakeup flag.
> 

AFAICU, wakeup flag is deleted when struct device is deleted, hence,
device_init_wakeup() call may not be required in .remove(). But,
dev_pm_clear_wake_irq() can be moved to driver core.

Regards
Vignesh
