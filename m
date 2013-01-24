From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/6] i2c: omap: also complete() when stat becomes zero
Date: Thu, 24 Jan 2013 11:05:11 +0200
Message-ID: <20130124090511.GB23053@blackmetal.musicnaut.iki.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
 <1358936588-16375-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:45648 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab3AXJFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 04:05:14 -0500
Content-Disposition: inline
In-Reply-To: <1358936588-16375-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: w.sang@pengutronix.de, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, Jan 23, 2013 at 12:23:04PM +0200, Felipe Balbi wrote:
> In case we loop on IRQ handler until stat is
> finally zero, we would end up in a situation
> where all I2C transfers would misteriously
> timeout because we were not calling complete()
> in that situation.

This is wrong, you may still have bytes to transfer,
but a new interrupt has not arrived yet.

This patch also breaks bisection; if you just apply patches 1-2 of this
series the I2C does not work at all.

> Fix the issue by moving omap_i2c_complete_cmd()
> call inside the 'out' label.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index be8c591..53985b4 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1022,9 +1022,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  		}
>  	} while (stat);
>  
> -	omap_i2c_complete_cmd(dev, err);
> -
>  out:
> +	omap_i2c_complete_cmd(dev, err);
>  	spin_unlock_irqrestore(&dev->lock, flags);
>  
>  	return IRQ_HANDLED;
> -- 
> 1.8.1.rc1.5.g7e0651a
> 
