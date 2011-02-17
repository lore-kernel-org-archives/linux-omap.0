From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
Date: Thu, 17 Feb 2011 14:33:28 +0900
Message-ID: <015c01cbce64$373c6ef0$a5b54cd0$%kim@samsung.com>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Nicolas Pitre' <nico@fluxnic.net>
Cc: 'Srinidhi Kasagar' <srinidhi.kasagar@stericsson.com>, 'Kevin Hilman' <khilman@deeprootsystems.com>, 'Anton Vorontsov' <avorontsov@mvista.com>, 'Lennert Buytenhek' <kernel@wantstofly.org>, linux-samsung-soc@vger.kernel.org, 'Erik Gilling' <konkers@android.com>, linux-sh@vger.kernel.org, 'Vincent Sanders' <support@simtec.co.uk>, "'Hans J. Koch'" <hjk@linutronix.de>, 'Magnus Damm' <magnus.damm@gmail.com>, 'Marc Singer' <elf@buici.com>, 'Tony Lindgren' <tony@atomide.com>, 'David Brown' <davidb@codeaurora.org>, 'Alessandro Rubini' <rubini@unipv.it>, 'Jiandong Zheng' <jdzheng@broadcom.com>, 'Wan ZongShun' <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, 'Olof Johansson' <olof@lixom.net>, 'Ryan Mallon' <ryan@bluewatersys.com>, 'Ben Dooks' <ben-linux@fluff.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Daniel
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/memory.h                  |    2 ++
>  arch/arm/kernel/tcm.c                          |    2 +-
>  arch/arm/mach-aaec2000/include/mach/memory.h   |    2 +-
>  arch/arm/mach-at91/include/mach/memory.h       |    2 +-
>  arch/arm/mach-bcmring/include/mach/hardware.h  |    2 +-
>  arch/arm/mach-bcmring/include/mach/memory.h    |    2 +-
>  arch/arm/mach-clps711x/include/mach/memory.h   |    2 +-
>  arch/arm/mach-cns3xxx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-davinci/include/mach/memory.h    |    4 ++--
>  arch/arm/mach-dove/include/mach/memory.h       |    2 +-
>  arch/arm/mach-ebsa110/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ep93xx/include/mach/memory.h     |   10 +++++-----
>  arch/arm/mach-footbridge/include/mach/memory.h |    2 +-
>  arch/arm/mach-h720x/include/mach/memory.h      |    2 +-
>  arch/arm/mach-integrator/include/mach/memory.h |    2 +-
>  arch/arm/mach-iop13xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-iop32x/include/mach/memory.h     |    2 +-
>  arch/arm/mach-iop33x/include/mach/memory.h     |    2 +-
>  arch/arm/mach-ixp2000/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ixp23xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ixp4xx/include/mach/memory.h     |    2 +-
>  arch/arm/mach-kirkwood/include/mach/memory.h   |    2 +-
>  arch/arm/mach-ks8695/include/mach/memory.h     |    2 +-
>  arch/arm/mach-lh7a40x/include/mach/memory.h    |    2 +-
>  arch/arm/mach-loki/include/mach/memory.h       |    2 +-
>  arch/arm/mach-lpc32xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-mmp/include/mach/memory.h        |    2 +-
>  arch/arm/mach-msm/board-msm7x30.c              |    2 +-
>  arch/arm/mach-msm/include/mach/memory.h        |   10 +++++-----
>  arch/arm/mach-mv78xx0/include/mach/memory.h    |    2 +-
>  arch/arm/mach-mx3/mach-kzm_arm11_01.c          |    2 +-
>  arch/arm/mach-netx/include/mach/memory.h       |    2 +-
>  arch/arm/mach-nomadik/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ns9xxx/include/mach/memory.h     |    2 +-
>  arch/arm/mach-nuc93x/include/mach/memory.h     |    2 +-
>  arch/arm/mach-orion5x/include/mach/memory.h    |    2 +-
>  arch/arm/mach-pnx4008/include/mach/memory.h    |    2 +-
>  arch/arm/mach-pxa/include/mach/memory.h        |    2 +-
>  arch/arm/mach-realview/include/mach/memory.h   |    4 ++--
>  arch/arm/mach-rpc/include/mach/memory.h        |    2 +-
>  arch/arm/mach-s3c2400/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s3c2410/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s3c24a0/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s3c64xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5p6442/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5p64x0/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5pc100/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5pv210/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5pv310/include/mach/memory.h    |    2 +-
>  arch/arm/mach-sa1100/include/mach/memory.h     |    2 +-
>  arch/arm/mach-shark/include/mach/memory.h      |    2 +-
>  arch/arm/mach-shmobile/include/mach/memory.h   |    2 +-
>  arch/arm/mach-tegra/include/mach/memory.h      |    2 +-
>  arch/arm/mach-u300/include/mach/memory.h       |    6 +++---
>  arch/arm/mach-u300/u300.c                      |    2 +-
>  arch/arm/mach-ux500/include/mach/memory.h      |    2 +-
>  arch/arm/mach-versatile/include/mach/memory.h  |    2 +-
>  arch/arm/mach-vexpress/include/mach/memory.h   |    2 +-
>  arch/arm/mach-w90x900/include/mach/memory.h    |    2 +-
>  arch/arm/plat-omap/include/plat/memory.h       |    4 ++--
>  arch/arm/plat-spear/include/plat/memory.h      |    2 +-
>  arch/arm/plat-stmp3xxx/include/mach/memory.h   |    2 +-
>  arch/arm/plat-tcc/include/mach/memory.h        |    2 +-
>  63 files changed, 77 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 23c2e8e..00b04ae 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -24,6 +24,8 @@
>   */
>  #define UL(x) _AC(x, UL)
> 
> +#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> +
>  #ifdef CONFIG_MMU
> 
>  /*
> diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
> index 26685c2..f5cf660 100644
> --- a/arch/arm/kernel/tcm.c
> +++ b/arch/arm/kernel/tcm.c
> @@ -15,7 +15,7 @@
>  #include <linux/string.h> /* memcpy */
>  #include <asm/cputype.h>
>  #include <asm/mach/map.h>
> -#include <mach/memory.h>
> +#include <asm/memory.h>
>  #include "tcm.h"
> 
>  static struct gen_pool *tcm_pool;

