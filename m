From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix clk_get_usecount() warning
Date: Fri, 20 Jan 2006 11:01:55 -0800
Message-ID: <20060120190154.GE4431@atomide.com>
References: <43CD3B18.1010803@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CD3B18.1010803@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [060117 10:50]:
> 
> ARM: OMAP: Fix warning about missing clk_get_usecount() declaration
> 
> arch/arm/plat-omap/clock.c exports clk_get_usecount(), but linux/clk.h
> doesn't contain the prototype for it. Add it to asm/arch/clock.h and add
> clock.h to omap-audio-aic23.c.
> 
> sound/oss/omap-audio-aic23.c: In function `audio_aic23_init':
> sound/oss/omap-audio-aic23.c:680: warning: implicit declaration of
> function `clk_get_usecount'
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>
> 
> 

> --- ./include/asm-arm/arch-omap/clock.h_orig	2006-01-17 18:52:15.414780616 +0100
> +++ ./include/asm-arm/arch-omap/clock.h	2006-01-17 19:10:53.619787616 +0100
> @@ -57,6 +57,7 @@ extern void propagate_rate(struct clk *c
>  extern void followparent_recalc(struct clk * clk);
>  extern void clk_allow_idle(struct clk *clk);
>  extern void clk_deny_idle(struct clk *clk);
> +extern int clk_get_usecount(struct clk *clk);
>  
>  /* Clock flags */
>  #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
> --- ./sound/oss/omap-audio-aic23.c_orig	2006-01-17 18:40:00.000000000 +0100
> +++ ./sound/oss/omap-audio-aic23.c	2006-01-17 18:56:08.970274784 +0100
> @@ -47,6 +47,7 @@
>  #include <asm/arch/mcbsp.h>
>  #include <asm/arch/fpga.h>
>  #include <asm/arch/aic23.h>
> +#include <asm/arch/clock.h>
>  
>  #include "omap-audio.h"
>  #include "omap-audio-dma-intfc.h"

Thanks, pushing today.

Tony
