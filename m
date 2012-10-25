From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Thu, 25 Oct 2012 09:38:06 -0700
Message-ID: <8739124idt.fsf@deeprootsystems.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58641 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935860Ab2JYQhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 12:37:35 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1288718pad.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:37:34 -0700 (PDT)
In-Reply-To: <1351155648-20429-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Thu, 25 Oct 2012 12:00:48 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: w.sang@pengutronix.de, ben-linux@fluff.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

+Paul

Felipe Balbi <balbi@ti.com> writes:

> if we allow compiler reorder our writes, we could
> fall into a situation where dev->buf_len is reset
> for no apparent reason.

Any chance this would help with the bug Paul found with I2C timeouts on
beagle userspace startup?

Kevin

> This bug was found with a simple script which would
> transfer data to an i2c client from 1 to 1024 bytes
> (a simple for loop), when we got to transfer sizes
> bigger than the fifo size, dev->buf_len was reset
> to zero before we had an oportunity to handle XDR
> Interrupt. Because dev->buf_len was zero, we entered
> omap_i2c_transmit_data() to transfer zero bytes,
> which would mean we would just silently exit
> omap_i2c_transmit_data() without actually writing
> anything to DATA register. That would cause XDR
> IRQ to trigger forever and we would never transfer
> the remaining bytes.
>
> After adding the memory barrier, we also drop resetting
> dev->buf_len to zero in omap_i2c_xfer_msg() because
> both omap_i2c_transmit_data() and omap_i2c_receive_data()
> will act until dev->buf_len reaches zero, rendering the
> other write in omap_i2c_xfer_msg() redundant.
>
> This patch has been tested with pandaboard for a few
> iterations of the script mentioned above.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> This bug has been there forever, but it's quite annoying.
> I think it deserves being pushed upstream during this -rc
> cycle, but if Wolfram decides to wait until v3.8, I don't
> mind.
>
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..1ec4e6e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -521,6 +521,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
>  	dev->buf = msg->buf;
>  	dev->buf_len = msg->len;
> +	wmb();
>  
>  	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
>  
> @@ -579,7 +580,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	 */
>  	timeout = wait_for_completion_timeout(&dev->cmd_complete,
>  						OMAP_I2C_TIMEOUT);
> -	dev->buf_len = 0;
>  	if (timeout == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		omap_i2c_init(dev);