(snip)

> diff --git a/arch/arm/mach-s3c2400/include/mach/memory.h b/arch/arm/mach-
> s3c2400/include/mach/memory.h
> index cf5901f..3f33670 100644
> --- a/arch/arm/mach-s3c2400/include/mach/memory.h
> +++ b/arch/arm/mach-s3c2400/include/mach/memory.h
> @@ -15,6 +15,6 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H
> 
> -#define PHYS_OFFSET	UL(0x0C000000)
> +#define PLAT_PHYS_OFFSET	UL(0x0C000000)
> 
>  #endif
> diff --git a/arch/arm/mach-s3c2410/include/mach/memory.h b/arch/arm/mach-
> s3c2410/include/mach/memory.h
> index 6f1e587..f92b97b 100644
> --- a/arch/arm/mach-s3c2410/include/mach/memory.h
> +++ b/arch/arm/mach-s3c2410/include/mach/memory.h
> @@ -11,6 +11,6 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H
> 
> -#define PHYS_OFFSET	UL(0x30000000)
> +#define PLAT_PHYS_OFFSET	UL(0x30000000)
> 
>  #endif
> diff --git a/arch/arm/mach-s3c24a0/include/mach/memory.h b/arch/arm/mach-
> s3c24a0/include/mach/memory.h
> index 7d74fd5..7d208a7 100644
> --- a/arch/arm/mach-s3c24a0/include/mach/memory.h
> +++ b/arch/arm/mach-s3c24a0/include/mach/memory.h
> @@ -11,7 +11,7 @@
>  #ifndef __ASM_ARCH_24A0_MEMORY_H
>  #define __ASM_ARCH_24A0_MEMORY_H __FILE__
> 
> -#define PHYS_OFFSET UL(0x10000000)
> +#define PLAT_PHYS_OFFSET UL(0x10000000)
> 
>  #define __virt_to_bus(x) __virt_to_phys(x)
>  #define __bus_to_virt(x) __phys_to_virt(x)
> diff --git a/arch/arm/mach-s3c64xx/include/mach/memory.h b/arch/arm/mach-
> s3c64xx/include/mach/memory.h
> index 42cc54e..4760cda 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/memory.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/memory.h
> @@ -13,7 +13,7 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H
> 
> -#define PHYS_OFFSET     UL(0x50000000)
> +#define PLAT_PHYS_OFFSET     UL(0x50000000)
> 
>  #define CONSISTENT_DMA_SIZE	SZ_8M
> 
> diff --git a/arch/arm/mach-s5p6442/include/mach/memory.h b/arch/arm/mach-
> s5p6442/include/mach/memory.h
> index 9ddd877..cfe259d 100644
> --- a/arch/arm/mach-s5p6442/include/mach/memory.h
> +++ b/arch/arm/mach-s5p6442/include/mach/memory.h
> @@ -13,7 +13,7 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H
> 
> -#define PHYS_OFFSET		UL(0x20000000)
> +#define PLAT_PHYS_OFFSET		UL(0x20000000)
>  #define CONSISTENT_DMA_SIZE	SZ_8M
> 
>  #endif /* __ASM_ARCH_MEMORY_H */
> diff --git a/arch/arm/mach-s5p64x0/include/mach/memory.h b/arch/arm/mach-
> s5p64x0/include/mach/memory.h
> index 1b036b0..365a6eb 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/memory.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/memory.h
> @@ -13,7 +13,7 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H __FILE__
> 
> -#define PHYS_OFFSET		UL(0x20000000)
> +#define PLAT_PHYS_OFFSET		UL(0x20000000)
>  #define CONSISTENT_DMA_SIZE	SZ_8M
> 
>  #endif /* __ASM_ARCH_MEMORY_H */
> diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/mach-
> s5pc100/include/mach/memory.h
> index 4b60d18..bda4e79 100644
> --- a/arch/arm/mach-s5pc100/include/mach/memory.h
> +++ b/arch/arm/mach-s5pc100/include/mach/memory.h
> @@ -13,6 +13,6 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H
> 
> -#define PHYS_OFFSET     	UL(0x20000000)
> +#define PLAT_PHYS_OFFSET     	UL(0x20000000)
> 
>  #endif
> diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-
> s5pv210/include/mach/memory.h
> index d503e0c..7b5fcf0 100644
> --- a/arch/arm/mach-s5pv210/include/mach/memory.h
> +++ b/arch/arm/mach-s5pv210/include/mach/memory.h
> @@ -13,7 +13,7 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H
> 
> -#define PHYS_OFFSET		UL(0x20000000)
> +#define PLAT_PHYS_OFFSET		UL(0x20000000)
>  #define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
> 
>  /*
> diff --git a/arch/arm/mach-s5pv310/include/mach/memory.h b/arch/arm/mach-
> s5pv310/include/mach/memory.h
> index 1dffb48..470b01b 100644
> --- a/arch/arm/mach-s5pv310/include/mach/memory.h
> +++ b/arch/arm/mach-s5pv310/include/mach/memory.h
> @@ -13,7 +13,7 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H __FILE__
> 
> -#define PHYS_OFFSET		UL(0x40000000)
> +#define PLAT_PHYS_OFFSET		UL(0x40000000)
> 
>  /* Maximum of 256MiB in one bank */
>  #define MAX_PHYSMEM_BITS	32

(snip)

> --
> 1.6.2.5

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Hmm...and as a note, submitted changing 'mach-exynos4' from 'mach-s5pv310'.
I know you can handle it later :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
