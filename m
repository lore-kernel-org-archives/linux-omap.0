From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH V2 4/5] drivers/rtc/rtc-ds1307.c: Support optional wakeup
 interrupt source
Date: Wed, 1 Jul 2015 14:54:04 +0200
Message-ID: <20150701125404.GR485@piout.net>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
 <1435076114-12416-5-git-send-email-nm@ti.com>
 <558ACE87.6040509@ti.com>
 <558AD5B1.8030406@ti.com>
 <20150624162654.GA29259@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150624162654.GA29259@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 24/06/2015 at 11:26:54 -0500, Nishanth Menon wrote :
> I am wrong here - code just returns 0 and ignores err. So, how about
> the following patch instead: (Alexandre, please do let me know if the
> entire series needs to be reposted):

Can you resend just that one as v3? I'll take it right away. Thanks!

>  - improvement as suggested
>  - Picked up previous acks
>  - cleanup in probe does not need dev_pm_clear_wake_irq.
> -->8<---
> From 12367f8edffc25613f6f920d9bd7b69dfed57ce1 Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Mon, 22 Jun 2015 14:13:19 -0500
> Subject: [PATCH V3] drivers/rtc/rtc-ds1307.c: Support optional wakeup interrupt
>  source
> 
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
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c |   36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index b03880fc32b5..e16989c48a90 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -15,6 +15,9 @@
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/rtc/ds1307.h>
>  #include <linux/rtc.h>
>  #include <linux/slab.h>
> @@ -114,6 +117,7 @@ struct ds1307 {
>  #define HAS_ALARM	1		/* bit 1 == irq claimed */
>  	struct i2c_client	*client;
>  	struct rtc_device	*rtc;
> +	int			wakeirq;
>  	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
>  			       u8 length, u8 *values);
>  	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
> @@ -1156,6 +1160,8 @@ read_rtc:
>  	}
>  
>  	if (want_irq) {
> +		struct device_node *node = client->dev.of_node;
> +
>  		err = devm_request_threaded_irq(&client->dev,
>  						client->irq, NULL, irq_handler,
>  						IRQF_SHARED | IRQF_ONESHOT,
> @@ -1163,13 +1169,34 @@ read_rtc:
>  		if (err) {
>  			client->irq = 0;
>  			dev_err(&client->dev, "unable to request IRQ!\n");
> -		} else {
> +			goto no_irq;
> +		}
>  
> -			set_bit(HAS_ALARM, &ds1307->flags);
> -			dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
> +		set_bit(HAS_ALARM, &ds1307->flags);
> +		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
> +
> +		/* Currently supported by OF code only! */
> +		if (!node)
> +			goto no_irq;
> +
> +		err = of_irq_get(node, 1);
> +		if (err <= 0) {
> +			if (err == -EPROBE_DEFER)
> +				goto exit;
> +			goto no_irq;
> +		}
> +		ds1307->wakeirq = err;
> +
> +		err = dev_pm_set_dedicated_wake_irq(&client->dev,
> +						    ds1307->wakeirq);
> +		if (err) {
> +			dev_err(&client->dev, "unable to setup wakeIRQ %d!\n",
> +				err);
> +			goto exit;
>  		}
>  	}
>  
> +no_irq:
>  	if (chip->nvram_size) {
>  
>  		ds1307->nvram = devm_kzalloc(&client->dev,
> @@ -1213,6 +1240,9 @@ static int ds1307_remove(struct i2c_client *client)
>  {
>  	struct ds1307 *ds1307 = i2c_get_clientdata(client);
>  
> +	if (ds1307->wakeirq)
> +		dev_pm_clear_wake_irq(&client->dev);
> +
>  	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
>  		sysfs_remove_bin_file(&client->dev.kobj, ds1307->nvram);
>  
> -- 
> 1.7.9.5
> 
> -- 
> Regards,
> Nishanth Menon

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
