From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Fix zoom3 defconfig build
Date: Mon, 26 Apr 2010 09:59:27 -0500
Message-ID: <4BD5AA4F.800@ti.com>
References: <1272287902-4707-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57508 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab0DZO7a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Apr 2010 10:59:30 -0400
In-Reply-To: <1272287902-4707-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Manjunatha GK had written, on 04/26/2010 08:18 AM, the following:
> The zoom3 defconfig build is broken with opp patches.
> This patch will fix the same. Build and boot tested on
> omap zoom3 board.
> 
> Build error log:
> In file included from arch/arm/plat-omap/include/plat/omap-pm.h:21,
>                  from arch/arm/mach-omap2/hsmmc.c:19:
> arch/arm/plat-omap/include/plat/opp.h: In function 'opp_find_freq_exact':
> arch/arm/plat-omap/include/plat/opp.h:255: error: implicit declaration of function 'ERR_PTR'

I think this is a valid change, though I think commit message is not 
informative enough in this case. the problem is that opp.h defines a set 
of empty access functions for use when CPUFREQ is not defined, which is 
the case you seem to be hitting. it is not restricted to zoom3 defconfig.

If you could rephrase the commit message accordingly, it would be helpful.

> 
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/include/plat/opp.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> index dc9a0d9..6b38a20 100644
> --- a/arch/arm/plat-omap/include/plat/opp.h
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -15,6 +15,7 @@
>  #define __ASM_ARM_OMAP_OPP_H
>  
>  #include <linux/cpufreq.h>
> +#include <linux/err.h>
>  
>  #ifdef CONFIG_ARCH_OMAP3
>  enum opp_t {


-- 
Regards,
Nishanth Menon
