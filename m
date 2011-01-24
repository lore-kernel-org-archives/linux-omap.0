From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH] OMAP2+: remove unused UART base addresses from
 omap_globals
Date: Mon, 24 Jan 2011 12:11:54 +0530
Message-ID: <20110124064154.GA16582@m-desktop>
References: <1295649015-26348-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49251 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751995Ab1AXGm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 01:42:56 -0500
Received: by mail-yw0-f53.google.com with SMTP id 6so1518385ywa.26
        for <linux-omap@vger.kernel.org>; Sun, 23 Jan 2011 22:42:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295649015-26348-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin, 
How about folding below changes into your patch since the UART dma irq
numbers are getting assigned from hwmod database.

-Manjunath

diff --git a/arch/arm/plat-omap/include/plat/dma-44xx.h
b/arch/arm/plat-omap/include/plat/dma-44xx.h
index 1f767cb..129d147 100644
--- a/arch/arm/plat-omap/include/plat/dma-44xx.h
+++ b/arch/arm/plat-omap/include/plat/dma-44xx.h
@@ -68,14 +68,6 @@
 #define OMAP44XX_DMA_SPI2_RX1                  46
 #define OMAP44XX_DMA_MMC2_TX                   47
 #define OMAP44XX_DMA_MMC2_RX                   48
-#define OMAP44XX_DMA_UART1_TX                  49
-#define OMAP44XX_DMA_UART1_RX                  50
-#define OMAP44XX_DMA_UART2_TX                  51
-#define OMAP44XX_DMA_UART2_RX                  52
-#define OMAP44XX_DMA_UART3_TX                  53
-#define OMAP44XX_DMA_UART3_RX                  54
-#define OMAP44XX_DMA_UART4_TX                  55
-#define OMAP44XX_DMA_UART4_RX                  56
 #define OMAP44XX_DMA_MMC4_TX                   57
 #define OMAP44XX_DMA_MMC4_RX                   58
 #define OMAP44XX_DMA_MMC5_TX                   59
diff --git a/arch/arm/plat-omap/include/plat/dma.h
b/arch/arm/plat-omap/include/plat/dma.h
index d1c916f..c5be190 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -159,12 +159,6 @@
 #define OMAP24XX_DMA_SPI2_RX1          46      /* S_DMA_45 */
 #define OMAP24XX_DMA_MMC2_TX           47      /* S_DMA_46 */
 #define OMAP24XX_DMA_MMC2_RX           48      /* S_DMA_47 */
-#define OMAP24XX_DMA_UART1_TX          49      /* S_DMA_48 */
-#define OMAP24XX_DMA_UART1_RX          50      /* S_DMA_49 */
-#define OMAP24XX_DMA_UART2_TX          51      /* S_DMA_50 */
-#define OMAP24XX_DMA_UART2_RX          52      /* S_DMA_51 */
-#define OMAP24XX_DMA_UART3_TX          53      /* S_DMA_52 */
-#define OMAP24XX_DMA_UART3_RX          54      /* S_DMA_53 */
 #define OMAP24XX_DMA_USB_W2FC_TX0      55      /* S_DMA_54 */
 #define OMAP24XX_DMA_USB_W2FC_RX0      56      /* S_DMA_55 */
 #define OMAP24XX_DMA_USB_W2FC_TX1      57      /* S_DMA_56 */
@@ -193,8 +187,6 @@
 #define OMAP34XX_DMA_USIM_TX           79      /* S_DMA_78 */
 #define OMAP34XX_DMA_USIM_RX           80      /* S_DMA_79 */
 
-#define OMAP36XX_DMA_UART4_TX          81      /* S_DMA_80 */
-#define OMAP36XX_DMA_UART4_RX          82      /* S_DMA_81 */
 /*----------------------------------------------------------------------------*/
 
 #define OMAP1_DMA_TOUT_IRQ             (1 << 0)


On Fri, Jan 21, 2011 at 02:30:15PM -0800, Kevin Hilman wrote:
> Now that omap_hwmod + omap_device is used for OMAP UART device and
> driver code, we no longer need the UART physical addresses in
> omap_globals.
> 
> Note that the #defines for the base addresses are still left in
> <plat/serial.h> since they are used by DEBUG_LL and uncompress code.
> 
> Build tested for OMAP1 (omap1_defconfig) and OMAP2+ (omap2plus_defconfig)
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies on Tony's for-next branch.
> 
>  arch/arm/mach-omap2/common.c             |   14 --------------
>  arch/arm/plat-omap/include/plat/common.h |    4 ----
>  2 files changed, 0 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
> index d5eaee3..8044c8a 100644
> --- a/arch/arm/mach-omap2/common.c
> +++ b/arch/arm/mach-omap2/common.c
> @@ -50,9 +50,6 @@ static struct omap_globals omap242x_globals = {
>  	.ctrl	= OMAP242X_CTRL_BASE,
>  	.prm	= OMAP2420_PRM_BASE,
>  	.cm	= OMAP2420_CM_BASE,
> -	.uart1_phys	= OMAP2_UART1_BASE,
> -	.uart2_phys	= OMAP2_UART2_BASE,
> -	.uart3_phys	= OMAP2_UART3_BASE,
>  };
>  
>  void __init omap2_set_globals_242x(void)
> @@ -71,9 +68,6 @@ static struct omap_globals omap243x_globals = {
>  	.ctrl	= OMAP243X_CTRL_BASE,
>  	.prm	= OMAP2430_PRM_BASE,
>  	.cm	= OMAP2430_CM_BASE,
> -	.uart1_phys	= OMAP2_UART1_BASE,
> -	.uart2_phys	= OMAP2_UART2_BASE,
> -	.uart3_phys	= OMAP2_UART3_BASE,
>  };
>  
>  void __init omap2_set_globals_243x(void)
> @@ -92,10 +86,6 @@ static struct omap_globals omap3_globals = {
>  	.ctrl	= OMAP343X_CTRL_BASE,
>  	.prm	= OMAP3430_PRM_BASE,
>  	.cm	= OMAP3430_CM_BASE,
> -	.uart1_phys	= OMAP3_UART1_BASE,
> -	.uart2_phys	= OMAP3_UART2_BASE,
> -	.uart3_phys	= OMAP3_UART3_BASE,
> -	.uart4_phys	= OMAP3_UART4_BASE,	/* Only on 3630 */
>  };
>  
>  void __init omap2_set_globals_3xxx(void)
> @@ -119,10 +109,6 @@ static struct omap_globals omap4_globals = {
>  	.prm	= OMAP4430_PRM_BASE,
>  	.cm	= OMAP4430_CM_BASE,
>  	.cm2	= OMAP4430_CM2_BASE,
> -	.uart1_phys	= OMAP4_UART1_BASE,
> -	.uart2_phys	= OMAP4_UART2_BASE,
> -	.uart3_phys	= OMAP4_UART3_BASE,
> -	.uart4_phys	= OMAP4_UART4_BASE,
>  };
>  
>  void __init omap2_set_globals_443x(void)
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> index 29b2afb..1b8095b 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -56,10 +56,6 @@ struct omap_globals {
>  	unsigned long   prm;            /* Power and Reset Management */
>  	unsigned long   cm;             /* Clock Management */
>  	unsigned long   cm2;
> -	unsigned long	uart1_phys;
> -	unsigned long	uart2_phys;
> -	unsigned long	uart3_phys;
> -	unsigned long	uart4_phys;
>  };
>  
>  void omap2_set_globals_242x(void);
> -- 
> 1.7.3.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
