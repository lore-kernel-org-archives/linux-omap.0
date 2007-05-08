From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix warning mach-omap2/pm.c
Date: Mon, 7 May 2007 17:16:55 -0700
Message-ID: <20070508001654.GE31968@atomide.com>
References: <463C38BD.4030208@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <463C38BD.4030208@googlemail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [070505 00:57]:
> 
> Fix warning
> 
> arch/arm/mach-omap2/pm.c: In function 'omap2_enter_full_retention':
> arch/arm/mach-omap2/pm.c:504: warning: implicit declaration of
> function 'omap2_gpio_prepare_for_retention'
> arch/arm/mach-omap2/pm.c:531: warning: implicit declaration of
> function 'omap2_gpio_resume_after_retention'
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 

> Index: linux-osk/arch/arm/mach-omap2/pm.c
> ===================================================================
> --- linux-osk.orig/arch/arm/mach-omap2/pm.c
> +++ linux-osk/arch/arm/mach-omap2/pm.c
> @@ -44,6 +44,7 @@
>  #include <asm/arch/mux.h>
>  #include <asm/arch/dma.h>
>  #include <asm/arch/board.h>
> +#include <asm/arch/gpio.h>
>  
>  #define PRCM_REVISION		0x000
>  #define PRCM_SYSCONFIG		0x010
> 

Thanks, pushing today.

Tony
