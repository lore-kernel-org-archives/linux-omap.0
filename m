From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: remove unused UART base addresses from omap_globals
Date: Mon, 24 Jan 2011 13:54:18 -0800
Message-ID: <87wrlu6k8l.fsf@ti.com>
References: <1295649015-26348-1-git-send-email-khilman@ti.com>
	<20110124064154.GA16582@m-desktop> <20110124074520.GB16582@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57033 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab1AXVyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 16:54:24 -0500
Received: by mail-qy0-f172.google.com with SMTP id 34so3330627qyk.3
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 13:54:24 -0800 (PST)
In-Reply-To: <20110124074520.GB16582@m-desktop> (Manjunath Kondaiah G.'s
	message of "Mon, 24 Jan 2011 13:15:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> We need additional changes for removing these macros since omap2+ till
> omap3 hwmod uart db is not using dma request lines in omap4 way.

Feel free to send the DMA changes as an additional patch.  This is
independent of my changes, so can be a separate patch.

Thanks,

Kevin

> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index b85c630..7347bbc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -366,8 +366,8 @@ static struct omap_hwmod_irq_info uart1_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
> +	{ .name = "rx",	.dma_req = 50, },
> +	{ .name = "tx",	.dma_req = 49, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap2420_uart1_slaves[] = {
> @@ -403,8 +403,8 @@ static struct omap_hwmod_irq_info uart2_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
> +	{ .name = "rx",	.dma_req = 52, },
> +	{ .name = "tx",	.dma_req = 51, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap2420_uart2_slaves[] = {
> @@ -440,8 +440,8 @@ static struct omap_hwmod_irq_info uart3_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
> +	{ .name = "rx",	.dma_req = 54, },
> +	{ .name = "tx",	.dma_req = 53, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap2420_uart3_slaves[] = {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 8ecfbcd..1d8c391 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -365,8 +365,8 @@ static struct omap_hwmod_irq_info uart1_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
> +	{ .name = "rx",	.dma_req = 50, },
> +	{ .name = "tx",	.dma_req = 49, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap2430_uart1_slaves[] = {
> @@ -402,8 +402,8 @@ static struct omap_hwmod_irq_info uart2_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
> +	{ .name = "rx",	.dma_req = 52, },
> +	{ .name = "tx",	.dma_req = 51, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap2430_uart2_slaves[] = {
> @@ -439,8 +439,8 @@ static struct omap_hwmod_irq_info uart3_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
> +	{ .name = "rx",	.dma_req = 54, },
> +	{ .name = "tx",	.dma_req = 53, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap2430_uart3_slaves[] = {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 8d81813..1595cc0 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -518,8 +518,8 @@ static struct omap_hwmod_irq_info uart1_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
> +	{ .name = "tx",	.dma_req = 49, },
> +	{ .name = "rx",	.dma_req = 50, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap3xxx_uart1_slaves[] = {
> @@ -555,8 +555,8 @@ static struct omap_hwmod_irq_info uart2_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
> +	{ .name = "tx",	.dma_req = 51, },
> +	{ .name = "rx",	.dma_req = 52, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap3xxx_uart2_slaves[] = {
> @@ -592,8 +592,8 @@ static struct omap_hwmod_irq_info uart3_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
> -	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
> -	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
> +	{ .name = "tx",	.dma_req = 53, },
> +	{ .name = "rx",	.dma_req = 54, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap3xxx_uart3_slaves[] = {
> @@ -629,8 +629,8 @@ static struct omap_hwmod_irq_info uart4_mpu_irqs[] =
> {
>  };
>  
>  static struct omap_hwmod_dma_info uart4_sdma_reqs[] = {
> -	{ .name = "rx",	.dma_req = OMAP36XX_DMA_UART4_RX, },
> -	{ .name = "tx",	.dma_req = OMAP36XX_DMA_UART4_TX, },
> +	{ .name = "rx",	.dma_req = 82, },
> +	{ .name = "tx",	.dma_req = 81, },
>  };
>  
>  static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
>
>
> On Mon, Jan 24, 2011 at 12:11:54PM +0530, G, Manjunath Kondaiah wrote:
>> Kevin, 
>> How about folding below changes into your patch since the UART dma irq
>> numbers are getting assigned from hwmod database.
>> 
>> -Manjunath
>> 
>> diff --git a/arch/arm/plat-omap/include/plat/dma-44xx.h
>> b/arch/arm/plat-omap/include/plat/dma-44xx.h
>> index 1f767cb..129d147 100644
>> --- a/arch/arm/plat-omap/include/plat/dma-44xx.h
>> +++ b/arch/arm/plat-omap/include/plat/dma-44xx.h
>> @@ -68,14 +68,6 @@
>>  #define OMAP44XX_DMA_SPI2_RX1                  46
>>  #define OMAP44XX_DMA_MMC2_TX                   47
>>  #define OMAP44XX_DMA_MMC2_RX                   48
>> -#define OMAP44XX_DMA_UART1_TX                  49
>> -#define OMAP44XX_DMA_UART1_RX                  50
>> -#define OMAP44XX_DMA_UART2_TX                  51
>> -#define OMAP44XX_DMA_UART2_RX                  52
>> -#define OMAP44XX_DMA_UART3_TX                  53
>> -#define OMAP44XX_DMA_UART3_RX                  54
>> -#define OMAP44XX_DMA_UART4_TX                  55
>> -#define OMAP44XX_DMA_UART4_RX                  56
>>  #define OMAP44XX_DMA_MMC4_TX                   57
>>  #define OMAP44XX_DMA_MMC4_RX                   58
>>  #define OMAP44XX_DMA_MMC5_TX                   59
>> diff --git a/arch/arm/plat-omap/include/plat/dma.h
>> b/arch/arm/plat-omap/include/plat/dma.h
>> index d1c916f..c5be190 100644
>> --- a/arch/arm/plat-omap/include/plat/dma.h
>> +++ b/arch/arm/plat-omap/include/plat/dma.h
>> @@ -159,12 +159,6 @@
>>  #define OMAP24XX_DMA_SPI2_RX1          46      /* S_DMA_45 */
>>  #define OMAP24XX_DMA_MMC2_TX           47      /* S_DMA_46 */
>>  #define OMAP24XX_DMA_MMC2_RX           48      /* S_DMA_47 */
>> -#define OMAP24XX_DMA_UART1_TX          49      /* S_DMA_48 */
>> -#define OMAP24XX_DMA_UART1_RX          50      /* S_DMA_49 */
>> -#define OMAP24XX_DMA_UART2_TX          51      /* S_DMA_50 */
>> -#define OMAP24XX_DMA_UART2_RX          52      /* S_DMA_51 */
>> -#define OMAP24XX_DMA_UART3_TX          53      /* S_DMA_52 */
>> -#define OMAP24XX_DMA_UART3_RX          54      /* S_DMA_53 */
>>  #define OMAP24XX_DMA_USB_W2FC_TX0      55      /* S_DMA_54 */
>>  #define OMAP24XX_DMA_USB_W2FC_RX0      56      /* S_DMA_55 */
>>  #define OMAP24XX_DMA_USB_W2FC_TX1      57      /* S_DMA_56 */
>> @@ -193,8 +187,6 @@
>>  #define OMAP34XX_DMA_USIM_TX           79      /* S_DMA_78 */
>>  #define OMAP34XX_DMA_USIM_RX           80      /* S_DMA_79 */
>>  
>> -#define OMAP36XX_DMA_UART4_TX          81      /* S_DMA_80 */
>> -#define OMAP36XX_DMA_UART4_RX          82      /* S_DMA_81 */
>>  /*----------------------------------------------------------------------------*/
>>  
>>  #define OMAP1_DMA_TOUT_IRQ             (1 << 0)
>> 
>> 
>> On Fri, Jan 21, 2011 at 02:30:15PM -0800, Kevin Hilman wrote:
>> > Now that omap_hwmod + omap_device is used for OMAP UART device and
>> > driver code, we no longer need the UART physical addresses in
>> > omap_globals.
>> > 
>> > Note that the #defines for the base addresses are still left in
>> > <plat/serial.h> since they are used by DEBUG_LL and uncompress code.
>> > 
>> > Build tested for OMAP1 (omap1_defconfig) and OMAP2+ (omap2plus_defconfig)
>> > 
>> > Signed-off-by: Kevin Hilman <khilman@ti.com>
>> > ---
>> > Applies on Tony's for-next branch.
>> > 
>> >  arch/arm/mach-omap2/common.c             |   14 --------------
>> >  arch/arm/plat-omap/include/plat/common.h |    4 ----
>> >  2 files changed, 0 insertions(+), 18 deletions(-)
>> > 
>> > diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
>> > index d5eaee3..8044c8a 100644
>> > --- a/arch/arm/mach-omap2/common.c
>> > +++ b/arch/arm/mach-omap2/common.c
>> > @@ -50,9 +50,6 @@ static struct omap_globals omap242x_globals = {
>> >  	.ctrl	= OMAP242X_CTRL_BASE,
>> >  	.prm	= OMAP2420_PRM_BASE,
>> >  	.cm	= OMAP2420_CM_BASE,
>> > -	.uart1_phys	= OMAP2_UART1_BASE,
>> > -	.uart2_phys	= OMAP2_UART2_BASE,
>> > -	.uart3_phys	= OMAP2_UART3_BASE,
>> >  };
>> >  
>> >  void __init omap2_set_globals_242x(void)
>> > @@ -71,9 +68,6 @@ static struct omap_globals omap243x_globals = {
>> >  	.ctrl	= OMAP243X_CTRL_BASE,
>> >  	.prm	= OMAP2430_PRM_BASE,
>> >  	.cm	= OMAP2430_CM_BASE,
>> > -	.uart1_phys	= OMAP2_UART1_BASE,
>> > -	.uart2_phys	= OMAP2_UART2_BASE,
>> > -	.uart3_phys	= OMAP2_UART3_BASE,
>> >  };
>> >  
>> >  void __init omap2_set_globals_243x(void)
>> > @@ -92,10 +86,6 @@ static struct omap_globals omap3_globals = {
>> >  	.ctrl	= OMAP343X_CTRL_BASE,
>> >  	.prm	= OMAP3430_PRM_BASE,
>> >  	.cm	= OMAP3430_CM_BASE,
>> > -	.uart1_phys	= OMAP3_UART1_BASE,
>> > -	.uart2_phys	= OMAP3_UART2_BASE,
>> > -	.uart3_phys	= OMAP3_UART3_BASE,
>> > -	.uart4_phys	= OMAP3_UART4_BASE,	/* Only on 3630 */
>> >  };
>> >  
>> >  void __init omap2_set_globals_3xxx(void)
>> > @@ -119,10 +109,6 @@ static struct omap_globals omap4_globals = {
>> >  	.prm	= OMAP4430_PRM_BASE,
>> >  	.cm	= OMAP4430_CM_BASE,
>> >  	.cm2	= OMAP4430_CM2_BASE,
>> > -	.uart1_phys	= OMAP4_UART1_BASE,
>> > -	.uart2_phys	= OMAP4_UART2_BASE,
>> > -	.uart3_phys	= OMAP4_UART3_BASE,
>> > -	.uart4_phys	= OMAP4_UART4_BASE,
>> >  };
>> >  
>> >  void __init omap2_set_globals_443x(void)
>> > diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
>> > index 29b2afb..1b8095b 100644
>> > --- a/arch/arm/plat-omap/include/plat/common.h
>> > +++ b/arch/arm/plat-omap/include/plat/common.h
>> > @@ -56,10 +56,6 @@ struct omap_globals {
>> >  	unsigned long   prm;            /* Power and Reset Management */
>> >  	unsigned long   cm;             /* Clock Management */
>> >  	unsigned long   cm2;
>> > -	unsigned long	uart1_phys;
>> > -	unsigned long	uart2_phys;
>> > -	unsigned long	uart3_phys;
>> > -	unsigned long	uart4_phys;
>> >  };
>> >  
>> >  void omap2_set_globals_242x(void);
>> > -- 
>> > 1.7.3.5
>> > 
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
