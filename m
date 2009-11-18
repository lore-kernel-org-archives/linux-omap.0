From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 1/3] omap: fix unlikely(x) < y
Date: Wed, 18 Nov 2009 10:36:39 -0800
Message-ID: <20091118183639.GN29266@atomide.com>
References: <200911172239.nAHMd32K018260@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60321 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932210AbZKRSgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 13:36:52 -0500
Content-Disposition: inline
In-Reply-To: <200911172239.nAHMd32K018260@imap1.linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: akpm@linux-foundation.org
Cc: rmk@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, roel.kluin@gmail.com, linux-omap@vger.kernel.org

* akpm@linux-foundation.org <akpm@linux-foundation.org> [091117 14:39]:
> From: Roel Kluin <roel.kluin@gmail.com>
> 
> The closing parenthesis was not in the right location.

I've added this to omap-fixes and will send to Linus today
along with few other fixes.

Andrew & Russell, please let me know if you have this
already queued for Linus, and I'll drop it from my queue.

Regards,

Tony

 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/arm/plat-omap/gpio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/arm/plat-omap/gpio.c~omap-fix-unlikelyx-y arch/arm/plat-omap/gpio.c
> --- a/arch/arm/plat-omap/gpio.c~omap-fix-unlikelyx-y
> +++ a/arch/arm/plat-omap/gpio.c
> @@ -391,7 +391,7 @@ static inline int gpio_valid(int gpio)
>  
>  static int check_gpio(int gpio)
>  {
> -	if (unlikely(gpio_valid(gpio)) < 0) {
> +	if (unlikely(gpio_valid(gpio) < 0)) {
>  		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
>  		dump_stack();
>  		return -1;
> _
