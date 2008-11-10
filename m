From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Mon, 10 Nov 2008 14:27:05 +0200
Message-ID: <20081110122705.GP7467@gandalf.research.nokia.com>
References: <12263140092601-git-send-email-ext-eero.nurkkala@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52827 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYKJM1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 07:27:19 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAACQqqP024814
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 14:27:17 +0200
Content-Disposition: inline
In-Reply-To: <12263140092601-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, Nov 10, 2008 at 12:46:49PM +0200, ext ext-eero.nurkkala@nokia.com wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 

you need to put a patch description here. Ditto to other patches.

> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f4d1edc..9ae3ad3 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -642,8 +642,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				if (stat & OMAP_I2C_STAT_RRDY)
>  					num_bytes = dev->fifo_size;
>  				else
> -					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG);
> +					num_bytes = (omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG)
> +							>> 8) & 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
> -- 
> 1.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
