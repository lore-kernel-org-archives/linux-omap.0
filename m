From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] The fix prevents kernel crash caused by twl4030 power
	button malfunction.
Date: Mon, 23 Jun 2008 13:43:36 +0300
Message-ID: <20080623104335.GI7741@atomide.com>
References: <1213710486-19986-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.179] ([63.208.196.179]:58248 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753780AbYFWKnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 06:43:10 -0400
Content-Disposition: inline
In-Reply-To: <1213710486-19986-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org

* Roman Tereshonkov <roman.tereshonkov@nokia.com> [080617 16:49]:
> If i2c connection is broken the twl4030 power button driver is unregistered.
> The function input_free_device has to be called only when
> input_register_device failed. Otherwise input_unregister_device is used.

Pushing today.

Tony

> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-pwrbutton.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/i2c/chips/twl4030-pwrbutton.c
> index cbc31aa..a8258df 100644
> --- a/drivers/i2c/chips/twl4030-pwrbutton.c
> +++ b/drivers/i2c/chips/twl4030-pwrbutton.c
> @@ -95,8 +95,10 @@ static int __init twl4030_pwrbutton_init(void)
>  	powerbutton_dev->name = "triton2-pwrbutton";
>  
>  	err = input_register_device(powerbutton_dev);
> -	if (err)
> -		goto free_input_dev;
> +	if (err) {
> +		input_free_device(powerbutton_dev);
> +		goto free_irq_and_out;
> +	}
>  
>  	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_IMR1);
>  	if (err) {
> @@ -122,7 +124,7 @@ static int __init twl4030_pwrbutton_init(void)
>  	}
>  
>  	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> -				   value | PWR_PWRON_BOTH , PWR_EDR1);
> +				   value | PWR_PWRON_BOTH, PWR_EDR1);
>  
>  	if (err) {
>  		printk(KERN_WARNING "I2C error %d while writing TWL4030"
> @@ -136,7 +138,7 @@ static int __init twl4030_pwrbutton_init(void)
>  
>  
>  free_input_dev:
> -	input_free_device(powerbutton_dev);
> +	input_unregister_device(powerbutton_dev);
>  free_irq_and_out:
>  	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
>  out:
> -- 
> 1.5.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
