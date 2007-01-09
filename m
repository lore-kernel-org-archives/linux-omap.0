From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add missing includes to board-nokia770
Date: Tue, 9 Jan 2007 15:20:11 -0800
Message-ID: <20070109232011.GI7384@atomide.com>
References: <459D27D7.8060508@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459D27D7.8060508@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070104 08:15]:
> 
> ARM: OMAP: Add missing includes to board-nokia770 to make it
> compile again.
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/arch/arm/mach-omap1/board-nokia770.c
> ===================================================================
> --- linux-osk.orig/arch/arm/mach-omap1/board-nokia770.c
> +++ linux-osk/arch/arm/mach-omap1/board-nokia770.c
> @@ -16,6 +16,8 @@
>  
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/workqueue.h>
> +#include <linux/delay.h>
>  
>  #include <asm/hardware.h>
>  #include <asm/mach-types.h>
> 

Pushing today.

Tony
