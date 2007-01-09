From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix missing workqueue include in board-h2.c
Date: Tue, 9 Jan 2007 15:14:50 -0800
Message-ID: <20070109231449.GF7384@atomide.com>
References: <459D1D81.4020308@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459D1D81.4020308@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070104 07:31]:
> 
> ARM: OMAP: Fix missing #include <linux/workqueue.h> in
> board-h2.c resulting in
> 
> In file included from arch/arm/mach-omap1/board-h2.c:40:
> include/asm/arch/irda.h:27: error: field 'gpio_expa' has
> incomplete type
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

> Index: linux-osk/arch/arm/mach-omap1/board-h2.c
> ===================================================================
> --- linux-osk.orig/arch/arm/mach-omap1/board-h2.c
> +++ linux-osk/arch/arm/mach-omap1/board-h2.c
> @@ -27,6 +27,7 @@
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/input.h>
> +#include <linux/workqueue.h>
>  
>  #include <asm/hardware.h>
>  #include <asm/mach-types.h>
> 

Pushing today.

Tony
