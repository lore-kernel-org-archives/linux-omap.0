From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Tue, 11 Nov 2008 15:27:01 +0530
Message-ID: <024701c943e3$d8f28760$LocalHost@wipultra806>
References: <1226386315303-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52264 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755896AbYKKJ5P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 04:57:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>


----- Original Message ----- 
From: <ext-eero.nurkkala@nokia.com>
To: <linux-omap@vger.kernel.org>
Cc: "Eero Nurkkala" <ext-eero.nurkkala@nokia.com>
Sent: Tuesday, November 11, 2008 12:21 PM
Subject: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading


> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> The amount of bytes to receive is read from wrong
> place. It is the 6 bits starting from the bit 8 from
> BUFSTAT_REG that indicate this amount. Not the 8 LSB:s.
> 6 LSB:s are used for the TX buffer.
> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
> drivers/i2c/busses/i2c-omap.c |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a999606..f15668d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -621,8 +621,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  if (stat & OMAP_I2C_STAT_RRDY)
>  num_bytes = dev->fifo_size;
>  else
> - num_bytes = omap_i2c_read_reg(dev,
> - OMAP_I2C_BUFSTAT_REG);
> + num_bytes = (omap_i2c_read_reg(dev,
> + OMAP_I2C_BUFSTAT_REG)
> + >> 8) & 0x3F;
>  }

I believe "And"ing by 0x3F will apply to transmit also.

>  while (num_bytes) {
>  num_bytes--;
> -- 
> 1.6.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
