From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
	changes
Date: Fri, 13 Jan 2012 15:04:21 +0000
Message-ID: <20120113150421.GF16726@n2100.arm.linux.org.uk>
References: <20120112184256.GA2287@atomide.com> <alpine.LFD.2.02.1201121441580.2722@xanadu.home> <alpine.LFD.2.02.1201121447270.2722@xanadu.home> <20120112195951.GB2287@atomide.com> <20120113140520.GE16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59895 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab2AMPEe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 10:04:34 -0500
Content-Disposition: inline
In-Reply-To: <20120113140520.GE16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sascha Hauer <kernel@pengutronix.de>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Fri, Jan 13, 2012 at 02:05:20PM +0000, Russell King - ARM Linux wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> ARM: Add arm_memblock_steal() to allocate memory away from the kernel
> 
> Several platforms are now using the memblock_alloc+memblock_free+
> memblock_remove trick to obtain memory which won't be mapped in the
> kernel's page tables.  Most platforms do this (correctly) in the
> ->reserve callback.  However, OMAP has started to call these functions
> outside of this callback, and this is extremely unsafe - memory will
> not be unmapped, and could well be given out after memblock is no
> longer responsible for its management.
> 
> So, provide arm_memblock_steal() to perform this function, and ensure
> that it panic()s if it is used inappropriately.  Convert everyone
> over, including OMAP.
> 
> As a result, OMAP will panic on boot with this change.  OMAP needs to
> be fixed, or 137d105d50 (ARM: OMAP4: Fix errata i688 with MPU
> interconnect barriers.) reverted until such time it can be fixed
> correctly.

Santosh points out that this is only used if the errata i688 option is
enabled, so I've added to this patch to make this config option depend
on BROKEN, marked it as such, and commited the result to my fixes branch.

I'll be planning to push this to Linus sometime on Monday.

> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/memblock.h      |    2 ++
>  arch/arm/mach-imx/mach-mx31_3ds.c    |    5 ++---
>  arch/arm/mach-imx/mach-mx31moboard.c |    5 ++---
>  arch/arm/mach-imx/mach-pcm037.c      |    5 ++---
>  arch/arm/mach-omap2/omap-secure.c    |   13 ++-----------
>  arch/arm/mach-omap2/omap4-common.c   |   10 +++-------
>  arch/arm/mm/init.c                   |   17 +++++++++++++++++
>  arch/arm/plat-omap/devices.c         |    5 ++---
>  8 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memblock.h b/arch/arm/include/asm/memblock.h
> index b8da2e4..00ca5f9 100644
> --- a/arch/arm/include/asm/memblock.h
> +++ b/arch/arm/include/asm/memblock.h
> @@ -6,4 +6,6 @@ struct machine_desc;
>  
>  extern void arm_memblock_init(struct meminfo *, struct machine_desc *);
>  
> +phys_addr_t arm_memblock_steal(phys_addr_t size, phys_addr_t align);
> +
>  #endif
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index 89c3325..4d1aab1 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -36,6 +36,7 @@
>  #include <asm/mach/time.h>
>  #include <asm/memory.h>
>  #include <asm/mach/map.h>
> +#include <asm/memblock.h>
>  #include <mach/common.h>
>  #include <mach/iomux-mx3.h>
>  #include <mach/3ds_debugboard.h>
> @@ -754,10 +755,8 @@ static struct sys_timer mx31_3ds_timer = {
>  static void __init mx31_3ds_reserve(void)
>  {
>  	/* reserve MX31_3DS_CAMERA_BUF_SIZE bytes for mx3-camera */
> -	mx3_camera_base = memblock_alloc(MX31_3DS_CAMERA_BUF_SIZE,
> +	mx3_camera_base = arm_memblock_steal(MX31_3DS_CAMERA_BUF_SIZE,
>  					 MX31_3DS_CAMERA_BUF_SIZE);
> -	memblock_free(mx3_camera_base, MX31_3DS_CAMERA_BUF_SIZE);
> -	memblock_remove(mx3_camera_base, MX31_3DS_CAMERA_BUF_SIZE);
>  }
>  
>  MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
> diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
> index b95981d..f225262 100644
> --- a/arch/arm/mach-imx/mach-mx31moboard.c
> +++ b/arch/arm/mach-imx/mach-mx31moboard.c
> @@ -41,6 +41,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <asm/mach/map.h>
> +#include <asm/memblock.h>
>  #include <mach/board-mx31moboard.h>
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -584,10 +585,8 @@ struct sys_timer mx31moboard_timer = {
>  static void __init mx31moboard_reserve(void)
>  {
>  	/* reserve 4 MiB for mx3-camera */
> -	mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
> +	mx3_camera_base = arm_memblock_steal(MX3_CAMERA_BUF_SIZE,
>  			MX3_CAMERA_BUF_SIZE);
> -	memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> -	memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
>  }
>  
>  MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
> diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
> index d7e1516..e48854b 100644
> --- a/arch/arm/mach-imx/mach-pcm037.c
> +++ b/arch/arm/mach-imx/mach-pcm037.c
> @@ -39,6 +39,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <asm/mach/map.h>
> +#include <asm/memblock.h>
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  #include <mach/iomux-mx3.h>
> @@ -680,10 +681,8 @@ struct sys_timer pcm037_timer = {
>  static void __init pcm037_reserve(void)
>  {
>  	/* reserve 4 MiB for mx3-camera */
> -	mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
> +	mx3_camera_base = arm_memblock_steal(MX3_CAMERA_BUF_SIZE,
>  			MX3_CAMERA_BUF_SIZE);
> -	memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> -	memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
>  }
>  
>  MACHINE_START(PCM037, "Phytec Phycore pcm037")
> diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
> index 69f3c72..d8f8ef4 100644
> --- a/arch/arm/mach-omap2/omap-secure.c
> +++ b/arch/arm/mach-omap2/omap-secure.c
> @@ -16,6 +16,7 @@
>  #include <linux/memblock.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/memblock.h>
>  
>  #include <mach/omap-secure.h>
>  
> @@ -57,20 +58,10 @@ u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32 arg2,
>  /* Allocate the memory to save secure ram */
>  int __init omap_secure_ram_reserve_memblock(void)
>  {
> -	phys_addr_t paddr;
>  	u32 size = OMAP_SECURE_RAM_STORAGE;
>  
>  	size = ALIGN(size, SZ_1M);
> -	paddr = memblock_alloc(size, SZ_1M);
> -	if (!paddr) {
> -		pr_err("%s: failed to reserve %x bytes\n",
> -				__func__, size);
> -		return -ENOMEM;
> -	}
> -	memblock_free(paddr, size);
> -	memblock_remove(paddr, size);
> -
> -	omap_secure_memblock_base = paddr;
> +	omap_secure_memblock_base = arm_memblock_steal(size, SZ_1M);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index bc16c81..40a8fbc 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -20,6 +20,7 @@
>  #include <asm/hardware/gic.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/map.h>
> +#include <asm/memblock.h>
>  
>  #include <plat/irqs.h>
>  #include <plat/sram.h>
> @@ -61,13 +62,8 @@ static int __init omap_barriers_init(void)
>  		return -ENODEV;
>  
>  	size = ALIGN(PAGE_SIZE, SZ_1M);
> -	paddr = memblock_alloc(size, SZ_1M);
> -	if (!paddr) {
> -		pr_err("%s: failed to reserve 4 Kbytes\n", __func__);
> -		return -ENOMEM;
> -	}
> -	memblock_free(paddr, size);
> -	memblock_remove(paddr, size);
> +	paddr = arm_memblock_steal(size, SZ_1M);
> +
>  	dram_io_desc[0].virtual = OMAP4_DRAM_BARRIER_VA;
>  	dram_io_desc[0].pfn = __phys_to_pfn(paddr);
>  	dram_io_desc[0].length = size;
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index e34ea8a..6ec1226 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -22,6 +22,7 @@
>  #include <linux/memblock.h>
>  
>  #include <asm/mach-types.h>
> +#include <asm/memblock.h>
>  #include <asm/prom.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
> @@ -307,6 +308,22 @@ static void arm_memory_present(void)
>  }
>  #endif
>  
> +static bool arm_memblock_steal_permitted = true;
> +
> +phys_addr_t arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> +{
> +	phys_addr_t phys;
> +
> +	if (!arm_memblock_steal_permitted)
> +		panic("arm_memblock_steal used in an unsafe manner\n");
> +
> +	phys = memblock_alloc(size, align);
> +	memblock_free(phys, size);
> +	memblock_remove(phys, size);
> +
> +	return phys;
> +}
> +
>  void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>  {
>  	int i;
> @@ -349,6 +366,7 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>  	if (mdesc->reserve)
>  		mdesc->reserve();
>  
> +	arm_memblock_steal_permitted = false;
>  	memblock_allow_resize();
>  	memblock_dump_all();
>  }
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 1971932..60278f4 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -20,6 +20,7 @@
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> +#include <asm/memblock.h>
>  
>  #include <plat/tc.h>
>  #include <plat/board.h>
> @@ -164,14 +165,12 @@ void __init omap_dsp_reserve_sdram_memblock(void)
>  	if (!size)
>  		return;
>  
> -	paddr = memblock_alloc(size, SZ_1M);
> +	paddr = arm_memblock_steal(size, SZ_1M);
>  	if (!paddr) {
>  		pr_err("%s: failed to reserve %x bytes\n",
>  				__func__, size);
>  		return;
>  	}
> -	memblock_free(paddr, size);
> -	memblock_remove(paddr, size);
>  
>  	omap_dsp_phys_mempool_base = paddr;
>  }
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
