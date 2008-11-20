From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [patch 2.6.28-rc5 4/5] twl4030 power button irq
Date: Thu, 20 Nov 2008 12:12:42 +0200
Message-ID: <20081120101242.GF8667@gandalf.research.nokia.com>
References: <200811191728.58850.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17659 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYKTKNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 05:13:10 -0500
Content-Disposition: inline
In-Reply-To: <200811191728.58850.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Wed, Nov 19, 2008 at 05:28:58PM -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Disable the TWL4030_PWRIRQ_PWRBTN symbol from the system headers;
> initialization of the power button handler still needs work, so
> an equivalent symbol is defined in its driver.
> 
> Power IRQs now properly handle trigger specs from request_irq();
> stop goofing with registers reserved to the IRQ infrastructure.
> 
> Minor cleanup:  switch several messages to pr_debug().

How about moving this to a platform_device as well and also move to
drivers/input/misc ?

This question, of course, won't prevent this patch from being applied.

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/i2c/chips/twl4030-pwrbutton.c |   50 ++++++++------------------------
>  include/linux/i2c/twl4030.h           |    2 -
>  2 files changed, 15 insertions(+), 37 deletions(-)
> 
> --- a/drivers/i2c/chips/twl4030-pwrbutton.c
> +++ b/drivers/i2c/chips/twl4030-pwrbutton.c
> @@ -29,18 +29,16 @@
>  #include <linux/interrupt.h>
>  #include <linux/i2c/twl4030.h>
>  
> -#define PWR_ISR1 0
> -#define PWR_IMR1 1
> +
>  #define PWR_PWRON_IRQ (1<<0)
>  
> -#define PWR_EDR1 5
> -#define PWR_PWRON_RISING (1<<1)
> -#define PWR_PWRON_FALLING  (1<<0)
> -#define PWR_PWRON_BOTH (PWR_PWRON_RISING | PWR_PWRON_FALLING)
> +#define STS_HW_CONDITIONS 0xf
>  
> -#define PWR_SIH_CTRL 7
>  
> -#define STS_HW_CONDITIONS 0xf
> +/* FIXME have this constant delivered to us as part of the
> + * twl4030-core setup ...
> + */
> +#define TWL4030_PWRIRQ_PWRBTN	(TWL4030_PWR_IRQ_BASE + 0)
>  
>  static struct input_dev *powerbutton_dev;
>  
> @@ -73,20 +71,19 @@ static irqreturn_t powerbutton_irq(int i
>  static int __init twl4030_pwrbutton_init(void)
>  {
>  	int err = 0;
> -	u8 value;
>  
>  	/* PWRBTN == PWRON */
> -	if (request_irq(TWL4030_PWRIRQ_PWRBTN, powerbutton_irq, 0,
> -			"PwrButton", NULL) < 0) {
> -		printk(KERN_ERR "Unable to allocate IRQ for power button\n");
> -		err = -EBUSY;
> +	err = request_irq(TWL4030_PWRIRQ_PWRBTN, powerbutton_irq,
> +			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +			"PwrButton", NULL);
> +	if (err < 0) {
> +		pr_debug("Can't get IRQ for power button: %d\n", err);
>  		goto out;
>  	}
>  
>  	powerbutton_dev = input_allocate_device();
>  	if (!powerbutton_dev) {
> -		printk(KERN_ERR
> -			"Unable to allocate input device for power button\n");
> +		pr_debug("Can't allocate power button\n");
>  		err = -ENOMEM;
>  		goto free_irq_and_out;
>  	}
> @@ -97,26 +94,7 @@ static int __init twl4030_pwrbutton_init
>  
>  	err = input_register_device(powerbutton_dev);
>  	if (err) {
> -		input_free_device(powerbutton_dev);
> -		goto free_irq_and_out;
> -	}
> -
> -	/* FIXME just pass IRQF_EDGE_FALLING | IRQF_EDGE_RISING
> -	 * to request_irq(), once MODULE_INT supports them...
> -	 */
> -	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_EDR1);
> -	if (err) {
> -		printk(KERN_WARNING "I2C error %d while reading TWL4030"
> -					" INT PWR_EDR1 register\n", err);
> -		goto free_input_dev;
> -	}
> -
> -	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> -				   value | PWR_PWRON_BOTH, PWR_EDR1);
> -
> -	if (err) {
> -		printk(KERN_WARNING "I2C error %d while writing TWL4030"
> -					" INT PWR_EDR1 register\n", err);
> +		pr_debug("Can't register power button: %d\n", err);
>  		goto free_input_dev;
>  	}
>  
> @@ -126,7 +104,7 @@ static int __init twl4030_pwrbutton_init
>  
>  
>  free_input_dev:
> -	input_unregister_device(powerbutton_dev);
> +	input_free_device(powerbutton_dev);
>  free_irq_and_out:
>  	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
>  out:
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -379,7 +379,7 @@ int twl4030_sih_setup(int module);
>  /* #define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4) */
>  /* #define TWL4030_MODIRQ_PWR		(TWL4030_IRQ_BASE + 5) */
>  
> -#define TWL4030_PWRIRQ_PWRBTN		(TWL4030_PWR_IRQ_BASE + 0)
> +/* #define TWL4030_PWRIRQ_PWRBTN		(TWL4030_PWR_IRQ_BASE + 0) */
>  /* #define TWL4030_PWRIRQ_CHG_PRES		(TWL4030_PWR_IRQ_BASE + 1) */
>  /* #define TWL4030_PWRIRQ_USB_PRES		(TWL4030_PWR_IRQ_BASE + 2) */
>  /* #define TWL4030_PWRIRQ_RTC		(TWL4030_PWR_IRQ_BASE + 3) */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
