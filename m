From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM PATCH] OMAP3: PM: Save and restore I2C wakeup sources
Date: Mon, 20 Apr 2009 16:15:32 -0700
Message-ID: <87d4b6apd7.fsf@deeprootsystems.com>
References: <1237988300-25985-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:28109 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbZDTXPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 19:15:36 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2078447wff.4
        for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 16:15:35 -0700 (PDT)
In-Reply-To: <1237988300-25985-1-git-send-email-aaro.koskinen@nokia.com> (Aaro Koskinen's message of "Wed\, 25 Mar 2009 15\:38\:20 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Save and restore I2C wakeup sources.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Sorry for the delay, this one slipped through the cracks.
Pushing to PM branch.

Kevin

> ---
>  drivers/i2c/busses/i2c-omap.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 50f3285..5ce055c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -183,6 +183,7 @@ struct omap_i2c_dev {
>  	u16			sclhstate;
>  	u16			bufstate;
>  	u16			syscstate;
> +	u16			westate;
>  };
>  
>  static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
> @@ -242,6 +243,7 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
>  		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
> +		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
>  	}
>  	dev->idle = 0;
>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> @@ -316,8 +318,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			 * WFI instruction.
>  			 * REVISIT: Some wkup sources might not be needed.
>  			 */
> -			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> -							OMAP_I2C_WE_ALL);
> +			dev->westate = OMAP_I2C_WE_ALL;
> +			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
>  
>  		}
>  	}
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
