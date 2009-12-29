From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] omap i2c: make errata 1.153 workaround a
 separate function
Date: Mon, 28 Dec 2009 16:13:56 -0800
Message-ID: <20091229001356.GU3512@atomide.com>
References: <1261394999-20857-1-git-send-email-virtuoso@slind.org>
 <1261394999-20857-2-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1261394999-20857-2-git-send-email-virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org> [091221 03:29]:
> This is to avoid insanely long lines and levels of indentation.
> 
> Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
> CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: nm-l0cyMroinI0@public.gmane.org

Nice, this driver sure could use some clean-up.

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |   43 ++++++++++++++++++++++------------------
>  1 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 75bf3ad..2d146ac 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -671,6 +671,27 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>  #define omap_i2c_rev1_isr		NULL
>  #endif
>  
> +/*
> + * OMAP3430 Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing
> + * data to DATA_REG. Otherwise some data bytes can be lost while transferring
> + * them from the memory to the I2C interface.
> + */
> +static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
> +{
> +	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
> +		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> +			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
> +							OMAP_I2C_STAT_XDR));
> +			*err |= OMAP_I2C_STAT_XUDF;
> +			return -ETIMEDOUT;
> +		}
> +		cpu_relax();
> +		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +	}
> +
> +	return 0;
> +}
> +
>  static irqreturn_t
>  omap_i2c_isr(int this_irq, void *dev_id)
>  {
> @@ -794,25 +815,9 @@ complete:
>  					break;
>  				}
>  
> -				/*
> -				 * OMAP3430 Errata 1.153: When an XRDY/XDR
> -				 * is hit, wait for XUDF before writing data
> -				 * to DATA_REG. Otherwise some data bytes can
> -				 * be lost while transferring them from the
> -				 * memory to the I2C interface.
> -				 */
> -
> -				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
> -						while (!(stat & OMAP_I2C_STAT_XUDF)) {
> -							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> -								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> -								err |= OMAP_I2C_STAT_XUDF;
> -								goto complete;
> -							}
> -							cpu_relax();
> -							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> -						}
> -				}
> +				if ((dev->rev <= OMAP_I2C_REV_ON_3430) &&
> +				    errata_omap3_1p153(dev, &stat, &err))
> +					goto complete;
>  
>  				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
>  			}
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
