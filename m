From: Lokesh Vutla <a0131933@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of
 memory
Date: Mon, 19 Oct 2015 19:26:34 +0530
Message-ID: <5624F692.5070302@ti.com>
References: <1444778000-22537-1-git-send-email-tony@atomide.com>
 <561DD014.10403@ti.com> <20151014160245.GA10113@atomide.com>
 <561F5C0C.6080106@ti.com> <20151015140551.GM10113@atomide.com>
 <561FC2E9.9050805@ti.com> <20151016192300.GD24370@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151016192300.GD24370@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, "Woodruff,
 Richard" <r-woodruff2@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr. H.
 Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Saturday 17 October 2015 12:53 AM, Tony Lindgren wrote:
> * Lokesh Vutla <a0131933@ti.com> [151015 08:21]:

[..snip..]

>>>
> 
> 8< ----------------------From c37732f6cea23d15faaaaa357cf698833c03ce05 Mon Sep 17 00:00:00 2001
> Date: Fri, 16 Oct 2015 12:16:21 -0700
> Subject: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of memory
> 
> On boards with more than 2GB of RAM booting goes wrong with things not
> working and we're getting lots of l3 warnings:
> 
> WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147
> l3_interrupt_handler+0x260/0x384()
> 44000000.ocp:L3 Custom Error: MASTER MMC6 TARGET DMM1 (Idle):
> Data Access in User mode during Functional access
> ...
> [<c044e158>] (scsi_add_host_with_dma) from [<c04705c8>]
> (ata_scsi_add_hosts+0x5c/0x18c)
> [<c04705c8>] (ata_scsi_add_hosts) from [<c046b13c>]
> (ata_host_register+0x150/0x2cc)
> [<c046b13c>] (ata_host_register) from [<c046b38c>]
> (ata_host_activate+0xd4/0x124)
> [<c046b38c>] (ata_host_activate) from [<c047f42c>]
> (ahci_host_activate+0x5c/0x194)
> [<c047f42c>] (ahci_host_activate) from [<c0480854>]
> (ahci_platform_init_host+0x1f0/0x3f0)
> [<c0480854>] (ahci_platform_init_host) from [<c047c9dc>]
> (ahci_probe+0x70/0x98)
> [<c047c9dc>] (ahci_probe) from [<c04220cc>]
> (platform_drv_probe+0x54/0xb4)
> 
> Let's fix the issue by enabling ZONE_DMA for LPAE. Note that we need to
> limit dma_zone_size to 2GB as the rest of the RAM is beyond the 4GB limit.
> 
> Let's also fix things for dra7 as done in similar patches in the TI tree
> by Lokesh Vutla <lokeshvutla@ti.com>.

Looks good to me.
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Since there is a big hole with in the memory space, we might also need
to enable SPARSEMEM ?

Thanks and regards,
Lokesh

> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -49,6 +49,7 @@ config SOC_OMAP5
>  	select OMAP_INTERCONNECT
>  	select OMAP_INTERCONNECT_BARRIER
>  	select PM_OPP if PM
> +	select ZONE_DMA if ARM_LPAE
>  
>  config SOC_AM33XX
>  	bool "TI AM33XX"
> @@ -78,6 +79,7 @@ config SOC_DRA7XX
>  	select OMAP_INTERCONNECT
>  	select OMAP_INTERCONNECT_BARRIER
>  	select PM_OPP if PM
> +	select ZONE_DMA if ARM_LPAE
>  
>  config ARCH_OMAP2PLUS
>  	bool
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -243,6 +243,9 @@ static const char *const omap5_boards_compat[] __initconst = {
>  };
>  
>  DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
> +#if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
> +	.dma_zone_size	= SZ_2G,
> +#endif
>  	.reserve	= omap_reserve,
>  	.smp		= smp_ops(omap4_smp_ops),
>  	.map_io		= omap5_map_io,
> @@ -288,6 +291,9 @@ static const char *const dra74x_boards_compat[] __initconst = {
>  };
>  
>  DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
> +#if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
> +	.dma_zone_size	= SZ_2G,
> +#endif
>  	.reserve	= omap_reserve,
>  	.smp		= smp_ops(omap4_smp_ops),
>  	.map_io		= dra7xx_map_io,
> @@ -308,6 +314,9 @@ static const char *const dra72x_boards_compat[] __initconst = {
>  };
>  
>  DT_MACHINE_START(DRA72X_DT, "Generic DRA72X (Flattened Device Tree)")
> +#if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
> +	.dma_zone_size	= SZ_2G,
> +#endif
>  	.reserve	= omap_reserve,
>  	.map_io		= dra7xx_map_io,
>  	.init_early	= dra7xx_init_early,
> 
