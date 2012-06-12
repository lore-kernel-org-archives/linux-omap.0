From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Mon, 11 Jun 2012 23:47:57 -0700
Message-ID: <20120612064757.GE12766@atomide.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59241 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab2FLGsA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 02:48:00 -0400
Content-Disposition: inline
In-Reply-To: <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com

* Zumeng Chen <zumeng.chen@gmail.com> [120611 07:05]:
> If we don't set proper debouce time for ads7846, then there are
> flooded interrupt counters of ads7846 responding to one time
> touch on screen, so the driver couldn't work well.
> 
> And since most OMAP3 series boards pass NULL pointer of board_pdata
> to omap_ads7846_init, so it's more proper to set it in driver level
> after having gpio_request done.
> 
> This patch has been validated on 3530evm.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Please remove my Signed-off-by, where does that come from?

Tony


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
> -- 
> 1.7.5.4
> 
