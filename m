From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Tue, 11 Nov 2008 18:51:30 +0530
Message-ID: <034e01c94400$69fa2620$LocalHost@wipultra806>
References: <12263863521940-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59356 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbYKKNVn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 08:21:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>


----- Original Message ----- 
From: <ext-eero.nurkkala@nokia.com>
To: <linux-omap@vger.kernel.org>
Cc: "Eero Nurkkala" <ext-eero.nurkkala@nokia.com>
Sent: Tuesday, November 11, 2008 12:22 PM
Subject: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers


> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
>
> The prescalers for 100 kHz and 400 kHz mode
> are wrong. The internal clock is the fclock
> divided by the prescaler. Also, the scll and
> sclh values should be adjusted correctly.
> Having the correct prescaler is important in
> the process of getting standard i2c clock. In
> addition, it (psc) is used to get the correct
> noise filter and thus, lets more error resilient
> i2c communications.
>
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
> drivers/i2c/busses/i2c-omap.c |   12 +++++++++---
> 1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f15668d..cee2f2d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -288,7 +288,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>
>  /* HSI2C controller internal clk rate should be 19.2 Mhz */
> - internal_clk = 19200;
> + if (dev->speed > 400)
> + internal_clk = 19200;
> + else if (dev->speed > 100)
> + internal_clk = 9600;
> + else
> + internal_clk = 4000;

Is internal clk 4000 valid??  PSC_REG  field cannot encompass ( its 4 bit field) 
the calculated psc if internal_clk is 4000.

> +
>  fclk_rate = clk_get_rate(dev->fclk) / 1000;
>
>  /* Compute prescaler divisor */
> @@ -306,8 +312,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  hssclh = fclk_rate / (dev->speed * 2) - 6;
>  } else {
>  /* To handle F/S modes */
> - fsscll = internal_clk / (dev->speed * 2) - 6;
> - fssclh = internal_clk / (dev->speed * 2) - 6;
> + fsscll = internal_clk / (dev->speed * 2) - 7;
> + fssclh = internal_clk / (dev->speed * 2) - 5;
>  }
>  scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
>  sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
> -- 
> 1.6.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

