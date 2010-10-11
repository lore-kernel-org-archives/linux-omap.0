From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 2/3] omap: dsp: fix ioremap() usage
Date: Mon, 11 Oct 2010 10:15:53 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F47B2BCD@dlee06.ent.ti.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
 <1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39795 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab0JKPQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 11:16:10 -0400
In-Reply-To: <1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe 
> Contreras
> Sent: Sunday, October 10, 2010 12:41 PM
> To: linux-arm; linux-omap; Greg KH
> Cc: Ramirez Luna, Omar; Russell King; Felipe Contreras
> Subject: [PATCH 2/3] omap: dsp: fix ioremap() usage
> 
> On commit 309caa9 doing ioremap() became forbidden due tue 
> architectural limitations. Only a single mapping is allowed 
> now, so the mempool must not be part of the memory managed by 
> the kernel.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/plat-omap/common.c              |   43 
> +++++++++++++++++++++++++++--
>  arch/arm/plat-omap/devices.c             |   30 ---------------------
>  arch/arm/plat-omap/include/plat/common.h |    3 +-
>  arch/arm/plat-omap/include/plat/dsp.h    |    6 ----
>  4 files changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/common.c 
> b/arch/arm/plat-omap/common.c index 57205a4..3fee3ca 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -37,7 +37,6 @@
>  #include <plat/fpga.h>
>  #include <plat/serial.h>
>  #include <plat/vram.h>
> -#include <plat/dsp.h>
>  
>  #include <plat/clock.h>
>  
> @@ -84,11 +83,49 @@ const void *omap_get_var_config(u16 tag, 
> size_t *len)  }  EXPORT_SYMBOL(omap_get_var_config);
>  
> -void __init omap_reserve(void)
> +#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
> +
> +static phys_addr_t omap_dsp_mempool_base;
> +
> +static void __init omap_dsp_reserve_mem(struct meminfo *mi) {
> +	phys_addr_t size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
> +	phys_addr_t addr = ~0;
> +	int i;
> +
> +	if (!size)
> +		return;
> +
> +	for (i = mi->nr_banks - 1; i >= 0; i--)
> +		if (mi->bank[i].size >= size) {
> +			mi->bank[i].size -= size;
> +			addr = mi->bank[i].start + mi->bank[i].size;
> +			break;
> +		}

Missing {} in "for" lopp. Even tough you are checking for success inside
For loop why check again outside? And also not need to define addr.
What do you think about this:


static void __init omap_dsp_reserve_mem(struct meminfo *mi) {
	phys_addr_t size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
	int i;

	if (!size)
		return;

	for (i = mi->nr_banks - 1; i >= 0; i--) {
		if (mi->bank[i].size >= size) {
			mi->bank[i].size -= size;
			omap_dsp_mempool_base = 
				mi->bank[i].start + mi->bank[i].size;
			return;
		}
	}
	pr_err("%s: failed to reserve 0x%x bytes\n", __func__, size);
}

Regards,
Fernando.

> +
> +	if (addr == ~0) {
> +		pr_err("%s: failed to reserve 0x%x bytes\n",
> +				__func__, size);
> +		return;
> +	}
> +
> +	omap_dsp_mempool_base = addr;
> +}
> +
> +phys_addr_t omap_dsp_get_mempool_base(void) {
> +	return omap_dsp_mempool_base;
> +}
> +EXPORT_SYMBOL(omap_dsp_get_mempool_base);
> +#else
> +static inline void omap_dsp_reserve_mem(struct meminfo *mi) 
> { } #endif
> +
> +void __init omap_reserve(struct meminfo *mi)
>  {
>  	omapfb_reserve_sdram_memblock();
>  	omap_vram_reserve_sdram_memblock();
> -	omap_dsp_reserve_sdram_memblock();
> +	omap_dsp_reserve_mem(mi);
>  }
>  
>  /*
> diff --git a/arch/arm/plat-omap/devices.c 
> b/arch/arm/plat-omap/devices.c index 4c8f9b9..d1920be 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -15,7 +15,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> -#include <linux/memblock.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -273,35 +272,6 @@ static void omap_init_wdt(void)  static 
> inline void omap_init_wdt(void) {}  #endif
>  
> -#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
> -
> -static phys_addr_t omap_dsp_phys_mempool_base;
> -
> -void __init omap_dsp_reserve_sdram_memblock(void)
> -{
> -	phys_addr_t size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
> -	phys_addr_t paddr;
> -
> -	if (!size)
> -		return;
> -
> -	paddr = __memblock_alloc_base(size, SZ_1M, MEMBLOCK_REAL_LIMIT);
> -	if (!paddr) {
> -		pr_err("%s: failed to reserve %x bytes\n",
> -				__func__, size);
> -		return;
> -	}
> -
> -	omap_dsp_phys_mempool_base = paddr;
> -}
> -
> -phys_addr_t omap_dsp_get_mempool_base(void) -{
> -	return omap_dsp_phys_mempool_base;
> -}
> -EXPORT_SYMBOL(omap_dsp_get_mempool_base);
> -#endif
> -
>  /*
>   * This gets called after board-specific INIT_MACHINE, and 
> initializes most
>   * on-chip peripherals accessible on this board (except for 
> few like USB):
> diff --git a/arch/arm/plat-omap/include/plat/common.h 
> b/arch/arm/plat-omap/include/plat/common.h
> index 9776b41..3675492 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -30,11 +30,12 @@
>  #include <plat/i2c.h>
>  
>  struct sys_timer;
> +struct meminfo;
>  
>  extern void omap_map_common_io(void);
>  extern struct sys_timer omap_timer;
>  
> -extern void omap_reserve(void);
> +extern void omap_reserve(struct meminfo *mi);
>  
>  /*
>   * IO bases for various OMAP processors diff --git 
> a/arch/arm/plat-omap/include/plat/dsp.h 
> b/arch/arm/plat-omap/include/plat/dsp.h
> index 9c604b3..4e53687 100644
> --- a/arch/arm/plat-omap/include/plat/dsp.h
> +++ b/arch/arm/plat-omap/include/plat/dsp.h
> @@ -22,10 +22,4 @@ struct omap_dsp_platform_data {
>  	phys_addr_t phys_mempool_size;
>  };
>  
> -#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
> -extern void omap_dsp_reserve_sdram_memblock(void);
> -#else
> -static inline void omap_dsp_reserve_sdram_memblock(void) { } -#endif
> -
>  #endif
> --
> 1.7.3.1.2.g7fe2b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 