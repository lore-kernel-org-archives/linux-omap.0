From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 47/50] staging: omap-thermal: switch mutex to spinlock
 inside omap-bandgap
Date: Sat, 16 Mar 2013 08:41:30 -0400
Message-ID: <5144687A.7030007@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com> <1363352438-15935-48-git-send-email-eduardo.valentin@ti.com> <20130316085902.GP9138@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20130316085902.GP9138@mwanda>
Sender: linux-pm-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 16-03-2013 04:59, Dan Carpenter wrote:
> On Fri, Mar 15, 2013 at 09:00:35AM -0400, Eduardo Valentin wrote:
>> Because there is a need to lock inside IRQ handler, this patch
>> changes the locking mechanism inside the omap-bandgap.[c,h] to
>> spinlocks. Now this lock is used to protect omap_bandgap struct
>> during APIs exposed (possibly used in sysfs handling functions)
>> and inside the ALERT IRQ handler.
>>
>> Because there are registers shared among the sensors, this lock
>> is global, not per sensor.
>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>   drivers/staging/omap-thermal/TODO           |    1 -
>>   drivers/staging/omap-thermal/omap-bandgap.c |   18 ++++++++++--------
>>   drivers/staging/omap-thermal/omap-bandgap.h |    4 ++--
>>   3 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/staging/omap-thermal/TODO b/drivers/staging/omap-thermal/TODO
>> index 77b761b..0f24e9b 100644
>> --- a/drivers/staging/omap-thermal/TODO
>> +++ b/drivers/staging/omap-thermal/TODO
>> @@ -1,7 +1,6 @@
>>   List of TODOs (by Eduardo Valentin)
>>
>>   on omap-bandgap.c:
>> -- Rework locking
>>   - Improve driver code by adding usage of regmap-mmio
>>   - Test every exposed API to userland
>>   - Add support to hwmon
>> diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
>> index 4b631fd..846ced6 100644
>> --- a/drivers/staging/omap-thermal/omap-bandgap.c
>> +++ b/drivers/staging/omap-thermal/omap-bandgap.c
>> @@ -33,7 +33,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/err.h>
>>   #include <linux/types.h>
>> -#include <linux/mutex.h>
>> +#include <linux/spinlock.h>
>>   #include <linux/reboot.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_platform.h>
>> @@ -170,6 +170,7 @@ static irqreturn_t omap_bandgap_talert_irq_handler(int irq, void *data)
>>   	u32 t_hot = 0, t_cold = 0, ctrl;
>>   	int i;
>>
>> +	spin_lock(&bg_ptr->lock);
>>   	for (i = 0; i < bg_ptr->conf->sensor_count; i++) {
>>   		tsr = bg_ptr->conf->sensors[i].registers;
>>   		ctrl = omap_bandgap_readl(bg_ptr, tsr->bgap_status);
>> @@ -208,6 +209,7 @@ static irqreturn_t omap_bandgap_talert_irq_handler(int irq, void *data)
>>   		if (bg_ptr->conf->report_temperature)
>>   			bg_ptr->conf->report_temperature(bg_ptr, i);
>>   	}
>> +	spin_unlock(&bg_ptr->lock);
>>
>>   	return IRQ_HANDLED;
>>   }
>> @@ -502,9 +504,9 @@ int _omap_bandgap_write_threshold(struct omap_bandgap *bg_ptr, int id, int val,
>>   	if (ret < 0)
>>   		goto exit;
>>
>> -	mutex_lock(&bg_ptr->bg_mutex);
>> +	spin_lock(&bg_ptr->lock);
>
> These need to disable interrupts because we take the spin lock in
> the IRQ handler.

This IRQ gets masked at the IRQ controller level when served (ONE_SHOT). 
Not sure if your comment is applicable in this case..

>
> regards,
> dan carpenter
>
>
>
>

