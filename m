From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] [I2C-OMAP] Add support for 16-bit registers
Date: Wed, 9 Dec 2009 00:29:14 +0000
Message-ID: <20091209002914.GB32202@fluff.org.uk>
References: <1260083648-13051-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260083648-13051-1-git-send-email-darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 05, 2009 at 11:14:08PM -0800, Cory Maccarrone wrote:
> The current i2c-omap driver is set up for 32-bit registers, which
> corresponds to most OMAP devices.  However, OMAP730/850 based
> devices use a 16-bit register size.
> 
> This change modifies the driver to perform a runtime CPU type check
> to determine the register sizes, and uses a bit shift of either 1
> or 2 bits to compute the proper register sizes for all registers.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |  138 ++++++++++++++++++++++-------------------
>  1 files changed, 73 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 827da08..dc7cf71 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -49,24 +49,26 @@
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
>  
>  #define OMAP_I2C_REV_REG		0x00
> -#define OMAP_I2C_IE_REG			0x04
> -#define OMAP_I2C_STAT_REG		0x08
> -#define OMAP_I2C_IV_REG			0x0c
> +#define OMAP_I2C_IE_REG			0x01
> +#define OMAP_I2C_STAT_REG		0x02
> +#define OMAP_I2C_IV_REG			0x03
>  /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
> -#define OMAP_I2C_WE_REG			0x0c
> -#define OMAP_I2C_SYSS_REG		0x10
> -#define OMAP_I2C_BUF_REG		0x14
> -#define OMAP_I2C_CNT_REG		0x18
> -#define OMAP_I2C_DATA_REG		0x1c
> -#define OMAP_I2C_SYSC_REG		0x20
> -#define OMAP_I2C_CON_REG		0x24
> -#define OMAP_I2C_OA_REG			0x28
> -#define OMAP_I2C_SA_REG			0x2c
> -#define OMAP_I2C_PSC_REG		0x30
> -#define OMAP_I2C_SCLL_REG		0x34
> -#define OMAP_I2C_SCLH_REG		0x38
> -#define OMAP_I2C_SYSTEST_REG		0x3c
> -#define OMAP_I2C_BUFSTAT_REG		0x40
> +#define OMAP_I2C_WE_REG			0x03
> +#define OMAP_I2C_SYSS_REG		0x04
> +#define OMAP_I2C_BUF_REG		0x05
> +#define OMAP_I2C_CNT_REG		0x06
> +#define OMAP_I2C_DATA_REG		0x07
> +#define OMAP_I2C_SYSC_REG		0x08
> +#define OMAP_I2C_CON_REG		0x09
> +#define OMAP_I2C_OA_REG			0x0a
> +#define OMAP_I2C_SA_REG			0x0b
> +#define OMAP_I2C_PSC_REG		0x0c
> +#define OMAP_I2C_SCLL_REG		0x0d
> +#define OMAP_I2C_SCLH_REG		0x0e
> +#define OMAP_I2C_SYSTEST_REG		0x0f
> +#define OMAP_I2C_BUFSTAT_REG		0x10
> +
> +#define OMAP_I2C_REG(host, reg)		(OMAP_I2C_##reg##_REG << (host)->reg_shift)

could you leave the definitions alone and shift the other way?
  
>  /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
>  #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
> @@ -161,6 +163,7 @@ struct omap_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;		/* virtual */
>  	int			irq;
> +	int			reg_shift;      /* bit shift for I2C register addresses */
>  	struct clk		*iclk;		/* Interface clock */
>  	struct clk		*fclk;		/* Functional clock */
>  	struct completion	cmd_complete;
> @@ -232,7 +235,7 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
>  	clk_enable(dev->fclk);
>  	dev->idle = 0;
>  	if (dev->iestate)
> -		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, IE), dev->iestate);

how about changing the read and write register calls to do the
necessary address munging so you don't have to change all the
callsites throughout the file?

