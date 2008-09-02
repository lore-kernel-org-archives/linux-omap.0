From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC: 2.6 patch] fix arch/arm/plat-omap/gpio.c compilation
Date: Tue, 2 Sep 2008 15:48:00 -0700
Message-ID: <20080902224759.GK23085@atomide.com>
References: <20080829092321.GG16462@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55980 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYIBWsY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:48:24 -0400
Content-Disposition: inline
In-Reply-To: <20080829092321.GG16462@cs181140183.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Adrian Bunk <bunk@kernel.org> [080829 02:24]:
> This patch fixes the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/arm/plat-omap/gpio.o
> ...
> arch/arm/plat-omap/gpio.c: In function '_omap_gpio_init':
> arch/arm/plat-omap/gpio.c:1492: error: 'omap_mpuio_device' undeclared (first use in this function)
> arch/arm/plat-omap/gpio.c:1492: error: (Each undeclared identifier is reported only once
> arch/arm/plat-omap/gpio.c:1492: error: for each function it appears in.)
> make[2]: *** [arch/arm/plat-omap/gpio.o] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 3e76ee2..9e1341e 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1488,7 +1488,7 @@ static int __init _omap_gpio_init(void)
>  		bank->chip.set = gpio_set;
>  		if (bank_is_mpuio(bank)) {
>  			bank->chip.label = "mpuio";
> -#ifdef CONFIG_ARCH_OMAP1
> +#ifdef CONFIG_ARCH_OMAP16XX
>  			bank->chip.dev = &omap_mpuio_device.dev;
>  #endif
>  			bank->chip.base = OMAP_MPUIO(0);
> 

Looks like a proper fix. BTW, this same fix is already in a patch from
Russell.

Tony
