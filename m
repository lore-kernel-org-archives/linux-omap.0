From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add missing include to dsp/mblog.c
Date: Tue, 9 Jan 2007 15:21:51 -0800
Message-ID: <20070109232150.GJ7384@atomide.com>
References: <459D285A.7080009@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459D285A.7080009@googlemail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [070104 08:17]:
> 
> ARM: OMAP: Add missing include to dsp/mblog.c to make it
> compile again.
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/arch/arm/plat-omap/dsp/mblog.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dsp/mblog.c
> +++ linux-osk/arch/arm/plat-omap/dsp/mblog.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/init.h>
> +#include <linux/jiffies.h>
>  #include <asm/arch/mailbox.h>
>  #include "dsp_mbcmd.h"
>  #include "dsp.h"
> 

Pushing today.

Tony
