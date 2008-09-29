From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 1/8] i2c-omap: Do not use interruptible wait call
	in omap_i2c_xfer_msg
Date: Mon, 29 Sep 2008 23:21:00 +0100
Message-ID: <20080929222100.GN2716@fluff.org.uk>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:49767 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751786AbYI2WVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 18:21:24 -0400
Content-Disposition: inline
In-Reply-To: <1222329234-31473-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: i2c@lm-sensors.org, Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

On Thu, Sep 25, 2008 at 10:53:47AM +0300, Tony Lindgren wrote:
> From: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> If there is a signal pending and wait_for_completion_interruptible_timeout
> terminates with -ERESTARTSYS, we return and disable the i2c clocks in
> omap_i2c_xfer.
> 
> If we terminate before sending last i2c message with a stop condition, the
> bus remains busy and we are not able to send new messages into bus with
> successive omap_i2c_xfer calls. Therefore a pending signal is not caught
> here and we return only because of timeout or i2c error.

I assume that this is preferable to aborting an transfer when the
signal is caught (if possible) ?
 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index e7eb7bf..cfb76f5 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -328,8 +328,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  		w |= OMAP_I2C_CON_STP;
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
>  
> -	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
> -						      OMAP_I2C_TIMEOUT);
> +	r = wait_for_completion_timeout(&dev->cmd_complete,
> +					OMAP_I2C_TIMEOUT);
>  	dev->buf_len = 0;
>  	if (r < 0)
>  		return r;
> -- 
> 1.5.6.rc3.21.g8c6b5
> 
> 
> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
