From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH 2/8] i2c: omap: reorder exit path of omap_i2c_xfer_msg()
Date: Thu, 25 Oct 2012 17:10:10 +0530
Message-ID: <CAM=Q2cvUeLbS20HScrGTOcraSUrCzhzCi8MQLxd9MOb_7ZFFYA@mail.gmail.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
	<1350899218-13624-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:57185 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab2JYLkM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 07:40:12 -0400
In-Reply-To: <1350899218-13624-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, Oct 22, 2012 at 3:16 PM, Felipe Balbi <balbi@ti.com> wrote:
> just a cleanup patch trying to make exit path
> more straightforward. No changes otherwise.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index c07d9c4..bea0277 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -505,6 +505,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  {
>         struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
>         unsigned long timeout;
> +       int ret;
>         u16 w;
>
>         dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
> @@ -582,31 +583,38 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>         dev->buf_len = 0;
>         if (timeout == 0) {
>                 dev_err(dev->dev, "controller timed out\n");
> -               omap_i2c_init(dev);
> -               return -ETIMEDOUT;
> +               ret = -ETIMEDOUT;
> +               goto err_i2c_init;
>         }
>
> -       if (likely(!dev->cmd_err))
> -               return 0;
> -
>         /* We have an error */
>         if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>                             OMAP_I2C_STAT_XUDF)) {
> -               omap_i2c_init(dev);
> -               return -EIO;
> +               ret = -EIO;
> +               goto err_i2c_init;
>         }
>
>         if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
>                 if (msg->flags & I2C_M_IGNORE_NAK)
>                         return 0;
> +
>                 if (stop) {
>                         w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
>                         w |= OMAP_I2C_CON_STP;
>                         omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
>                 }
> -               return -EREMOTEIO;
> +
> +               ret = -EREMOTEIO;
> +               goto err;

This adds reset to nack may be that can be removed.


>         }
> -       return -EIO;
> +
> +       return 0;
> +
> +err_i2c_init:
> +       omap_i2c_init(dev);
> +
> +err:
> +       return ret;
>  }
>
>
> --
> 1.8.0.rc0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
