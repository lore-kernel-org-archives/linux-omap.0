From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Thu, 17 Feb 2011 16:08:43 -0800
Message-ID: <20110218000843.GP20795@atomide.com>
References: <1297832056-28142-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18880 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab1BRAIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 19:08:49 -0500
Content-Disposition: inline
In-Reply-To: <1297832056-28142-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: ben-i2c@fluff.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Richard woodruff <r-woodruff2@ti.com>

* Keerthy <j-keerthy@ti.com> [110215 20:53]:
> From: Richard woodruff <r-woodruff2@ti.com>
> 
> This errata occurs when the ARDY interrupt generation is enabled.
> At the begining of every new transaction the ARDY interrupt is cleared.
> 
> On continuous i2c transactions where after clearing the ARDY bit from
> I2C_STAT register (clearing the interrupt), the IRQ line is reasserted and the
> I2C_STAT[ARDY] bit set again on 1. In fact, the ARDY status bit is not cleared
> at the write access to I2C_STAT[ARDY] and only the IRQ line is deasserted and
> then reasserted. This is not captured in the usual errata documents.
> 
> The workaround is to have a double clear of ARDY status in irq handler.

I'll add this to omap-testing for few days and then if no issue Ben
can merge this.

Regards,

Tony
 
> Signed-off-by: Richard woodruff <r-woodruff2@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b605ff3..5b35cf4 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -847,11 +847,15 @@ complete:
>  			dev_err(dev->dev, "Arbitration lost\n");
>  			err |= OMAP_I2C_STAT_AL;
>  		}
> +		/* 
> +		 * ProDB0017052: Clear ARDY bit twice
> +		 */ 
>  		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
>  					OMAP_I2C_STAT_AL)) {
>  			omap_i2c_ack_stat(dev, stat &
>  				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> -				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> +				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
> +				OMAP_I2C_STAT_ARDY));
>  			omap_i2c_complete_cmd(dev, err);
>  			return IRQ_HANDLED;
>  		}
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
