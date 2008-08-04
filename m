From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PROTECT_KEY register is in the PM_MASTER module not in
	the PM_RECEIVER module
Date: Mon, 4 Aug 2008 10:50:29 +0300
Message-ID: <20080804075028.GA8885@atomide.com>
References: <20080716165325.GA4424@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64745 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYHDHud (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 03:50:33 -0400
Content-Disposition: inline
In-Reply-To: <20080716165325.GA4424@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080716 19:53]:
> This patch fixes a write to the wrong address in the triton2 chip.

Pushing today.

Tony


> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-usb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
> index ab335ca..20858b5 100644
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -586,7 +586,7 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
>  	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
>  
>  	/* disable access to power configuration registers */
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, PROTECT_KEY);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, PROTECT_KEY);
>  }
>  
>  static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
> -- 
> 1.5.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
