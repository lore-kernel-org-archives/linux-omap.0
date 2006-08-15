From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] ARM: OMAP: Add Amstrad Delta platform bits for
	framebuffer.
Date: Tue, 15 Aug 2006 09:54:35 +0200
Message-ID: <20060815075435.GA5426@orphique>
References: <20060814183119.GN27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060814183119.GN27094@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 14, 2006 at 07:31:19PM +0100, Jonathan McDowell wrote:
> This patch adds the platform file components for the Amstrad Delta LCD
> framebuffer. I have confirmed it works with latest git. The patch to
> clock.c /is/ needed for this to work.
> 
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
[snip]
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index cc08775..70a5d50 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -20,6 +20,7 @@ #include <linux/err.h>
>  #include <linux/clk.h>
>  
>  #include <asm/io.h>
> +#include <asm/mach-types.h>
>  
>  #include <asm/arch/cpu.h>
>  #include <asm/arch/usb.h>
> @@ -756,6 +757,14 @@ #if defined(CONFIG_MACH_OMAP_PERSEUS2) |
>  	omap_writew(omap_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
>  #endif
>  
> +#ifdef CONFIG_MACH_AMS_DELTA
> +	/* Amstrad Delta wants BCLK high when inactive */
> +	if (machine_is_ams_delta())
> +		omap_writel(omap_readl(ULPD_CLOCK_CTRL) |
> +				(1 << SDW_MCLK_INV_BIT),
> +				ULPD_CLOCK_CTRL);
> +#endif

This #ifdef is not necessary. machine_is_ams_delta() will expand to (0)
when CONFIG_MACH_AMS_DELTA not selected and that if (0) will be
optimized away.

>  	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
>  	/* (on 730, bit 13 must not be cleared) */
>  	if (cpu_is_omap730())


Best regards,
	ladis
