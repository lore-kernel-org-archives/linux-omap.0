From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v2] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 21:00:53 +0200
Message-ID: <5581C3E5.6020109@gmail.com>
References: <1434565751-14944-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34532 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbFQTA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2015 15:00:57 -0400
In-Reply-To: <1434565751-14944-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, wsa@the-dreams.de
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi!

On 17/06/15 20:29, Felipe Balbi wrote:
> -		if (dev->speed > 400 ||
> -			       dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
> -			internal_clk = 19200;

Let's compare, what it waas before in this case...

> -		else if (dev->speed > 100)
> -			internal_clk = 9600;
> -		else
> -			internal_clk = 4000;
> +		if (dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK ||
> +				dev->speed > 400) {
> +			internal_clk = 1920000;

Seems that it should be 19200000? Because...

> +			internal_clk_period = NSECS_PER_SEC /
> +				internal_clk; /* ns */

520

> +		} else {
> +			internal_clk = 12000000;
> +			internal_clk_period = NSECS_PER_SEC /
> +				internal_clk; /* ns */
> +		}
> +
>  		fclk = clk_get(dev->dev, "fck");
> -		fclk_rate = clk_get_rate(fclk) / 1000;
> +		fclk_rate = clk_get_rate(fclk);
>  		clk_put(fclk);
>  
>  		/* Compute prescaler divisor */
>  		psc = fclk_rate / internal_clk;
>  		psc = psc - 1;
>  
> +		/*
> +		 * Here's the tricky part, we want to make sure our duty cycle
> +		 * is as close to 50% as possible. In order to achieve that, we
> +		 * will first figure out what's the period on chosen scl is,
> +		 * then divide that by two and calculate SCLL and SCLH based on
> +		 * that.
> +		 *
> +		 * SCLL and SCLH equations are as folows:
> +		 *
> +		 * SCLL = (tLow / iclk_period) - 7;
> +		 * SCLH = (tHigh / iclk_period) - 5;
> +		 *
> +		 * Where iclk_period is period of Internal Clock.
> +		 *
> +		 * tLow and tHigh will be basically half of scl_period where
> +		 * possible as long as we can match I2C spec's minimum limits
> +		 * for them.
> +		 */
> +		scl_period = NSECS_PER_SEC / (dev->speed * 1000);
> +
>  		/* If configured for High Speed */
>  		if (dev->speed > 400) {
> -			unsigned long scl;
> +			unsigned long fs_period;
> +
> +			/*
> +			 * first phase of HS mode is up to
> +			 * 400kHz so we will use that.
> +			 */
> +			fs_period = NSECS_PER_SEC / 400000;
>  
>  			/* For first phase of HS mode */
> -			scl = internal_clk / 400;

scl=19200/400=48

> -			fsscll = scl - (scl / 3) - 7;
fsscll=48-16-7=25
> -			fssclh = (scl / 3) - 5;
fssclh=16-5=11
> +			fsscll = DIV_ROUND_UP(fs_period >> 1,
> +					internal_clk_period) - 7;
> +			fssclh = (fs_period >> 1) / internal_clk_period - 5;

And with your patch:
fsscll=ROUND_UP(1250/520)-7=-4
fssclh=1250/520-5=-3

Alex.
