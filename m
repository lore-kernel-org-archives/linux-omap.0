From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] twl4030-gpio: Remove default pullup enable/disable of GPIO
Date: Thu, 25 Sep 2008 10:20:50 -0700
Message-ID: <200809251020.51152.david-b@pacbell.net>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028BF72A8E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:21371 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752757AbYIYRUy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 13:20:54 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028BF72A8E@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Ghongadematt, Girish" <girishsg@ti.com>

On Thursday 25 September 2008, Pakaravoor, Jagadeesh wrote:
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> One twl4030_request_gpio() should not tamper with the pullup
> enabling/disabling of the rest of the GPIOs. So removing the default
> pullup values written to REG_GPIOPUPDCTR1.
> 
> Signed-off-by: Girish S G <girishsg@ti.com>
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Now I can remove this from my own GPIO cleanups.  ;)

I was wondering why this code existed in the first
place ... at *best* it makes sense when initializing
the TWL4030.  But some boards may need to use some
of those pullups; others, not.

For that matter ... why does the hsmmc init glue always
enable pullups on the card detect signals?  Are there
boards which don't actually have external pullups there?
It's fairly conventional that all MMC/SD signals have
an external pullup.  (Except maybe DAT4..DAT7 for MMC+.)

Need for such a pullup should be in board-specific init
data, for boards which need it.

- Dave



> ---
> Index: linux-omap-git/drivers/i2c/chips/twl4030-gpio.c
> ===================================================================
> --- linux-omap-git.orig/drivers/i2c/chips/twl4030-gpio.c	2008-09-25 17:30:27.000000000 +0530
> +++ linux-omap-git/drivers/i2c/chips/twl4030-gpio.c	2008-09-25 18:43:08.932257869 +0530
> @@ -301,7 +301,6 @@ int twl4030_request_gpio(int gpio)
>  	if (gpio_usage_count & (0x1 << gpio))
>  		ret = -EBUSY;
>  	else {
> -		u8 clear_pull[6] = { 0, 0, 0, 0, 0, 0 };
>  		/* First time usage? - switch on GPIO module */
>  		if (!gpio_usage_count) {
>  			ret =
> @@ -311,10 +310,6 @@ int twl4030_request_gpio(int gpio)
>  		}
>  		if (!ret)
>  			gpio_usage_count |= (0x1 << gpio);
> -
> -		ret =
> -		twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
> -				REG_GPIOPUPDCTR1, 5);
>  	}
>  	up(&gpio_sem);
>  	return ret;
> 
> --
> With Regards,
> Jagadeesh Bhaskar P
>  
> ----------------------------
> Some men see things as they are and say why - I dream things that never were and say why not.
> - George Bernard Shaw
> -------------------
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


