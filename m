From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH V2 4/5] drivers/rtc/rtc-ds1307.c: Support optional wakeup
 interrupt source
Date: Wed, 24 Jun 2015 18:36:39 +0300
Message-ID: <558ACE87.6040509@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com> <1435076114-12416-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435076114-12416-5-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 06/23/2015 07:15 PM, Nishanth Menon wrote:
> With the recent pinctrl-single changes, SoCs such as Texas
> Instrument's OMAP processors can treat wake-up events from deeper idle
> states as interrupts.
>
> Let's add support for the optional second interrupt for wake-up using
> the generic wakeirq support added in commit 4990d4fe327b ("PM /
> Wakeirq: Add automated device wake IRQ handling")
>
> Finally, to pass the wake-up interrupt in the dts file,
> interrupts-extended property needs to be passed.
>
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> support for optional wake-up") + ee83bd3b6483 ("serial: omap: Switch
> wake-up interrupt to generic wakeirq")
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> 	- dropped the need for specific suspend-resume handlers generic api
> 	  has adequate hooks for those
> 	- little more code flow cleanups.
>
> V1: https://patchwork.kernel.org/patch/4759171/
>
>   drivers/rtc/rtc-ds1307.c |   41 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index b03880fc32b5..b00d97dbf955 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -15,6 +15,9 @@
>   #include <linux/i2c.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_wakeirq.h>
>   #include <linux/rtc/ds1307.h>
>   #include <linux/rtc.h>
>   #include <linux/slab.h>
> @@ -114,6 +117,7 @@ struct ds1307 {
>   #define HAS_ALARM	1		/* bit 1 == irq claimed */
>   	struct i2c_client	*client;
>   	struct rtc_device	*rtc;
> +	int			wakeirq;
>   	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
>   			       u8 length, u8 *values);
>   	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
> @@ -1156,6 +1160,8 @@ read_rtc:
>   	}
>
>   	if (want_irq) {
> +		struct device_node *node = client->dev.of_node;
> +
>   		err = devm_request_threaded_irq(&client->dev,
>   						client->irq, NULL, irq_handler,
>   						IRQF_SHARED | IRQF_ONESHOT,
> @@ -1163,13 +1169,36 @@ read_rtc:
>   		if (err) {
>   			client->irq = 0;
>   			dev_err(&client->dev, "unable to request IRQ!\n");
> -		} else {
> +			goto no_irq;
> +		}
> +
> +		set_bit(HAS_ALARM, &ds1307->flags);
> +		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
>
> -			set_bit(HAS_ALARM, &ds1307->flags);
> -			dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
> +		/* Currently supported by OF code only! */
> +		if (!node)
> +			goto no_irq;
> +
> +		ds1307->wakeirq = of_irq_get(node, 1);
> +		if (ds1307->wakeirq <= 0) {
> +			if (ds1307->wakeirq == -EPROBE_DEFER) {
> +				err = ds1307->wakeirq;
> +				goto exit;
> +			}
> +			ds1307->wakeirq = 0;
> +			goto no_irq;
> +		}

Might be above code could be done a little bit simpler?

		err = of_irq_get(node, 1);
		if (err <= 0) {
			if (err == -EPROBE_DEFER)
				goto exit;
			goto no_irq;
		}
		ds1307->wakeirq = err;

> +
> +		err = dev_pm_set_dedicated_wake_irq(&client->dev,
> +						    ds1307->wakeirq);
> +		if (err) {
> +			dev_err(&client->dev, "unable to setup wakeIRQ %d\n",
> +				err);
> +			goto exit;
>   		}
>   	}
>
> +no_irq:
>   	if (chip->nvram_size) {
>
>   		ds1307->nvram = devm_kzalloc(&client->dev,
> @@ -1206,6 +1235,9 @@ read_rtc:
>   	return 0;
>
>   exit:
> +	if (ds1307->wakeirq)
> +		dev_pm_clear_wake_irq(&client->dev);
> +
>   	return err;
>   }
>
> @@ -1213,6 +1245,9 @@ static int ds1307_remove(struct i2c_client *client)
>   {
>   	struct ds1307 *ds1307 = i2c_get_clientdata(client);
>
> +	if (ds1307->wakeirq)
> +		dev_pm_clear_wake_irq(&client->dev);
> +
>   	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
>   		sysfs_remove_bin_file(&client->dev.kobj, ds1307->nvram);
>
>


-- 
regards,
-grygorii
