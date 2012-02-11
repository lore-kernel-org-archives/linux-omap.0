From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] i2c: fix missing handling of errata I2C_OMAP3_1P153
Date: Sat, 11 Feb 2012 22:48:42 +0530
Message-ID: <4F36A2F2.7040003@ti.com>
References: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48940 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221Ab2BKRSs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 12:18:48 -0500
Received: by mail-pw0-f41.google.com with SMTP id wz17so3291649pbc.28
        for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 09:18:47 -0800 (PST)
In-Reply-To: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tasskjapp@gmail.com
Cc: linux-omap@vger.kernel.org

On Monday 06 February 2012 08:03 PM, tasskjapp@gmail.com wrote:
> From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
>
> i2c_prope set the dev->errata flag, but omap_i2c_init cleared the flag again. Move the errata handling to i2c_init.
>
 also in my opinion moving the reset to 0 should be moved to probe.
also you may want to cc linux-i2c for the driver patches.
> Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 801df60..ecaa60d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -473,6 +473,10 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>  		dev->errata |= I2C_OMAP_ERRATA_I207;
>  
> +	if (dev->rev <= OMAP_I2C_REV_ON_3430)
> +		dev->errata |= I2C_OMAP3_1P153;
> +
> +
>  	/* Enable interrupts */
>  	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> @@ -1058,9 +1062,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
>  
> -	if (dev->rev <= OMAP_I2C_REV_ON_3430)
> -		dev->errata |= I2C_OMAP3_1P153;
> -
>  	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
>  		u16 s;
>  

