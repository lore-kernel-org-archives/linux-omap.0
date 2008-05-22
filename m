From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix compiler error at pm-debug
Date: Thu, 22 May 2008 12:50:39 -0700
Message-ID: <20080522195038.GK23002@atomide.com>
References: <20080521054330.GA5460@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60437 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYEVTug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 15:50:36 -0400
Content-Disposition: inline
In-Reply-To: <20080521054330.GA5460@party>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [080520 22:57]:
> Fix compiler error at pm-debug

Thanks, pushing today.

Tony

> 
>   CC      arch/arm/mach-omap2/pm-debug.o
> In file included from arch/arm/mach-omap2/pm-debug.c:30:
> arch/arm/mach-omap2/prm.h: In function `prm_rmw_reg_bits':
> arch/arm/mach-omap2/prm.h:107: error: implicit declaration of function `__raw_readl'
> arch/arm/mach-omap2/prm.h:110: error: implicit declaration of function `__raw_writel'
> arch/arm/mach-omap2/pm-debug.c: In function `serial_wait_tx':
> arch/arm/mach-omap2/pm-debug.c:59: error: implicit declaration of function `__raw_readb'
> make[1]: *** [arch/arm/mach-omap2/pm-debug.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 361e52b..8a9f3c4 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/io.h>
>  
>  #include <asm/arch/clock.h>
>  #include <asm/arch/board.h>
