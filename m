From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: drivers/rtc/rtc-ds1307.c: Support optional wakeup interrupt
 source
Date: Thu, 28 May 2015 15:06:05 +0200
Message-ID: <20150528130605.GQ2185@piout.net>
References: <1408637521-6764-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408637521-6764-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

Do you mind rebasing that one so I can apply it?

On 21/08/2014 at 11:12:01 -0500, Nishanth Menon wrote :
> With the recent pinctrl-single changes, SoCs such as Texas
> Instrument's OMAP processors can treat wake-up events from deeper idle
> states as interrupts.
> 
> Let's add support for the optional second interrupt for wake-up
> events. And then SoC can wakeup and handle the event using it's
> regular handler.
> 
> Finally, to pass the wake-up interrupt in the dts file,
> interrupts-extended property needs to be passed.
> 
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> support for optional wake-up")
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index f03d5ba..5feedfc 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -15,6 +15,8 @@
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/string.h>
>  #include <linux/rtc.h>
>  #include <linux/bcd.h>
> @@ -115,6 +117,7 @@ struct ds1307 {
>  	struct i2c_client	*client;
>  	struct rtc_device	*rtc;
>  	struct work_struct	work;
> +	int			wakeirq;
>  	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
>  			       u8 length, u8 *values);
>  	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
> @@ -835,6 +838,34 @@ ds1307_nvram_write(struct file *filp, struct kobject *kobj,
>  
>  /*----------------------------------------------------------------------*/
>  
> +static int ds1307_i2c_suspend(struct i2c_client *client,  pm_message_t mesg)
> +{
> +	struct ds1307 *ds1307 = i2c_get_clientdata(client);
> +	struct device *dev = &client->dev;
> +
> +	if (!ds1307->wakeirq)
> +		return 0;
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq(ds1307->wakeirq);
> +
> +	return 0;
> +}
> +
> +static int ds1307_i2c_resume(struct i2c_client *client)
> +{
> +	struct ds1307 *ds1307 = i2c_get_clientdata(client);
> +	struct device *dev = &client->dev;
> +
> +	if (!ds1307->wakeirq)
> +		return 0;
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_nosync(ds1307->wakeirq);
> +
> +	return 0;
> +}
> +
>  static int ds1307_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -1116,6 +1147,8 @@ read_rtc:
>  	}
>  
>  	if (want_irq) {
> +		struct device_node *node = client->dev.of_node;
> +
>  		err = request_irq(client->irq, ds1307_irq, IRQF_SHARED,
>  			  ds1307->rtc->name, client);
>  		if (err) {
> @@ -1125,6 +1158,28 @@ read_rtc:
>  
>  			set_bit(HAS_ALARM, &ds1307->flags);
>  			dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
> +			if (node)
> +				ds1307->wakeirq = irq_of_parse_and_map(node, 1);
> +
> +			if (ds1307->wakeirq <= 0)
> +				ds1307->wakeirq = 0;
> +			else
> +				err = devm_request_irq(&client->dev,
> +						       ds1307->wakeirq,
> +						       ds1307_irq,
> +						       IRQF_ONESHOT,
> +						       ds1307->rtc->name,
> +						       client);
> +			if (err) {
> +				dev_err(&client->dev, "unable to get wakeIRQ %d\n",
> +					err);
> +				free_irq(client->irq, client);
> +				goto exit;
> +			}
> +
> +			/* We enable the interrupt only during suspend path */
> +			if (ds1307->wakeirq)
> +				disable_irq_nosync(ds1307->wakeirq);
>  		}
>  	}
>  
> @@ -1189,6 +1244,8 @@ static struct i2c_driver ds1307_driver = {
>  	},
>  	.probe		= ds1307_probe,
>  	.remove		= ds1307_remove,
> +	.suspend	= ds1307_i2c_suspend,
> +	.resume		= ds1307_i2c_resume,
>  	.id_table	= ds1307_id,
>  };
>  

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
