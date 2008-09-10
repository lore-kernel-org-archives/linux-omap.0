From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix occasional i2c driver hang
Date: Wed, 10 Sep 2008 16:42:47 -0700
Message-ID: <20080910234246.GR21163@atomide.com>
References: <423644ca0808281230g1f8c20ceta4a6822098d4e431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51931 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbYIJXms (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 19:42:48 -0400
Content-Disposition: inline
In-Reply-To: <423644ca0808281230g1f8c20ceta4a6822098d4e431@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Marini <jason.marini@gmail.com>
Cc: linux-omap@vger.kernel.org

* Jason Marini <jason.marini@gmail.com> [080828 12:31]:
> The i2c driver contains a while loop that has no timeout.  If i2c is in a
> funky state and OMAP_I2C_CON_STT remains asserted, the kernel hangs.  Insert
> the standard i2c timeout into the loop.

Pushing today.

Tony


> Signed-off-by: Jason P Marini <jason.marini@gmail.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 3c4e581..3a7b6ef 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -440,9 +440,16 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> 
>  	if (dev->b_hw && stop) {
> +		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
> +
>  		/* H/w behavior: dont write stt and stp together.. */
>  		while (omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) & OMAP_I2C_CON_STT) {
> -			/* Dont do anything - this will come in a couple of loops at max*/
> +			/* Let the user know if i2c is in a bad state */
> +			if (time_after (jiffies, delay)) {
> +				dev_err(dev->dev, "controller timed out "
> +				"waiting for start condition to finish\n");
> +				return -ETIMEDOUT;
> +			}
>  		}
>  		w |= OMAP_I2C_CON_STP;
>  		w &= ~OMAP_I2C_CON_STT;
> -- 
> 1.5.5.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
