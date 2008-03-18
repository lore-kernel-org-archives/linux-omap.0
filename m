From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: [PATCH] I2C: Fix OMAP I2C status register handling in IRQ processing
Date: Mon, 17 Mar 2008 22:38:16 -0500
Message-ID: <20080318033815.GA23504@ubuntu-workstation>
References: <20080312175609.GA9811@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:42707 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYCRDje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 23:39:34 -0400
Received: by py-out-1112.google.com with SMTP id u52so8159904pyb.10
        for <linux-omap@vger.kernel.org>; Mon, 17 Mar 2008 20:39:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080312175609.GA9811@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Wed, Mar 12, 2008 at 12:56:10PM -0500, Seth Forshee wrote:
> The IRQ handler in omap-i2c.c can sometimes clear status bits without
> actually processing them.  In particular, error status bits will be
> ignored if any of the ARDY, RRDY, RDR, XRDY, or XDR bits are
> concurrently set.

Are there any more comments on the patch below?  If there is a problem
with style or implementation details I will fix them and submit a new
patch, as long as the functionality isn't affected as with the
previous comments.  But it is possible for the error status bits to go
unhandled and unreported (in fact it always happens for me with any
address for which there is no slave present on a given bus), so I would
think that it would be desirable to get a fix applied.

Cheers,
Seth

> 
> Signed-off-by: Seth Forshee <seth.forshee@gmail.com>
> ---
> 
> More information:
> 
> I originally noticed this problem on a custom 2430 board I am working
> with.  Whenever an i2c chip driver calls i2c_probe() the device would
> be found on both i2c busses at each of the possible addresses for the
> device.  I discovered that NACK was being set in the status register
> but omap_i2c_xfer() still returned success because ARDY was also set.
> 
> This patch fixes this issue on my board and hasn't caused any problems
> (in my admittedly light i2c usage).  I don't have immediate access to
> an SDP board however, so it has not been tested on that platform.
> 
>  drivers/i2c/busses/i2c-omap.c |   28 +++++++++++++---------------
>  1 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 4777466..a16d513 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -590,7 +590,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  	struct omap_i2c_dev *dev = dev_id;
>  	u16 bits;
>  	u16 stat, w;
> -	int count = 0;
> +	int err, count = 0;
>  
>  	if (dev->idle)
>  		return IRQ_NONE;
> @@ -605,10 +605,19 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  
>  		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
>  
> -		if (stat & OMAP_I2C_STAT_ARDY) {
> -			omap_i2c_complete_cmd(dev, 0);
> -			continue;
> +		err = 0;
> +		if (stat & OMAP_I2C_STAT_NACK) {
> +			err |= OMAP_I2C_STAT_NACK;
> +			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> +					   OMAP_I2C_CON_STP);
>  		}
> +		if (stat & OMAP_I2C_STAT_AL) {
> +			dev_err(dev->dev, "Arbitration lost\n");
> +			err |= OMAP_I2C_STAT_AL;
> +		}
> +		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
> +					OMAP_I2C_STAT_AL))
> +			omap_i2c_complete_cmd(dev, err);
>  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
>  			u8 num_bytes = 1;
>  			if (dev->fifo_size) {
> @@ -640,7 +649,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				}
>  			}
>  			omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
> -			continue;
>  		}
>  		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
>  			u8 num_bytes = 1;
> @@ -674,7 +682,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
>  			}
>  			omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> -			continue;
>  		}
>  		if (stat & OMAP_I2C_STAT_ROVR) {
>  			dev_err(dev->dev, "Receive overrun\n");
> @@ -684,15 +691,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  			dev_err(dev->dev, "Transmit overflow\n");
>  			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
>  		}
> -		if (stat & OMAP_I2C_STAT_NACK) {
> -			omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_NACK);
> -			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> -					   OMAP_I2C_CON_STP);
> -		}
> -		if (stat & OMAP_I2C_STAT_AL) {
> -			dev_err(dev->dev, "Arbitration lost\n");
> -			omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_AL);
> -		}
>  	}
>  
>  	return count ? IRQ_HANDLED : IRQ_NONE;
> -- 
> 1.5.2.5
> 
