From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: CPUidle: include <linux/export.h>
Date: Mon, 7 Nov 2011 16:12:15 -0800
Message-ID: <20111108001214.GE31337@atomide.com>
References: <1320710320-8279-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47158 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816Ab1KHAMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 19:12:18 -0500
Content-Disposition: inline
In-Reply-To: <1320710320-8279-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [111107 15:23]:
> The CPUidle use THIS_MODULE, so needs <linux/export.h>
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, one more for omap/fixes.   This one applies to Linus' master branch,
> but also applies to your current omap/fixes.

Thanks, applying into fixes. Looks like I did not grep for THIS_MODULE..

Tony
 
>  arch/arm/mach-omap2/cpuidle34xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4bf6e6e..2e0fa5a 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/cpuidle.h>
> +#include <linux/export.h>
>  
>  #include <plat/prcm.h>
>  #include <plat/irqs.h>
> -- 
> 1.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
