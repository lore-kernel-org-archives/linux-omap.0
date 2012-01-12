From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] I2C: OMAP: Recover from Bus Busy condition
Date: Thu, 12 Jan 2012 11:25:38 +0530
Message-ID: <4F0E75DA.5080903@ti.com>
References: <1326303765-30140-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326303765-30140-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 11 January 2012 11:12 PM, Shubhrajyoti D wrote:
> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

I am reworking the patch on the latest changes.
Please ignore this.
> In case a peripheral is driving SDA bus low (ie. a start condition), provide
> a constant clock output using the test mode of the OMAP I2C controller to
> try and clear the bus. Soft reset I2C controller after attempting the bus clear
> to ensure that controller is in a good state.
>
> Based upon Vikram Pandita's patch from TI Android 3.0 kernel and modified for
> mainline by Jon Hunter. A couple differences from the original patch ...
> 1. Add a new function for bus clear
> 2. Ensure that the CON.I2C_EN bit is set when using the SYSTEST feature to
>    output a permanent clock. This bit needs to be set and tpyically it would
>    be set by the unidle function but this is not the case for all OMAP
>    generations.
> 3. Program the SYSTEST setting only the bits we care about. However, restore
>    SYSTEST registers to there original state as some OMAP generations do not
>    implement perform a soft-reset.
> 4. Clear the CON register after performing the bus clear, so when we call the
>    init function the controller is disabled and the init function will
>    re-enable later.
>
> Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
> Original patch can be found here:
> http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=a2ab04192ba25e60f95ba1ff3af5601a2d7b5bd1
> applies on Kevin's for_3.3/i2c/misc
>
>  drivers/i2c/busses/i2c-omap.c |   32 +++++++++++++++++++++++++++++---
>  1 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f713eac..6d59bc6 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -147,16 +147,15 @@ enum {
>  #define OMAP_I2C_SCLH_HSSCLH	8
>  
>  /* I2C System Test Register (OMAP_I2C_SYSTEST): */
> -#ifdef DEBUG
>  #define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
>  #define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
>  #define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
> -#define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
> +#define OMAP_I2C_SYSTEST_TMODE_TEST	(2 << 12)	/* Test mode select */
> +#define OMAP_I2C_SYSTEST_TMODE_LOOP	(3 << 12)	/* Test mode select */
>  #define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
>  #define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
>  #define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
>  #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
> -#endif
>  
>  /* OCP_SYSSTATUS bit definitions */
>  #define SYSS_RESETDONE_MASK		(1 << 0)
> @@ -508,6 +507,31 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
>  }
>  
>  /*
> + * Bus Clear
> + */
> +static int omap_i2c_bus_clear(struct omap_i2c_dev *dev)
> +{
> +	u16 w;
> +
> +	/*
> +	 * Per the I2C specification, if we are stuck in a bus busy state
> +	 * we can attempt a bus clear to try and recover the bus by sending
> +	 * at least 9 clock pulses on SCL. Put the I2C in a test mode so it
> +	 * will output a continuous clock on SCL.
> +	 */
> +	w = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG,
> +		(OMAP_I2C_SYSTEST_ST_EN | OMAP_I2C_SYSTEST_TMODE_TEST));
> +	msleep(1);
> +	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, w);
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	omap_i2c_reset(dev);
> +	omap_i2c_init(dev);
> +	return omap_i2c_wait_for_bb(dev);
> +}
> +
> +/*
>   * Low level master read/write transaction.
>   */
>  static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> @@ -632,6 +656,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  	r = omap_i2c_wait_for_bb(dev);
>  	if (r < 0)
> +		r = omap_i2c_bus_clear(dev);
> +	if (r < 0)
>  		goto out;
>  
>  	if (dev->set_mpu_wkup_lat != NULL)
