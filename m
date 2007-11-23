From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Moving TWL id for i2c in board files
Date: Fri, 23 Nov 2007 13:20:18 -0800
Message-ID: <20071123212018.GI559@atomide.com>
References: <47153419.2030609@indt.org.br>
	<200711211506.lALF6e2t025107@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200711211506.lALF6e2t025107@dbdp31.itg.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Chandra shekhar <x0044955@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Chandra shekhar <x0044955@ti.com> [071121 07:07]:
> This patch moves the the adapter number from twl core file to board files. 
> 
> Signed-off-by: chandra shekhar <x0044955@ti.com>
> ---
>  drivers/i2c/chips/twl4030_core.c |    2 --
>  include/asm/arch/board-2430sdp.h |    3 +++
>  include/asm/arch/board-3430sdp.h |    2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> Index: linux-git-anand-19NOV/drivers/i2c/chips/twl4030_core.c
> ===================================================================
> --- linux-git-anand-19NOV.orig/drivers/i2c/chips/twl4030_core.c	2007-11-18 23:30:05.000000000 -0500
> +++ linux-git-anand-19NOV/drivers/i2c/chips/twl4030_core.c	2007-11-21 11:49:56.219607432 -0500
> @@ -131,8 +131,6 @@
>  #define HFCLK_FREQ_38p4_MHZ		(3 << 0)
>  #define HIGH_PERF_SQ			(1 << 3)
>  
> -/* on I2C-1 for 2430SDP */
> -#define CONFIG_I2C_TWL4030_ID		1
>  
>  /**** Helper functions */
>  static int
> Index: linux-git-anand-19NOV/include/asm/arch/board-2430sdp.h
> ===================================================================
> --- linux-git-anand-19NOV.orig/include/asm/arch/board-2430sdp.h	2007-11-18 23:31:52.000000000 -0500
> +++ linux-git-anand-19NOV/include/asm/arch/board-2430sdp.h	2007-11-21 11:49:25.828227624 -0500
> @@ -34,6 +34,9 @@
>  #define OMAP24XX_ETHR_GPIO_IRQ		149
>  #define SDP2430_CS0_BASE		0x04000000
>  
> +/* on I2C-2 for 2430SDP */
> +#define CONFIG_I2C_TWL4030_ID		2
> +
>  #define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
>  
>  /* TWL4030 Primary Interrupt Handler (PIH) interrupts */
> Index: linux-git-anand-19NOV/include/asm/arch/board-3430sdp.h
> ===================================================================
> --- linux-git-anand-19NOV.orig/include/asm/arch/board-3430sdp.h	2007-11-18 23:31:52.000000000 -0500
> +++ linux-git-anand-19NOV/include/asm/arch/board-3430sdp.h	2007-11-21 11:49:41.887786200 -0500
> @@ -61,6 +61,8 @@
>  #define ONENAND_MAP	0x20000000  /* OneNand flash */
>  
>  #ifdef CONFIG_TWL4030_CORE
> +/* on I2C-1 for 3430SDP */
> +#define CONFIG_I2C_TWL4030_ID           1
>  
>  #define TWL4030_IRQNUM INT_34XX_SYS_NIRQ

This will again break any chance of compiling in support for multiple
omap2 and omap3 boards. Could you please update this to get the ID
configuration from board-*.c files? See how tps65010 handles it
for example.

Regards,

Tony
