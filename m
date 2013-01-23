From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 5/6] i2c: omap: wait for transfer completion before
 sending STP bit
Date: Wed, 23 Jan 2013 22:10:31 +0200
Message-ID: <20130123201031.GF23057@blackmetal.musicnaut.iki.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
 <1358936588-16375-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:34240 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3AWUKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 15:10:34 -0500
Content-Disposition: inline
In-Reply-To: <1358936588-16375-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: w.sang@pengutronix.de, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

Some minor comments/questions:

On Wed, Jan 23, 2013 at 12:23:07PM +0200, Felipe Balbi wrote:
> @@ -639,31 +630,37 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  		dev_err(dev->dev, "controller timed out\n");
>  		omap_i2c_reset(dev);
>  		__omap_i2c_init(dev);
> -		return -ETIMEDOUT;
> +		ret = -ETIMEDOUT;
> +		goto out;
>  	}
>  
> -	if (likely(!dev->cmd_err))
> -		return 0;
> -
>  	/* We have an error */
>  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>  			    OMAP_I2C_STAT_XUDF)) {
>  		omap_i2c_reset(dev);
>  		__omap_i2c_init(dev);
> -		return -EIO;
> +		ret = -EIO;
> +		goto out;

Why change return to goto on these paths? If you reset and re-initialize
the controller, I think it's unlikely that omap_i2c_wait_for_ardy()
will ever succeed?

A.
