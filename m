From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] Input: Fix lm8323 probe and module unloading
Date: Thu, 15 May 2008 11:01:06 +0300
Message-ID: <20080515080105.GC4625@kedavra.cpe.vivax.com.br>
References: <1210824079-22548-1-git-send-email-tony@atomide.com> <1210824079-22548-2-git-send-email-tony@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50545 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbYEOIAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 04:00:16 -0400
Content-Disposition: inline
In-Reply-To: <1210824079-22548-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, daniel.stone@nokia.com

On Wed, May 14, 2008 at 09:01:18PM -0700, Tony Lindgren wrote:
> Make module unloading and reloading behave:
> 
> - Driver probe could fail if input_register_device fails as
>   no error was returned from probe
> 
> - Driver interrupt was using unused platform_data field,
>   change to use i2c platform data interrupt instead
> 
> - Free resources on unloading module
> 
> - Mark platform data as __init_or_module
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-n800.c |    2 +-
>  drivers/input/keyboard/lm8323.c  |   18 +++++++++++++-----
>  include/linux/i2c/lm8323.h       |    2 --
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> index efcb25d..ae85c2c 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c
> @@ -642,7 +642,7 @@ static struct i2c_board_info __initdata n800_i2c_board_info_1[] = {
>  
>  extern struct tcm825x_platform_data n800_tcm825x_platform_data;
>  
> -static struct i2c_board_info __initdata n800_i2c_board_info_2[] = {
> +static struct i2c_board_info __initdata_or_module n800_i2c_board_info_2[] = {
>  #if defined (CONFIG_VIDEO_TCM825X) || defined (CONFIG_VIDEO_TCM825X_MODULE)
>  	{
>  		I2C_BOARD_INFO(TCM825X_NAME, TCM825X_I2C_ADDR),
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index e793ae7..d472da0 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -755,13 +755,11 @@ static int lm8323_probe(struct i2c_client *client,
>  	if (init_pwm(lm, 3, &client->dev, lm8323_pdata->pwm3_name) < 0)
>  		goto fail5;
>  
> -	lm->irq = lm8323_pdata->irq_gpio;
> -	debug(&c->dev, "IRQ: %d\n", lm->irq);
> -
> +	lm->irq = client->irq;
>  	mutex_init(&lm->lock);
>  	INIT_WORK(&lm->work, lm8323_work);
>  
> -	err = request_irq(client->irq, lm8323_irq,
> +	err = request_irq(lm->irq, lm8323_irq,

instead, you could just remove lm->irq field from structure and keep
using client->irq.

>  			  IRQF_TRIGGER_FALLING | IRQF_DISABLED |
>  			  IRQF_SAMPLE_RANDOM, DRIVER_NAME, lm);
>  	if (err) {
> @@ -802,7 +800,8 @@ static int lm8323_probe(struct i2c_client *client,
>  		set_bit(EV_REP, idev->evbit);
>  
>  	lm->idev = idev;
> -	if (input_register_device(idev)) {
> +	err = input_register_device(idev);
> +	if (err) {
>  		dev_dbg(&client->dev, "error registering input device\n");
>  		goto fail8;
>  	}
> @@ -833,7 +832,16 @@ static int lm8323_remove(struct i2c_client *client)
>  	struct lm8323_chip *lm = i2c_get_clientdata(client);
>  
>  	free_irq(lm->irq, lm);
> +	cancel_work_sync(&lm->work);
> +	input_unregister_device(lm->idev);
>  	device_remove_file(&lm->client->dev, &dev_attr_disable_kp);
> +	if (lm->pwm3.enabled)
> +		led_classdev_unregister(&lm->pwm3.cdev);
> +	if (lm->pwm2.enabled)
> +		led_classdev_unregister(&lm->pwm2.cdev);
> +	if (lm->pwm1.enabled)
> +		led_classdev_unregister(&lm->pwm1.cdev);
> +	kfree(lm);
>  
>  	return 0;
>  }
> diff --git a/include/linux/i2c/lm8323.h b/include/linux/i2c/lm8323.h
> index 5cb09ab..17d6b33 100644
> --- a/include/linux/i2c/lm8323.h
> +++ b/include/linux/i2c/lm8323.h
> @@ -17,8 +17,6 @@
>  #define LM8323_KEYMAP_SIZE (0x7f + 1)
>  
>  struct lm8323_platform_data {
> -	u16 irq_gpio;
> -
>  	int debounce_time; /* Time to watch for key bouncing, in ms. */
>  	int active_time; /* Idle time until sleep, in ms. */
>  
> -- 
> 1.5.3.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
