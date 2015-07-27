From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 4/4] ARM: omap2: restore OMAP4 barrier behaviour
Date: Mon, 27 Jul 2015 16:23:45 -0500
Message-ID: <55B6A161.8010307@ti.com>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

Russell

On 07/15/2015 12:47 PM, Russell King wrote:
> Restore the OMAP4 barrier behaviour using the new implementation which
> allows multiplatform systems to hook into the mb() and wmb() ARM
> implementations to perform any necessary additional barrier maintanence.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-omap2/Kconfig                 | 28 +++------
>  arch/arm/mach-omap2/common.h                | 12 +++-
>  arch/arm/mach-omap2/include/mach/barriers.h | 33 -----------
>  arch/arm/mach-omap2/omap-secure.h           |  7 ---
>  arch/arm/mach-omap2/omap4-common.c          | 90 +++++++++++++++++++++++------
>  arch/arm/mach-omap2/sleep44xx.S             | 10 +---
>  6 files changed, 90 insertions(+), 90 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/include/mach/barriers.h
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 2128441430ad..8427997e09c4 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -29,6 +29,7 @@ config ARCH_OMAP4
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
>  	select OMAP_INTERCONNECT
> +	select OMAP_INTERCONNECT_BARRIER
>  	select PL310_ERRATA_588369 if CACHE_L2X0
>  	select PL310_ERRATA_727915 if CACHE_L2X0
>  	select PM_OPP if PM
> @@ -46,6 +47,7 @@ config SOC_OMAP5
>  	select HAVE_ARM_TWD if SMP
>  	select HAVE_ARM_ARCH_TIMER
>  	select ARM_ERRATA_798181 if SMP
> +	select OMAP_INTERCONNECT_BARRIER
>  
>  config SOC_AM33XX
>  	bool "TI AM33XX"
> @@ -70,6 +72,7 @@ config SOC_DRA7XX
>  	select HAVE_ARM_ARCH_TIMER
>  	select IRQ_CROSSBAR
>  	select ARM_ERRATA_798181 if SMP
> +	select OMAP_INTERCONNECT_BARRIER
>  
>  config ARCH_OMAP2PLUS
>  	bool
> @@ -91,6 +94,10 @@ config ARCH_OMAP2PLUS
>  	help
>  	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
>  
> +config OMAP_INTERCONNECT_BARRIER
> +	bool
> +	select ARM_HEAVY_MB
> +	
>  
>  if ARCH_OMAP2PLUS
>  
> @@ -240,27 +247,6 @@ config OMAP3_SDRC_AC_TIMING
>  	  wish to say no.  Selecting yes without understanding what is
>  	  going on could result in system crashes;
>  
> -config OMAP4_ERRATA_I688
> -	bool "OMAP4 errata: Async Bridge Corruption"
> -	depends on (ARCH_OMAP4 || SOC_OMAP5) && !ARCH_MULTIPLATFORM
> -	select ARCH_HAS_BARRIERS
> -	help
> -	  If a data is stalled inside asynchronous bridge because of back
> -	  pressure, it may be accepted multiple times, creating pointer
> -	  misalignment that will corrupt next transfers on that data path
> -	  until next reset of the system (No recovery procedure once the
> -	  issue is hit, the path remains consistently broken). Async bridge
> -	  can be found on path between MPU to EMIF and MPU to L3 interconnect.
> -	  This situation can happen only when the idle is initiated by a
> -	  Master Request Disconnection (which is trigged by software when
> -	  executing WFI on CPU).
> -	  The work-around for this errata needs all the initiators connected
> -	  through async bridge must ensure that data path is properly drained
> -	  before issuing WFI. This condition will be met if one Strongly ordered
> -	  access is performed to the target right before executing the WFI.
> -	  In MPU case, L3 T2ASYNC FIFO and DDR T2ASYNC FIFO needs to be drained.
> -	  IO barrier ensure that there is no synchronisation loss on initiators
> -	  operating on both interconnect port simultaneously.
>  endmenu
>  
>  endif
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 46e24581d624..82f88b4ec15f 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -189,6 +189,15 @@ static inline void omap44xx_restart(enum reboot_mode mode, const char *cmd)
>  }
>  #endif
>  
> +#ifdef CONFIG_OMAP_INTERCONNECT_BARRIER
> +void omap_barrier_reserve_memblock(void);
> +void omap_barriers_init(void);
> +#else
> +static inline void omap_barrier_reserve_memblock(void)
> +{
> +}
> +#endif
> +
>  /* This gets called from mach-omap2/io.c, do not call this */
>  void __init omap2_set_globals_tap(u32 class, void __iomem *tap);
>  
> @@ -200,9 +209,6 @@ void __init omap4_map_io(void);
>  void __init omap5_map_io(void);
>  void __init ti81xx_map_io(void);
>  
> -/* omap_barriers_init() is OMAP4 only */
> -void omap_barriers_init(void);
> -
>  /**
>   * omap_test_timeout - busy-loop, testing a condition
>   * @cond: condition to test until it evaluates to true
> diff --git a/arch/arm/mach-omap2/include/mach/barriers.h b/arch/arm/mach-omap2/include/mach/barriers.h
> deleted file mode 100644
> index 1c582a8592b9..000000000000
> --- a/arch/arm/mach-omap2/include/mach/barriers.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - * OMAP memory barrier header.
> - *
> - * Copyright (C) 2011 Texas Instruments, Inc.
> - *  Santosh Shilimkar <santosh.shilimkar@ti.com>
> - *  Richard Woodruff <r-woodruff2@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> - */
> -
> -#ifndef __MACH_BARRIERS_H
> -#define __MACH_BARRIERS_H
> -
> -#include <asm/outercache.h>
> -
> -extern void omap_bus_sync(void);
> -
> -#define rmb()		dsb()
> -#define wmb()		do { dsb(); outer_sync(); omap_bus_sync(); } while (0)
> -#define mb()		wmb()
> -
> -#endif	/* __MACH_BARRIERS_H */
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
> index dec2b05d184b..af2851fbcdf0 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -70,13 +70,6 @@ extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
>  extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
>  extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
>  
> -#ifdef CONFIG_OMAP4_ERRATA_I688
> -extern int omap_barrier_reserve_memblock(void);
> -#else
> -static inline void omap_barrier_reserve_memblock(void)
> -{ }
> -#endif
> -
>  #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
>  void set_cntfreq(void);
>  #else
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 7bb116a6f86f..9c7aac616938 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -51,16 +51,73 @@ static void __iomem *twd_base;
>  
>  #define IRQ_LOCALTIMER		29
>  
> -#ifdef CONFIG_OMAP4_ERRATA_I688
> +#ifdef CONFIG_OMAP_INTERCONNECT_BARRIER
> +
>  /* Used to implement memory barrier on DRAM path */
>  #define OMAP4_DRAM_BARRIER_VA			0xfe600000
>  
> -void __iomem *dram_sync, *sram_sync;
> +static void __iomem *dram_sync, *sram_sync;
> +static phys_addr_t dram_sync_paddr;
> +static u32 dram_sync_size;
> +
> +/*
> + * The OMAP4 bus structure contains asynchrnous bridges which can buffer
> + * data writes from the MPU. These asynchronous bridges can be found on
> + * paths between the MPU to EMIF, and the MPU to L3 interconnects.
> + *
> + * We need to be careful about re-ordering which can happen as a result
> + * of different accesses being performed via different paths, and
> + * therefore different asynchronous bridges.
> + */
>  
> -static phys_addr_t paddr;
> -static u32 size;
> +/*
> + * OMAP4 interconnect barrier which is called for each mb() and wmb().
> + * This is to ensure that normal paths to DRAM (normal memory, cacheable
> + * accesses) are properly synchronised with writes to DMA coherent memory
> + * (normal memory, uncacheable) and device writes.
> + *
> + * The mb() and wmb() barriers only operate only on the MPU->MA->EMIF
> + * path, as we need to ensure that data is visible to other system
> + * masters prior to writes to those system masters being seen.
> + *
> + * Note: the SRAM path is not synchronised via mb() and wmb().
> + */
> +static void omap4_mb(void)

Sorry for the late response but this throws a warning when CONFIG_ARCH_OMAP4
is not configured.

arch/arm/mach-omap2/omap4-common.c:85:13: warning: 'omap4_mb' defined but not used [-Wunused-function]

If this was already taken I can just throw a patch up against what ever tree it is on.

<snip>

-- 
------------------
Dan Murphy
