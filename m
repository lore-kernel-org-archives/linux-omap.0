From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Date: Fri, 15 Mar 2019 13:47:18 +0100
Message-ID: <20190315124717.x3do5evok5syipo7@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Tero Kristo <t-kristo@ti.com>, Phil Reid <preid@electromag.com.au>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:33PM +0100, Wolfram Sang wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Add the master_xfer_irqless hook to enable i2c transactions
> in irq disabled contexts like the poweroff case.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Minor nit below not withstanding

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


> ---
>  drivers/i2c/busses/i2c-omap.c | 79 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index cd9c65f3d404..bf48126faf94 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -269,6 +269,8 @@ static const u8 reg_map_ip_v2[] = {
>  	[OMAP_I2C_IP_V2_IRQENABLE_CLR] = 0x30,
>  };
>  
> +static int omap_i2c_xfer_data(struct omap_i2c_dev *omap);
> +
>  static inline void omap_i2c_write_reg(struct omap_i2c_dev *omap,
>  				      int reg, u16 val)
>  {
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
>  {
>  	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
>  	unsigned long timeout;
>  	u16 w;
> +	int ret;
>  
>  	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
>  		msg->addr, msg->len, msg->flags, stop);
> @@ -680,7 +695,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
>  	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
>  
> -	reinit_completion(&omap->cmd_complete);
> +	if (!polling)
> +		reinit_completion(&omap->cmd_complete);
>  	omap->cmd_err = 0;
>  
>  	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
> @@ -732,8 +748,21 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	 * REVISIT: We should abort the transfer on signals, but the bus goes
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
> -	timeout = wait_for_completion_timeout(&omap->cmd_complete,
> -						OMAP_I2C_TIMEOUT);
> +	if (!polling) {
> +		timeout = wait_for_completion_timeout(&omap->cmd_complete,
> +						      OMAP_I2C_TIMEOUT);
> +	} else {
> +		do {
> +			omap_i2c_wait(omap);
> +			ret = omap_i2c_xfer_data(omap);
> +		} while (ret == -EAGAIN);
> +
> +		if (!ret)
> +			timeout = 1;
> +		else
> +			timeout = 0;


nit: the following might be cleaner

		ret = !!timeout;

> +	}
> +
>  	if (timeout == 0) {
>  		dev_err(omap->dev, "controller timed out\n");
>  		omap_i2c_reset(omap);
> @@ -772,7 +801,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>   * to do the work during IRQ processing.
>   */
>  static int
> -omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +omap_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg msgs[], int num,
> +		     bool polling)
>  {
>  	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
>  	int i;
> @@ -794,7 +824,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  		omap->set_mpu_wkup_lat(omap->dev, omap->latency);
>  
>  	for (i = 0; i < num; i++) {
> -		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
> +		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)),
> +				      polling);
>  		if (r != 0)
>  			break;
>  	}
> @@ -813,6 +844,18 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	return r;
>  }
>  
> +static int
> +omap_i2c_xfer_irq(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{
> +	return omap_i2c_xfer_common(adap, msgs, num, false);
> +}
> +
> +static int
> +omap_i2c_xfer_polling(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{
> +	return omap_i2c_xfer_common(adap, msgs, num, true);
> +}
> +
>  static u32
>  omap_i2c_func(struct i2c_adapter *adap)
>  {
> @@ -1035,10 +1078,8 @@ omap_i2c_isr(int irq, void *dev_id)
>  	return ret;
>  }
>  
> -static irqreturn_t
> -omap_i2c_isr_thread(int this_irq, void *dev_id)
> +static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>  {
> -	struct omap_i2c_dev *omap = dev_id;
>  	u16 bits;
>  	u16 stat;
>  	int err = 0, count = 0;
> @@ -1056,7 +1097,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  
>  		if (!stat) {
>  			/* my work here is done */
> -			goto out;
> +			err = -EAGAIN;
> +			break;
>  		}
>  
>  		dev_dbg(omap->dev, "IRQ (ISR = 0x%04x)\n", stat);
> @@ -1165,14 +1207,25 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
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
>  	.functionality	= omap_i2c_func,
>  };
>  
> -- 
> 2.11.0
> 
