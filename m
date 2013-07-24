From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 4/4] mfd: twl6030-irq: Add interrupt mapping table for
 the twl6032
Date: Wed, 24 Jul 2013 16:39:18 +0300
Message-ID: <51EFD906.20501@ti.com>
References: <1374595624-15054-1-git-send-email-grygorii.strashko@ti.com> <1374595624-15054-5-git-send-email-grygorii.strashko@ti.com> <20130724115212.GJ26801@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130724115212.GJ26801@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-kernel@vger.kernel.org, Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
List-Id: linux-omap@vger.kernel.org

On 07/24/2013 02:52 PM, Lee Jones wrote:
> On Tue, 23 Jul 2013, Grygorii Strashko wrote:
>
>> From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
>>
>> This patch adds interrupt mapping table for the twl6032.
>
> Repeating the $SUBJECT line is never helpful.
>
>> Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/mfd/twl6030-irq.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
>> index 89f130b..e4df87f 100644
>> --- a/drivers/mfd/twl6030-irq.c
>> +++ b/drivers/mfd/twl6030-irq.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/suspend.h>
>>   #include <linux/of.h>
>>   #include <linux/irqdomain.h>
>> +#include <linux/of_device.h>
>>
>>   #include "twl-core.h"
>>
>> @@ -84,6 +85,36 @@ static int twl6030_interrupt_mapping[24] = {
>>   	CHARGERFAULT_INTR_OFFSET,	/* Bit 22	INT_CHRG	*/
>>   	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
>>   };
>> +
>> +static int twl6032_interrupt_mapping[24] = {
>> +	PWR_INTR_OFFSET,	/* Bit 0	PWRON			*/
>> +	PWR_INTR_OFFSET,	/* Bit 1	RPWRON			*/
>> +	PWR_INTR_OFFSET,	/* Bit 2	SYS_VLOW		*/
>> +	RTC_INTR_OFFSET,	/* Bit 3	RTC_ALARM		*/
>> +	RTC_INTR_OFFSET,	/* Bit 4	RTC_PERIOD		*/
>> +	HOTDIE_INTR_OFFSET,	/* Bit 5	HOT_DIE			*/
>> +	SMPSLDO_INTR_OFFSET,	/* Bit 6	VXXX_SHORT		*/
>> +	PWR_INTR_OFFSET,	/* Bit 7	SPDURATION		*/
>> +
>> +	PWR_INTR_OFFSET,	/* Bit 8	WATCHDOG		*/
>> +	BATDETECT_INTR_OFFSET,	/* Bit 9	BAT			*/
>> +	SIMDETECT_INTR_OFFSET,	/* Bit 10	SIM			*/
>> +	MMCDETECT_INTR_OFFSET,	/* Bit 11	MMC			*/
>> +	MADC_INTR_OFFSET,	/* Bit 12	GPADC_RT_EOC		*/
>> +	MADC_INTR_OFFSET,	/* Bit 13	GPADC_SW_EOC		*/
>> +	GASGAUGE_INTR_OFFSET,	/* Bit 14	CC_EOC			*/
>> +	GASGAUGE_INTR_OFFSET,	/* Bit 15	CC_AUTOCAL		*/
>> +
>> +	USBOTG_INTR_OFFSET,	/* Bit 16	ID_WKUP			*/
>> +	USBOTG_INTR_OFFSET,	/* Bit 17	VBUS_WKUP		*/
>> +	USBOTG_INTR_OFFSET,	/* Bit 18	ID			*/
>> +	USB_PRES_INTR_OFFSET,	/* Bit 19	VBUS			*/
>> +	CHARGER_INTR_OFFSET,	/* Bit 20	CHRG_CTRL		*/
>> +	CHARGERFAULT_INTR_OFFSET,	/* Bit 21	EXT_CHRG	*/
>> +	CHARGERFAULT_INTR_OFFSET,	/* Bit 22	INT_CHRG	*/
>
> OCD failure. ;)
>
> NB: Kidding, you don't have to do anything about this.
>
>> +	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
>> +};
>> +
>>   /*----------------------------------------------------------------------*/
>>
>>   static unsigned twl6030_irq_base;
>> @@ -91,6 +122,7 @@ static int twl_irq;
>>   static bool twl_irq_wake_enabled;
>>
>>   static atomic_t twl6030_wakeirqs = ATOMIC_INIT(0);
>> +static const int *irq_mapping_tbl;
>
> What I'd actually like to see is the creation of 'struct twl6030' to
> keep all your goodies in; irq_domain, irq_mapping_tbl etc and for you
> to pass that around instead of creating more global variables e.g. via
> request_threaded_irq(..., void *dev_id) to access the aforementioned
> information.

I can add this as the first patch in series - Is It ok?

>
>>   static int twl6030_irq_pm_notifier(struct notifier_block *notifier,
>>   				   unsigned long pm_event, void *unused)
>> @@ -164,7 +196,7 @@ static irqreturn_t twl6030_irq_thread(int irq, void *data)
>>   		if (sts.int_sts & 0x1) {
>>   			int module_irq =
>>   				irq_find_mapping(irq_domain,
>> -						 twl6030_interrupt_mapping[i]);
>> +						 irq_mapping_tbl[i]);
>>   			if (module_irq)
>>   				handle_nested_irq(module_irq);
>>   			else
>> @@ -339,6 +371,12 @@ static struct irq_domain_ops twl6030_irq_domain_ops = {
>>   	.xlate	= irq_domain_xlate_onetwocell,
>>   };
>>
>> +static const struct of_device_id twl6030_of_match[] = {
>> +	{.compatible = "ti,twl6030", &twl6030_interrupt_mapping},
>> +	{.compatible = "ti,twl6032", &twl6032_interrupt_mapping},
>> +	{ },
>> +};
>> +
>>   int twl6030_init_irq(struct device *dev, int irq_num)
>>   {
>>   	struct			device_node *node = dev->of_node;
>> @@ -346,6 +384,15 @@ int twl6030_init_irq(struct device *dev, int irq_num)
>>   	int			status;
>>   	u8			mask[3];
>>   	struct irq_domain	*irq_domain;
>> +	const struct of_device_id *of_id;
>> +
>> +	of_id = of_match_device(twl6030_of_match, dev);
>> +	if (!of_id || !of_id->data) {
>> +		dev_err(dev, "Unknown TWL device model\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	irq_mapping_tbl = of_id->data;
>>
>>   	nr_irqs = TWL6030_NR_IRQS;
>>
>

Regards,
-grygorii
