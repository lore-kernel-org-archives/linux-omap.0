From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 1/5] HDQ/1-wire support for OMAP2430/3430
Date: Mon, 10 Dec 2007 10:28:27 -0800
Message-ID: <20071210182827.GF19104@atomide.com>
References: <005901c83b15$b23d4150$fe8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <005901c83b15$b23d4150$fe8818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: 'Evgeniy Polyakov' <johnpol@2ka.mipt.ru>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com> [071210 02:17]:
> This patch adds HDQ base address defines and registers hdq as platform device.
> 
> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> ---
>  arch/arm/mach-omap2/devices.c        |   30 ++++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/omap24xx.h |    2 +-
>  include/asm-arm/arch-omap/omap34xx.h |    2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c	2007-11-29 03:53:52.867460848 -0500
> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c	2007-11-29 03:54:18.801518272 -0500
> @@ -221,6 +221,35 @@
>  void omap_init_eac(struct eac_platform_data *pdata) {}
>  #endif
>  
> +#if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
> +static struct resource omap_hdq_resources[] = {
> +	{
> +		.start		= OMAP_HDQ_BASE,
> +		.end		= OMAP_HDQ_BASE + 0x1C,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= INT_24XX_HDQ_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +static struct platform_device omap_hdq_dev = {
> +	.name = "omap_hdq",
> +	.id = 0,
> +	.dev = {
> +		.platform_data = NULL,
> +	},
> +	.num_resources  = ARRAY_SIZE(omap_hdq_resources),
> +	.resource       = omap_hdq_resources,
> +};
> +static inline void omap_hdq_init(void)
> +{
> +	(void) platform_device_register(&omap_hdq_dev);
> +}
> +#else
> +static inline void omap_hdq_init(void) {}
> +#endif
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static int __init omap2_init_devices(void)
> @@ -231,6 +260,7 @@
>  	omap_init_camera();
>  	omap_init_mbox();
>  	omap_init_mcspi();
> +	omap_hdq_init();
>  	omap_init_sti();
>  
>  	return 0;
> Index: linux-omap-2.6/include/asm-arm/arch-omap/omap24xx.h
> ===================================================================
> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/omap24xx.h	2007-11-29 03:53:52.867460848 -0500
> +++ linux-omap-2.6/include/asm-arm/arch-omap/omap24xx.h	2007-11-29 03:54:18.801518272 -0500
> @@ -92,7 +92,7 @@
>  #define OMAP2_CM_BASE		OMAP2430_CM_BASE
>  #define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
>  #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
> -
> +#define OMAP_HDQ_BASE		(L4_24XX_BASE + 0xb2000)
>  #endif
>  
>  #endif /* __ASM_ARCH_OMAP24XX_H */
> Index: linux-omap-2.6/include/asm-arm/arch-omap/omap34xx.h
> ===================================================================
> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/omap34xx.h	2007-11-29 03:53:52.867460848 -0500
> +++ linux-omap-2.6/include/asm-arm/arch-omap/omap34xx.h	2007-11-29 03:54:18.801518272 -0500
> @@ -62,7 +62,7 @@
>  #define OMAP2_CM_BASE			OMAP3430_CM_BASE
>  #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
>  #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
> -
> +#define OMAP_HDQ_BASE			(L4_34XX_BASE + 0xB2000)
>  #endif
>  
>  #define OMAP34XX_DSP_BASE	0x58000000

Please remove the duplicate define, you can just define it in devices.c
depending if it's 2430 or 3430. Otherwise you're adding yet another
artificial block to compile in support for both 2430 and 3430 into the
same kernel.

Regards,

Tony
