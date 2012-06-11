From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Mon, 11 Jun 2012 17:37:33 +0300
Message-ID: <4FD602AD.1060304@compulab.co.il>
References: <zumeng.chen@gmail.com> <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com> <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:53998
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755171Ab2FKOhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:37:42 -0400
In-Reply-To: <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

This is input subsystem, add Dmitry and linux-input.

On 06/11/12 17:00, Zumeng Chen wrote:
> If we don't set proper debouce time for ads7846, then there are
> flooded interrupt counters of ads7846 responding to one time
> touch on screen, so the driver couldn't work well.
> 
> And since most OMAP3 series boards pass NULL pointer of board_pdata
> to omap_ads7846_init, so it's more proper to set it in driver level
> after having gpio_request done.

What about other non-OMAP platforms?

NULL pointer for board_pdata, only means that the default pdata is used.
Please, see the common-board-devices.c file more closely.

> 
> This patch has been validated on 3530evm.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/input/touchscreen/ads7846.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index f02028e..a82a5fb 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -61,6 +61,7 @@
>  
>  /* this driver doesn't aim at the peak continuous sample rate */
>  #define	SAMPLE_BITS	(8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
> +#define	DEBOUNCE_TIME	310 /* About 10 ms */

I think hard coding this value is wrong.
Can't it be derived from the pdata->debounce_* fields?

>  
>  struct ts_event {
>  	/*
> @@ -980,6 +981,7 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>  		}
>  
>  		ts->gpio_pendown = pdata->gpio_pendown;
> +		gpio_set_debounce(pdata->gpio_pendown, DEBOUNCE_TIME);
>  
>  	} else {
>  		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");

-- 
Regards,
Igor.
