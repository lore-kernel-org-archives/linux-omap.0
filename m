From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove duplicate omap34xx.h entry
Date: Fri, 8 Jun 2007 03:20:45 -0700
Message-ID: <20070608102044.GF28556@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C470112180E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470112180E@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070607 17:11]:
> Please apply this on top of OMAP3430 patch set.
> 
> Remove duplicate omap34xx.h from hardware.h
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files:
>  hardware.h |    1 -
>  1 files changed, 1 deletion(-)
> 
> =======================================================================
> --- linux-omap/include/asm-arm/arch-omap/hardware.h	2007-06-07 19:04:50.000000000 -0500
> +++ val_3430_GIT/include/asm-arm/arch-omap/hardware.h	2007-06-07 19:05:20.000000000 -0500
> @@ -284,7 +284,6 @@
>  #include "omap730.h"
>  #include "omap1510.h"
>  #include "omap16xx.h"
> -#include "omap34xx.h"
>  
>  #ifdef CONFIG_ARCH_OMAP24XX
>  #include "omap24xx.h"

Pushing today.

Tony
