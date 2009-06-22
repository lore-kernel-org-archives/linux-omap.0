From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
Date: Mon, 22 Jun 2009 13:56:42 -0700
Message-ID: <87y6rk0yyd.fsf@deeprootsystems.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f182.google.com ([209.85.222.182]:45335 "EHLO
	mail-pz0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZFVU4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 16:56:42 -0400
Received: by pzk12 with SMTP id 12so106492pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 13:56:45 -0700 (PDT)
In-Reply-To: <1245702865-4459-1-git-send-email-ubh@ti.com> (Ulrik Bech Hald's message of "Mon\, 22 Jun 2009 15\:34\:25 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Ulrik Bech Hald <ubh@ti.com> writes:

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

Minor CodingStyle comments below...

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

But the local variable define here, followed by a blank line, and
the assignment to zero is unnecessary.

> +			/* 3430 I2C Errata 1.15
> +			 * RDR could be set when the bus is busy, then
> +			 * ignore the interrupt, and clear the bit.
> +			 */

Move the '*/' to the end of the previous line. 

> +			u8 stat2 = 0;
> +			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +			if (stat2 & OMAP_I2C_STAT_BB)
> +				return IRQ_HANDLED;
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
