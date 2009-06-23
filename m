From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Mon, 22 Jun 2009 19:16:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47247 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZFWBQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 21:16:46 -0400
In-Reply-To: <1245702865-4459-1-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Hello Ulrik, Jagadeesh, 

On Mon, 22 Jun 2009, Ulrik Bech Hald wrote:

> Under certain rare conditions, I2C_STAT[13].RDR bit may be set,
> and the corresponding interrupt fire, even when there is no
> data in the receive FIFO, or the I2C data transfer is still
> ongoing. These spurious RDR events must be ignored by the
> software.
> 
> A check for OMAP_I2C_STAT_BB is introduced in the ISR to
> prevent further processing of RDR interrupt, if the bus is busy.
> 
> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ece0125..88feea1 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -668,6 +668,15 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  			omap_i2c_complete_cmd(dev, err);
>  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
>  			u8 num_bytes = 1;
> +			/* 3430 I2C Errata 1.15
> +			 * RDR could be set when the bus is busy, then
> +			 * ignore the interrupt, and clear the bit.
> +			 */
> +			u8 stat2 = 0;
> +			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +			if (stat2 & OMAP_I2C_STAT_BB)
> +				return IRQ_HANDLED;

Why use stat2? Why not just test stat again?


> +
>  			if (dev->fifo_size) {
>  				if (stat & OMAP_I2C_STAT_RRDY)
>  					num_bytes = dev->fifo_size;
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
