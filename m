From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon errata 1.153
Date: Mon, 22 Jun 2009 15:30:30 -0700
Message-ID: <87iqin296h.fsf@deeprootsystems.com>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:7397 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZFVWah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 18:30:37 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1561767wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 15:30:40 -0700 (PDT)
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com> (Moiz Sonasath's message of "Mon\, 22 Jun 2009 11\:49\:56 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

"Sonasath, Moiz" <m-sonasath@ti.com> writes:

> This patch includes the workarround for I2C Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing data to DATA_REG

How was this tested/validated, on what platforms etc.

> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> Signed-off by: Nishant Kamat <nskamat@ti.com>
> Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   54 +++++++++++++++++++++++++++++++++++++---
>  1 files changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ece0125..e84836b 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -632,6 +632,37 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>  #define omap_i2c_rev1_isr		NULL
>  #endif
>  
> +/* I2C Errata 1.153:
> + * When an XRDY/XDR is hit, wait for XUDF before writing data to DATA_REG.
> + * Otherwise some data bytes can be lost while transferring them from the
> + * memory to the I2C interface.
> + */
> +
> +static int omap_i2c_wait_for_xudf(struct omap_i2c_dev *dev)
> +{
> +	u16 xudf;
> +	int counter = 500;
> +
> +	/* We are in interrupt context. Wait for XUDF for max 7 msec */

What does being in interrupt context have to do with how long you
wait?  Threaded interrupts are now in mainline and will become the
default, so this ISR may run in thread context.


> +	xudf = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +	while (!(xudf & OMAP_I2C_STAT_XUDF) && counter--) {
> +		if (xudf & (OMAP_I2C_STAT_ROVR | OMAP_I2C_STAT_NACK |
> +			    OMAP_I2C_STAT_AL))
> +			return -EINVAL;
> +		udelay(10);
> +		xudf = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +	}
> +
> +	if (!counter) {
> +		/* Clear Tx FIFO */
> +		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
> +				OMAP_I2C_BUF_TXFIF_CLR);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
>  static irqreturn_t
>  omap_i2c_isr(int this_irq, void *dev_id)
>  {
> @@ -639,6 +670,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  	u16 bits;
>  	u16 stat, w;
>  	int err, count = 0;
> +	int error;
>  
>  	if (dev->idle)
>  		return IRQ_NONE;
> @@ -647,7 +679,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
>  		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
>  		if (count++ == 100) {
> -			dev_warn(dev->dev, "Too much work in one IRQ\n");
> +			dev_dbg(dev->dev, "Too much work in one IRQ\n");

Should stay as dev_warn I think.

>  			break;
>  		}
>  
> @@ -715,11 +747,22 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  							OMAP_I2C_BUFSTAT_REG);
>  			}
>  			while (num_bytes) {
> -				num_bytes--;
>  				w = 0;
>  				if (dev->buf_len) {
> +					if (cpu_is_omap34xx()) {
> +						/* OMAP3430 Errata 1.153 */
> +						error = omap_i2c_wait_for_xudf(dev);
> +						if (error) {
> +							omap_i2c_ack_stat(dev, stat &
> +								(OMAP_I2C_STAT_XRDY |
> +								 OMAP_I2C_STAT_XDR));
> +							dev_err(dev->dev, "Transmit error\n");
> +							omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_XUDF);
> +
> +							return IRQ_HANDLED;
> +						}
> +					}

Yuck, too much wrapping here.  Running through checkpatch would've warned
you about this.  Looks like you need to break this out into a subroutine.


>  					w = *dev->buf++;
> -					dev->buf_len--;
>  					/* Data reg from  2430 is 8 bit wide */
>  					if (!cpu_is_omap2430() &&
>  							!cpu_is_omap34xx()) {
> @@ -728,6 +771,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  							dev->buf_len--;
>  						}
>  					}
> +					omap_i2c_write_reg(dev,
> +						OMAP_I2C_DATA_REG, w);
> +					num_bytes--;
> +					dev->buf_len--;
>  				} else {
>  					if (stat & OMAP_I2C_STAT_XRDY)
>  						dev_err(dev->dev,
> @@ -739,7 +786,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  							"data to send\n");
>  					break;
>  				}
> -				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
>  			}
>  			omap_i2c_ack_stat(dev,
>  				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
