From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Add local timer support for Device Tree
Date: Mon, 9 Jul 2012 06:15:49 -0700
Message-ID: <20120709131549.GI1122@atomide.com>
References: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
 <1341839470-5586-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19322 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab2GINPw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 09:15:52 -0400
Content-Disposition: inline
In-Reply-To: <1341839470-5586-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120709 06:16]:
> Add cortex-a9 local timer  support for all OMAP4 based
> SOCs using DT.
...

> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -36,6 +36,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include <asm/mach/time.h>
>  #include <plat/dmtimer.h>
> @@ -384,9 +385,13 @@ static void __init omap4_timer_init(void)
>  	if (omap_rev() != OMAP4430_REV_ES1_0) {
>  		int err;
>  
> -		err = twd_local_timer_register(&twd_local_timer);
> -		if (err)
> -			pr_err("twd_local_timer_register failed %d\n", err);
> +		if (of_have_populated_dt()) {
> +			twd_local_timer_of_register();
> +		} else {
> +			err = twd_local_timer_register(&twd_local_timer);
> +			if (err)
> +				pr_err("twd_local_timer_register failed %d\n", err);
> +		}
>  	}
>  #endif
>  }

How about just return after twd_local_timer_of_register() instead?
That avoids nesting the code further.

Tony
