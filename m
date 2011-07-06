From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Tue, 05 Jul 2011 17:01:01 -0700
Message-ID: <8739ikp9aa.fsf@ti.com>
References: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60281 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751378Ab1GFABG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 20:01:06 -0400
In-Reply-To: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Tue, 5 Jul 2011 12:41:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently the fifo depth is set to zero for OMAP4 which disables
> the FIFO usage. This patch enables the FIFO usage for I2C transactions
> on OMAP4 also.
>
> Tested on omap4430 and 3430.
>
> Reported-By: Nishanth Menon <nm@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> Rebased on top of the series by Andy Green
> http://www.spinics.net/lists/linux-i2c/msg05632.html

Thanks.

This is v3.1 material, but would be nice to see a couple tested-by or
acked-by tags from folks that are more actively using the I2C driver
before merging

Kevin


>  drivers/i2c/busses/i2c-omap.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d53cd61..8f87a37 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1068,13 +1068,14 @@ omap_i2c_probe(struct platform_device *pdev)
>  		 * size. This is to ensure that we can handle the status on int
>  		 * call back latencies.
>  		 */
> -		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430) {
> -			dev->fifo_size = 0;
> +
> +		dev->fifo_size = (dev->fifo_size / 2);
> +
> +		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
>  			dev->b_hw = 0; /* Disable hardware fixes */
> -		} else {
> -			dev->fifo_size = (dev->fifo_size / 2);
> +		else
>  			dev->b_hw = 1; /* Enable hardware fixes */
> -		}
> +
>  		/* calculate wakeup latency constraint for MPU */
>  		if (dev->set_mpu_wkup_lat != NULL)
>  			dev->latency = (1000000 * dev->fifo_size) /
