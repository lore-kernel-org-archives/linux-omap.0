From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: leds-gpio broken with current git?
Date: Wed, 25 Feb 2009 09:45:25 -0600
Message-ID: <E68A8093-E247-4EA8-86D9-EE83DE35F644@beagleboard.org>
References: <7088542D-28A0-4BCA-9583-6BCDDF9E960A@student.utwente.nl> <8F7AF80515AF0D4D93307E594F3CB40E210F49EC@dlee03.ent.ti.com> <200902231304.22137.david-b@pacbell.net> <200902231408.14387.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:54916 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbZBYPpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 10:45:31 -0500
Received: by rv-out-0506.google.com with SMTP id g37so73255rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 07:45:29 -0800 (PST)
In-Reply-To: <200902231408.14387.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jason Kridner <jdk@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Diego Dompe <diego.dompe@ridgerun.com>


On Feb 23, 2009, at 4:08 PM, David Brownell wrote:

> On Monday 23 February 2009, David Brownell wrote:
>>
>>> Perhaps something broke with Tony's RC1 merge?
>>> The LEDs are broken for me as well.
>>
>> Still works for me.  Did you maybe not enable the twl4030
>> GPIO support in Kconfig?
>
> Oh, and if you did *not*, please give this patch a try.
> I've been meaning to test it.

Thanks, the patch works.  Not enabling the TWL4030 GPIO was the issue  
and this patch provides a good method of not having all the GPIOs fail  
due to the failure of just one.  Diego assisted in the test, as I had  
first taken the approach of removing the failing GPIO.

>
>
> - Dave
>
>
> ==============
> Sometimes it's awkward to make sure that the array in the
> platform_data handed to the leds-gpio driver has only valid
> data ... some leds may not be always available, and coping
> with that currently requires patching or rebuilding the array.
>
> This patch fixes that by making it be OK to pass an invalid
> GPIO (such as "-EINVAL") ... such table entries are skipped.
>
> ---
> drivers/leds/leds-gpio.c |   12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -90,13 +90,19 @@ static int gpio_led_probe(struct platfor
> 		cur_led = &pdata->leds[i];
> 		led_dat = &leds_data[i];
>
> +		/* skip leds that aren't available */
> +		led_dat->gpio = cur_led->gpio;
> +		if (!gpio_is_valid(led_dat->gpio)) {
> +			dev_dbg(&pdev->dev, "skipping %s\n", cur_led->name);
> +			continue;
> +		}
> +
> 		ret = gpio_request(cur_led->gpio, cur_led->name);
> 		if (ret < 0)
> 			goto err;
>
> 		led_dat->cdev.name = cur_led->name;
> 		led_dat->cdev.default_trigger = cur_led->default_trigger;
> -		led_dat->gpio = cur_led->gpio;
> 		led_dat->can_sleep = gpio_cansleep(cur_led->gpio);
> 		led_dat->active_low = cur_led->active_low;
> 		if (pdata->gpio_blink_set) {
> @@ -125,6 +131,8 @@ static int gpio_led_probe(struct platfor
> err:
> 	if (i > 0) {
> 		for (i = i - 1; i >= 0; i--) {
> +			if (!gpio_is_valid(leds_data[i].gpio))
> +				continue;
> 			led_classdev_unregister(&leds_data[i].cdev);
> 			cancel_work_sync(&leds_data[i].work);
> 			gpio_free(leds_data[i].gpio);
> @@ -145,6 +153,8 @@ static int __devexit gpio_led_remove(str
> 	leds_data = platform_get_drvdata(pdev);
>
> 	for (i = 0; i < pdata->num_leds; i++) {
> +		if (!gpio_is_valid(leds_data[i].gpio))
> +			continue;
> 		led_classdev_unregister(&leds_data[i].cdev);
> 		cancel_work_sync(&leds_data[i].work);
> 		gpio_free(leds_data[i].gpio);
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

