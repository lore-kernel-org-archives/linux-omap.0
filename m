From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 4/9] ARM: OMAP2+: AM33XX: Reserve memory to comply with
 EMIF spec
Date: Wed, 7 Aug 2013 19:30:13 -0700
Message-ID: <CA+Bv8XaGf=BGNX1=DKLQTwiFkisvkt3H-J3Wjy5dhqb1z9NtVw@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-5-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:48076 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405Ab3HHCaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 22:30:14 -0400
Received: by mail-qe0-f41.google.com with SMTP id a11so1446897qen.28
        for <linux-omap@vger.kernel.org>; Wed, 07 Aug 2013 19:30:13 -0700 (PDT)
In-Reply-To: <1375811376-49985-5-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> SDRAM controller on AM33XX requires that a modification of certain
> bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
> AM335x-Rev H) is followed by a dummy read access to SDRAM. This
> scenario arises when entering a low power state like DeepSleep.
> To ensure that the read is not from a cached region we reserve
> some memory during bootup using the arm_memblock_steal() API.
>
> A subsequent patch will pass along the location of the reserved
> memory location to the AM335x suspend handler which modifies the
> PWR_MGMT_CTRL register in the EMIF.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/mach-omap2/board-generic.c |    2 +-
>  arch/arm/mach-omap2/common.c        |   28 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/common.h        |    4 ++++
>  arch/arm/mach-omap2/io.c            |    1 +
>  4 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index be5d005..aed750c 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -156,7 +156,7 @@ static const char *am33xx_boards_compat[] __initdata = {
>  };
>
>  DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
> -       .reserve        = omap_reserve,
> +       .reserve        = am33xx_reserve,
>         .map_io         = am33xx_map_io,
>         .init_early     = am33xx_init_early,
>         .init_irq       = omap_intc_of_init,
> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
> index 2dabb9e..756586f 100644
> --- a/arch/arm/mach-omap2/common.c
> +++ b/arch/arm/mach-omap2/common.c
> @@ -15,6 +15,8 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_data/dsp-omap.h>
> +#include <asm/memblock.h>
> +#include <asm/mach/map.h>
>
>  #include "common.h"
>  #include "omap-secure.h"
> @@ -34,3 +36,29 @@ void __init omap_reserve(void)
>         omap_secure_ram_reserve_memblock();
>         omap_barrier_reserve_memblock();
>  }
> +
> +static phys_addr_t am33xx_paddr;
> +static u32 am33xx_size;
> +
> +/* Steal one page physical memory for uncached read DeepSleep */
> +void __init am33xx_reserve(void)
> +{
> +       am33xx_size = ALIGN(PAGE_SIZE, SZ_1M);
> +       am33xx_paddr = arm_memblock_steal(am33xx_size, SZ_1M);
> +}
> +
> +void __iomem *am33xx_dram_sync;
> +
> +void __init am33xx_dram_sync_init(void)
> +{
> +       struct map_desc dram_io_desc[1];
> +
> +       dram_io_desc[0].virtual = __phys_to_virt(am33xx_paddr);
> +       dram_io_desc[0].pfn = __phys_to_pfn(am33xx_paddr);
> +       dram_io_desc[0].length = am33xx_size;
> +       dram_io_desc[0].type = MT_MEMORY_SO;
> +
> +       iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
> +
> +       am33xx_dram_sync = (void __iomem *) dram_io_desc[0].virtual;
> +}
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index dfcc182..6b8ef74 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -294,6 +294,10 @@ struct omap2_hsmmc_info;
>  extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
>  extern void omap_reserve(void);
>
> +extern void am33xx_reserve(void);
> +extern void am33xx_dram_sync_init(void);
> +extern void __iomem *am33xx_dram_sync;
> +
>  struct omap_hwmod;
>  extern int omap_dss_reset(struct omap_hwmod *);
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 4a3f06f..3ad7543 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -322,6 +322,7 @@ void __init ti81xx_map_io(void)
>  void __init am33xx_map_io(void)
>  {
>         iotable_init(omapam33xx_io_desc, ARRAY_SIZE(omapam33xx_io_desc));
> +       am33xx_dram_sync_init();
>  }
>  #endif
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
