From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] leds: leds-gpio: adopt pinctrl support
Date: Fri, 31 Aug 2012 09:04:04 -0700
Message-ID: <20120831160402.GN1303@atomide.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-5-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:23157 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754172Ab2HaQER (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 12:04:17 -0400
Content-Disposition: inline
In-Reply-To: <1346405361-29711-5-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

* AnilKumar Ch <anilkumar@ti.com> [120831 02:30]:
> Adopt pinctrl support to leds-gpio driver, based on the device
> pointer (leds-gpio) pinctrl driver configure SoC pins to GPIO
> mode.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/leds/leds-gpio.c |   31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index c032b21..d98dfb9 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  struct gpio_led_data {
>  	struct led_classdev cdev;
> @@ -236,14 +237,23 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
>  {
>  	struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
>  	struct gpio_leds_priv *priv;
> -	int i, ret = 0;
> +	struct pinctrl *pinctrl;
> +	int i = 0;
> +	int ret = 0;
> +
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		return PTR_ERR(pinctrl);
> +	}

I think you need to just print out a warning here as most systems don't
have the pinctrl implemented. And some people just do static pinmuxing
in the bootloader.

Regards,

Tony
