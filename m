From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix build issues with missing include of
 linux/bug.h
Date: Wed, 7 Mar 2012 16:45:59 -0800
Message-ID: <20120308004559.GN12083@atomide.com>
References: <20120307213209.GI12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41909 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab2CHAqC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 19:46:02 -0500
Content-Disposition: inline
In-Reply-To: <20120307213209.GI12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120307 13:04]:
> 
> Looks like this is needed for some .config files with
> current for-next

This is because of next/master commit 6c03438ed (kernel.h: doesn't
explicitly use bug.h, so don't include it). Will update the commit
message to say:

Otherwise we can get the following if bug.h is not included from kernel.h:

> arch/arm/mach-omap2/powerdomain-common.c:
> In function 'omap2_pwrdm_get_mem_bank_onstate_mask':
> arch/arm/mach-omap2/powerdomain-common.c:64:3: error:
> implicit declaration of function 'WARN_ON' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

 
> --- a/arch/arm/mach-omap2/clkt_clksel.c
> +++ b/arch/arm/mach-omap2/clkt_clksel.c
> @@ -43,6 +43,7 @@
>  #include <linux/errno.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/bug.h>
>  
>  #include <plat/clock.h>
>  
> --- a/arch/arm/mach-omap2/powerdomain-common.c
> +++ b/arch/arm/mach-omap2/powerdomain-common.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> +#include <linux/bug.h>
>  #include "pm.h"
>  #include "cm.h"
>  #include "cm-regbits-34xx.h"
> --- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> +#include <linux/bug.h>
>  
>  #include <plat/prcm.h>
>  
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/bug.h>
>  
>  #include <plat/cpu.h>
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
