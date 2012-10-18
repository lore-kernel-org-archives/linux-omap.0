From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/NOT FOR MERGING 4/5] i2c: omap: don't re-enable IRQs after masking them
Date: Thu, 18 Oct 2012 10:10:06 -0700
Message-ID: <874nlrg101.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
	<1350488043-5053-5-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:46691 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab2JRRJv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 13:09:51 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so3571774dak.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 10:09:51 -0700 (PDT)
In-Reply-To: <1350488043-5053-5-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Wed, 17 Oct 2012 18:34:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> OMAP I2C driver will re-enable IRQs right after
> masking them during suspend.
>
> That's not what we want. We want to keep IRQs
> masked until our resume method is called.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..7eeae11 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1247,14 +1247,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>  
>  	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
>  
> -	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
> -		iv = omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
> -	} else {
> -		omap_i2c_write_reg(_dev, OMAP_I2C_STAT_REG, _dev->iestate);
> -
> -		/* Flush posted write */
> -		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
> -	}

Are you sure this re-enables the interrupt?  It looks to me like
it's meant to clear the interrupt.    

> +	/* Flush posted write */
> +	omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);

Assuming the above is correct, should this be IE_REG?

>  	return 0;
>  }

Kevin
