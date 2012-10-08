From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: remove duplicated include from
 board-omap3stalker.c
Date: Mon, 8 Oct 2012 15:01:00 -0700
Message-ID: <20121008220059.GW13011@atomide.com>
References: <CAPgLHd-DH3T=WxZqSBF0hHAsJbqC2Kw0K-+R9GLT8dtKsFfYjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55949 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751963Ab2JHWBF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 18:01:05 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd-DH3T=WxZqSBF0hHAsJbqC2Kw0K-+R9GLT8dtKsFfYjA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [121007 06:26]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.

Thanks applying into omap fixes.

Tony
 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/board-omap3stalker.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
> index c7f3d02..731235e 100644
> --- a/arch/arm/mach-omap2/board-omap3stalker.c
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -48,11 +48,6 @@
>  #include <video/omap-panel-tfp410.h>
>  
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> -#include <linux/input/matrix_keypad.h>
> -#include <linux/spi/spi.h>
> -#include <linux/interrupt.h>
> -#include <linux/smsc911x.h>
> -#include <linux/i2c/at24.h>
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "mux.h"
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
