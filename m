From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Pre 3430 patch for io.c map table cleanup
Date: Thu, 21 Jun 2007 05:03:34 -0700
Message-ID: <20070621120333.GJ20283@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011E65C4@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E65C4@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070614 14:16]:
> Cleanup map descriptor table in io.c for 2420 and 2430
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files:
>  arch/arm/mach-omap2/io.c
> 
> =======================================================================
> 
> --- linux-omap/arch/arm/mach-omap2/io.c	2007-05-30 14:02:43.000000000 -0500
> +++ lin_for_mmc/arch/arm/mach-omap2/io.c	2007-06-14 15:40:42.000000000 -0500
>  
>  void __init omap2_map_common_io(void)
>  {
> -	iotable_init(omap2_io_desc, ARRAY_SIZE(omap2_io_desc));
> -
> +#if defined(CONFIG_ARCH_OMAP2420)
> +	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
> +	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
> +#elif defined(CONFIG_ARCH_OMAP2430)
> +	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
> +	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
> +#endif
>  	/* Normally devicemaps_init() would flush caches and tlb after
>  	 * mdesc->map_io(), but we must also do it here because of the CPU
>  	 * revision check below.

You don't need the #defines here. This adds yet another artificial
barrier to compiling in both.

Use cpu_is_omap34xx() et al to init them.

Tony
