From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: fix the ads7846 init code
Date: Wed, 11 Jul 2012 16:00:39 -0700
Message-ID: <87sjcxhpig.fsf@ti.com>
References: <1339661781-5086-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:40702 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753201Ab2GKXAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 19:00:46 -0400
Received: by pbbrr13 with SMTP id rr13so3112408pbb.40
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 16:00:38 -0700 (PDT)
In-Reply-To: <1339661781-5086-1-git-send-email-grinberg@compulab.co.il> (Igor
	Grinberg's message of "Thu, 14 Jun 2012 11:16:21 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zumeng Chen <zumeng.chen@windriver.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Igor,

Igor Grinberg <grinberg@compulab.co.il> writes:

> In case a board provides the gpio_pendown and not board_pdata,
> the GPIO debounce is not taken care of.
> Fix this by taking care of GPIO debounce in any case.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

I just notice this this patch causing some faults in current l-o master
branch.  

> ---
>  arch/arm/mach-omap2/common-board-devices.c |   22 ++++++++++++----------
>  1 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index 1706ebc..c187586 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -63,28 +63,30 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>  	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
>  	int err;
>  
> -	if (board_pdata && board_pdata->get_pendown_state) {
> -		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> -		if (err) {
> -			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> -			return;
> -		}
> -		gpio_export(gpio_pendown, 0);
> -
> -		if (gpio_debounce)
> -			gpio_set_debounce(gpio_pendown, gpio_debounce);
> +	err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> +	if (err) {
> +		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> +		return;
>  	}
>  
> +	if (gpio_debounce)
> +		gpio_set_debounce(gpio_pendown, gpio_debounce);
> +
>  	spi_bi->bus_num	= bus_num;
>  	spi_bi->irq	= gpio_to_irq(gpio_pendown);
>  
>  	if (board_pdata) {
>  		board_pdata->gpio_pendown = gpio_pendown;
>  		spi_bi->platform_data = board_pdata;
> +		if (board_pdata->get_pendown_state)
> +			gpio_export(gpio_pendown, 0);
>  	} else {
>  		ads7846_config.gpio_pendown = gpio_pendown;
>  	}
>  
> +	if (!board_pdata || (board_pdata && !board_pdata->get_pendown_state))
> +		gpio_free(gpio_pendown);

The logic here for freeing the GPIO doesn't make any sense to me.
IIUC, the gpio_pendown is always used, so should not be freed.

Moreover, if this GPIO is freed, that allows that GPIO bank to runtime
suspend if there are no other GPIOs in use in that bank.  So the first
attempt to use the GPIO will fault.

For example, on my Overo board(s), I noticed this failing as soon as teh
ads7846 driver probes, requests the IRQ and the GPIO triggering is set.

Getting rid of this free fixes the problem.

The changelog doesn't describe why the GPIO is freed here so I'm not
sure I follow, but it seems to me that once this GPIO is requesed, it
should not be freed as long as it's used, otherwise PM faults can occur.

Kevin

>From bb87c3b5586950e480d0699504997a9ad587fd85 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 11 Jul 2012 15:47:29 -0700
Subject: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing
 pen-down GPIO

commit 97ee9f01d6 (ARM: OMAP: fix the ads7846 init code) mistakenly
frees the pen-down GPIO even though it will be used by the ads7846
driver.

Freeing a GPIO means that the GPIO bank containing that GPIO can be
runtime suspended if its the last/only GPIO being used in that bank.
If the GPIO bank is runtime suspended, any accesses to that bank will
cause faults.

Because the current code frees the GPIO, the ads7846 driver probe will
fault when it requests its IRQ line.  Because the IRQ is a GPIO line,
the request IRQ will trickle down into the OMAP GPIO layer:
gpio_irq_type() --> _set_gpio_triggering() which can fault if the
bank has been runtime suspended.

This is exctly what happens on Overo platforms (3530 Water, 3730 Overo
FireSTORM) since this is the only GPIO used in the bank.

To fix, don't free the GPIO at all since it is always in use.

Cc: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/common-board-devices.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index c187586..1ae6fd6 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -84,9 +84,6 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		ads7846_config.gpio_pendown = gpio_pendown;
 	}
 
-	if (!board_pdata || (board_pdata && !board_pdata->get_pendown_state))
-		gpio_free(gpio_pendown);
-
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
 #else
-- 
1.7.9.2

