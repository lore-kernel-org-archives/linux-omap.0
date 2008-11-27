From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Thu, 27 Nov 2008 10:38:51 +0200
Message-ID: <1227775131.27458.24.camel@eenurkka-desktop>
References: <12277070551136-git-send-email-ext-eero.nurkkala@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35450 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbYK0IjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 03:39:18 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAR8dFpc019174
	for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 10:39:15 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAR8d9Hk011315
	for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 10:39:09 +0200
In-Reply-To: <12277070551136-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

We scope-verified these scl and sch values for 100 and 400 kHz busses.
Now they're in the specs.

On Wed, 2008-11-26 at 15:44 +0200, ext-eero.nurkkala@nokia.com wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> The prescalers for 100 kHz and 400 kHz mode
> are wrong for omap 3430 and omap 2430. The
> internal clock is the fclock divided by the
> prescaler. The PSC is an 8 bit field in
> omap3430 and omap2430. Moreover, the scll and
> sclh values should be adjusted properly.
> Having the correct prescaler is important in
> the process of getting a finite i2c clock. In
> addition, the prescaler is used in the process
> of activating the correct noise filter and thus,
> lets more error resilient i2c communications.
> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 630702c..c21af3f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -337,7 +337,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>  
>  		/* HSI2C controller internal clk rate should be 19.2 Mhz */
> -		internal_clk = 19200;
> +		if (dev->speed > 400)
> +			internal_clk = 19200;
> +		else if (dev->speed > 100)
> +			internal_clk = 9600;
> +		else
> +			internal_clk = 4000;
> +
>  		fclk_rate = clk_get_rate(dev->fclk) / 1000;
>  
>  		/* Compute prescaler divisor */
> @@ -355,8 +361,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			hssclh = fclk_rate / (dev->speed * 2) - 6;
>  		} else {
>  			/* To handle F/S modes */
> -			fsscll = internal_clk / (dev->speed * 2) - 6;
> -			fssclh = internal_clk / (dev->speed * 2) - 6;
> +			fsscll = internal_clk / (dev->speed * 2) - 3;
> +			fssclh = internal_clk / (dev->speed * 2) - 9;
>  		}
>  		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
>  		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;

