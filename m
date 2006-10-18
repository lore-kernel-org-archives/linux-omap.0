From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix apollon boot
Date: Wed, 18 Oct 2006 22:36:15 +0300
Message-ID: <20061018193613.GE4669@atomide.com>
References: <000801c6ed07$dd1172a0$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <000801c6ed07$dd1172a0$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [061011 10:37]:
> In previous GPMC patch, there was a typo. Fix typo and add header files for
> set_irq_type() warnings.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> --
> 
> diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
> omap2/board-apollon.c
> index 5d455d4..99651b2 100644
> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -25,6 +25,7 @@ #include <linux/mtd/onenand.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/leds.h>
> +#include <linux/irq.h>
>  
>  #include <asm/hardware.h>
>  #include <asm/mach-types.h>
> @@ -199,7 +200,7 @@ static inline void __init apollon_init_s
>  		return;
>  	}
>  	apollon_smc91x_resources[0].start = base + 0x300;
> -	apollon_smc91x_resources[1].end   = base + 0x30f;
> +	apollon_smc91x_resources[0].end   = base + 0x30f;
>  	udelay(100);
>  
>  	omap_cfg_reg(W4__24XX_GPIO74);
> 

Pushing today.

Tony
