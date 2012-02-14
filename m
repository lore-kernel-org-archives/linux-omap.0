From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3.3 v2] OMAP4: PRM: fix build breakage when CONFIG_OF
 is not defined
Date: Tue, 14 Feb 2012 12:38:01 -0800
Message-ID: <20120214203801.GU1426@atomide.com>
References: <1328699683-19357-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328699683-19357-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Luciano Coelho <coelho@ti.com> [120208 02:43]:
> Since 3.3-rc1, prm44xx.c build breaks if CONFIG_OF is not set:
> 
> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/prm44xx.o] Error 1
> 
> This is because of a missing include, which is added indirectly if
> CONFIG_OF is defined.  This problem was introduced in commit
> 2f31b51 (ARM: OMAP4: PRM: use PRCM interrupt handler).
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>

A similar patch should be already in mainline kernel queued by Russell.

Tony

> ---
> v2: changed the commit log to use abbrev sha and include the commit subject
> 
>  arch/arm/mach-omap2/prm44xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index 33dd655..f2e06ad 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -20,6 +20,7 @@
>  #include "common.h"
>  #include <plat/cpu.h>
>  #include <plat/prcm.h>
> +#include <plat/irqs.h>
>  
>  #include "vp.h"
>  #include "prm44xx.h"
> -- 
> 1.7.5.4
> 
