From: Stefan Lengfeld <contact@stefanchrist.eu>
Subject: Re: [PATCH 06/12] i2c: omap: Add the master_xfer_irqless hook
Date: Tue, 16 Apr 2019 00:05:46 +0200
Message-ID: <20190415220546.bvrp7jodgdq7phwg@porty>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-7-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

the subject line of this patch

    i2c: omap: Add the master_xfer_irqless hook

still contains the old name of the callback '_irqless'. It should be
'_atomic' instead.


On Wed, Apr 03, 2019 at 02:40:13PM +0200, Wolfram Sang wrote:
> Add the master_xfer_irqless hook to enable i2c transactions

Here again. It should be 'master_xfer_atomic'.


> in irq disabled contexts like the poweroff case.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [wsa: simplified code a little: 'timeout = !ret']
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 76 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 63 insertions(+), 13 deletions(-)
> 

snipped 

> @@ -648,15 +650,28 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
>  			(1000 * omap->speed / 8);
>  }
>  
> +static void omap_i2c_wait(struct omap_i2c_dev *omap)
> +{
> +	u16 stat;
> +	u16 mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
> +	int count = 0;
> +
> +	do {
> +		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
> +		count++;
> +	} while (!(stat & mask) && count < 5);
> +}
> +
>  /*
>   * Low level master read/write transaction.
>   */
>  static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> -			     struct i2c_msg *msg, int stop)
> +			     struct i2c_msg *msg, int stop, bool polling)

Nitpick. In the patches for the other drivers the boolean flag is called
'atomic' and not 'polling'.

>  {
>  	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
>  	unsigned long timeout;
>  	u16 w;
> +	int ret;
>  
>  	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
>  		msg->addr, msg->len, msg->flags, stop);

sniped

> @@ -1165,14 +1204,25 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  		}
>  	} while (stat);
>  
> -	omap_i2c_complete_cmd(omap, err);
> +	return err;
> +}
> +
> +static irqreturn_t
> +omap_i2c_isr_thread(int this_irq, void *dev_id)
> +{
> +	int ret;
> +	struct omap_i2c_dev *omap = dev_id;
> +
> +	ret = omap_i2c_xfer_data(omap);
> +	if (ret != -EAGAIN)
> +		omap_i2c_complete_cmd(omap, ret);
>  
> -out:
>  	return IRQ_HANDLED;
>  }
>  
>  static const struct i2c_algorithm omap_i2c_algo = {
> -	.master_xfer	= omap_i2c_xfer,
> +	.master_xfer	= omap_i2c_xfer_irq,
> +	.master_xfer_atomic	= omap_i2c_xfer_polling,

When consistency with other drivers is a goal, the functions should be
named like:

    .master_xfe = omap_i2c_xfer,
    .master_xfer_atomic = omap_i2c_xfer_atomic,

The first without a suffix and the second with the '_atomic' suffix.

Kind regards,
Stefan
