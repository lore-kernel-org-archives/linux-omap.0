From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Thu, 8 Jan 2009 15:37:52 +0200
Message-ID: <20090108133751.GJ27566@atomide.com>
References: <12276110261037-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58317 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842AbZAHNhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 08:37:53 -0500
Content-Disposition: inline
In-Reply-To: <12276110261037-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

* ext-eero.nurkkala@nokia.com <ext-eero.nurkkala@nokia.com> [081125 13:04]:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> The number of bytes to be received is read from wrong
> place with all OMAPs with highspeed I2C support,
> which involves a FIFO and BUFSTAT_REG. It is the 6
> bits starting from the bit 8 in the BUFSTAT_REG
> that indicate this amount of bytes to be read.
> Moreover, only the 6 LSB:s are relevant for the 
> TXSTAT field. 

Pushing to l-o tree and adding to omap-fixes queue.

Tony

> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 96f3bed..71b37ed 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -675,8 +675,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				if (stat & OMAP_I2C_STAT_RRDY)
>  					num_bytes = dev->fifo_size;
>  				else
> -					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG);
> +					num_bytes = (omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG)
> +							>> 8) & 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
> @@ -714,8 +715,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				if (stat & OMAP_I2C_STAT_XRDY)
>  					num_bytes = dev->fifo_size;
>  				else
> -					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG);
> +					num_bytes = (omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG))
> +							& 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
> -- 
> 1.6.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