>  }
>  
>  static void omap_i2c_idle(struct omap_i2c_dev *dev)
> @@ -241,15 +244,15 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>  
>  	WARN_ON(dev->idle);
>  
> -	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> -	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> +	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, IE));
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, IE), 0);
>  	if (dev->rev < OMAP_I2C_REV_2) {
> -		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
> +		iv = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, IV)); /* Read clears */
>  	} else {
> -		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, STAT), dev->iestate);
>  
>  		/* Flush posted write before the dev->idle store occurs */
> -		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +		omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, STAT));
>  	}
>  	dev->idle = 1;
>  	clk_disable(dev->fclk);
> @@ -265,12 +268,12 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	unsigned long internal_clk = 0;
>  
>  	if (dev->rev >= OMAP_I2C_REV_2) {
> -		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, SYSC), SYSC_SOFTRESET_MASK);
>  		/* For some reason we need to set the EN bit before the
>  		 * reset done bit gets set. */
>  		timeout = jiffies + OMAP_I2C_TIMEOUT;
> -		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> -		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), OMAP_I2C_CON_EN);
> +		while (!(omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, SYSS)) &
>  			 SYSS_RESETDONE_MASK)) {
>  			if (time_after(jiffies, timeout)) {
>  				dev_warn(dev->dev, "timeout waiting "
> @@ -283,7 +286,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  		/* SYSC register is cleared by the reset; rewrite it */
>  		if (dev->rev == OMAP_I2C_REV_ON_2430) {
>  
> -			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
> +			omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, SYSC),
>  					   SYSC_AUTOIDLE_MASK);
>  
>  		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
> @@ -296,18 +299,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			v |= (SYSC_CLOCKACTIVITY_FCLK <<
>  			      __ffs(SYSC_CLOCKACTIVITY_MASK));
>  
> -			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);
> +			omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, SYSC), v);
>  			/*
>  			 * Enabling all wakup sources to stop I2C freezing on
>  			 * WFI instruction.
>  			 * REVISIT: Some wkup sources might not be needed.
>  			 */
> -			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> +			omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, WE),
>  							OMAP_I2C_WE_ALL);
>  
>  		}
>  	}
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), 0);
>  
>  	if (cpu_class_is_omap1()) {
>  		/*
> @@ -388,25 +391,25 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	}
>  
>  	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
> -	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, PSC), psc);
>  
>  	/* SCL low and high time values */
> -	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
> -	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, SCLL), scll);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, SCLH), sclh);
>  
>  	if (dev->fifo_size)
>  		/* Note: setup required fifo size - 1 */
> -		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, BUF),
>  					(dev->fifo_size - 1) << 8 | /* RTRSH */
>  					OMAP_I2C_BUF_RXFIF_CLR |
>  					(dev->fifo_size - 1) | /* XTRSH */
>  					OMAP_I2C_BUF_TXFIF_CLR);
>  
>  	/* Take the I2C module out of reset: */
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), OMAP_I2C_CON_EN);
>  
>  	/* Enable interrupts */
> -	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, IE),
>  			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
>  			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
> @@ -422,7 +425,7 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
>  	unsigned long timeout;
>  
>  	timeout = jiffies + OMAP_I2C_TIMEOUT;
> -	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
> +	while (omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, STAT)) & OMAP_I2C_STAT_BB) {
>  		if (time_after(jiffies, timeout)) {
>  			dev_warn(dev->dev, "timeout waiting for bus ready\n");
>  			return -ETIMEDOUT;
> @@ -449,18 +452,18 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (msg->len == 0)
>  		return -EINVAL;
>  
> -	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, SA), msg->addr);
>  
>  	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
>  	dev->buf = msg->buf;
>  	dev->buf_len = msg->len;
>  
> -	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CNT), dev->buf_len);
>  
>  	/* Clear the FIFO Buffers */
> -	w = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
> +	w = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, BUF));
>  	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
> -	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, BUF), w);
>  
>  	init_completion(&dev->cmd_complete);
>  	dev->cmd_err = 0;
> @@ -479,16 +482,16 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (!dev->b_hw && stop)
>  		w |= OMAP_I2C_CON_STP;
>  
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), w);
>  
>  	/*
>  	 * Don't write stt and stp together on some hardware.
>  	 */
>  	if (dev->b_hw && stop) {
>  		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
> -		u16 con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> +		u16 con = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, CON));
>  		while (con & OMAP_I2C_CON_STT) {
> -			con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> +			con = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, CON));
>  
>  			/* Let the user know if i2c is in a bad state */
>  			if (time_after(jiffies, delay)) {
> @@ -501,7 +504,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  
>  		w |= OMAP_I2C_CON_STP;
>  		w &= ~OMAP_I2C_CON_STT;
> -		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), w);
>  	}
>  
>  	/*
> @@ -533,9 +536,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  		if (msg->flags & I2C_M_IGNORE_NAK)
>  			return 0;
>  		if (stop) {
> -			w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> +			w = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, CON));
>  			w |= OMAP_I2C_CON_STP;
> -			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> +			omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), w);
>  		}
>  		return -EREMOTEIO;
>  	}
> @@ -589,7 +592,7 @@ omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u16 err)
>  static inline void
>  omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
>  {
> -	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, STAT), stat);
>  }
>  
>  /* rev1 devices are apparently only on some 15xx */
> @@ -604,7 +607,7 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>  	if (dev->idle)
>  		return IRQ_NONE;
>  
> -	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
> +	iv = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, IV));
>  	switch (iv) {
>  	case 0x00:	/* None */
>  		break;
> @@ -614,14 +617,14 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>  		break;
>  	case 0x02:	/* No acknowledgement */
>  		omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_NACK);
> -		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_STP);
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), OMAP_I2C_CON_STP);
>  		break;
>  	case 0x03:	/* Register access ready */
>  		omap_i2c_complete_cmd(dev, 0);
>  		break;
>  	case 0x04:	/* Receive data ready */
>  		if (dev->buf_len) {
> -			w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
> +			w = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, DATA));
>  			*dev->buf++ = w;
>  			dev->buf_len--;
>  			if (dev->buf_len) {
> @@ -639,7 +642,7 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>  				w |= *dev->buf++ << 8;
>  				dev->buf_len--;
>  			}
> -			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
> +			omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, DATA), w);
>  		} else
>  			dev_err(dev->dev, "XRDY IRQ while no data to send\n");
>  		break;
> @@ -664,8 +667,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  	if (dev->idle)
>  		return IRQ_NONE;
>  
> -	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> -	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
> +	bits = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, IE));
> +	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, STAT)))) & bits) {
>  		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
>  		if (count++ == 100) {
>  			dev_warn(dev->dev, "Too much work in one IRQ\n");
> @@ -679,13 +682,13 @@ complete:
>  		 * acked after the data operation is complete.
>  		 * Ref: TRM SWPU114Q Figure 18-31
>  		 */
> -		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
> +		omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, STAT), stat &
>  				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
>  				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
>  
>  		if (stat & OMAP_I2C_STAT_NACK) {
>  			err |= OMAP_I2C_STAT_NACK;
> -			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> +			omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON),
>  					   OMAP_I2C_CON_STP);
>  		}
>  		if (stat & OMAP_I2C_STAT_AL) {
> @@ -707,12 +710,12 @@ complete:
>  					num_bytes = dev->fifo_size;
>  				else    /* read RXSTAT on RDR interrupt */
>  					num_bytes = (omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG)
> +							OMAP_I2C_REG(dev, BUFSTAT))
>  							>> 8) & 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
> -				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
> +				w = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, DATA));
>  				if (dev->buf_len) {
>  					*dev->buf++ = w;
>  					dev->buf_len--;
> @@ -747,7 +750,7 @@ complete:
>  					num_bytes = dev->fifo_size;
>  				else    /* read TXSTAT on XDR interrupt */
>  					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG)
> +							OMAP_I2C_REG(dev, BUFSTAT))
>  							& 0x3F;
>  			}
>  			while (num_bytes) {
> @@ -792,11 +795,11 @@ complete:
>  								goto complete;
>  							}
>  							cpu_relax();
> -							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +							stat = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, STAT));
>  						}
>  				}
>  
> -				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
> +				omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, DATA), w);
>  			}
>  			omap_i2c_ack_stat(dev,
>  				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> @@ -877,13 +880,13 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	omap_i2c_unidle(dev);
>  
> -	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, REV)) & 0xff;
>  
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>  		u16 s;
>  
>  		/* Set up the fifo size - Get total size */
> -		s = (omap_i2c_read_reg(dev, OMAP_I2C_BUFSTAT_REG) >> 14) & 0x3;
> +		s = (omap_i2c_read_reg(dev, OMAP_I2C_REG(dev, BUFSTAT)) >> 14) & 0x3;
>  		dev->fifo_size = 0x8 << s;
>  
>  		/*
> @@ -895,6 +898,11 @@ omap_i2c_probe(struct platform_device *pdev)
>  		dev->b_hw = 1; /* Enable hardware fixes */
>  	}
>  
> +	if (cpu_is_omap7xx())
> +		dev->reg_shift = 1;
> +	else
> +		dev->reg_shift = 2;
> +
>  	/* reset ASAP, clearing any IRQs */
>  	omap_i2c_init(dev);
>  
> @@ -932,7 +940,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  err_free_irq:
>  	free_irq(dev->irq, dev);
>  err_unuse_clocks:
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), 0);
>  	omap_i2c_idle(dev);
>  	omap_i2c_put_clocks(dev);
>  err_iounmap:
> @@ -956,7 +964,7 @@ omap_i2c_remove(struct platform_device *pdev)
>  
>  	free_irq(dev->irq, dev);
>  	i2c_del_adapter(&dev->adapter);
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	omap_i2c_write_reg(dev, OMAP_I2C_REG(dev, CON), 0);
>  	omap_i2c_put_clocks(dev);
>  	iounmap(dev->base);
>  	kfree(dev);
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
